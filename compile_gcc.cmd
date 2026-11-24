@echo off
rem compile_gcc.cmd - build the JFS utilities with GCC 9 / kLIBC (32-bit OS/2 executables)
rem   compile_gcc.cmd         build, log in compile_gcc.log, output in bin\
rem   compile_gcc.cmd relink  only rebuild the library and link (objects from the last build)
rem   compile_gcc.cmd clean   remove bin\ and the log
rem Needs GCC 9 (ANPM) and watcom-wlink-hll (wl.exe). The file list is written out file by file (OS/2 CMD.EXE has no CALL :label).
set UNIXROOT=C:
set PATH=C:\usr\bin;%PATH%
set C_INCLUDE_PATH=src/shim;C:/usr/include
set LIBRARY_PATH=C:/usr/lib
set EMXOMFLD_TYPE=WLINK
set EMXOMFLD_LINKER=wl.exe
set EMXOMFLD_PRELINK=0
if "%1"=="clean" goto clean
if "%1"=="relink" goto library
if not exist bin md bin
if not exist bin\obj md bin\obj
if exist bin\*.exe del bin\*.exe < nul
if exist bin\obj\*.obj del bin\obj\*.obj < nul
echo ==== compile > compile_gcc.log
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_bootsec.obj src/utils/libfs/bootsec.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_bufpool.obj src/utils/libfs/bufpool.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_cmputmsg.obj src/utils/libfs/cmputmsg.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_devices.obj src/utils/libfs/devices.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_diskmap.obj src/utils/libfs/diskmap.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_fssubs.obj src/utils/libfs/fssubs.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_imgdev.obj src/utils/libfs/imgdev.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_inode.obj src/utils/libfs/inode.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_log_dump.obj src/utils/libfs/log_dump.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_log_map.obj src/utils/libfs/log_map.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_log_read.obj src/utils/libfs/log_read.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_log_work.obj src/utils/libfs/log_work.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_logform.obj src/utils/libfs/logform.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_logredo.obj src/utils/libfs/logredo.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_message.obj src/utils/libfs/message.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_super.obj src/utils/libfs/super.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/libfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\libfs_utilsubs.obj src/utils/libfs/utilsubs.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/format -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\format_initmap.obj src/utils/format/initmap.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/format -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\format_inodemap.obj src/utils/format/inodemap.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/format -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\format_inodes.obj src/utils/format/inodes.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/format -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\format_lvmbdblk.obj src/utils/format/lvmbdblk.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/format -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\format_xmkfs.obj src/utils/format/xmkfs.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/wrap -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\wrap_jfsformat.obj src/utils/wrap/jfsformat.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_fsckbmap.obj src/utils/chkdsk/fsckbmap.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_fsckcbbl.obj src/utils/chkdsk/fsckcbbl.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_fsckconn.obj src/utils/chkdsk/fsckconn.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_fsckdire.obj src/utils/chkdsk/fsckdire.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_fsckdtre.obj src/utils/chkdsk/fsckdtre.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_fsckea.obj src/utils/chkdsk/fsckea.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_fsckimap.obj src/utils/chkdsk/fsckimap.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_fsckino.obj src/utils/chkdsk/fsckino.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_fsckmeta.obj src/utils/chkdsk/fsckmeta.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_fsckmsgs.obj src/utils/chkdsk/fsckmsgs.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_fsckpfs.obj src/utils/chkdsk/fsckpfs.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_fsckruns.obj src/utils/chkdsk/fsckruns.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_fsckwsp.obj src/utils/chkdsk/fsckwsp.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_fsckxtre.obj src/utils/chkdsk/fsckxtre.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chkdsk -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chkdsk_xchkdsk.obj src/utils/chkdsk/xchkdsk.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/wrap -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\wrap_jfschk.obj src/utils/wrap/jfschk.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/cachejfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\cachejfs_cachejfs.obj src/utils/cachejfs/cachejfs.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/chklog -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\chklog_chklog.obj src/utils/chklog/chklog.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/clrbblks -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\clrbblks_cbblfsck.obj src/utils/clrbblks/cbblfsck.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/clrbblks -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\clrbblks_cbblino.obj src/utils/clrbblks/cbblino.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/clrbblks -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\clrbblks_cbblwsp.obj src/utils/clrbblks/cbblwsp.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/clrbblks -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\clrbblks_clrbblks.obj src/utils/clrbblks/clrbblks.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -D_JFS_CACHESTATS -Isrc/include -Isrc/utils/cstats -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\cstats_cstats.obj src/utils/cstats/cstats.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/defrag -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\defrag_defragfs.obj src/utils/defrag/defragfs.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -D_JFS_DEBUG -DTRACE -Isrc/include -Isrc/utils/extendfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\extendfs_extendfs.obj src/utils/extendfs/extendfs.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/logdump -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\logdump_helpers.obj src/utils/logdump/helpers.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/logdump -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\logdump_logdump.obj src/utils/logdump/logdump.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/logredo -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\logredo_helpers.obj src/utils/logredo/helpers.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/logredo -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\logredo_xlogredo.obj src/utils/logredo/xlogredo.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/validfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\validfs_dumpfs.obj src/utils/validfs/dumpfs.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/validfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\validfs_initmap.obj src/utils/validfs/initmap.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/validfs -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\validfs_validfs.obj src/utils/validfs/validfs.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/xchkdmp -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xchkdmp_xchkdmp.obj src/utils/xchkdmp/xchkdmp.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -Isrc/include -Isrc/utils/xchklog -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xchklog_xchklog.obj src/utils/xchklog/xchklog.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/xpeek -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xpeek_alter.obj src/utils/xpeek/alter.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/xpeek -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xpeek_directory.obj src/utils/xpeek/directory.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/xpeek -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xpeek_display.obj src/utils/xpeek/display.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/xpeek -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xpeek_dmap.obj src/utils/xpeek/dmap.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/xpeek -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xpeek_fsckcbbl.obj src/utils/xpeek/fsckcbbl.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/xpeek -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xpeek_help.obj src/utils/xpeek/help.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/xpeek -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xpeek_iag.obj src/utils/xpeek/iag.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/xpeek -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xpeek_inode.obj src/utils/xpeek/inode.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/xpeek -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xpeek_io.obj src/utils/xpeek/io.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/xpeek -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xpeek_super.obj src/utils/xpeek/super.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/xpeek -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xpeek_super2.obj src/utils/xpeek/super2.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/xpeek -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xpeek_ui.obj src/utils/xpeek/ui.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/xpeek -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xpeek_uisubs.obj src/utils/xpeek/uisubs.c >> compile_gcc.log 2>&1
gcc -Zomf -O2 -w -std=gnu99 -include src/shim/jfs_compat.h -DM_I386 -D_JFS_OS2 -D_JFS_UTILITY -DINCL_NOPMAPI -DONE_FILESET_PER_AGGR -DTRACE -Isrc/include -Isrc/utils/xpeek -Isrc/utils/libfs -Isrc/utils/chkdsk -c -o bin\obj\xpeek_xpeek.obj src/utils/xpeek/xpeek.c >> compile_gcc.log 2>&1
:library
echo ==== library >> compile_gcc.log
if exist bin\ujfs.lib del bin\ujfs.lib
emxomfar rc bin\ujfs.lib bin\obj\libfs_bootsec.obj bin\obj\libfs_bufpool.obj bin\obj\libfs_cmputmsg.obj bin\obj\libfs_devices.obj bin\obj\libfs_diskmap.obj bin\obj\libfs_fssubs.obj bin\obj\libfs_imgdev.obj bin\obj\libfs_inode.obj bin\obj\libfs_log_dump.obj bin\obj\libfs_log_map.obj bin\obj\libfs_log_read.obj bin\obj\libfs_log_work.obj bin\obj\libfs_logform.obj bin\obj\libfs_logredo.obj bin\obj\libfs_message.obj bin\obj\libfs_super.obj bin\obj\libfs_utilsubs.obj >> compile_gcc.log 2>&1
echo ==== link >> compile_gcc.log
echo -o bin\jfsformat.exe > bin\jfsformat.rsp
echo bin\obj\format_initmap.obj >> bin\jfsformat.rsp
echo bin\obj\format_inodemap.obj >> bin\jfsformat.rsp
echo bin\obj\format_inodes.obj >> bin\jfsformat.rsp
echo bin\obj\format_lvmbdblk.obj >> bin\jfsformat.rsp
echo bin\obj\format_xmkfs.obj >> bin\jfsformat.rsp
echo bin\obj\wrap_jfsformat.obj >> bin\jfsformat.rsp
echo bin\ujfs.lib >> bin\jfsformat.rsp
gcc -Zomf @bin\jfsformat.rsp >> compile_gcc.log 2>&1
echo -o bin\jfschk.exe > bin\jfschk.rsp
echo bin\obj\chkdsk_fsckbmap.obj >> bin\jfschk.rsp
echo bin\obj\chkdsk_fsckcbbl.obj >> bin\jfschk.rsp
echo bin\obj\chkdsk_fsckconn.obj >> bin\jfschk.rsp
echo bin\obj\chkdsk_fsckdire.obj >> bin\jfschk.rsp
echo bin\obj\chkdsk_fsckdtre.obj >> bin\jfschk.rsp
echo bin\obj\chkdsk_fsckea.obj >> bin\jfschk.rsp
echo bin\obj\chkdsk_fsckimap.obj >> bin\jfschk.rsp
echo bin\obj\chkdsk_fsckino.obj >> bin\jfschk.rsp
echo bin\obj\chkdsk_fsckmeta.obj >> bin\jfschk.rsp
echo bin\obj\chkdsk_fsckmsgs.obj >> bin\jfschk.rsp
echo bin\obj\chkdsk_fsckpfs.obj >> bin\jfschk.rsp
echo bin\obj\chkdsk_fsckruns.obj >> bin\jfschk.rsp
echo bin\obj\chkdsk_fsckwsp.obj >> bin\jfschk.rsp
echo bin\obj\chkdsk_fsckxtre.obj >> bin\jfschk.rsp
echo bin\obj\chkdsk_xchkdsk.obj >> bin\jfschk.rsp
echo bin\obj\wrap_jfschk.obj >> bin\jfschk.rsp
echo bin\ujfs.lib >> bin\jfschk.rsp
gcc -Zomf @bin\jfschk.rsp >> compile_gcc.log 2>&1
echo -o bin\cachejfs.exe > bin\cachejfs.rsp
echo bin\obj\cachejfs_cachejfs.obj >> bin\cachejfs.rsp
echo bin\ujfs.lib >> bin\cachejfs.rsp
gcc -Zomf @bin\cachejfs.rsp >> compile_gcc.log 2>&1
echo -o bin\chklgjfs.exe > bin\chklgjfs.rsp
echo bin\obj\chklog_chklog.obj >> bin\chklgjfs.rsp
echo bin\ujfs.lib >> bin\chklgjfs.rsp
gcc -Zomf @bin\chklgjfs.rsp >> compile_gcc.log 2>&1
echo -o bin\clrbblks.exe > bin\clrbblks.rsp
echo bin\obj\clrbblks_cbblfsck.obj >> bin\clrbblks.rsp
echo bin\obj\clrbblks_cbblino.obj >> bin\clrbblks.rsp
echo bin\obj\clrbblks_cbblwsp.obj >> bin\clrbblks.rsp
echo bin\obj\clrbblks_clrbblks.obj >> bin\clrbblks.rsp
echo bin\ujfs.lib >> bin\clrbblks.rsp
gcc -Zomf @bin\clrbblks.rsp >> compile_gcc.log 2>&1
echo -o bin\cstats.exe > bin\cstats.rsp
echo bin\obj\cstats_cstats.obj >> bin\cstats.rsp
echo bin\ujfs.lib >> bin\cstats.rsp
gcc -Zomf @bin\cstats.rsp >> compile_gcc.log 2>&1
echo -o bin\defragfs.exe > bin\defragfs.rsp
echo bin\obj\defrag_defragfs.obj >> bin\defragfs.rsp
echo bin\ujfs.lib >> bin\defragfs.rsp
gcc -Zomf @bin\defragfs.rsp >> compile_gcc.log 2>&1
echo -o bin\extendfs.exe > bin\extendfs.rsp
echo bin\obj\extendfs_extendfs.obj >> bin\extendfs.rsp
echo bin\ujfs.lib >> bin\extendfs.rsp
gcc -Zomf @bin\extendfs.rsp >> compile_gcc.log 2>&1
echo -o bin\logdump.exe > bin\logdump.rsp
echo bin\obj\logdump_helpers.obj >> bin\logdump.rsp
echo bin\obj\logdump_logdump.obj >> bin\logdump.rsp
echo bin\ujfs.lib >> bin\logdump.rsp
gcc -Zomf @bin\logdump.rsp >> compile_gcc.log 2>&1
echo -o bin\logredo.exe > bin\logredo.rsp
echo bin\obj\logredo_helpers.obj >> bin\logredo.rsp
echo bin\obj\logredo_xlogredo.obj >> bin\logredo.rsp
echo bin\ujfs.lib >> bin\logredo.rsp
gcc -Zomf @bin\logredo.rsp >> compile_gcc.log 2>&1
echo -o bin\validfs.exe > bin\validfs.rsp
echo bin\obj\validfs_dumpfs.obj >> bin\validfs.rsp
echo bin\obj\validfs_initmap.obj >> bin\validfs.rsp
echo bin\obj\validfs_validfs.obj >> bin\validfs.rsp
echo bin\ujfs.lib >> bin\validfs.rsp
gcc -Zomf @bin\validfs.rsp >> compile_gcc.log 2>&1
echo -o bin\xchkdmp.exe > bin\xchkdmp.rsp
echo bin\obj\xchkdmp_xchkdmp.obj >> bin\xchkdmp.rsp
echo bin\ujfs.lib >> bin\xchkdmp.rsp
gcc -Zomf @bin\xchkdmp.rsp >> compile_gcc.log 2>&1
echo -o bin\xchklog.exe > bin\xchklog.rsp
echo bin\obj\xchklog_xchklog.obj >> bin\xchklog.rsp
echo bin\ujfs.lib >> bin\xchklog.rsp
gcc -Zomf @bin\xchklog.rsp >> compile_gcc.log 2>&1
echo -o bin\xpeek.exe > bin\xpeek.rsp
echo bin\obj\xpeek_alter.obj >> bin\xpeek.rsp
echo bin\obj\xpeek_directory.obj >> bin\xpeek.rsp
echo bin\obj\xpeek_display.obj >> bin\xpeek.rsp
echo bin\obj\xpeek_dmap.obj >> bin\xpeek.rsp
echo bin\obj\xpeek_fsckcbbl.obj >> bin\xpeek.rsp
echo bin\obj\xpeek_help.obj >> bin\xpeek.rsp
echo bin\obj\xpeek_iag.obj >> bin\xpeek.rsp
echo bin\obj\xpeek_inode.obj >> bin\xpeek.rsp
echo bin\obj\xpeek_io.obj >> bin\xpeek.rsp
echo bin\obj\xpeek_super.obj >> bin\xpeek.rsp
echo bin\obj\xpeek_super2.obj >> bin\xpeek.rsp
echo bin\obj\xpeek_ui.obj >> bin\xpeek.rsp
echo bin\obj\xpeek_uisubs.obj >> bin\xpeek.rsp
echo bin\obj\xpeek_xpeek.obj >> bin\xpeek.rsp
echo bin\ujfs.lib >> bin\xpeek.rsp
gcc -Zomf @bin\xpeek.rsp >> compile_gcc.log 2>&1
set FAIL=0
if not exist bin\jfsformat.exe set FAIL=1
if not exist bin\jfschk.exe set FAIL=1
if not exist bin\cachejfs.exe set FAIL=1
if not exist bin\chklgjfs.exe set FAIL=1
if not exist bin\clrbblks.exe set FAIL=1
if not exist bin\cstats.exe set FAIL=1
if not exist bin\defragfs.exe set FAIL=1
if not exist bin\extendfs.exe set FAIL=1
if not exist bin\logdump.exe set FAIL=1
if not exist bin\logredo.exe set FAIL=1
if not exist bin\validfs.exe set FAIL=1
if not exist bin\xchkdmp.exe set FAIL=1
if not exist bin\xchklog.exe set FAIL=1
if not exist bin\xpeek.exe set FAIL=1
if "%FAIL%"=="1" goto failed
echo OK: bin\jfsformat.exe bin\jfschk.exe bin\cachejfs.exe bin\chklgjfs.exe bin\clrbblks.exe bin\cstats.exe bin\defragfs.exe bin\extendfs.exe bin\logdump.exe bin\logredo.exe bin\validfs.exe bin\xchkdmp.exe bin\xchklog.exe bin\xpeek.exe
echo OK >> compile_gcc.log
goto end
:failed
echo FAILED, see compile_gcc.log
echo FAILED >> compile_gcc.log
goto end
:clean
if exist bin rmdir /s /q bin
if exist compile_gcc.log del compile_gcc.log
:end
