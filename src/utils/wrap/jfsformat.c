/* jfsformat.c - stand-alone program around the 32-bit format routine of xmkfs.c.
   The original is only reachable through the 16-bit FORMAT entry point of UJFS.DLL (called by FORMAT.COM). */
#include <stdlib.h>

extern unsigned short format(unsigned short argc, unsigned char **argv, unsigned char **envp);

int main(int argc, char **argv)
{
    /* the routine expects argv[0] to be the function name and argv[1] the volume */
    return (int) format((unsigned short) argc, (unsigned char **) argv, NULL);
}
