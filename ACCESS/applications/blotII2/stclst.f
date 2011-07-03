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

C $Id: stclst.f,v 1.1 2009/03/25 04:47:54 gdsjaar Exp $
C $Log: stclst.f,v $
C Revision 1.1  2009/03/25 04:47:54  gdsjaar
C Added blotII2 source since Copyright was asserted.
C
C Update copyright notice in suplib.
C
C Add blotII2 to config files.  Note that blot will not build yet since
C it requires some libraries that are still being reviewed for copyright
C assertion.
C
C Revision 1.3  2001/02/12 21:27:08  gdsjaar
C Changes to get the background color changing working again.
C
C Revision 1.2  1994/06/13 18:29:09  gdsjaar
C Fixed background and foreground color setting. (I think)
C
c Revision 1.1  1994/04/07  20:15:54  gdsjaar
c Initial checkin of ACCESS/graphics/blotII2
c
c Revision 1.2  1990/12/14  08:58:48  gdsjaar
c Added RCS Id and Log to all files
c
C============================================================================
      SUBROUTINE STCLST(MODULE)
C============================================================================

C   --*** STCLST ***  (BLOT) set color list mapping
C
C --Parameters:
C
C --  MODULE - character name of the subroutine module setting the colors
C
C  PURPOSE:  SETS THE DESIRED MAPPING OF THE DEFAULT COLORS.  THE ROUTINE
C            WAS WRITTEN TO ALLOW THE USER TO CHANGE THE MAPPING FOR
C            DIFFERENT PROGRAMS, SPECIFICALLY MAPPING ONE WAY FOR CONTOURS
C            AND PAINTING AND ANOTHER FOR PLOTTING.
C
      CHARACTER*(*) MODULE
      include 'params.blk'
      include 'cmap-lst.blk'
      CHARACTER*1 LSTMOD
      SAVE LSTMOD
      LOGICAL PLTICL

      CHARACTER*(MXSTLN) LIST1(NCOLOR), LIST2(NCOLOR)

      DATA LSTMOD / ' '/
      DATA LIST1 / 'BLACK   ', 'WHITE   ', 'RED     ',
     &   'GREEN   ', 'YELLOW  ', 'BLUE    ',
     &   'CYAN    ', 'MAGENTA ', '        ' /
      DATA LIST2 / 'BLACK   ', 'WHITE   ', 'BLUE    ',
     &   'MAGENTA ', 'CYAN    ', 'GREEN   ',
     &   'YELLOW  ', 'RED     ', '        ' /

C
C SET COLLST TO EITHER LIST DEPENDING ON THE VALUE OF MODULE
C
      IF(LSTMOD .NE. MODULE(1:1)) THEN
         LSTMOD = MODULE(1:1)

         IF(MODULE(1:1) .EQ. 'D' .OR. MODULE(1:1) .EQ. 'd') THEN
            DO 10 I = 1, NCOLOR
               COLLST(I) = LIST2(I)
10          CONTINUE
         ELSE
            DO 20 I = 1, NCOLOR
               COLLST(I) = LIST1(I)
20          CONTINUE
         END IF

         DO 30 I = 1, NCOLOR-2
            IF (PLTICL (COLLST(I+2), RCOLOR)) THEN
               COLMAP(I) = RCOLOR
            ELSE
               COLMAP(I) = -1
            ENDIF
30       CONTINUE
      END IF


      RETURN
      END
