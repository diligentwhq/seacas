C Copyright (C) 2009 Sandia Corporation.  Under the terms of Contract
C DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
C certain rights in this software
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
C 
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
C 

C $Id: pltlgy.f,v 1.1 2009/06/10 18:23:55 gdsjaar Exp $ 
C $Log: pltlgy.f,v $
C Revision 1.1  2009/06/10 18:23:55  gdsjaar
C Open source and copyright assertion
C
C Title:	SVDI Ver. 1.1
C SCR#:	126.2
C Type:	Open Source Software
C
C The Department of Energy (DOE), by memo dated 06/10/2009, has granted
C Sandia permission to assert its copyright in software entitled "SVDI
C Ver. 1.1".
C
C In accordance with the DOE's permission:
C
C All copies of "SVDI Ver. 1.1" that are released under an Open Source
C Software (OSS) license should be marked: Copyright (year first
C published) Sandia Corporation. Under the terms of Contract
C DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
C certain rights in this software.
C
C The above notice should appear before the OSS license, and the above
C notice and the OSS license are the ONLY terms that should appear in
C the software or the associated web site. No other disclaimers or
C notices should be used.
C
C The primary vehicle for distribution of "SVDI Ver. 1.1" should be the
C OSS license and associated web site. However, if "SVDI Ver. 1.1" is to
C be released without an OSS license it should be marked: Copyright
C (year first published) Sandia Corporation. Under the terms of Contract
C DE-AC04-94AL85000, there is a non-exclusive license for use of this
C work by or on behalf of the U.S. Government. Export of this program
C may require a license from the United States Government.
C
C At a minimum, this copyright notice should be on the package
C containing the program. Preferably, the copyright notice should also
C be incorporated into the source code and be displayed on at least the
C first screen that comes up when the software is run. In addition, the
C following complete language should also be included in the copyright
C notice:
C
C NOTICE:
C
C 	For five (5) years from 06/10/2009, the United States
C 	Government is granted for itself and others acting on its
C 	behalf a paid-up, nonexclusive, irrevocable worldwide license
C 	in this data to reproduce, prepare derivative works, and
C 	perform publicly and display publicly, by or on behalf of the
C 	Government. There is provision for the possible extension of
C 	the term of this license. Subsequent to that period or any
C 	extension granted, the United States Government is granted for
C 	itself and others acting on its behalf a paid-up,
C 	nonexclusive, irrevocable worldwide license in this data to
C 	reproduce, prepare derivative works, distribute copies to the
C 	public, perform publicly and siplay publicly, and to permit
C 	others to do so. The specific term of the license can be
C 	identified by inquiry made to Sandia Corportation or DOE.
C
C 	NEITHER THE UNITED STATES GOVERNMENT, NOR THE UNITED STATES
C 	DEPARTMENT OF ENERGY, NOR SANDIA CORPORATION, NOR ANY OF THEIR
C 	EMPLOYEES, MAKES ANY WARRANTY, EXPRESS OR IMPLIED, OR ASSUMES
C 	ANY LEGAL RESPONSIBILITY FOR THE ACCURACY, COMPLETENESS, OR
C 	USEFULNESS OF ANY INFORMATION, APPARATUS, PRODUCT, OR PROCESS
C 	DISCLOSED, OR REPRESENTS THAT ITS USE WOULD NOT INFRINGE
C 	PRIVATELY OWNED RIGHTS.
C
C 	Any licensee of this software has the obligation and
C 	responsibility to abide by the applicable export control laws,
C 	regulations, and general prohibitions relating to the export
C 	of technical data. Failure to obtain an export control license
C 	or other authority from the Government may result in criminal
C 	liability under U.S. laws.
C
C (End of Notice)
C
C This alternate language should only be used if the software is to be
C distributed without the OSS license. If there is any question at all
C as to which notice is appropriate, please contact Jason D. Martinez at
C (505) 844-8067.
C
C This software has been assigned SCR# 126.2. This number is a Sandia
C internal tracking number and is a useful reference when contacting the
C Intellectual Property Center or Licensing and IP Management. However,
C since this software is to be released as OSS, the software is deemed
C to be Publicly Available.
C
C Revision 1.3  2000/10/25 13:32:35  gdsjaar
C Modified intrinsic functions to use generic versions to avoid warnings on SGI 64-bit compiles
C
C Revision 1.2  1993/07/16 18:07:54  gdsjaar
C Added external pltblk statements so that linkers would pull in block
C data subprogram to initialize constants.
C
c Revision 1.1  1993/07/16  16:48:36  gdsjaar
c Changed plt to library rather than single source file.
c 
C=======================================================================
      SUBROUTINE PLTLGY(X,Y,NUM,XLAB,XUNIT,YLAB,YUNIT)
      REAL DEVCAP(23)
      REAL DEFOUT(7)
      COMMON /STATUS/DEVCAP,DEFOUT
      REAL DEVP(5)
      COMMON /DEVICE/DEVP
      REAL COLP(3)
      REAL PALETT(3,16)
      COMMON /COLOR/COLP,PALETT
      REAL TEXTP(40)
      COMMON /TEXT/TEXTP
      REAL VECTP(5)
      REAL XCUR
      REAL YCUR
      COMMON /VECTRC/VECTP,XCUR,YCUR
      INTEGER IDEX(200,2)
      INTEGER NVECT(200,2)
      REAL XSIZE(200,2)
      REAL YSIZE(200,2)
      REAL X0(2300,2)
      REAL Y0(2300,2)
      REAL X1(2300,2)
      REAL Y1(2300,2)
      COMMON /FONT/IDEX,NVECT,XSIZE,YSIZE,X0,Y0,X1,Y1
      REAL GRAPHP(100)
      COMMON /GRAPH/GRAPHP
      COMMON /MAPPAR/MAPP(11)
      REAL MAPP
      COMMON /STORAG/MEMORY(1000)
      LOGICAL CPUIFC
      CHARACTER*(*) XLAB,XUNIT,YLAB,YUNIT
      REAL INTERX,MINEXY,MAXEXY
      DIMENSION X(1),Y(1)

 2840 CONTINUE
      CALL VECRGS(IABS(NUM),X,XMAX,XMIN)
      CALL VECRGS(IABS(NUM),Y,YMAX,YMIN)
      IF (GRAPHP(22).EQ.1. .OR. GRAPHP(22).EQ.2.) THEN
         CALL PLTINO(XMIN,XMAX,FNLOWX,FNUPPX,INTERX,IEXPX,NMINX)
         TNEXPX = 10.**IEXPX
         XSTART = FNLOWX
         XEND = FNUPPX
         IF (YMIN.LE.0) THEN
            CALL VECRGP(IABS(NUM),Y,YMAX,YMIN)
            CALL PLTFLU
            CALL SIORPT('PLTLGY',
     *     'Y <= 0 found on logarithmic Y axis; ignoring Y values <= 0.'
     *                  ,2)
         END IF

         TEMP = LOG10(YMIN)
         MINEXY = INT(TEMP)
         IF (TEMP.LT.0. .AND. MINEXY.NE.TEMP) THEN
            MINEXY = MINEXY - 1
         END IF

         TEMP = LOG10(YMAX)
         MAXEXY = INT(TEMP)
         IF (TEMP.GT.0. .AND. MAXEXY.NE.TEMP) THEN
            MAXEXY = MAXEXY + 1
         END IF

         TENMNY = 10.**MINEXY
         TENMXY = 10.**MAXEXY
         GRAPHP(24) = FNLOWX*TNEXPX
         GRAPHP(25) = FNUPPX*TNEXPX
         GRAPHP(26) = (FNUPPX-FNLOWX)/INTERX
         GRAPHP(27) = NMINX
         GRAPHP(28) = TENMNY
         GRAPHP(29) = TENMXY
         GRAPHP(78) = FNLOWX*TNEXPX
         GRAPHP(79) = GRAPHP(78)
         GRAPHP(80) = FNUPPX*TNEXPX
         GRAPHP(81) = INTERX*TNEXPX
         GRAPHP(82) = NMINX
         GRAPHP(83) = TENMNY
         GRAPHP(85) = TENMXY

      ELSE IF (GRAPHP(22).EQ.3.) THEN
         TINT = (GRAPHP(25)-GRAPHP(24))/GRAPHP(26)
         IEXPX = NINT(LOG10(ABS(TINT)))
         TNEXPX = 10.**IEXPX
         FNLOWX = GRAPHP(24)/TNEXPX
         FNUPPX = GRAPHP(25)/TNEXPX
         INTERX = (FNUPPX-FNLOWX)/INT(GRAPHP(26))
         NMINX = INT(GRAPHP(27))
         XSTART = FNLOWX
         XEND = FNUPPX
         YMIN = GRAPHP(28)
         YMAX = GRAPHP(29)
         IF (YMIN.LE.0) THEN
            CALL VECRGP(IABS(NUM),Y,YTEMP,YMIN)
            CALL PLTFLU
            CALL SIORPT('PLTLGY',
     *'User scaling specified minimum Y <= 0 on log Y axis; using data t
     *o get min Y',2)
         END IF

         IF (YMAX.LE.0) THEN
            CALL VECRGP(IABS(NUM),Y,YMAX,YTEMP)
            CALL PLTFLU
            CALL SIORPT('PLTLGY',
     *'User scaling specified maximum Y <= 0 on log Y axis; using data t
     *o get max Y',2)
         END IF

         MINEXY = LOG10(YMIN)
         MAXEXY = LOG10(YMAX)
         TENMNY = 10.**MINEXY
         TENMXY = 10.**MAXEXY
         GRAPHP(78) = XSTART*TNEXPX
         GRAPHP(79) = GRAPHP(78)
         GRAPHP(80) = XEND*TNEXPX
         GRAPHP(81) = INTERX*TNEXPX
         GRAPHP(82) = NMINX
         GRAPHP(83) = YMIN
         GRAPHP(84) = GRAPHP(83)
         GRAPHP(85) = YMAX

      ELSE IF (GRAPHP(22).EQ.4.) THEN
         IEXPX = NINT(LOG10(ABS(GRAPHP(81))))
         TNEXPX = 10.**IEXPX
         XSTART = GRAPHP(78)/TNEXPX
         XEND = GRAPHP(80)/TNEXPX
         FNLOWX = GRAPHP(79)/TNEXPX
         INTERX = GRAPHP(81)/TNEXPX
         NMINX = INT(GRAPHP(82))
         YMIN = GRAPHP(83)
         YMAX = GRAPHP(85)
         IF (YMIN.LE.0) THEN
            CALL VECRGP(IABS(NUM),Y,YTEMP,YMIN)
            CALL PLTFLU
            CALL SIORPT('PLTLGY',
     *'Exact scaling specified maximum Y <= 0 on log Y axis; using data
     *to get min Y',2)
         END IF

         IF (YMAX.LE.0) THEN
            CALL VECRGP(IABS(NUM),Y,YMAX,YTEMP)
            CALL PLTFLU
            CALL SIORPT('PLTLGY',
     *'Exact scaling specified maximum Y <= 0 on log Y axis; using data
     *to get max Y',2)
         END IF

         MINEXY = LOG10(YMIN)
         MAXEXY = LOG10(YMAX)
         TENMNY = 10.**MINEXY
         TENMXY = 10.**MAXEXY
         GRAPHP(24) = XSTART*TNEXPX
         GRAPHP(25) = XEND*TNEXPX
         GRAPHP(26) = (XSTART-XEND)/INTERX
         GRAPHP(27) = NMINX
         GRAPHP(28) = YMIN
         GRAPHP(29) = YMAX
      END IF

      IF (GRAPHP(91).NE.-999999.) THEN
         FAC = 10.** (IEXPX-GRAPHP(91))
         IEXPX = INT(GRAPHP(91))
         TNEXPX = 10.**IEXPX
         XSTART = XSTART*FAC
         XEND = XEND*FAC
         FNLOWX = FNLOWX*FAC
         INTERX = INTERX*FAC
      END IF

      IF (GRAPHP(40).EQ.2. .OR. GRAPHP(40).EQ.4.) THEN
         XSTART = XSTART*TNEXPX
         XEND = XEND*TNEXPX
         FNLOWX = FNLOWX*TNEXPX
         FNUPPX = FNUPPX*TNEXPX
         INTERX = INTERX*TNEXPX
         IEXPX = 0
         TNEXPX = 1.
      END IF

      IF (CPUIFC(.FALSE.)) THEN
         GO TO 2860

      END IF

      CALL PLTAXS(GRAPHP(1),GRAPHP(2),GRAPHP(3),GRAPHP(4),'x',XSTART,
     *            XEND,FNLOWX,INT(GRAPHP(41)),INTERX,NMINX,XLAB,XUNIT,
     *            IEXPX)
      IF (CPUIFC(.FALSE.)) THEN
         GO TO 2860

      END IF

      CALL PLTLAX(GRAPHP(1),GRAPHP(2),GRAPHP(3),GRAPHP(4),'y',MINEXY,
     *            MAXEXY,YLAB,YUNIT)
      IF (CPUIFC(.FALSE.)) THEN
         GO TO 2860

      END IF

      CALL PLTGM2(XSTART*TNEXPX,XEND*TNEXPX,MINEXY,MAXEXY,GRAPHP(1),
     *            GRAPHP(1)+GRAPHP(3),GRAPHP(2),GRAPHP(2)+GRAPHP(4),
     *            GRAPHP(7))
      CALL PLTUWN(GRAPHP(7))
      CALL PLTCUR(X,Y,NUM)
      IF (CPUIFC(.FALSE.)) THEN
         GO TO 2860

      END IF

 2850 IF (.NOT. (.TRUE.)) GO TO 2840
 2860 CONTINUE
      RETURN

      END
