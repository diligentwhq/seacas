/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: PMPI_Graph_neighbors_count.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ************** PMPI_Graph_neighbors_count.c ************************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

/* STUB */
int PMPI_Graph_neighbors_count ( MPI_Comm comm, int rank, int *nneighbors )
{
  fprintf(stderr,"%s:%d: NOT IMPLEMENTED\n",__FILE__,__LINE__);
  return MPI_Abort((MPI_Comm)NULL, MPI_UNDEFINED); 
}
