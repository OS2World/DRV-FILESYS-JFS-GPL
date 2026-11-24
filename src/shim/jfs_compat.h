/* jfs_compat.h - forced into every source file when building with GCC / kLIBC.
   Declares the C library types first so that jfs_aixisms.h can rename the two that differ (ino_t, daddr_t),
   and the spin lock type that the IBM kernel header mmph.h supplied. */
#ifndef _JFS_COMPAT_H
#define _JFS_COMPAT_H
/* the base OS/2 API of the kLIBC headers, with every group the utilities use (the sources include the standalone
   toolkit headers bsedos.h, bseerr.h ... which are empty shims here) */
#define INCL_DOS
#define INCL_DOSERRORS
#define INCL_DOSDEVIOCTL
#define INCL_DOSDEVICES
#define INCL_DOSFILEMGR
#define INCL_DOSMEMMGR
#define INCL_DOSSEMAPHORES
#define INCL_DOSEXCEPTIONS
#define INCL_DOSMISC
#define INCL_DOSNLS
#define INCL_DOSPROCESS
#define INCL_DOSSESMGR
#define INCL_SUB
#define INCL_KBD
#define INCL_VIO
#include <os2.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <io.h>
#include <unistd.h>
#include <stddef.h>
#include <stdarg.h>
/* IBM C keywords */
#define _Seg16
#define _Far16
#define _Pascal
#define _loadds
#define _Optlink
#define _Inline static inline
#ifndef min
#define min(a,b) (((a) < (b)) ? (a) : (b))
#define max(a,b) (((a) > (b)) ? (a) : (b))
#endif
/* IBM C intrinsic used by the debug break point macro brkpoint() */
static inline void _interrupt(int n) { (void) n; __asm__ __volatile__("int $3"); }
typedef unsigned long SpinLock_t;
/* kernel types of the IBM header bsekee.h, only used in structures of the file system driver */
typedef unsigned long MutexLock_t;
typedef struct { unsigned long Addr; unsigned long Size; } KernPageList_t;
typedef struct { unsigned long a[4]; } KernCacheList_t;
#endif
