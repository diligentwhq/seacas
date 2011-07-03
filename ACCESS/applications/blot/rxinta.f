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

C $Log: rxinta.f,v $
C Revision 1.2  2009/03/25 12:36:47  gdsjaar
C Add copyright and license notice to all files.
C Permission to assert copyright has been granted; blot is now open source, BSD
C
C Revision 1.1  1994/04/07 20:10:27  gdsjaar
C Initial checkin of ACCESS/graphics/blotII2
C
c Revision 1.2  1990/12/14  08:56:44  gdsjaar
c Added RCS Id and Log to all files
c
C=======================================================================
      SUBROUTINE RXINTA (INLINE, IFLD, INTYP, CFIELD, IFIELD,
     &   SELMSG, MAXSEL, NUMSEL, IXSEL, *)
C=======================================================================

C   --*** RXINTA *** (BLOT) Alternate parse selection command
C   --   John Glick - 10/28/88
C   --
C   --RXINTA selects the items listed in the command.  If there are no
C   --fields, all the items are selected.  If the first field is ADD, the
c   --items are added to the items already selected, otherwise only the
C   --listed items are selected.  This routine behaves nearly like
C   --the RIXINT routine in the RIXINT library.  The only difference
C   --is that duplicate items in IXSEL are eliminated only if they
C   --would be adjacent in the array.
C   --
C   --Parameters:
C   --   INLINE - IN/OUT - the parsed input line for the log file
C   --   IFLD - IN/OUT - the free-field reader index
C   --   INTYP - IN - the free-field reader field types
C   --   CFIELD - IN - the character fields
C   --   IFIELD - IN - the integer fields
C   --   SELMSG - IN - the type of item for error messages
C   --   MAXSEL - IN - the number of the maximum selected items
C   --   NUMSEL - IN/OUT - the number of selected items; set to zero
C   --      upon entry unless ADD is the first field
C   --   IXSEL - IN/OUT - the selected items
C   --   * - return statement if error before any items selected

      CHARACTER*(*) INLINE
      INTEGER INTYP(*)
      CHARACTER*(*) CFIELD(*)
      INTEGER IFIELD(*)
      CHARACTER*(*) SELMSG
      INTEGER IXSEL(*)

      LOGICAL FFEXST, FFNUMB, FFMATC
      CHARACTER*80 ERRMSG
      INTEGER IRNG(3)

      IF (.NOT. (FFEXST (IFLD, INTYP))) THEN

C      --Select all items if no fields

         NUMSEL = MAXSEL
         DO 100 I = 1, MAXSEL
            IXSEL(I) = I
  100    CONTINUE

      ELSE IF (FFMATC (IFLD, INTYP, CFIELD, 'OFF', 3)) THEN

C      --Select no items if OFF

         CALL FFADDC ('OFF', INLINE)
         NUMSEL = 0

      ELSE

C      --Reset to none selected unless ADD

         IF (FFMATC (IFLD, INTYP, CFIELD, 'ADD', 3)) THEN
            CALL FFADDC ('ADD', INLINE)
         ELSE
            IF (.NOT. FFNUMB (IFLD, INTYP)) THEN
               ERRMSG =
     &            'Expected "OFF" or "ADD" or ' // SELMSG // ' range'
               CALL PRTERR ('CMDERR', ERRMSG(:LENSTR(ERRMSG)))
               GOTO 140
            END IF
            NUMSEL = 0
         END IF

  110    CONTINUE
         IF (FFEXST (IFLD, INTYP)) THEN

C         --Scan numeric range

            CALL FFVRNG (IFLD, INTYP, CFIELD, IFIELD,
     &         SELMSG, MAXSEL, IRNG, *130)
            CALL FFADDV (IRNG, INLINE)

C         --Store the range selected

            DO 120 I = IRNG(1), IRNG(2), IRNG(3)
               IF (NUMSEL .EQ. 0  .OR.
     &            LOCINT(I, NUMSEL, IXSEL) .NE. NUMSEL) THEN
                  IF (NUMSEL .GE. MAXSEL) THEN
                     ERRMSG = 'Too many ' // SELMSG // 's selected'
                     CALL PRTERR ('CMDERR', ERRMSG(:LENSTR(ERRMSG)))
                     GOTO 130
                  END IF

                  NUMSEL = NUMSEL + 1
                  IXSEL(NUMSEL) = I
               END IF
  120       CONTINUE

            GOTO 110
         END IF

  130    CONTINUE
         IF (NUMSEL .EQ. 0) THEN
            ERRMSG = 'No ' // SELMSG // 's are selected'
            CALL PRTERR ('CMDWARN', ERRMSG(:LENSTR(ERRMSG)))
         END IF
      END IF

      RETURN

  140 CONTINUE
      RETURN 1
      END
