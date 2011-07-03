/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_File_read_at.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ******************    MPI_File_read_at.c    ************************/
/****************************************************************************/
/* Author : Lisa Alano July 22 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_File_read_at(MPI_File fh, MPI_Offset offset, void *buf,
                   int count, MPI_Datatype datatype, MPI_Status *status)
{
  _MPI_COVERAGE();
  return PMPI_File_read_at (fh, offset, buf, count, datatype, status); 
}

