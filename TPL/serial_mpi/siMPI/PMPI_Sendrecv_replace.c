/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: PMPI_Sendrecv_replace.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2006/08/10 22:26:03 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  ****************  PMPI_Sendrecv_replace.c   ************************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

/* STUB */
int PMPI_Sendrecv_replace( void *buf, int count, MPI_Datatype datatype, 
                        int dest, int sendtag, int source, int recvtag, 
                        MPI_Comm comm, MPI_Status *status )
{
  fprintf(stderr,"%s:%d: NOT IMPLEMENTED\n",__FILE__,__LINE__);
  return MPI_Abort((MPI_Comm)NULL, MPI_UNDEFINED); 
}

