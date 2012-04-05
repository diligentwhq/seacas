/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: PMPI_Allgatherv.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2006/08/10 22:26:03 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ******************     PMPI_Allgatherv.c    ************************/
/****************************************************************************/
/* Author : Lisa Alano July 17 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

/* STUB */
int PMPI_Allgatherv ( void *sendbuf, int sendcount, MPI_Datatype sendtype, 
                     void *recvbuf, int *recvcounts, int *displs, 
                    MPI_Datatype recvtype, MPI_Comm comm )
{
  _MPI_COVERAGE();
  if ( recvcounts == 0 ) return MPI_ERR_ARG;
  return PMPI_Gather(sendbuf,sendcount,sendtype,recvbuf,*recvcounts,recvtype,0,comm);
}

