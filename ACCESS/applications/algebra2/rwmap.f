C    Copyright(C) 2008 Sandia Corporation.  Under the terms of Contract
C    DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
C    certain rights in this software
C    
C    Redistribution and use in source and binary forms, with or without
C    modification, are permitted provided that the following conditions are
C    met:
C    
C    * Redistributions of source code must retain the above copyright
C       notice, this list of conditions and the following disclaimer.
C              
C    * Redistributions in binary form must reproduce the above
C      copyright notice, this list of conditions and the following
C      disclaimer in the documentation and/or other materials provided
C      with the distribution.
C                            
C    * Neither the name of Sandia Corporation nor the names of its
C      contributors may be used to endorse or promote products derived
C      from this software without specific prior written permission.
C                                                    
C    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
C    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
C    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
C    A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
C    OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
C    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
C    LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
C    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
C    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
C    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
C    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
C    

C=======================================================================
      SUBROUTINE RWMAP (NDBIN, NDBOUT, NUMEL, NUMELO, IXELEM,
     &                  MAPEL, NEWIX)
C=======================================================================
C $Id: rwmap.f,v 1.1 2008/10/31 05:04:01 gdsjaar Exp $
C $Log: rwmap.f,v $
C Revision 1.1  2008/10/31 05:04:01  gdsjaar
C Moved the applications into an applications subdirectory.
C
C Revision 1.1  2008/06/18 16:00:27  gdsjaar
C Initial adding of files to sourceforge
C
C Revision 1.5  2008/03/14 13:45:29  gdsjaar
C Added copyright information to top of all files.
C
C ALGEBRA2 is now open-sourced under BSD license
C
C Revision 1.4  1996/02/12 21:28:48  caforsy
C Removed redundant checks for ExodusII API calls
C
C Revision 1.3  1995/10/03 21:36:38  mksmith
C Removing old algII files
C Replacing modified algII files
C
C Revision 1.2  1993/08/02 14:21:33  gdsjaar
C Split out common blocks into separare files. Miscellaneous bug fixes
C on several files.  First public release version.
C
c Revision 1.1  1993/07/30  21:43:41  gdsjaar
c Initial checkin of ACCESS/translate/algII
c
c Revision 1.1.1.1  1990/11/09  16:25:42  gdsjaar
c Algebra - Unix Version
c
c Revision 1.1  90/11/09  16:25:40  gdsjaar
c Initial revision
c 

C   --*** RWMAP *** (ALGEBRA) Read and write database element order map
C   --   Written by Amy Gilkey - revised 04/28/88
C   --   Modified for EXODUSIIV2 format 8/29/95
C   --
C   --RWMAP reads and writes the element order map to the database.
C   --Deleted elements are removed.
C   --
C   --Parameters:
C   --   NDBIN, NDBOUT - IN - the input and output database file
C   --   NUMEL  - IN - the number of elements
C   --   NUMELO - IN - the number of output elements
C   --   IXELEM - IN - the indices of the output elements (iff NUMELO <> NUMEL)
C   --   IOERR  - OUT - input/output error flag
C   --   MAPEL - SCRATCH - the element order map
C   --   NEWIX - SCRATCH - size = NUMEL (iff NUMELO <> NUMEL)
C   --
C   --Database must be positioned at start of map upon entry;
C   --upon exit at end of map.

      INTEGER IXELEM(*)
      INTEGER MAPEL(*)
      INTEGER NEWIX(*)

      call exgmap (ndbin, mapel, ierr)

      IF ((NUMELO .GT. 0) .AND. (NUMEL .NE. NUMELO)) THEN
         DO 100 IEL = 1, NUMEL
            NEWIX(IEL) = 0
  100    CONTINUE
         DO 110 IX = 1, NUMELO
            NEWIX(IXELEM(IX)) = IX
  110    CONTINUE
         IELO = 0
         DO 120 IEL = 1, NUMEL
            IF (NEWIX(MAPEL(IEL)) .GT. 0) THEN
               IELO = IELO + 1
               MAPEL(IELO) = NEWIX(MAPEL(IEL))
            END IF
  120    CONTINUE
      END IF

      call expmap(ndbout, mapel, ierr)

      RETURN
      END
