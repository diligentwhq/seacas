/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: PMPI_Type_get_envelope.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ****************  PMPI_Type_get_envelope.c  ************************/
/****************************************************************************/
/* Author : Lisa Alano July 24 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

/* STUB */
int PMPI_Type_get_envelope(
        MPI_Datatype datatype, 
        int *num_integers, 
        int *num_addresses, 
        int *num_datatypes, 
        int *combiner)
{
  fprintf(stderr,"%s:%d: NOT IMPLEMENTED\n",__FILE__,__LINE__);
  return MPI_Abort((MPI_Comm)NULL, MPI_UNDEFINED); 
}

