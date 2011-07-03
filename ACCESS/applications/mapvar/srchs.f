C Copyright (c) 2007 Sandia Corporation. Under the terms of Contract
C DE-AC04-94AL85000 with Sandia Corporation, the U.S. Governement
C retains certain rights in this software.
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

C $Id: srchs.f,v 1.1 2008/10/31 05:04:15 gdsjaar Exp $
C $Log: srchs.f,v $
C Revision 1.1  2008/10/31 05:04:15  gdsjaar
C Moved the applications into an applications subdirectory.
C
C Revision 1.1  2008/06/18 16:09:22  gdsjaar
C Initial import of files into sourceforge repository
C
C Revision 1.5  2007/10/17 18:40:36  gdsjaar
C Added copyright notice to all files.
C
C Mapvar is licensed under the BSD license
C
C Revision 1.4  2003/09/11 12:47:53  gwwellm
C tet element processing and 3 years of bug fixes I thought I had already committed
C
C Revision 1.3  1999/03/15 16:52:11  gwwellm
C New interpolation scheme added
C Degenerate Hex elements now handled correctly
C Reorganized flow thru code for improved efficiency
C Miscellaneous bug fixes
C
C Revision 1.2  1998/04/15 19:43:39  gwwellm
C Added truth table, input search tolerance as user command,
C general bug fixes and cleanup
C
C Revision 1.1  1998/03/13 18:12:29  gdsjaar
C New code -- mapvar. Interpolates results form an exodusII results file
C to a differently mesh geometry.  Written by Gerry Wellman,
C 9117. Loosely based on MERLIN. Provides a superset of merlin
C functionality.
C
C
      SUBROUTINE SRCHS (
     *  NPSRF,   NFSRF,   LINKSRF, XYZSRF,
     *  NPTS,    XYZPTS,  TOLSRCH,
     *  NISR,    NRSR,    NISS,    NRSS,    ISRCHR,  RSRCHR, LBLK,
     *  LIST,    IND,     IRNK,    IRNK2,   INDX,    ILO,     IUP,
     *  IDP,     IDS,     XMIN,    XMAX,    ISCR,    RSCR,    IERR )
