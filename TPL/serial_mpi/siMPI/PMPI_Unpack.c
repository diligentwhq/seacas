/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: PMPI_Unpack.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2006/08/10 22:26:03 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  **************************  PMPI_Unpack.c   ************************/
/****************************************************************************/
/* Author : Lisa Alano July 24 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

/* STUB */
int PMPI_Unpack ( void *inbuf, int insize, int *position, 
                void *outbuf, int outcount, MPI_Datatype datatype, 
                MPI_Comm comm )
{
  return MPI_Abort((MPI_Comm)0, MPI_UNDEFINED); 
}

