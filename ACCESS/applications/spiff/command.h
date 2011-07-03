/*                        Copyright (c) 1988 Bellcore
**                            All Rights Reserved
**       Permission is granted to copy or use this program, EXCEPT that it
**       may not be sold for profit, the copyright notice must be reproduced
**       on copies, and credit should be given to Bellcore where it is due.
**       BELLCORE MAKES NO WARRANTY AND ACCEPTS NO LIABILITY FOR THIS PROGRAM.
*/

#ifndef C_INCLUDED
extern int C_is_cmd(char *input_line);
extern void C_clear_cmd(void);
extern void C_addcmd(char *str);
extern void C_docmds(void);

#define _C_CMDMAX	100

#define C_INCLUDED
#endif
