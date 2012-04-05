/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Pack_size.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2006/08/10 22:26:03 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ************************  MPI_Pack_size.c   ************************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_Pack_size ( int incount, MPI_Datatype datatype, MPI_Comm comm, 
                   int *size )
{
  _MPI_COVERAGE();
  return PMPI_Pack_size (incount, datatype, comm, size);
}

