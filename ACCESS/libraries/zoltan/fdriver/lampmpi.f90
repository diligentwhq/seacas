!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Zoltan Library for Parallel Applications                                   !
! For more info, see the README file in the top-level Zoltan directory.      ! 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!  CVS File Information :
!     $RCSfile: lampmpi.f90,v $
!     $Author: gdsjaar $
!     $Date: 2009/06/09 18:37:57 $
!     Revision: 1.4 $
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

! LAM 6.3 beta 2 contains external PMPI_WTIME, PMPI_WTICK in mpif.h but
! does not define those routines in the library.  This causes an unresoved
! reference error with some compilers.  This file contains dummy routines
! for them to resolve the symbols.

      subroutine pmpi_wtime()
      end subroutine pmpi_wtime

      subroutine pmpi_wtick()
      end subroutine pmpi_wtick
