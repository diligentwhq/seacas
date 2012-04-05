/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_File_write_all_begin.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2006/08/10 22:26:03 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  **************  MPI_File_write_all_begin.c  ************************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_File_write_all_begin(MPI_File fh, void *buf, int count, 
                            MPI_Datatype datatype)
{
  _MPI_COVERAGE();
  return PMPI_File_write_all_begin (fh, buf, count, datatype); 
}

