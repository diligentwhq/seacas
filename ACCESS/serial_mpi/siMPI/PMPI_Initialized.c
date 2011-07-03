/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: PMPI_Initialized.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  *********************  PMPI_Initialized.c   ************************/
/****************************************************************************/
/* Author : Lisa Alano July 23 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int PMPI_Initialized( int *flag )
{
  int retval;
  retval = _MPI_checkIntP (flag);
  if (retval!=MPI_SUCCESS)
  {
    MPI_Abort((MPI_Comm)NULL, MPI_ERR_OTHER);
    return retval;
  }
  *flag = _MPI_INITIALIZED_FLAG;
  return MPI_SUCCESS; 
}

