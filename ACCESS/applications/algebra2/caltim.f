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
      SUBROUTINE CALTIM (TMIN, TMAX, DELT, NINTV,
     &                   NSTEPS, TIMES, NPTIMS, IPTIMS)
C=======================================================================
C $Id: caltim.f,v 1.1 2008/10/31 05:04:00 gdsjaar Exp $
C $Log: caltim.f,v $
C Revision 1.1  2008/10/31 05:04:00  gdsjaar
C Moved the applications into an applications subdirectory.
C
C Revision 1.1  2008/06/18 16:00:25  gdsjaar
C Initial adding of files to sourceforge
C
C Revision 1.4  2008/03/14 13:45:25  gdsjaar
C Added copyright information to top of all files.
C
C ALGEBRA2 is now open-sourced under BSD license
C
C Revision 1.3  1995/10/03 21:35:57  mksmith
C Removing old algII files
C Replacing modified algII files
C
C Revision 1.2  1993/08/02 14:20:36  gdsjaar
C Split out common blocks into separare files. Miscellaneous bug fixes
C on several files.  First public release version.
C
c Revision 1.1  1993/07/30  21:41:46  gdsjaar
c Initial checkin of ACCESS/translate/algII
c
c Revision 1.1.1.1  1990/11/09  16:23:29  gdsjaar
c Algebra - Unix Version
c
c Revision 1.1  90/11/09  16:23:28  gdsjaar
c Initial revision
c 

C   --*** CALTIM *** (TIMSEL) Calculate the selected times
C   --   Written by Amy Gilkey - revised 11/10/87
C   --
C   --CALTIM calculates the selected times based on the time
C   --parameters.  The calculation is done only if the number of selected
C   --times is less than 0.
C   --
C   --Parameters:
C   --   TMIN - IN - the minimum selected time
C   --   TMAX - IN - the maximum selected time
C   --   DELT - IN - the interval between selected times
C   --      0 < - user selected times mode
C   --      0 = - all available times mode
C   --      0 > - uniform time interval mode (dependent on NINTV if <> 0)
C   --   NINTV - IN - in user selected times mode, the number of times;
C   --      in uniform time interval mode, negative if zero interval
C   --   NSTEPS - IN - the number of time steps
C   --   TIMES - IN - the database times
C   --   NPTIMS - IN/OUT - the number of selected times; the
C   --      calculation is done only if this is negative
C   --   IPTIMS - IN/OUT - the selected time steps

C   --Routines Called:
C   --   LOCREA - (ETCLIB) Locate closest value
C   --   NUMEQL - (ETCLIB) Count the number of equal values

      REAL TMIN, TMAX, DELT
      INTEGER NINTV
      INTEGER NSTEPS
      REAL TIMES(*)
      INTEGER NPTIMS
      INTEGER IPTIMS(*)

      LOGICAL DOSORT

      IF (NPTIMS .GE. 0) RETURN

      NSTEPX = NSTEPS

      DOSORT = .FALSE.

      IF (NSTEPX .EQ. 0) THEN

C      --Check for no time steps

         NPTIMS = 0
         TMIN = 0.0
         TMAX = 0.0
         DELT = 0.0
         NINTV = 0

      ELSE IF (DELT .GT. 0.0) THEN

C      --Select database time steps between TMIN and TMAX at interval DELT

         IF (TMIN .GT. TMAX) THEN
            NPTIMS = 0
         ELSE IF (TMIN .EQ. TMAX) THEN
            IPTIMS(1) = LOCREA (TMIN, NSTEPS, TIMES)
            NPTIMS = 1
         ELSE
            IF (NINTV .GT. 0) THEN
               IS = 1
               IE = NINTV
               DELT = (TMAX - TMIN) / NINTV
            ELSE IF (NINTV .LT. 0) THEN
               IS = 0
               IE = - NINTV - 1
               IF (NINTV .NE. -1) DELT = (TMAX - TMIN) / (-NINTV-1)
            ELSE
               IS = 0
               TIMMAX = TMAX + 0.01*DELT
               IE = INT ((TIMMAX - TMIN) / DELT)
            END IF

            ILAST = 0
            N = 0
            DO 100 I = IS, IE
               T = TMIN + DELT*I
               ITHIS = LOCREA (T, NSTEPS, TIMES)
               IF (ILAST .NE. ITHIS) THEN
                  IWHERE = LOCINT (ITHIS, N, IPTIMS)
                  IF (IWHERE .LE. 0) THEN
                     N = N + 1
                     IPTIMS(N) = ITHIS
                     IF (ILAST .GE. ITHIS) DOSORT = .TRUE.
                     ILAST = ITHIS
                  END IF
               END IF
  100       CONTINUE
            NPTIMS = N
         END IF

      ELSE IF (DELT .EQ. 0.0) THEN

C      --Select all the database time steps between TMIN and TMAX

         N = 0
         ISTIM = LOCREA (TMIN, NSTEPS, TIMES)
         IETIM = LOCREA (TMAX, NSTEPS, TIMES)
         TIMMIN = TIMES(ISTIM)
         TIMMAX = TIMES(IETIM)
         DO 110 ITHIS = 1, NSTEPS
            IF ((TIMES(ITHIS) .GE. TIMMIN)
     &         .AND. (TIMES(ITHIS) .LE. TIMMAX)) THEN
               N = N + 1
               IPTIMS(N) = ITHIS
            END IF
  110    CONTINUE
         NPTIMS = N

      ELSE

C      --Select the database time steps nearest a specified list of times
C      --(in IPTIMS)

         ILAST = 0
         DO 120 I = 1, NINTV
            ITHIS = IPTIMS(I)
            IF (ILAST .GE. ITHIS) DOSORT = .TRUE.
            ILAST = ITHIS
  120    CONTINUE
         NPTIMS = NINTV
      END IF

C   --Sort the selected time steps numbers (in IPTIMS)

      IF (DOSORT) THEN
         ILAST = 0
         N = 0
         DO 140 I = 1, NPTIMS
            ITHIS = IPTIMS(I)
            IXTHIS = I
            DO 130 J = I+1, NPTIMS
               IF (IPTIMS(J) .LT. ITHIS) THEN
                  ITHIS = IPTIMS(J)
                  IXTHIS = J
               END IF
  130       CONTINUE
            IPTIMS(IXTHIS) = IPTIMS(I)
            IF (ILAST .NE. ITHIS) THEN
               N = N + 1
               IPTIMS(N) = ITHIS
               ILAST = ITHIS
            END IF
  140    CONTINUE
         NPTIMS = N
      END IF

      RETURN
      END
