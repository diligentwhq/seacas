/*
 * Copyright (C) 2009 Sandia Corporation.  Under the terms of Contract
 * DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
 * certain rights in this software
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 * 
 *     * Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *       with the distribution.
 * 
 *     * Neither the name of Sandia Corporation nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 */
/*====================================================================
 * ------------------------
 * | CVS File Information |
 * ------------------------
 *
 * $RCSfile: md_wrap_intel_c.c,v $
 *
 * $Author: gdsjaar $
 *
 * $Date: 2009/06/09 13:32:43 $
 *
 * $Revision: 1.1 $
 *
 * $Name:  $
 *====================================================================*/

/*******************************************************************************
 * Copyright 1995, Sandia Corporation.  The United States Government retains a *
 * nonexclusive license in this software as prescribed in AL 88-1 and AL 91-7. *
 * Export of this program may require a license from the United States         *
 * Government.                                                                 *
 ******************************************************************************/

#include <stdio.h>
#include <signal.h>

#ifdef MPI
#include <mpi.h>
#else
#define MPI_Request int
#endif

#define nCUBE 1
#define INTEL 2
#define SUN   3
#define DELTA 4
#define MACHINE INTEL
#define CUBESIZ 4096 /* a power of two >= number of processors */

/******************************************************************************/
/******************************************************************************/
/******************************************************************************/

void get_parallel_info(int *proc, int *nprocs, int *dim)

{
  *proc   = mynode();
  *nprocs = numnodes();
  *dim    = 0;

} /* get_parallel_info */

/******************************************************************************/
/******************************************************************************/
/******************************************************************************/

int md_read(char *buf, int bytes, int *source, int *type, int *flag)

{
  /*
    extern int Me, Numnodes;
    */

  long int info[8];
  long     lflag;

  crecvx(*type, buf, (long) bytes, *source, -1, info);

  if ((*source == -1) || (*type == -1)) {
     *type   = info[0];
     *source = info[2];
  }

  return ((int) info[1]);

} /* md_read */

/******************************************************************************/
/******************************************************************************/
/******************************************************************************/

int md_write(char *buf, int bytes, int dest, int type, int *flag)

{
  /*
    extern int Me;
     */
  int  Me;
  long lflag;

  Me    = mynode();
  lflag = type * CUBESIZ + Me;

  /* dest=0xffff broadcasts to the current process on all of the nodes. */

  if (dest == 0xffff)
    csend(lflag, buf,(long) bytes, -1L, 0L); /* to everyone */
  else
    csend(type, buf, (long) bytes, (long) dest, 0L);

  return 0;

} /* md_write */

/******************************************************************************/
/******************************************************************************/
/******************************************************************************/

int md_wrap_iread(void *buf, int bytes, int *source, int *type,
                  MPI_Request *request)


/*******************************************************************************

  Machine dependent wrapped message-reading communication routine for the
  Intel.  This routine is a simple no-op but is used in order to provide
  compatibility with the MPI communication routine order.

  Author:          Scott A. Hutchinson, SNL, 9221
  =======

  Return code:     int
  ============

  Parameter list:
  ===============

  buf:             Beginning address of data to be sent.

  bytes:           Length of message in bytes.

  source:          Source processor number.

  type:            Message type

*******************************************************************************/

{

  return 0;

} /* md_wrap_iread */

/******************************************************************************/
/******************************************************************************/
/******************************************************************************/

int md_wrap_write(void *buf, int bytes, int dest, int type, int *flag)

/*******************************************************************************

  Machine dependent wrapped message-sending communication routine for the
  Intel.  This routine is exactly the same as md_write.

  Author:          Scott A. Hutchinson, SNL, 9221
  =======

  Return code:     int
  ============

  Parameter list:
  ===============

  buf:             Beginning address of data to be sent.

  bytes:           Length of message in bytes.

  dest:            Destination processor number.

  type:            Message type

  flag:

*******************************************************************************/

{

  int  Me;
  long lflag;

  Me    = mynode();
  lflag = type * CUBESIZ + Me;

  /* dest=0xffff broadcasts to the current process on all of the nodes. */

  if (dest == 0xffff)
    csend(lflag, buf,(long) bytes, -1L, 0L); /* to everyone */
  else
    csend(type, buf, (long) bytes, (long) dest, 0L);

  return 0;

} /* md_wrap_write */

/******************************************************************************/
/******************************************************************************/
/******************************************************************************/

int md_wrap_wait(void *buf, int bytes, int *source, int *type, int *flag,
                 MPI_Request *request)

/*******************************************************************************

  Machine dependent wrapped message-wait communication routine for the Intel.
  This routine is identical to md_read but is put here in order to be compatible
  with the order required to do MPI communication.

  Author:          Scott A. Hutchinson, SNL, 9221
  =======

  Return code:     int
  ============

  Parameter list:
  ===============

  buf:             Beginning address of data to be sent.

  bytes:           Length of message in bytes.
  dest:            Destination processor number.

  type:            Message type

  flag:

*******************************************************************************/

{

  long int info[8];

  crecvx(*type, buf, (long) bytes, *source, -1, info);

  if ((*source == -1) || (*type == -1)) {
     *type   = info[0];
     *source = info[2];
  }

  return ((int) info[1]);

} /* md_wrap_wait */

/******************************************************************************/
/******************************************************************************/
/******************************************************************************/

/*
 * This section is used to kill the program on all nodes when an "exit" is
 * called from the program.  The "exit" call must be redefined in a header file
 * (e.g., rf_salsa.h) to mean "osf_exit" when being compiled for OSF on the
 * Intel.  Make sure -DPARA is used when compiling.
 */


int osf_exit(int ignore, char *fname, int lno)

{
  fprintf(stderr, "global exit called from %s at line %d\n",
          fname, lno);
  fprintf(stderr, "Killing all nodes due to error.\n");
  kill(0, SIGKILL);
}
