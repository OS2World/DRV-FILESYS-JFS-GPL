/*
 * imgdev.c - disk image files as JFS volumes (see imgdev.h)
 *
 * Added for the OS2World update, not part of the IBM release; GNU GPL v2 or later like the rest.
 *
 * The geometry reported for an image is 512 byte sectors, 63 sectors per track, 255 heads. The JFS code
 * addresses the volume through DSK_READTRACK / DSK_WRITETRACK with cylinder, head and first sector; they are
 * converted to a byte offset in the file.
 */
#define IMGDEV_IMPL
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <os2.h>
#include <dskioctl.h>
#include <ioctl.h>
#include "imgdev.h"

/* this file calls the real functions */
#pragma pop_macro("DosOpen")
#pragma pop_macro("DosClose")
#pragma pop_macro("DosDevIOCtl")
#pragma pop_macro("DosQueryFSInfo")

#define IMG_SECTOR   512
#define IMG_SPT      63
#define IMG_HEADS    255
#define IMG_MAXOPEN  8

static struct {
    HFILE h;
    unsigned long long size;     /* bytes */
} img[IMG_MAXOPEN];
static int img_count = 0;
static unsigned long long img_lastsize = 0;   /* for DosQueryFSInfo after the image was closed */

/* the data packet of DSK_GETDEVICEPARAMS: a 31 byte BPB, the number of cylinders, the device type and the attributes */
#pragma pack(1)
struct img_dpb {
    USHORT bytes_per_sector;
    UCHAR  sectors_per_cluster;
    USHORT reserved_sectors;
    UCHAR  nbr_fats;
    USHORT root_entries;
    USHORT total_sectors;
    UCHAR  media_type;
    USHORT sectors_per_fat;
    USHORT sectors_per_track;
    USHORT number_of_heads;
    ULONG  hidden_sectors;
    ULONG  large_total_sectors;
    UCHAR  reserved_3[6];
    USHORT number_of_cylinders;
    UCHAR  device_type;
    USHORT device_attributes;
};
struct img_track {          /* TRACKLAYOUT */
    UCHAR  bCommand;
    USHORT usHead;
    USHORT usCylinder;
    USHORT usFirstSector;
    USHORT cSectors;
};
#pragma pack()

/* A name is an image file when it is a path of more than a drive letter: it has a directory part or a dot,
   and it is not a device name ("CHKDSK$", "\DEV\..."). "X:" and "X:\" are drives. */
static int is_image_name(const char *n)
{
    size_t len = strlen(n);
    if (len <= 2) return 0;
    if (n[len - 1] == '$') return 0;
    if (!strnicmp(n, "\\DEV\\", 5) || !strnicmp(n, "/DEV/", 5)) return 0;
    if (len == 3 && n[1] == ':' && (n[2] == '\\' || n[2] == '/')) return 0;
    return strchr(n, '.') != NULL || strchr(n, '\\') != NULL || strchr(n, '/') != NULL;
}

static int find_img(HFILE h)
{
    int i;
    for (i = 0; i < img_count; i++)
        if (img[i].h == h) return i;
    return -1;
}

ULONG img_DosOpen(PCSZ pszFileName, PHFILE phFile, PULONG pulAction, ULONG cbFile, ULONG ulAttribute,
                  ULONG fsOpenFlags, ULONG fsOpenMode, PEAOP2 peaop2)
{
    ULONG rc;
    FILESTATUS3 fs;

    if (!is_image_name(pszFileName))
        return DosOpen(pszFileName, phFile, pulAction, cbFile, ulAttribute, fsOpenFlags, fsOpenMode, peaop2);

    if (img_count >= IMG_MAXOPEN) return ERROR_TOO_MANY_OPEN_FILES;
    /* an image is an ordinary file: no DASD open, and it must exist (it is not created here) */
    fsOpenMode &= ~OPEN_FLAGS_DASD;
    rc = DosOpen(pszFileName, phFile, pulAction, 0, 0, OPEN_ACTION_OPEN_IF_EXISTS, fsOpenMode, NULL);
    if (rc) return rc;
    if (DosQueryFileInfo(*phFile, FIL_STANDARD, &fs, sizeof fs)) {
        DosClose(*phFile);
        return ERROR_INVALID_HANDLE;
    }
    img[img_count].h = *phFile;
    img[img_count].size = (unsigned long long) fs.cbFile;
    img_lastsize = img[img_count].size;
    img_count++;
    return NO_ERROR;
}

ULONG img_DosClose(HFILE hFile)
{
    int i = find_img(hFile);
    if (i >= 0) {
        img[i] = img[img_count - 1];
        img_count--;
    }
    return DosClose(hFile);
}

