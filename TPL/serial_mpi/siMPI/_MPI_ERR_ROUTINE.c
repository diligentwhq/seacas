/*****************************************************************************
 * CVS File Information :
 *    $RCSfile: _MPI_ERR_ROUTINE.c,v $
 *    $Author: gdsjaar $
 *    $Date: 2006/08/10 22:26:03 $
 *    $Revision: 1.1 $
 ****************************************************************************/
/******************************************************************/
/* FILE  ***********    _MPI_ERR_ROUTINE.c     ********************/
/******************************************************************/
/* Author : Lisa Alano June 19 2002                               */
/* Copyright (c) 2002 University of California Regents            */
/******************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "mpi.h"

#ifndef _MPI_ERR_ROUT
#define _MPI_ERR_ROUT

int _MPI_ERR_ROUTINE(MPI_Error_Class error, char* message)
{
  _MPI_COVERAGE();
#ifdef _MPI_DEBUG
  printf("ERROR: %d %s\n",error, message);
#endif 
  return 0;
}

#endif
