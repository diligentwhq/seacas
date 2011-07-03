C Copyright(C) 2009 Sandia Corporation. Under the terms of Contract
C DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
C certain rights in this software.
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

C $Id: indexx.f,v 1.1 2009/03/25 04:47:53 gdsjaar Exp $
C $Log: indexx.f,v $
C Revision 1.1  2009/03/25 04:47:53  gdsjaar
C Added blotII2 source since Copyright was asserted.
C
C Update copyright notice in suplib.
C
C Add blotII2 to config files.  Note that blot will not build yet since
C it requires some libraries that are still being reviewed for copyright
C assertion.
C
C Revision 1.1  1994/04/07 20:03:36  gdsjaar
C Initial checkin of ACCESS/graphics/blotII2
C
c Revision 1.1  1992/12/02  19:20:39  gdsjaar
c Changed bubble sort in hidixf into heapsort using subroutine indexx.
c
c Revision 1.1  1992/09/10  19:26:22  gdsjaar
c Modified equiv routine to sort on x coordinate and fall into and out
c of loops at correct times based on the distance between the x
c coordinates of the two meshes.  Should ultimately do on the
c coordinate with the maximum range.
c
c Revision 1.1.1.1  1991/02/21  15:43:42  gdsjaar
c NUMBERS: Greg Sjaardema, initial Unix release
c
c Revision 1.1  1991/02/21  15:43:41  gdsjaar
c Initial revision
c
C -*- Mode: fortran -*-
      SUBROUTINE INDEXX (ARRAY, INDX, N, INIT)
C
C------------------------------------------------------------------------
C     SUBROUTINE INDEXX: Indexes an array ARRAY, that is
C           it outputs an array INDX such that ARRAY(INDX(J)) is in 
C           ascending order for J=1,2,...,N.  The input quantities N and 
C           ARRAY are not changed.
C       Uses the HEAPSORT technique from "Numerical Recipes," Press,
C         Flannery, Teukolsky, Vetterling, page 233.
C
C       Modified by Greg Sjaardema, 1521, 3 March 1989
C           Sorts a multirow array ARRAY(NROW, *) on row IROW
C
C     ARRAY (NROW, *)  -  Array to be sorted, sorted on column IROW
C     NROW             -  Row dimension of ARRAY
C     IROW             -  Row of ARRAY to be sorted
C     INDX  (modified) -  Sorted order of ARRAY
C     N                -  Number of elements in ARRAY
C     INIT             -  .FALSE. if INDX already setup
C                         .TRUE.  if INDX must be initialized
C------------------------------------------------------------------------
C
      DIMENSION ARRAY(*), INDX(*)
      LOGICAL   INIT
C
      IF (INIT) THEN
         DO 5 I=1, N
            INDX(I) = I
    5    CONTINUE
      END IF
C
      IF (N .LE. 1) RETURN
      L = N/2 + 1
      IR = N
C
   10 CONTINUE
         IF (L .GT. 1) THEN
C ... Still in ``hiring'' phase
            L = L - 1
            INDXT = INDX(L)
            Q = ARRAY(INDXT)
          ELSE
C ... In ``retirement-and-promotion'' phase.  
C     Clear a space at the end of the array
            INDXT = INDX(IR)
            Q = ARRAY(INDXT)
C ... Retire the top of the heap into it
            INDX(IR) = INDX(1)
C ... Decrease the size of the corporation
            IR = IR - 1
C ... Done with the last promotion
            IF (IR .EQ. 1) THEN
C ... The least competent worker of all
               INDX(1) = INDXT
               RETURN
            END IF
         END IF
C ... Whether in hiring phase or promotion phase, set up to sift down 
C       element Q to its proper level.
         I = L
         J = L + L
   20    CONTINUE
         IF (J .LE. IR) THEN
            IF (J .LT. IR) THEN
C ... Compare to the better underling
               IF (ARRAY(INDX(J)) .LT. ARRAY(INDX(J+1))) 
     *            J = J + 1
            END IF
            IF (Q .LT. ARRAY(INDX(J))) THEN
C ... Demote Q
               INDX(I) = INDX(J)
               I = J
               J = J + J
            ELSE
C ... This is Q's level.  Set J to terminate the sift-down.
               J = IR + 1
            END IF
         GO TO 20
         END IF
C ... Put Q into its slot
         INDX(I) = INDXT
      GO TO 10
      END
