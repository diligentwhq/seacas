/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_File_write_at.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2006/08/10 22:26:03 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ******************    MPI_File_write_at.c   ************************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_File_write_at(MPI_File fh, MPI_Offset offset, void *buf,
                      int count, MPI_Datatype datatype, 
                      MPI_Status *status)
{
  _MPI_COVERAGE();
  return PMPI_File_write_at (fh, offset, buf, count, datatype, status); 
}

