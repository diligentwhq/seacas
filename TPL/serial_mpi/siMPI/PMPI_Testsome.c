/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: PMPI_Testsome.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2006/08/10 22:26:03 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ************************  PMPI_Testsome.c   ************************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

/* STUB */
int PMPI_Testsome( 
        int incount, 
        MPI_Request array_of_requests[], 
        int *outcount, 
        int array_of_indices[], 
        MPI_Status array_of_statuses[] )
{
  fprintf(stderr,"%s:%d: NOT IMPLEMENTED\n",__FILE__,__LINE__);
  return MPI_Abort((MPI_Comm)NULL, MPI_UNDEFINED); 
}

