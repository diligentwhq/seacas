/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Info_delete.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  **********************  MPI_Info_delete.c   ************************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_Info_delete(MPI_Info info, char *key)
{
  _MPI_COVERAGE();
  return PMPI_Info_delete(info, key);
}
