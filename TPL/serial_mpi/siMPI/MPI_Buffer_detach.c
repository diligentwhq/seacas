/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Buffer_detach.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2006/08/10 22:26:03 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ******************   MPI_Buffer_detach.c    ************************/
/****************************************************************************/
/* Author : Lisa Alano July 18 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

/* STUB */
int MPI_Buffer_detach( void *bufferptr, int *size)
{
  _MPI_COVERAGE();
  return PMPI_Buffer_detach (bufferptr, size); 
}

