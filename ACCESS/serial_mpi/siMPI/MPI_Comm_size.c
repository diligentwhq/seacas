/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Comm_size.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/******************************************************************/
/* FILE  ***********    MPI_Comm_size.c        ********************/
/******************************************************************/
/* Author : Lisa Alano June 19 2002                               */
/* Copyright (c) 2002 University of California Regents            */
/******************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "mpi.h"


int MPI_Comm_size(MPI_Comm comm, int* size)
{
  _MPI_COVERAGE();
  return PMPI_Comm_size(comm, size);
}

