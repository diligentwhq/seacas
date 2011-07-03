/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Pack.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ****************************   MPI_Pack.c   ************************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_Pack ( void *inbuf, int incount, MPI_Datatype datatype, 
               void *outbuf, int outcount, int *position, MPI_Comm comm )
{
  _MPI_COVERAGE();
  return PMPI_Pack (inbuf, incount, datatype, outbuf, outcount, position, comm);
}

