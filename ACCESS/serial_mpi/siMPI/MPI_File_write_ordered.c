/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_File_write_ordered.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ****************** MPI_File_write_ordered.c  ***********************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_File_write_ordered(MPI_File fh, void *buf, int count, 
                         MPI_Datatype datatype, MPI_Status *status)
{
  _MPI_COVERAGE();
  return PMPI_File_write_ordered (fh, buf, count, datatype, status);
}
