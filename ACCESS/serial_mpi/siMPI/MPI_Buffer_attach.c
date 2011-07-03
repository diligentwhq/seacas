/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Buffer_attach.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:39 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ******************   MPI_Buffer_attach.c    ************************/
/****************************************************************************/
/* Author : Lisa Alano July 18 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

/* STUB */
int MPI_Buffer_attach( void *buffer, int size )
{
  _MPI_COVERAGE();
  return PMPI_Buffer_attach (buffer, size); 
}

