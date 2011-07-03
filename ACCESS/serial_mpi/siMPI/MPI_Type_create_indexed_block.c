/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Type_create_indexed_block.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  *************** MPI_Type_create_indexed_block.c ********************/
/****************************************************************************/
/* Author : Lisa Alano July 24 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_Type_create_indexed_block( 
        int count, 
        int blocklength, 
        int array_of_displacements[], 
        MPI_Datatype old_type, 
        MPI_Datatype *newtype )
{
  _MPI_COVERAGE();
  return PMPI_Type_create_indexed_block (count, blocklength, array_of_displacements, old_type, newtype);
}

