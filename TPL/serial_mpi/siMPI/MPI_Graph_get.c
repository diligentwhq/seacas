/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Graph_get.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2006/08/10 22:26:03 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ************************  MPI_Graph_get.c   ************************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_Graph_get ( MPI_Comm comm, int maxindex, int maxedges, 
                   int *index, int *edges )
{
  _MPI_COVERAGE();
  return PMPI_Graph_get (comm, maxindex, maxedges, index, edges);
}

