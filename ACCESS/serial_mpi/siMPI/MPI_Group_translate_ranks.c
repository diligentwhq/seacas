/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Group_translate_ranks.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ************  MPI_Group_translate_ranks.c   ************************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_Group_translate_ranks ( MPI_Group group_a, int n, int *ranks_a, 
                             MPI_Group group_b, int *ranks_b )
{
  _MPI_COVERAGE();
  return PMPI_Group_translate_ranks (group_a, n, ranks_a, group_b, ranks_b);
}

