/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: MPI_Isend.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2006/08/10 22:26:03 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/***********************************************************************************************/
/* FILE  **************************      MPI_Isend.c           *********************************/
/***********************************************************************************************/
/* Author : Lisa Alano June 27 2002                                                            */
/* Copyright (c) 2002 University of California Regents                                         */
/***********************************************************************************************/

#include "mpi.h"

/*=============================================================================================*/
int MPI_Isend (void* message, int count, MPI_Datatype datatype, int dest,
        int tag, MPI_Comm comm, MPI_Request* request)
{
  _MPI_COVERAGE();
  return PMPI_Isend(message, count, datatype, dest, tag, comm, request); 
}
/*=============================================================================================*/
