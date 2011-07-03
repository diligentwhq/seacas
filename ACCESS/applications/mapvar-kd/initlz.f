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

C=======================================================================
*DECK,INITLZ
      BLOCK DATA INITLZ
C
C     ******************************************************************
C
C     BLOCK DATA SUBROUTINE TO INITIALIZE VARIABLES STORED IN
C     NAMED COMMON BLOCKS
C
C     ******************************************************************
C
C...NOTE: Cannot include exodusII.inc in a block data routine.      
      PARAMETER (MXSTLN=32)
      CHARACTER*(MXSTLN) QALINE,NAMECO,NAMVAR
c      CHARACTER*10 ELTYPE
      CHARACTER*80 HED
C
      COMMON /HEADER/ HED
      COMMON /NTPDAT/ IFILES(5)
      COMMON /CONTRL/ ISCHEM,IDEF,IACCU
      COMMON /AMESH/  NUMELA,NODESA,NBLKSA,NDIMA,NELNDA
      COMMON /BMESH/  NUMELB,NODESB,NBLKSB,NDIMB,NELNDB
      COMMON /AEXDS1/ NQAREC,NVARGP,NVARNP,NVAREL
      COMMON /AEXDS2/ QALINE(4,240),NAMECO(3),NAMVAR(512)
C      COMMON /ELMDAT/ NNELM(13)
      COMMON /SCHDAT/ TOLSHL,TOLQAD,TOLHEX,TOLTET,NISS,NRSS
      COMMON /TAPES/  NOUT,NTPOUT,NTP2,NTP3,NTP4
      COMMON /TOLDAT/ TOL,EPS,STRLMT,ITERMX
      COMMON /VARNPT/ IXDIS,IYDIS,IZDIS,IXVEL,IYVEL,IZVEL
      COMMON /VAREPT/ ISXX,ISYY,ISZZ,ISXY,ISYZ,ISZX,IELMS,IDENS
      common /DEBG/  idebug
      COMMON /INIVAL/ valini
C
      DATA HED/' '/
      DATA NOUT,NTPOUT,NTP2,NTP3,NTP4/                      
     1     6,7,12,13,14/
      DATA (IFILES(I),I=1,5)/5*0/
      DATA ISCHEM/1/
      DATA IDEF/1/
      DATA IDEBUG/0/
      DATA IACCU/0/
      DATA IXDIS,IYDIS,IZDIS,IXVEL,IYVEL,IZVEL/6*0/
      DATA ISXX,ISYY,ISZZ,ISXY,ISYZ,ISZX,IELMS,IDENS/8*0/
      DATA NUMELA,NODESA,NBLKSA,NDIMA,NELNDA/5*0/
      DATA NUMELB,NODESB,NBLKSB,NDIMB,NELNDB/5*0/
      DATA NQAREC,NVARGP,NVARNP,NVAREL/4*0/
      DATA ((QALINE(I,J),I=1,4),J=1,240)/960*' '/
      DATA (NAMECO(I),I=1,3)/3*' '/
      DATA (NAMVAR(I),I=1,512)/512*' '/
c      DATA (ELTYPE(I),I=1,13)/'TRI3','TRI6','QUAD4','QUAD8','QUAD9',    
c     1     'TETRA4','TETRA10','PRISM6','PRISM15','HEX8','HEX20',    
c     2     'HEX27','SHELL'/
C      DATA (NNELM(I),I=1,13)/3,6,4,8,9,4,10,6,15,8,20,27,4/
C
      DATA VALINI /0.0/
      DATA TOLSHL,TOLQAD,TOLHEX,TOLTET,NISS,NRSS
     *  /0.01,0.01,0.01,0.01, 5,10/
C
C TOLSHL=extension of box around MESH-A shell element
C TOLQAD=extension of box around MESH-A quad element
C TOLHEX=extension of box around MESH-A hex element
C NISS=number of integer search scratch  (=5)
C NRSS=number of    real search scratch (=10)
C
      DATA TOL,EPS,STRLMT,ITERMX/0.01,0.01,20.,20/
C
C TOL=difference in isoparametric coords after newton iteration (dont change)
C EPS=tolerance used in checking if point is within element or coincident
C     with a node
C STRLMT=tolerance for isoparametric coords to lie within an element
C
      END
