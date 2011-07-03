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

C $Id: sndnps.f,v 1.1 2009/03/25 04:47:54 gdsjaar Exp $
C $Log: sndnps.f,v $
C Revision 1.1  2009/03/25 04:47:54  gdsjaar
C Added blotII2 source since Copyright was asserted.
C
C Update copyright notice in suplib.
C
C Add blotII2 to config files.  Note that blot will not build yet since
C it requires some libraries that are still being reviewed for copyright
C assertion.
C
C Revision 1.1  1994/04/07 20:13:14  gdsjaar
C Initial checkin of ACCESS/graphics/blotII2
C
c Revision 1.2  1990/12/14  08:57:48  gdsjaar
c Added RCS Id and Log to all files
c
C=======================================================================
      SUBROUTINE SNDNPS (OPTION, NUMNPS, LNPSNL,
     &   IDNPS, NNNPS, IXNNPS, LTNNPS, FACNPS, INTPCK, *)
C=======================================================================

C   --*** SNDNPS *** (BLOT) Send database node sets
C   --   Written by Amy Gilkey - revised 05/04/88
C   --
C   --SNDNPS sends the node set information as a message.
C   --
C   --Parameters:
C   --   OPTION - IN - '*' to send all, else message options:
C   --      'H' to send information about node sets
C   --      'N' to send node set nodes
C   --      'F' to send node set factors
C   --   NUMNPS - IN - the number of node sets
C   --   LNPSNL - IN - the length of the node sets node list
C   --   IDNPS - IN - the node set ID for each set (if OPTION)
C   --   NNNPS - IN - the number of nodes for each set (if OPTION)
C   --   IXNNPS - IN - the index of the first node for each set (if OPTION)
C   --   LTNNPS - IN - the nodes for all sets (if OPTION)
C   --   FACNPS - IN - the distribution factors for all sets (if OPTION)
C   --   INTPCK - SCRATCH - size = 3 * NUMNPS
C   --   * - return statement if message error

      CHARACTER*(*) OPTION
      INTEGER IDNPS(*)
      INTEGER NNNPS(*)
      INTEGER IXNNPS(*)
      INTEGER LTNNPS(*)
      REAL FACNPS(*)
      INTEGER INTPCK(*)

      INTEGER PUTIR, PUTRR
      CHARACTER*8 TAG
      LOGICAL ISOK

      IF (NUMNPS .LE. 0) RETURN

      IF ((OPTION .EQ. '*') .OR. (INDEX (OPTION, 'H') .GT. 0)) THEN
         N = 0
         CALL CPYINT (NUMNPS, IDNPS, INTPCK(N+1))
         N = N + NUMNPS
         CALL CPYINT (NUMNPS, NNNPS, INTPCK(N+1))
         N = N + NUMNPS
         CALL CPYINT (NUMNPS, IXNNPS, INTPCK(N+1))
         N = N + NUMNPS

         TAG = 'NSETS'
         L = N
         IERR = PUTIR (TAG, INTPCK, L)
         CALL CHKPUT (IERR, TAG, L, ISOK)
         IF (.NOT. ISOK) RETURN 1
      END IF

      IF ((OPTION .EQ. '*') .OR. (INDEX (OPTION, 'N') .GT. 0)) THEN
         TAG = 'NSETS'
         L = LNPSNL
         IERR = PUTIR (TAG, LTNNPS, L)
         CALL CHKPUT (IERR, TAG, L, ISOK)
         IF (.NOT. ISOK) RETURN 1
      END IF

      IF ((OPTION .EQ. '*') .OR. (INDEX (OPTION, 'F') .GT. 0)) THEN
         TAG = 'NSETS'
         L = LNPSNL
         IERR = PUTRR (TAG, FACNPS, L)
         CALL CHKPUT (IERR, TAG, L, ISOK)
         IF (.NOT. ISOK) RETURN 1
      END IF

      RETURN
      END
