/*
 * uisubs.c - prompt() and more() for xpeek
 *
 * These two routines are in libfs/utilsubs.c of the original, but only when _JFS_DEBUG is defined (the original
 * build of xpeek was a debug build). The library of this build is not a debug build, so xpeek has its own copy.
 * Copied from utilsubs.c: Copyright (c) International Business Machines Corp., 2000, GNU GPL v2 or later.
 */
#include <stdio.h>
#include "jfs_types.h"
#include "xpeek.h"

/*
 *	prompt()
 */
char prompt(
	char	*str)
{
	char cmd[81];

	fputs(str, stdout);
	fflush(stdout);

	/* get NULL terminated input (exclude \n) */
	gets(cmd);

	return cmd[0]; /* return response letter */
}


/*
 *	more()
 */
int32 more(void)
{
	char cmd[81];

	fputs("- hit Enter to continue, e[x]it -", stdout);
	fflush(stdout);

	/* get NULL terminated input (exclude \n) */
	gets(cmd);

	if (cmd[0])
		return 0; /* do NOT continue */
	else
		return 1; /* continue */
}
