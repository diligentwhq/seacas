/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Recv_init.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  **********************  MPI_Recv_init.c   **************************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_Recv_init( void *buf, int count, MPI_Datatype datatype, int source, 
                  int tag, MPI_Comm comm, MPI_Request *request )
{
  _MPI_COVERAGE();
  return PMPI_Recv_init (buf, count, datatype, source, tag, comm, request);
}
