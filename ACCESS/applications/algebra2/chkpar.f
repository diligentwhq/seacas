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
      SUBROUTINE CHKPAR (TEST, MSG,
     &   PARTYP, LENARY, NELBLK, IXELB, ISEVOK,
     &   NUMIX, IXNODE, IXELEM,
     &   PARM1, PARM2, *)
C=======================================================================
C $Id: chkpar.f,v 1.1 2008/10/31 05:04:00 gdsjaar Exp $
C $Log: chkpar.f,v $
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
C Revision 1.3  1995/10/03 21:36:01  mksmith
C Removing old algII files
C Replacing modified algII files
C
C Revision 1.2  1993/08/02 14:20:40  gdsjaar
C Split out common blocks into separare files. Miscellaneous bug fixes
C on several files.  First public release version.
C
c Revision 1.1  1993/07/30  21:41:55  gdsjaar
c Initial checkin of ACCESS/translate/algII
c
c Revision 1.1.1.1  1990/11/09  16:23:38  gdsjaar
c Algebra - Unix Version
c
c Revision 1.1  90/11/09  16:23:37  gdsjaar
c Initial revision
c 

C   --*** CHKPAR *** (ALGEBRA) Check parameter data
C   --   Written by Amy Gilkey - revised 05/17/88
C   --
C   --CHKPAR checks the data for certain conditions (such as equality to
C   --zero).  If the data is in error, an error message is printed and
C   --the alternate return is taken.
C   --
C   --Parameters:
C   --   TEST - IN - the test to be performed:
C   --      EQ0 - if any data is equal to zero
C   --      LT0 - if any data is less than zero
C   --      LE0 - if any data is less than or equal to zero
C   --      ABSGT1 - if the absolute value of any data is greater than one
C   --      2EQ0 - if both data values equal zero
C   --   MSG - IN - the message if the condition is met
C   --   PARTYP - IN - the parameter type (element must be handled differently)
C   --   LENARY - IN - the length of the parameter arrays
C   --   NELBLK - IN - the number of element blocks
C   --   IXELB - IN - the cumulative element counts for each element block
C   --   ISEVOK - IN - the element variable truth table for each element block
C   --   NUMIX - IN - the number of selected values; <0 if all
C   --   IXNODE - IN - the indices of the selected nodes (only if NUMIX >= 0)
C   --   IXELEM - IN - the indices of the selected elements (only if NUMIX >= 0)
C   --   PARM1, PARM2 - IN - the data arrays to be checked
C   --   * - the return statement if the condition is met

      CHARACTER*(*) TEST
      CHARACTER*(*) MSG
      CHARACTER PARTYP
      INTEGER IXELB(0:NELBLK)
      LOGICAL ISEVOK(*)
      INTEGER IXNODE(*)
      INTEGER IXELEM(*)
      REAL PARM1(*), PARM2(*)

      IF (TEST .EQ. 'EQ0') THEN

         IF (NUMIX .GE. 0) THEN
            IF (PARTYP .NE. 'E') THEN
               DO 100 I = 1, NUMIX
                  J = IXNODE(I)
                  IF (PARM1(J) .EQ. 0) GOTO 400
  100          CONTINUE
            ELSE
               DO 120 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 110 I = IXELB(IELB-1)+1, IXELB(IELB)
                        J = IXELEM(I)
                        IF (PARM1(J) .EQ. 0) GOTO 400
  110                CONTINUE
                  END IF
  120          CONTINUE
            END IF

         ELSE
            IF (PARTYP .NE. 'E') THEN
               DO 130 J = 1, LENARY
                  IF (PARM1(J) .EQ. 0) GOTO 400
  130          CONTINUE
            ELSE
               DO 150 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 140 J = IXELB(IELB-1)+1, IXELB(IELB)
                        IF (PARM1(J) .EQ. 0) GOTO 400
  140                CONTINUE
                  END IF
  150          CONTINUE
            END IF
         END IF

      ELSE IF (TEST .EQ. 'LT0') THEN

         IF (NUMIX .GE. 0) THEN
            IF (PARTYP .NE. 'E') THEN
               DO 160 I = 1, NUMIX
                  J = IXNODE(I)
                  IF (PARM1(J) .LT. 0) GOTO 400
  160          CONTINUE
            ELSE
               DO 180 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 170 I = IXELB(IELB-1)+1, IXELB(IELB)
                        J = IXELEM(I)
                        IF (PARM1(J) .LT. 0) GOTO 400
  170                CONTINUE
                  END IF
  180          CONTINUE
            END IF

         ELSE
            IF (PARTYP .NE. 'E') THEN
               DO 190 J = 1, LENARY
                  IF (PARM1(J) .LT. 0) GOTO 400
  190          CONTINUE
            ELSE
               DO 210 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 200 J = IXELB(IELB-1)+1, IXELB(IELB)
                        IF (PARM1(J) .LT. 0) GOTO 400
  200                CONTINUE
                  END IF
  210          CONTINUE
            END IF
         END IF

      ELSE IF (TEST .EQ. 'LE0') THEN

         IF (NUMIX .GE. 0) THEN
            IF (PARTYP .NE. 'E') THEN
               DO 220 I = 1, NUMIX
                  J = IXNODE(I)
                  IF (PARM1(J) .LE. 0) GOTO 400
  220          CONTINUE
            ELSE
               DO 240 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 230 I = IXELB(IELB-1)+1, IXELB(IELB)
                        J = IXELEM(I)
                        IF (PARM1(J) .LE. 0) GOTO 400
  230                CONTINUE
                  END IF
  240          CONTINUE
            END IF

         ELSE
            IF (PARTYP .NE. 'E') THEN
               DO 250 J = 1, LENARY
                  IF (PARM1(J) .LE. 0) GOTO 400
  250          CONTINUE
            ELSE
               DO 270 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 260 J = IXELB(IELB-1)+1, IXELB(IELB)
                        IF (PARM1(J) .LE. 0) GOTO 400
  260                CONTINUE
                  END IF
  270          CONTINUE
            END IF
         END IF

      ELSE IF (TEST .EQ. 'ABSGT1') THEN

         IF (NUMIX .GE. 0) THEN
            IF (PARTYP .NE. 'E') THEN
               DO 280 I = 1, NUMIX
                  J = IXNODE(I)
                  IF (ABS(PARM1(J)) .GE. 0) GOTO 400
  280          CONTINUE
            ELSE
               DO 300 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 290 I = IXELB(IELB-1)+1, IXELB(IELB)
                        J = IXELEM(I)
                        IF (ABS(PARM1(J)) .GE. 0) GOTO 400
  290                CONTINUE
                  END IF
  300          CONTINUE
            END IF

         ELSE
            IF (PARTYP .NE. 'E') THEN
               DO 310 J = 1, LENARY
                  IF (ABS(PARM1(J)) .GE. 0) GOTO 400
  310          CONTINUE
            ELSE
               DO 330 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 320 J = IXELB(IELB-1)+1, IXELB(IELB)
                        IF (ABS(PARM1(J)) .GE. 0) GOTO 400
  320                CONTINUE
                  END IF
  330          CONTINUE
            END IF
         END IF

      ELSE IF (TEST .EQ. '2EQ0') THEN

         IF (NUMIX .GE. 0) THEN
            IF (PARTYP .NE. 'E') THEN
               DO 340 I = 1, NUMIX
                  J = IXNODE(I)
                  IF ((PARM1(J) .EQ. 0) .AND. (PARM2(J) .EQ. 0))
     &               GOTO 400
  340          CONTINUE
            ELSE
               DO 360 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 350 I = IXELB(IELB-1)+1, IXELB(IELB)
                        J = IXELEM(I)
                        IF ((PARM1(J) .EQ. 0) .AND. (PARM2(J) .EQ. 0))
     &                     GOTO 400
  350                CONTINUE
                  END IF
  360          CONTINUE
            END IF

         ELSE
            IF (PARTYP .NE. 'E') THEN
               DO 370 J = 1, LENARY
                  IF ((PARM1(J) .EQ. 0) .AND. (PARM2(J) .EQ. 0))
     &               GOTO 400
  370          CONTINUE
            ELSE
               DO 390 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 380 J = IXELB(IELB-1)+1, IXELB(IELB)
                        IF ((PARM1(J) .EQ. 0) .AND. (PARM2(J) .EQ. 0))
     &                     GOTO 400
  380                CONTINUE
                  END IF
  390          CONTINUE
            END IF
         END IF
      END IF

      RETURN

  400 CONTINUE
      CALL PRTERR ('FATAL', MSG)
      RETURN 1
      END
