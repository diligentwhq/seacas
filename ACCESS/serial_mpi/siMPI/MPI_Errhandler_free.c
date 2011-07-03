/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Errhandler_free.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ******************  MPI_Errhandler_free.c   ************************/
/****************************************************************************/
/* Author : Lisa Alano July 24 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_Errhandler_free( MPI_Errhandler *errhandler )
{
  _MPI_COVERAGE();
  return PMPI_Errhandler_free (errhandler);
}

