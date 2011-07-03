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
      INTEGER FUNCTION IDBLNK (IELBLK, IEL, IXELB, NUMLNK)
C=======================================================================
C$Id: idblnk.f,v 1.1 2008/10/31 05:04:00 gdsjaar Exp $
C$Log: idblnk.f,v $
CRevision 1.1  2008/10/31 05:04:00  gdsjaar
CMoved the applications into an applications subdirectory.
C
CRevision 1.1  2008/06/18 16:00:26  gdsjaar
CInitial adding of files to sourceforge
C
CRevision 1.2  2008/03/14 13:45:27  gdsjaar
CAdded copyright information to top of all files.
C
CALGEBRA2 is now open-sourced under BSD license
C
CRevision 1.1  1995/10/03 21:43:40  mksmith
CAdding files new to algII for algebra2
C
CRevision 1.1.1.1  1990/08/14 16:14:52  gdsjaar
CTesting
C
c Revision 1.1  90/08/14  16:14:51  gdsjaar
c Initial revision
c 
c Revision 1.1  90/08/09  13:39:29  gdsjaar
c Initial revision
c 

C   --*** IDBLNK *** (EXOLIB) Return link index
C   --   Written by Amy Gilkey - revised 12/03/87
C   --
C   --IDBLNK returns the link index of the element.
C   --
C   --Parameters:
C   --   IELBLK - IN/OUT - the element block number for IEL;
C   --      set if IELBLK <= 0
C   --   IEL - IN - the element number; assumed first in block if <= 0
C   --   IXELB - IN - the cumulative element counts by element block
C   --   NUMLNK - IN - the number of nodes per element

      INTEGER IXELB(0:*)
      INTEGER NUMLNK(*)

      IDBLNK = 1
      IF ((IELBLK .LE. 0) .AND. (IEL .LE. 0)) RETURN

      IF (IELBLK .LE. 0) THEN
         IELB = 0
  100    CONTINUE
         IF (IEL .GT. IXELB(IELB)) THEN
            IELB = IELB + 1
            GOTO 100
         END IF
         IELBLK = IELB
      END IF

      IDBLNK = 1
      DO 110 IELB = 1, IELBLK-1
         NEL = IXELB(IELB) - IXELB(IELB-1)
         IDBLNK = IDBLNK + NEL * NUMLNK(IELB)
  110 CONTINUE
      IF (IEL .GT. 0) THEN
         NEL = IEL - IXELB(IELBLK-1) - 1
         IDBLNK = IDBLNK + NEL * NUMLNK(IELBLK)
      END IF

      RETURN
      END
