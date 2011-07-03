/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Allgather.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:39 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ******************     MPI_Allgather.c      ************************/
/****************************************************************************/
/* Author : Lisa Alano July 17 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

/* STUB */
int MPI_Allgather ( void *sendbuf, int sendcount, MPI_Datatype sendtype,
                    void *recvbuf, int recvcount, MPI_Datatype recvtype, 
                   MPI_Comm comm )
{
  _MPI_COVERAGE();
  return PMPI_Allgather (sendbuf, sendcount, sendtype, recvbuf, recvcount, recvtype, comm); 
}

