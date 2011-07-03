C Copyright (C) 2009 Sandia Corporation.  Under the terms of Contract
C DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
C certain rights in this software
C 
C Redistribution and use in source and binary forms, with or without
C modification, are permitted provided that the following conditions are
C met:
C 
C     * Redistributions of source code must retain the above copyright
C       notice, this list of conditions and the following disclaimer.
C 
C     * Redistributions in binary form must reproduce the above
C       copyright notice, this list of conditions and the following
C       disclaimer in the documentation and/or other materials provided
C       with the distribution.
C 
C     * Neither the name of Sandia Corporation nor the names of its
C       contributors may be used to endorse or promote products derived
C       from this software without specific prior written permission.
C 
C THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
C "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
C LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
C A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
C OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
C SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
C LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
C DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
C THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
C (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
C OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
C 

C=======================================================================
      SUBROUTINE DBIST2 (NDB, NVAREL,  NELBLK, NELBDM, ISEVOK,
     $     VAREL, NUMELB, IVAR, IELB, *)
C=======================================================================
C$Id: dbist2.f,v 1.1 2009/06/09 13:32:43 gdsjaar Exp $
C$Log: dbist2.f,v $
CRevision 1.1  2009/06/09 13:32:43  gdsjaar
CReceived permission to assert copyright on nem_spread and ex1ex2v2.
C
CBoth are released under the BSD Open Source licence.
C
CRevision 1.1  1994/01/24 23:00:53  vryarbe
CInitial revision
C
c Revision 1.4  1992/04/08  21:13:22  gdsjaar
c Fixed problem with singly accessing doubly dimensioned array
c Added params to dbist2 and dbist1 so error messages would print
c
c Revision 1.3  1990/11/30  09:50:50  gdsjaar
c Modified to work on Unicos
c
c Revision 1.1.1.1  90/08/14  16:13:01  gdsjaar
c Testing
c 
c Revision 1.1  90/08/14  16:13:00  gdsjaar
c Initial revision
c 
c Revision 1.1  90/08/09  13:39:12  gdsjaar
c Initial revision
c 

C   --*** DBIST2 *** (EXOLIB) Internal to DBISTE, Read element variables 
C   --   Written by Greg Sjaardema 8/8/90, to remove MAX from dimensions
C   --
C   --DBIST2 reads the database element variables for one time step.
C   --
C   --Parameters:
C   --   NDB - IN - the database number
C   --   NVAREL - IN - the number of element variables
C   --   NVARDM - IN - the row dimension of VAREL
C   --   NELBLK - IN - the number of element blocks
C   --   NELBDM - IN - the row dimension of ISEVOK
C   --   ISEVOK - IN - the element block variable truth table;
C   --      variable i of block j exists iff ISEVOK(j,i)
C   --   VAREL - OUT - the element variables for the time step (if OPTION)
C   --   IVAR  - OUT - the nodal variable number if error on read.
C   --   IELB  - OUT - the element block number if error on read.
C   --   * - return statement if error encountered, including end-of-file;
C   --      message is printed
C   --
      INTEGER NDB
      INTEGER NVAREL, NELBLK, NELBDM
      INTEGER NUMELB(*)
c      LOGICAL ISEVOK(nvarel,*)
      integer ISEVOK(nvarel,*)
      REAL VAREL(*)

      IELo = 0
      DO 130 IELB = 1, NELBLK
         DO 120 IVAR = 1, NVAREL
            IF (ISEVOK(IVAR,IELB) .ne. 0) THEN
               READ (NDB, END=200, ERR=200, IOSTAT=IERR)
     &              (VAREL(IELo+N), N=1,NUMELB(IELB))
               ielo=ielo+numelb(ielb)
            END IF
  120    CONTINUE
  130 CONTINUE
      RETURN
  200 CONTINUE
      RETURN 1
      END
