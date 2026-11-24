/* jfschk.c - stand-alone program around chkdsk32 of xchkdsk.c.
   The original is reached through the CHKDSK and chkdsk32 entry points of UJFS.DLL (called by CHKDSK.COM / JFSCHK32.EXE). */
extern int chkdsk32(int argc, char **argv);

int main(int argc, char **argv)
{
    return chkdsk32(argc, argv);
}
