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

C $Id: pickn2.f,v 1.1 2009/03/25 04:47:54 gdsjaar Exp $
C $Log: pickn2.f,v $
C Revision 1.1  2009/03/25 04:47:54  gdsjaar
C Added blotII2 source since Copyright was asserted.
C
C Update copyright notice in suplib.
C
C Add blotII2 to config files.  Note that blot will not build yet since
C it requires some libraries that are still being reviewed for copyright
C assertion.
C
C Revision 1.1  1994/04/07 20:06:56  gdsjaar
C Initial checkin of ACCESS/graphics/blotII2
C
c Revision 1.2  1990/12/14  08:54:40  gdsjaar
c Added RCS Id and Log to all files
c
C=======================================================================
      SUBROUTINE PICKN2 (PROMPT, NUMNPF, XN, YN, MIDDEF, NDRES, *)
C=======================================================================

C   --*** PICKN2 *** (MESH) Pick a node from window
C   --  written by Ray J. Meyers    21 June, 1990
C   --
C   --PICKN2 puts a cursor on the screen, finds the associated world
C   --       coordinates and then locates and returns the node closest
C   --       to those coordinates.
C   --
C   --Parameters:
C   --   PROMPT - IN - the point requested
C   --   NUMNPF - IN - the number of nodes
C   --   XN - IN - the x coordinates of the nodes
C   --   yN - IN - the y coordinates of the nodes
C   --   MIDDEF - IN - true if the middle of the displayed mesh is to be the
C   --      starting position, else use the last selected position
C   --   NDRES - OUT - the node id selected
C   --   * - return statement if error picking point
C   --
C   --Common Variables:
C   --   Sets DXLAST, DYLAST of /PICK/
C   --   Uses /PICK/

      DIMENSION XN(*), YN(*)
      PARAMETER (KLFT=1, KRGT=2, KBOT=3, KTOP=4, KNEA=5, KFAR=6)

      COMMON /PICK/   INITP, PKDEF,
     &   PKMESH(KTOP), PKRMAT(3,3), PKRCEN(3),
     &   DMESH(KTOP), DVRAT, DXMID, DYMID, DXLAST, DYLAST
      LOGICAL INITP, PKDEF

      CHARACTER*(*) PROMPT
      LOGICAL MIDDEF

      CHARACTER*80 XPRMPT
      CHARACTER CH

      IF (.NOT. INITP) THEN
         CALL PRTERR ('CMDERR', 'No mesh is displayed')
         GOTO 100
      END IF

C      --Put up the cursor at the default location and wait for the user
C      --to select a point

      IF (PROMPT .NE. ' ') THEN
         XPRMPT = 'Pick ' // PROMPT // '...'
      ELSE
         XPRMPT = ' '
      END IF

      IF (MIDDEF) THEN
         DXRES = DXMID
         DYRES = DYMID
      ELSE
         DXRES = DXLAST
         DYRES = DYLAST
      END IF
      CALL GRIKEY (XPRMPT, DXRES, DYRES, CH, *100)

C      --Save the selected position

      DXLAST = DXRES
      DYLAST = DYRES

C      --Translate the point from device coordinates into mesh coordinates

      XRES = PKMESH(KLFT) + (DXRES - DMESH(KLFT)) * DVRAT
      YRES = PKMESH(KBOT) + (DYRES - DMESH(KBOT)) * DVRAT

C  -- FIND THE NEAREST NODE

      DISMIN = 10E+30
      DO 10 I = 1, NUMNPF
         X = XRES - XN(I)
         Y = YRES - YN(I)
         DIS = X*X + Y*Y
         IF(DIS .LT. DISMIN) THEN
             DISMIN = DIS
             NDRES = I
         END IF
10    CONTINUE

      RETURN

  100 CONTINUE
      RETURN 1
      END
