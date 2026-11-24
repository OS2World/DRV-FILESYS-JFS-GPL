/* shim: dskioctl.h of the kLIBC headers uses the BPB type (the BIOS parameter block of the disk IOCTLs,
   same layout as BIOSPARAMETERBLOCK of the toolkit), which it does not declare */
#ifndef _JFS_SHIM_DSKIOCTL_H
#define _JFS_SHIM_DSKIOCTL_H
#pragma pack(1)
typedef struct _JFS_BPB {
   USHORT usBytesPerSector;
   BYTE   bSectorsPerCluster;
   USHORT usReservedSectors;
   BYTE   cFATs;
   USHORT cRootEntries;
   USHORT cSectors;
   BYTE   bMedia;
   USHORT usSectorsPerFAT;
   USHORT usSectorsPerTrack;
   USHORT cHeads;
   ULONG  cHiddenSectors;
   ULONG  cLargeSectors;
   BYTE   abReserved[6];
   USHORT cCylinders;
   BYTE   bDeviceType;
   USHORT fsDeviceAttr;
} BPB;
#pragma pack()
#include_next <dskioctl.h>
#endif
