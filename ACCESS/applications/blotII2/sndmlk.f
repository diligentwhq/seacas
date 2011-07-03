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

C $Id: sndmlk.f,v 1.1 2009/03/25 04:47:54 gdsjaar Exp $
C $Log: sndmlk.f,v $
C Revision 1.1  2009/03/25 04:47:54  gdsjaar
C Added blotII2 source since Copyright was asserted.
C
C Update copyright notice in suplib.
C
C Add blotII2 to config files.  Note that blot will not build yet since
C it requires some libraries that are still being reviewed for copyright
C assertion.
C
C Revision 1.1  1994/04/07 20:12:57  gdsjaar
C Initial checkin of ACCESS/graphics/blotII2
C
c Revision 1.2  1990/12/14  08:57:41  gdsjaar
c Added RCS Id and Log to all files
c
C=======================================================================
      SUBROUTINE SNDMLK (OPTION, NELBLK, LENF, NLNKF, IF2EL, LINKF,
     &   NNPSUR, NPSURF, NPIX, INTPCK, *)
C=======================================================================

C   --*** SNDMLK *** (BLOT) Send surface face connectivity
C   --   Written by Amy Gilkey - revised 05/04/88
C   --
C   --SNDMLK sends the surface face connectivity.  The nodes in the
C   --connectivity are renumbered to include only surface nodes.
C   --
C   --Parameters:
C   --   OPTION - IN - '*' to send all, else message options:
C   --      'H' to send all header information
C   --      'C' to send connectivity
C   --      'E' to send element number
C   --   NELBLK - IN - the number of element blocks
C   --   LENF - IN - the cumulative face count by block (if OPTION)
C   --   NLNKF - IN - the number of nodes per face in each block (if OPTION)
C   --   IF2EL - IN - the element number for each face (if OPTION)
C   --   LINKF - IN - the face connectivity for each block (if OPTION)
C   --   NNPSUR - IN - the number of surface nodes (if nodal)
C   --   NPSURF - IN - the indices of the surface nodes (if nodal)
C   --   NPIX - IN - size = NUMNP
C   --   INTPCK - SCRATCH - size = size of LINKF
C   --   * - return statement if message error

      CHARACTER*(*) OPTION
      INTEGER LENF(0:*)
      INTEGER NLNKF(*)
      INTEGER IF2EL(*)
      INTEGER LINKF(*)
      INTEGER NPSURF(*)
      INTEGER NPIX(*)
      INTEGER INTPCK(*)

      INTEGER PUTIR
      CHARACTER*8 TAG
      LOGICAL ISOK

      IF ((OPTION .EQ. '*') .OR. (INDEX (OPTION, 'H') .GT. 0)) THEN
         TAG = 'MESHBLOC'
         L = NELBLK
         IERR = PUTIR (TAG, LENF(1), L)
         CALL CHKPUT (IERR, TAG, L, ISOK)
         IF (.NOT. ISOK) RETURN 1

         TAG = 'MESHBLOC'
         L = NELBLK
         IERR = PUTIR (TAG, NLNKF, L)
         CALL CHKPUT (IERR, TAG, L, ISOK)
         IF (.NOT. ISOK) RETURN 1
      END IF

      IF ((OPTION .EQ. '*') .OR. (INDEX (OPTION, 'C') .GT. 0)) THEN
         DO 100 I = 1, NNPSUR
            NPIX(NPSURF(I)) = I
  100    CONTINUE

         CALL CNTLNK (NELBLK, LENF, NLNKF, N, IDUM)
         DO 110 I = 1, N
            INTPCK(I) = NPIX(LINKF(I))
  110    CONTINUE

         TAG = 'MESHBLOC'
         L = N
         IERR = PUTIR (TAG, INTPCK, L)
         CALL CHKPUT (IERR, TAG, L, ISOK)
         IF (.NOT. ISOK) RETURN 1
      END IF

      IF ((OPTION .EQ. '*') .OR. (INDEX (OPTION, 'E') .GT. 0)) THEN
         TAG = 'MESHBLOC'
         L = LENF(NELBLK)
         IERR = PUTIR (TAG, IF2EL, L)
         CALL CHKPUT (IERR, TAG, L, ISOK)
         IF (.NOT. ISOK) RETURN 1
      END IF

      RETURN
      END
