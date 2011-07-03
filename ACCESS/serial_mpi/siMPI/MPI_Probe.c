/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Probe.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  *************************  MPI_Probe.c   ***************************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int MPI_Probe( int source, int tag, MPI_Comm comm, MPI_Status *status )
{
  _MPI_COVERAGE();
  return PMPI_Probe (source, tag, comm, status);
}

