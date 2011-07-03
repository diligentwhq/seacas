/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Type_get_contents.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ****************** MPI_Type_get_contents.c  ************************/
/****************************************************************************/
/* Author : Lisa Alano July 24 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_Type_get_contents(
        MPI_Datatype datatype, 
        int max_integers, 
        int max_addresses, 
        int max_datatypes, 
        int *array_of_integers, 
        MPI_Aint *array_of_addresses, 
        MPI_Datatype *array_of_datatypes)
{
  _MPI_COVERAGE();
  return PMPI_Type_get_contents (datatype, max_integers, max_addresses, max_datatypes, 
               array_of_integers, array_of_addresses, array_of_datatypes);
}

