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
      SUBROUTINE DOIF (TEST, PARTYP, LENARY, NELBLK, IXELB, ISEVOK,
     &           NUMIX, IXNODE, IXELEM, PARMC, PARMT, PARMF, RESULT)
C=======================================================================
C $Id: doif.f,v 1.1 2008/10/31 05:04:00 gdsjaar Exp $
C $Log: doif.f,v $
C Revision 1.1  2008/10/31 05:04:00  gdsjaar
C Moved the applications into an applications subdirectory.
C
C Revision 1.1  2008/06/18 16:00:26  gdsjaar
C Initial adding of files to sourceforge
C
C Revision 1.5  2008/03/14 13:45:27  gdsjaar
C Added copyright information to top of all files.
C
C ALGEBRA2 is now open-sourced under BSD license
C
C Revision 1.4  1996/02/26 16:57:56  caforsy
C Changed exopts call to abort on exodus failure; Fixed tmag subroutine
C to work with zoomed mesh; Added comments to subroutines that compute
C functions.
C
C Revision 1.3  1995/10/03 21:36:14  mksmith
C Removing old algII files
C Replacing modified algII files
C
C Revision 1.2  1993/08/02 14:21:02  gdsjaar
C Split out common blocks into separare files. Miscellaneous bug fixes
C on several files.  First public release version.
C
c Revision 1.1  1993/07/30  21:42:32  gdsjaar
c Initial checkin of ACCESS/translate/algII
c
c Revision 1.1.1.1  1990/11/09  16:24:23  gdsjaar
c Algebra - Unix Version
c
c Revision 1.1  90/11/09  16:24:22  gdsjaar
c Initial revision
c 

C   --*** DOIF *** (ALGEBRA) Perform operation (2 parameters)
C   --   Written by Amy Gilkey - revised 05/17/88
C   --
C   --DOIF performs an operation with up to two parameters on each array
C   --value.
C   --
C   --Parameters:
C   --   TEST   - IN  - the operator character
C   --   PARTYP - IN  - the parameter type (element must be handled differently)
C   --   LENARY - IN  - the length of the parameter arrays
C   --   NELBLK - IN  - the number of element blocks
C   --   IXELB  - IN  - the cumulative element counts for each element block
C   --   ISEVOK - IN  - the element variable truth table for each element block
C   --   NUMIX  - IN  - the number of selected values; <0 if all
C   --   IXNODE - IN  - the indices of the selected nodes (only if NUMIX>=0)
C   --   IXELEM - IN  - the indices of the selected elements (only if NUMIX>=0)
C   --   PARMC  - IN  - the condition arrays
C   --   PARMT, PARMF - IN - the true and false result arrays
C   --   RESULT - OUT - the returned result array

      CHARACTER*(*) TEST
      CHARACTER PARTYP
      INTEGER IXELB(0:NELBLK)
      LOGICAL ISEVOK(*)
      INTEGER IXNODE(*)
      INTEGER IXELEM(*)
      REAL PARMC(*)
      REAL PARMT(*), PARMF(*)
      REAL RESULT(*)

      IF (TEST .EQ. 'IFLZ') THEN

         IF (NUMIX .GE. 0) THEN
            IF (PARTYP .NE. 'E') THEN
               DO 100 I = 1, NUMIX
                  J = IXNODE(I)
                  IF (PARMC(J) .LT. 0.0) THEN
                     RESULT(J) = PARMT(J)
                  ELSE
                     RESULT(J) = PARMF(J)
                  END IF
  100          CONTINUE
            ELSE
               DO 120 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 110 I = IXELB(IELB-1)+1, IXELB(IELB)
                        J = IXELEM(I)
                        IF (PARMC(J) .LT. 0.0) THEN
                           RESULT(J) = PARMT(J)
                        ELSE
                           RESULT(J) = PARMF(J)
                        END IF
  110                CONTINUE
                  END IF
  120          CONTINUE
            END IF

         ELSE