C     
C-----------------------------------------------------------------------
C     
C DESCRIPTION:
C
C THIS SUBROUTINE CALCULATES THE CLOSEST POINT PROBLEM
C BETWEEN NPTS POINTS AND NFSRF SURFACES AND RETURNS RESULTS OF
C SEARCH IN ISRCHR,RSRCHR
C
C USED HERE FOR FINDING LOCATION OF EITHER NODE OR ELEMENT CENTROID
C FROM MESH-B IN SHELL ELEMENT OF MESH-A 
C
C-----------------------------------------------------------------------
C
C FORMAL PARAMETERS
C
C MEMORY      : P=PERMANENT, S=SCRATCH
C NAME        : IMPLICIT A-H,O-Z REAL, I-N INTEGER
C TYPE        : INPUT_STATUS/OUTPUT_STATUS (I=INPUT,O=OUTPUT,P=PASSED,
C               U=UNMODIFIED,-=UNDEFINED)
C DESCRIPTION : DESCRIPTION OF VARIABLE
C
C-----------------------------------------------------------------------
C
C CALLING ARGUMENTS:
C
C MEMORY NAME     TYPE   DESCRIPTION
C ---    ----     ---    -----------
C  P     NPSRF    I/U    NUMBER OF POINTS THAT DEFINE THE SURFACE
C  P     NFSRF    I/U    NUMBER OF SURFACES
C  P     LINKSRF  I/U    CONNECTIVITY OF SURFACES OF SIZE (4*NFSRF),
C                        NUMBERS REFER TO LOCATIONS IN XYZSRF ARRAY
C  P     XYZSRF   I/U    XYZ COORDS OF POINTS DEFINING SURFACE
C  P     NPTS     I/U    NUMBER OF POINTS TO BE SEARCHED
C  P     XYZPTS   I/U    XYZ COORDS OF POINTS TO BE SEARCHED
C  P     TOLSRCH  I/U    PROXIMITY TOLERANCE FOR POINT-TO-SURFACE SEARCH
C  P     NISR     I/U    NUMBER OF INTEGER SEARCH RESULTS (>=1)
C  P     NRSR     I/U    NUMBER OF REAL SEARCH RESULTS (>=4)
C  P     NISS     I/U    NUMBER OF INTEGER SEARCH SCRATCH (=5)
C  P     NRSS     I/U    NUMBER OF REAL SEARCH SCRATCH (=10)
C  P     ISRCHR   -/O    INTEGER SEARCH RESULTS
C  P     RSRCHR   -/O    REAL SEARCH RESULTS
C  P     LBLK     I/U    VECTOR BLOCKING PARAMETER (RECOMMEND 512 ON CRAY)
C  S     LIST     -/-    LIST OF POTENTIAL CONTACTS FOR A SURFACE
C  S     IND      -/-    INDEX ARRAY INDICATING COORD. ORDER OF EACH POINT
C  S     IRNK     -/-    RANK ARRAY
C  S     IRNK2    -/-    RANK ARRAY (INDIRECT)
C  S     INDX     -/P    INTERMEDIATE LIST OF POTENTIAL PAIRS (CONSTRUCTED
C                          AFTER THE INTERSECTION OF TWO OF THREE LISTS)
C  S     ILO      -/-    SEARCH BOX MINIMUM INDEX
C  S     IUP      -/-    SEARCH BOX MAXIMUM INDEX
C  S     XMIN     -/-    SEARCH BOX MINIMUM DIMENSION
C  S     XMAX     -/-    SEARCH BOX MAXIMUM DIMENSION
C  S     ISCR     -/-    INTEGER SCRATCH MEMORY
C  S     RSCR     -/-    REAL SCRATCH MEMORY
C  P     IERR     -/O    ERROR FLAG
C
C-----------------------------------------------------------------------
C
      COMMON /TAPES/  NOUT,NTPOUT,NTP2,NTP3,NTP4
C
C INPUT/OUTPUT ARRAYS
C
      DIMENSION
     *  LINKSRF(4,NFSRF),   XYZSRF(NPSRF,3),
     *  XYZPTS(NPTS,3),
     *  ISRCHR(NISR,NPTS),  RSRCHR(NRSR,NPTS)
      DIMENSION
     *  LIST(NPTS),         IND(NPTS,3),         IRNK(NPTS,3),
     *  IRNK2(NPTS,3,2),    INDX(NPTS)
      DIMENSION
     *  ILO(LBLK,3),        IUP(LBLK,3),         IDP(LBLK),
     *  IDS(LBLK)
      DIMENSION
     *  XMIN(LBLK,3),       XMAX(LBLK,3),        ISCR(NISS*LBLK),
     *  RSCR(NRSS*LBLK)
C
C ISRCHR and RSRCHR must be initialized to zero
C
      DO 1 I = 1, NPTS
        DO 2 J = 1, NISR
          ISRCHR(J,I) = 0
 2      CONTINUE
        DO 3 K = 1, NRSR
          RSRCHR(K,I) = 0.
 3      CONTINUE
 1    CONTINUE
C
      IF( NISR .LT. 1 .OR. NRSR .LT. 4 .OR. NISS .LT. 5 .OR.
     *    NRSS .LT. 10 )THEN
        IERR = 1
        RETURN
      ENDIF
C DIMENSION OF COORDINATES
      NDIM = 3
C ZERO SEARCH-PAIR COUNTER
      KOUNTS = 0
C
C CALL SORTING ROUTINE TO MAKE RANK ARRAYS
      CALL MKRNK( NPTS,NPTS,NDIM,XYZPTS,IND,IRNK,IRNK2 )
C
C LOOP OVER SURFACES AND SEARCH FOR POINTS WITHIN CAPTURE BOX
      DO 100 IFSRF = 1, NFSRF, LBLK
        NE = MIN(LBLK,NFSRF-IFSRF+1)
