/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_File_get_position_shared.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  **********  MPI_File_get_position_shared.c ************************/
/****************************************************************************/
/* Author : Lisa Alano July 22 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

/* STUB */
int MPI_File_get_position_shared(MPI_File fh, MPI_Offset *offset)
{
  _MPI_COVERAGE();
  return PMPI_File_get_position_shared(fh, offset); 
}

