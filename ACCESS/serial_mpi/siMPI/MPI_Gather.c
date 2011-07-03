/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Gather.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/* FILE  ******************       MPI_Gather.c       ************************/
/****************************************************************************/
/* Author : Lisa Alano July 16 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mpi.h"

/*==========================================================================*/
int MPI_Gather (void *sendbuf, int sendcnt, MPI_Datatype sendtype, void *recvbuf,
    int recvcnt, MPI_Datatype recvtype, int root, MPI_Comm comm)
{
  _MPI_COVERAGE();
  return PMPI_Gather(sendbuf, sendcnt, sendtype, recvbuf, recvcnt, recvtype, root, comm);
}
/*==========================================================================*/
