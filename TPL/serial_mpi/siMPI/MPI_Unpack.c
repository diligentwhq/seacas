/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Unpack.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2006/08/10 22:26:03 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ***************************   MPI_Unpack.c  ************************/
/****************************************************************************/
/* Author : Lisa Alano July 24 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_Unpack ( void *inbuf, int insize, int *position, 
                void *outbuf, int outcount, MPI_Datatype datatype, 
                MPI_Comm comm )
{
  _MPI_COVERAGE();
  return PMPI_Unpack (inbuf, insize, position, outbuf, outcount, datatype, comm);
}

