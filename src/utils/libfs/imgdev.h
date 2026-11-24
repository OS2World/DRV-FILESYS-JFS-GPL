/*
 * imgdev.h - disk image files as JFS volumes
 *
 * Added for the OS2World update, not part of the IBM release. Every JFS utility reaches the volume with DosOpen,
 * DosDevIOCtl (DASD and disk IOCTLs) and DosQueryFSInfo on a drive letter. When the "drive" is the name of an
 * ordinary file (a path, e.g. "c:\jfs\test.img") the calls below emulate the DASD volume on that file, so that
 * the tools can create, check and repair a JFS file system inside an image file. Drive letters and device names
 * are passed to the real OS/2 calls unchanged.
 *
 * Included into every source file of the utilities by src/shim/jfs_compat.h (forced include).
 */
#ifndef _JFS_IMGDEV_H
#define _JFS_IMGDEV_H

#ifndef IMGDEV_IMPL
/* kLIBC's os2.h may already map some of these names to other functions (DosOpen -> DosOpenL); imgdev.c restores
   the saved definitions with pop_macro. */
#pragma push_macro("DosOpen")
#pragma push_macro("DosClose")
#pragma push_macro("DosDevIOCtl")
#pragma push_macro("DosQueryFSInfo")
#undef DosOpen
#undef DosClose
#undef DosDevIOCtl
#undef DosQueryFSInfo
#define DosOpen        img_DosOpen
#define DosClose       img_DosClose
#define DosDevIOCtl    img_DosDevIOCtl
#define DosQueryFSInfo img_DosQueryFSInfo
#endif

#ifdef __cplusplus
extern "C" {
#endif
ULONG img_DosOpen(PCSZ pszFileName, PHFILE phFile, PULONG pulAction, ULONG cbFile, ULONG ulAttribute,
                  ULONG fsOpenFlags, ULONG fsOpenMode, PEAOP2 peaop2);
ULONG img_DosClose(HFILE hFile);
ULONG img_DosDevIOCtl(HFILE hDevice, ULONG ulCategory, ULONG ulFunction, PVOID pParams, ULONG cbParmLenMax,
                      PULONG pcbParmLen, PVOID pData, ULONG cbDataLenMax, PULONG pcbDataLen);
ULONG img_DosQueryFSInfo(ULONG ulDrive, ULONG ulLevel, PVOID pBuf, ULONG cbBuf);
#ifdef __cplusplus
}
#endif
#endif
