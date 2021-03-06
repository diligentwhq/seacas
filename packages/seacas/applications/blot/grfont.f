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

C $Log: grfont.f,v $
C Revision 1.2  2009/03/25 12:36:44  gdsjaar
C Add copyright and license notice to all files.
C Permission to assert copyright has been granted; blot is now open source, BSD
C
C Revision 1.1  1994/04/07 20:02:23  gdsjaar
C Initial checkin of ACCESS/graphics/blotII2
C
c Revision 1.2  1990/12/14  08:51:37  gdsjaar
c Added RCS Id and Log to all files
c
C=======================================================================
      SUBROUTINE GRFONT (IFNT)
C=======================================================================

C   --*** GRFONT *** (GRPLIB) Set font (PLT)
C   --   Written by Amy Gilkey - revised 01/22/87
C   --
C   --GRFONT sets a graphics font on the current device.
C   --
C   --Parameters:
C   --   IFNT - IN - the font type (as in /GRPCOM/)

C   --Routines Called:
C   --   PLTSTT - (PLTLIB) Set text parameter
C   --      7 = (KCHSPA) spacing between characters
C   --      12 = (KFONT) font (1=roman, 3=sanserif, 2=stick)

      PARAMETER (KCHSPA=7, KFONT=12)

      LOGICAL LDUM, PLTSTT

      IF (IFNT .EQ. 1) THEN
C      --stick font
         LDUM = PLTSTT (KCHSPA, 1.15)
         LDUM = PLTSTT (KFONT, 2.0)
      ELSE IF (IFNT .EQ. 2) THEN
C      --sanserif font
         LDUM = PLTSTT (KCHSPA, 1.15)
         LDUM = PLTSTT (KFONT, 3.0)
      ELSE IF (IFNT .EQ. 3) THEN
C      --roman font
         LDUM = PLTSTT (KCHSPA, 1.0)
         LDUM = PLTSTT (KFONT, 1.0)
      END IF

      RETURN
      END
