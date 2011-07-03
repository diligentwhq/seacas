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

C $Id: pltcur.f,v 1.1 2009/06/10 18:23:55 gdsjaar Exp $ 
C $Log: pltcur.f,v $
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
C Revision 1.5  2000/10/25 18:55:02  gdsjaar
C In the pltli? functions, check for N==0 before doing any array
C accesses.
C
C Also changed all references to 'mask' to be arrays where they were
C scalars since downstream code seems to treat them as arrays.
C
C Revision 1.4  2000/10/25 13:32:35  gdsjaar
C Modified intrinsic functions to use generic versions to avoid warnings on SGI 64-bit compiles
C
C Revision 1.3  1993/07/19 17:06:35  gdsjaar
C Changed hex constants back to preceding X, --needed on cray. Works
C either way on other systems.
C
c Revision 1.2  1993/07/16  17:33:12  gdsjaar
c Integer constant too big on sun, replaced it with hexadecimal notation
c
c Revision 1.1  1993/07/16  16:47:54  gdsjaar
c Changed plt to library rather than single source file.
c 
C=======================================================================
      SUBROUTINE PLTCUR(X,Y,NUM)
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
      DIMENSION X(*),Y(*),X0T(32),Y0T(32),X1T(32),Y1T(32)
      INTEGER MASKS(1)
      INTEGER IZBIT(32)
      DATA IZBIT/1,          2,          4,          8,
     *          16,         32,         64,        128,
     *         256,        512,       1024,       2048,
     *        4096,       8192,      16384,      32768,
     *       65536,     131072,     262144,     524288,
     *     1048576,    2097152,    4194304,    8388608,
     *    16777216,   33554432,   67108864,  134217728,
     *   268435456,  536870912, 1073741824, X'80000000'/
      DATA SYMRAT/120./

      IF (NUM.LE.0) THEN
         RETURN

      END IF

      CALL PLTSVV
      CALL PLTSVD
      CALL PLTSVT
      CALL PLTSTV(1,GRAPHP(5))
      CALL PLTSTD(1,GRAPHP(38))
      CALL PLTSTV(2,GRAPHP(63))
      IF (GRAPHP(6).EQ.1.) THEN
         CALL PLTSTT(3,0.)
         CALL PLTSTT(4,0.)
         SYMSIZ = (GRAPHP(3)+GRAPHP(4))*GRAPHP(46)/ (10.*SYMRAT)
         CALL PLTSTT(2,SYMSIZ)
         CALL PLTSTT(11,GRAPHP(66))
      END IF

      J = 0
      NP = 0
      IF (NUM.EQ.1) THEN
         IF (GRAPHP(6).EQ.1. .AND. SYMSIZ.GT.0.0) THEN
            IF (GRAPHP(21).EQ.1.) THEN
               X0T(1) = X(1)
               Y0T(1) = Y(1)

            ELSE IF (GRAPHP(21).EQ.2.) THEN
               IF (X(1).LE.0.) THEN
                  RETURN

               END IF

               X0T(1) = LOG10(X(1))
               Y0T(1) = Y(1)

            ELSE IF (GRAPHP(21).EQ.3.) THEN
               X0T(1) = X(1)
               IF (Y(1).LE.0.) THEN
                  RETURN

               END IF

               Y0T(1) = LOG10(Y(1))

            ELSE IF (GRAPHP(21).EQ.4.) THEN
               IF (X(1).LE.0.) THEN
                  RETURN

               END IF

               IF (Y(1).LE.0.) THEN
                  RETURN

               END IF

               X0T(1) = LOG10(X(1))
               Y0T(1) = LOG10(Y(1))
            END IF

            MASKS(1) = -1
            CALL PLTMP2(GRAPHP(7),1,MASKS,X0T,Y0T,X1T,Y1T)
            JB = IZBIT(1)
            IF (IAND(MASKS(1),JB).NE.0) THEN
               CALL PLTSTD(1,GRAPHP(75))
               CALL PLTXTS(X1T(1),Y1T(1),CHAR(INT(GRAPHP(47))))
            END IF

         END IF

      ELSE
         IF (GRAPHP(21).EQ.1.) THEN
            XSAV = X(1)
            YSAV = Y(1)

         ELSE IF (GRAPHP(21).EQ.2.) THEN
            DO 2000 I = 1,NUM
               IF (X(I).LE.0.) THEN
                  GO TO 2000

               END IF

               XSAV = X(I)
               YSAV = Y(I)
               GO TO 2010

 2000       CONTINUE
 2010       CONTINUE

         ELSE IF (GRAPHP(21).EQ.3.) THEN
            DO 2020 I = 1,NUM
               IF (Y(I).LE.0.) THEN
                  GO TO 2020

               END IF

               XSAV = X(I)
               YSAV = Y(I)
               GO TO 2030

 2020       CONTINUE
 2030       CONTINUE

         ELSE IF (GRAPHP(21).EQ.4.) THEN
            DO 2040 I = 1,NUM
               IF (X(I).LE.0. .OR. Y(I).LE.0.) THEN
                  GO TO 2040

               END IF

               XSAV = X(I)
               YSAV = Y(I)
               GO TO 2050

 2040       CONTINUE
 2050       CONTINUE
         END IF

 2060    IF (.NOT. (J.LT.NUM-1)) GO TO 2070
         K = MIN(NUM-J,32)
         IF (GRAPHP(21).EQ.1.) THEN
            NV = 0
            DO 2080 I = 1,K - 1
               NV = NV + 1
               X0T(I) = XSAV
               Y0T(I) = YSAV
               X1T(I) = X(I+J+1)
               Y1T(I) = Y(I+J+1)
               XSAV = X(I+J+1)
               YSAV = Y(I+J+1)
 2080       CONTINUE

         ELSE IF (GRAPHP(21).EQ.2.) THEN
            NV = 0
            DO 2100 I = 1,K - 1
               IF (X(J+I+1).LE.0.) THEN
                  GO TO 2100

               END IF

               NV = NV + 1
               X0T(NV) = LOG10(XSAV)
               Y0T(NV) = YSAV
               X1T(NV) = LOG10(X(J+I+1))
               Y1T(NV) = Y(J+I+1)
               XSAV = X(I+J+1)
               YSAV = Y(I+J+1)
 2100       CONTINUE

         ELSE IF (GRAPHP(21).EQ.3.) THEN
            NV = 0
            DO 2120 I = 1,K - 1
               IF (Y(J+I+1).LE.0.) THEN
                  GO TO 2120

               END IF

               NV = NV + 1
               X0T(NV) = XSAV
               Y0T(NV) = LOG10(YSAV)
               X1T(NV) = X(J+I+1)
               Y1T(NV) = LOG10(Y(J+I+1))
               XSAV = X(I+J+1)
               YSAV = Y(I+J+1)
 2120       CONTINUE

         ELSE IF (GRAPHP(21).EQ.4.) THEN
            NV = 0
            DO 2140 I = 1,K - 1
               IF (X(J+I+1).LE.0.) THEN
                  GO TO 2140

               END IF

               IF (Y(J+I+1).LE.0.) THEN
                  GO TO 2140

               END IF

               NV = NV + 1
               X0T(NV) = LOG10(XSAV)
               Y0T(NV) = LOG10(YSAV)
               X1T(NV) = LOG10(X(J+I+1))
               Y1T(NV) = LOG10(Y(J+I+1))
               XSAV = X(I+J+1)
               YSAV = Y(I+J+1)
 2140       CONTINUE
         END IF

         CALL PLTDV2(GRAPHP(7),NV,X0T,Y0T,X1T,Y1T)
         IF (GRAPHP(6).EQ.1. .AND. SYMSIZ.GT.0.0) THEN
            CALL PLTSTD(1,GRAPHP(75))
            MASKS(1) = -1
            XT = X1T(NV)
            YT = Y1T(NV)
            CALL PLTMP2(GRAPHP(7),NV,MASKS,X0T,Y0T,X1T,Y1T)
            DO 2160 L = 1,NV
               JB = IZBIT(L)
               IF (IAND(MASKS(1),JB).NE.0 .AND.
     *             MOD(L+NP+INT(GRAPHP(23))-1,INT(GRAPHP(23))).EQ.
     *             0) THEN
                  CALL PLTXTS(X1T(L),Y1T(L),CHAR(INT(GRAPHP(47))))
               END IF

 2160       CONTINUE
            CALL PLTSTD(1,GRAPHP(38))
         END IF

         NP = NP + NV
         J = J + K - 1
         IF (J+1.GE.NUM .AND. (GRAPHP(6).EQ.1..AND.SYMSIZ.GT.0.0)) THEN
            X0T(1) = XT
            Y0T(1) = YT
            CALL PLTSTD(1,GRAPHP(75))
            MASKS(1) = -1
            CALL PLTMP2(GRAPHP(7),1,MASKS,X0T,Y0T,X1T,Y1T)
            JB = IZBIT(1)
            IF (IAND(MASKS(1),JB).NE.0 .AND.
     *          MOD(NP+INT(GRAPHP(23)),INT(GRAPHP(23))).EQ.0) THEN
               CALL PLTXTS(X1T(1),Y1T(1),CHAR(INT(GRAPHP(47))))
            END IF

         END IF

         IF (CPUIFC(.FALSE.)) THEN
            GO TO 2070

         END IF

         GO TO 2060

 2070    CONTINUE
      END IF

      CALL PLTRET
      CALL PLTRED
      CALL PLTREV
      RETURN

      END