C CONSTRUCT THE BOUNDING BOX FOR NE SURFACES
        DO 110 J = 1, NE
          JFSRF = IFSRF + J - 1
          NI = LINKSRF(1,JFSRF)
          NJ = LINKSRF(2,JFSRF)
          NK = LINKSRF(3,JFSRF)
          NL = LINKSRF(4,JFSRF)
C
          XMINMS = MIN(XYZSRF(NI,1),XYZSRF(NJ,1),
     *                 XYZSRF(NK,1),XYZSRF(NL,1))
          XMAXMS = MAX(XYZSRF(NI,1),XYZSRF(NJ,1),
     *                 XYZSRF(NK,1),XYZSRF(NL,1))
          YMINMS = MIN(XYZSRF(NI,2),XYZSRF(NJ,2),
     *                 XYZSRF(NK,2),XYZSRF(NL,2))
          YMAXMS = MAX(XYZSRF(NI,2),XYZSRF(NJ,2),
     *                 XYZSRF(NK,2),XYZSRF(NL,2))
          ZMINMS = MIN(XYZSRF(NI,3),XYZSRF(NJ,3),
     *                 XYZSRF(NK,3),XYZSRF(NL,3))
          ZMAXMS = MAX(XYZSRF(NI,3),XYZSRF(NJ,3),
     *                 XYZSRF(NK,3),XYZSRF(NL,3))
          XDEL = XMAXMS - XMINMS
          YDEL = YMAXMS - YMINMS
          ZDEL = ZMAXMS - ZMINMS
          TOLER = TOLSRCH * MAX(XDEL,YDEL,ZDEL)
          XMIN(J,1) = XMINMS - TOLER
          XMAX(J,1) = XMAXMS + TOLER
          XMIN(J,2) = YMINMS - TOLER
          XMAX(J,2) = YMAXMS + TOLER
          XMIN(J,3) = ZMINMS - TOLER
          XMAX(J,3) = ZMAXMS + TOLER
  110   CONTINUE
C
        DO 120 IDIM = 1, NDIM
          CALL GETBND( LBLK, NE, XYZPTS(1,IDIM),  IND(1,IDIM),
     *                 NPTS,   XMIN(1,IDIM), XMAX(1,IDIM),
     *                 NPTS,    ILO(1,IDIM),  IUP(1,IDIM),
     *                 ISCR, RSCR )
  120   CONTINUE
C
        DO 130 J = 1, NE
          JFSRF = IFSRF + J - 1
          CALL MKLSTV(NPTS,IND,IRNK2,IUP,ILO,INDX,J,LIST,NLIST,
     *                LBLK,NDIM)
C
          DO 140 K = 1, NLIST
            KOUNTS = KOUNTS + 1
            IDP(KOUNTS) = LIST(K)
            IDS(KOUNTS) = JFSRF
            IF(KOUNTS .EQ. LBLK) THEN
C IF A VECTOR BLOCK HAS BEEN ACCUMMULATED, THEN DO THE LOCAL SEARCH
            CALL SHLSRC(
     *      KOUNTS,   NDIM,     NPTS,     NPSRF,    NFSRF,    NISR,     
     *      NRSR,     NRSS,     LBLK,     XYZSRF,   XYZPTS,   LINKSRF,
     *      ISRCHR,   RSRCHR,   IDP,      IDS,      RSCR,     TOLSRCH,
     *      IERR   )
            KOUNTS = 0
            ENDIF
C
  140     CONTINUE
  130   CONTINUE
  100 CONTINUE
C
C FOR ANY LEFTOVER PAIRS, DO THE LOCAL SEARCH
      IF( KOUNTS .NE. 0 ) THEN
        CALL SHLSRC(
     *    KOUNTS,   NDIM,     NPTS,     NPSRF,    NFSRF,    NISR,     
     *    NRSR,     NRSS,     LBLK,     XYZSRF,   XYZPTS,   LINKSRF,
     *    ISRCHR,   RSRCHR,   IDP,      IDS,      RSCR,     TOLSRCH ,
     *    IERR  )
      ENDIF
C
      RETURN
      END
      
