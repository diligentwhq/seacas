/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: PMPI_Type_create_subarray.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2006/08/10 22:26:03 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  *************** PMPI_Type_create_subarray.c ************************/
/****************************************************************************/
/* Author : Lisa Alano July 24 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

/* STUB */
int PMPI_Type_create_subarray(
        int ndims, 
        int *array_of_sizes, 
        int *array_of_subsizes, 
        int *array_of_starts, 
        int order, 
        MPI_Datatype oldtype, 
        MPI_Datatype *newtype)
{
  fprintf(stderr,"%s:%d: NOT IMPLEMENTED\n",__FILE__,__LINE__);
  return MPI_Abort((MPI_Comm)NULL, MPI_UNDEFINED); 
}