C           NUMIX < 0; ALL VALUES SELECTED
C           NUMEL=NUMELO; NUMNP=NUMNPO; IXELB(J)=IXELBO(J), J=1,NELBLK
            IF (PARTYP .NE. 'E') THEN
               DO 130 J = 1, LENARY
                  IF (PARMC(J) .LT. 0.0) THEN
                     RESULT(J) = PARMT(J)
                  ELSE
                     RESULT(J) = PARMF(J)
                  END IF
  130          CONTINUE
            ELSE
               DO 150 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 140 J = IXELB(IELB-1)+1, IXELB(IELB)
                        IF (PARMC(J) .LT. 0.0) THEN
                           RESULT(J) = PARMT(J)
                        ELSE
                           RESULT(J) = PARMF(J)
                        END IF
  140                CONTINUE
                  END IF
  150          CONTINUE
            END IF
         END IF

      ELSE IF (TEST .EQ. 'IFEZ') THEN

         IF (NUMIX .GE. 0) THEN
            IF (PARTYP .NE. 'E') THEN
               DO 160 I = 1, NUMIX
                  J = IXNODE(I)
                  IF (PARMC(J) .EQ. 0.0) THEN
                     RESULT(J) = PARMT(J)
                  ELSE
                     RESULT(J) = PARMF(J)
                  END IF
  160          CONTINUE
            ELSE
               DO 180 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 170 I = IXELB(IELB-1)+1, IXELB(IELB)
                        J = IXELEM(I)
                        IF (PARMC(J) .EQ. 0.0) THEN
                           RESULT(J) = PARMT(J)
                        ELSE
                           RESULT(J) = PARMF(J)
                        END IF
  170                CONTINUE
                  END IF
  180          CONTINUE
            END IF

         ELSE
C           NUMIX < 0; ALL VALUES SELECTED
C           NUMEL=NUMELO; NUMNP=NUMNPO; IXELB(J)=IXELBO(J), J=1,NELBLK
            IF (PARTYP .NE. 'E') THEN
               DO 190 J = 1, LENARY
                  IF (PARMC(J) .EQ. 0.0) THEN
                     RESULT(J) = PARMT(J)
                  ELSE
                     RESULT(J) = PARMF(J)
                  END IF
  190          CONTINUE
            ELSE
               DO 210 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 200 J = IXELB(IELB-1)+1, IXELB(IELB)
                        IF (PARMC(J) .EQ. 0.0) THEN
                           RESULT(J) = PARMT(J)
                        ELSE
                           RESULT(J) = PARMF(J)
                        END IF
  200                CONTINUE
                  END IF
  210          CONTINUE
            END IF
         END IF

      ELSE IF (TEST .EQ. 'IFGZ') THEN

         IF (NUMIX .GE. 0) THEN
            IF (PARTYP .NE. 'E') THEN
               DO 220 I = 1, NUMIX
                  J = IXNODE(I)
                  IF (PARMC(J) .GT. 0.0) THEN
                     RESULT(J) = PARMT(J)
                  ELSE
                     RESULT(J) = PARMF(J)
                  END IF
  220          CONTINUE
            ELSE
               DO 240 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 230 I = IXELB(IELB-1)+1, IXELB(IELB)
                        J = IXELEM(I)
                        IF (PARMC(J) .GT. 0.0) THEN
                           RESULT(J) = PARMT(J)
                        ELSE
                           RESULT(J) = PARMF(J)
                        END IF
  230                CONTINUE
                  END IF
  240          CONTINUE
            END IF

         ELSE
C           NUMIX < 0; ALL VALUES SELECTED
C           NUMEL=NUMELO; NUMNP=NUMNPO; IXELB(J)=IXELBO(J), J=1,NELBLK
            IF (PARTYP .NE. 'E') THEN
               DO 250 J = 1, LENARY
                  IF (PARMC(J) .GT. 0.0) THEN
                     RESULT(J) = PARMT(J)
                  ELSE
                     RESULT(J) = PARMF(J)
                  END IF
  250          CONTINUE
            ELSE
               DO 270 IELB = 1, NELBLK
                  IF (ISEVOK(IELB)) THEN
                     DO 260 J = IXELB(IELB-1)+1, IXELB(IELB)
                        IF (PARMC(J) .GT. 0.0) THEN
                           RESULT(J) = PARMT(J)
                        ELSE
                           RESULT(J) = PARMF(J)
                        END IF
  260                CONTINUE
                  END IF
  270          CONTINUE
            END IF
         END IF
      END IF

      RETURN
      END
