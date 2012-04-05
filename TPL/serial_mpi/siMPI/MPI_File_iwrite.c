/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_File_iwrite.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2006/08/10 22:26:03 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ******************   MPI_File_iwrite.c      ************************/
/****************************************************************************/
/* Author : Lisa Alano July 22 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

/* STUB */
int MPI_File_iwrite(MPI_File fh, void *buf, int count, 
                    MPI_Datatype datatype, MPIO_Request *request)
{
  _MPI_COVERAGE();
  return PMPI_File_iwrite(fh, buf, count, datatype, request); 
}