static ULONG img_rw(int i, ULONG func, struct img_track *t, void *buf, ULONG *pdatalen)
{
    unsigned long long sec, off;
    ULONG rc, actual, want = (ULONG) t->cSectors * IMG_SECTOR;
    ULONG newpos;

    sec = ((unsigned long long) t->usCylinder * IMG_HEADS + t->usHead) * IMG_SPT + t->usFirstSector;
    off = sec * IMG_SECTOR;
    if (off + want > img[i].size) return ERROR_SECTOR_NOT_FOUND;
    if (func == DSK_VERIFYTRACK) { *pdatalen = want; return NO_ERROR; }
    if (off > 0x7FFFFFFFULL) return ERROR_SEEK;       /* images of 2 GB and more are not supported yet */
    rc = DosSetFilePtr(img[i].h, (LONG) off, FILE_BEGIN, &newpos);
    if (rc) return rc;
    if (func == DSK_READTRACK) rc = DosRead(img[i].h, buf, want, &actual);
    else                       rc = DosWrite(img[i].h, buf, want, &actual);
    if (rc) return rc;
    if (actual != want) return func == DSK_READTRACK ? ERROR_READ_FAULT : ERROR_WRITE_FAULT;
    *pdatalen = want;
    return NO_ERROR;
}

ULONG img_DosDevIOCtl(HFILE hDevice, ULONG cat, ULONG func, PVOID pParams, ULONG cbParmLenMax,
                      PULONG pcbParmLen, PVOID pData, ULONG cbDataLenMax, PULONG pcbDataLen)
{
    int i = find_img(hDevice);
    if (i < 0)
        return DosDevIOCtl(hDevice, cat, func, pParams, cbParmLenMax, pcbParmLen, pData, cbDataLenMax, pcbDataLen);

    if (cat == IOC_DC && func == IODC_LV) {
        /* LVM query: an image is reported as an LVM volume without bad block tables */
        DDI_OS2LVM_param *p = (DDI_OS2LVM_param *) pParams;
        DDI_OS2LVM_data *d = (DDI_OS2LVM_data *) pData;
        if (p->Command == GET_BBR_INFO) {
            if (d->UserBuffer) memset(d->UserBuffer, 0, sizeof(BadBlockInfo));
            d->ReturnData = BBR_SUCCESS;
        }
        else if (p->Command == 0)
            d->ReturnData = 2;
        else
            d->ReturnData = BBR_FAILURE;
        return NO_ERROR;
    }
    if (cat != IOCTL_DISK) return ERROR_INVALID_FUNCTION;

    switch (func) {
    case DSK_LOCKDRIVE:
    case DSK_UNLOCKDRIVE:
    case DSK_REDETERMINEMEDIA:
    case DSK_BEGINFORMAT:
    case DSK_SETDEVICEPARAMS:
        return NO_ERROR;

    case DSK_GETDEVICEPARAMS: {
        struct img_dpb *d = (struct img_dpb *) pData;
        unsigned long long sectors = img[i].size / IMG_SECTOR;
        memset(d, 0, sizeof *d);
        d->bytes_per_sector = IMG_SECTOR;
        d->sectors_per_cluster = 1;
        d->media_type = 0xF8;
        d->sectors_per_track = IMG_SPT;
        d->number_of_heads = IMG_HEADS;
        d->large_total_sectors = (ULONG) sectors;
        d->number_of_cylinders = (USHORT) (sectors / (IMG_SPT * IMG_HEADS) + 1);
        d->device_type = 5;                           /* fixed disk */
        d->device_attributes = 0x0004;                /* DA_ABOVE16MB */
        if (pcbDataLen) *pcbDataLen = sizeof *d;
        return NO_ERROR;
    }

    case DSK_READTRACK:
    case DSK_WRITETRACK:
    case DSK_VERIFYTRACK: {
        ULONG len = 0, rc;
        rc = img_rw(i, func, (struct img_track *) pParams, pData, &len);
        if (pcbDataLen) *pcbDataLen = len;
        return rc;
    }
    }
    return ERROR_INVALID_FUNCTION;
}

/* DosQueryFSInfo by drive number: only the answers the tools use after a format of an image (volume label, free space) */
ULONG img_DosQueryFSInfo(ULONG ulDrive, ULONG ulLevel, PVOID pBuf, ULONG cbBuf)
{
    if (img_count == 0 && img_lastsize == 0)
        return DosQueryFSInfo(ulDrive, ulLevel, pBuf, cbBuf);
    if (ulLevel == FSIL_ALLOC) {
        FSALLOCATE *a = (FSALLOCATE *) pBuf;
        memset(a, 0, sizeof *a);
        a->cSectorUnit = 8;
        a->cUnit = (ULONG) (img_lastsize / (8 * IMG_SECTOR));
        a->cUnitAvail = a->cUnit;
        a->cbSector = IMG_SECTOR;
        return NO_ERROR;
    }
    if (ulLevel == FSIL_VOLSER) {
        memset(pBuf, 0, cbBuf);                       /* no volume label */
        return NO_ERROR;
    }
    return ERROR_INVALID_LEVEL;
}
