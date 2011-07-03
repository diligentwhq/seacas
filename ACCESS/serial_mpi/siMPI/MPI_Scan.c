/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Scan.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  *************************  MPI_Scan.c   ****************************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_Scan ( void *sendbuf, void *recvbuf, int count, MPI_Datatype datatype,
               MPI_Op op, MPI_Comm comm )
{
  _MPI_COVERAGE();
  return PMPI_Scan(sendbuf, recvbuf, count, datatype, op, comm);
}

