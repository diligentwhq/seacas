/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: PMPI_Type_extent.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2009/06/09 18:50:40 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/****************************************************************************/
/* FILE  *********************  PMPI_Type_extent.c   ************************/
/****************************************************************************/
/* Author : Lisa Alano July 24 2002                                         */
/* Copyright (c) 2002 University of California Regents                      */
/****************************************************************************/

#include "mpi.h"

int PMPI_Type_extent( MPI_Datatype datatype, MPI_Aint *extent )
{
  int index;
  if ( _MPI_BasicType(datatype) == MPI_SUCCESS )
    return _MPI_getSize(datatype);
  else
  {
    index = _MPI_FindType (datatype);
    if (index == _MPI_NOT_OK)
    { 
      _MPI_ERR_ROUTINE (MPI_ERR_TYPE, "MPI_TYPE_SIZE: datatype error");
      MPI_Abort (MPI_COMM_NULL, MPI_ERR_TYPE);
    }
    return _MPI_TYPE_LIST[index].extent;
  }

}

