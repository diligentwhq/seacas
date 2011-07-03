XCOMM!/bin/csh -f

XCOMM $Id: loadbal.c,v 1.3 2009/06/10 04:21:03 gdsjaar Exp $
XCOMM**************************************************************************
XCOMM**************************************************************************
XCOMM**
XCOMM**  SCRIPT: loadbal
XCOMM**
XCOMM**************************************************************************
XCOMM**************************************************************************

XCOMM Determine ACCESS based on the location of the script
if ("`echo $0 | sed 's/\///'`" != "$0") then
XCOMM Location of the script found
   if ("`ls -l $0 | sed 's/^l.*/l/'`" != "l") then
XCOMM Script is not a softlink
      setenv ACCESS `echo $0 | sed 's/\/etc\/.*//'`
      if (! -e $ACCESS/config/site.def) then
         setenv ACCESS _ACCESSDIR
      endif
   else
XCOMM Script is a softlink
      setenv ACCESS _ACCESSDIR
   endif
else
XCOMM Determining the location of the script failed, use default values
   setenv ACCESS _ACCESSDIR
endif

XCOMM initialize variables

#define TRANSLATOR 1
echo "==========================================================="
echo "| Sandia Engineering Analysis Access procedure for: loadbal"
echo '| $Revision: 1.3 $, $Date: 2009/06/10 04:21:03 $'
echo "==========================================================="
set codename=loadbal
set runid=DEFAULT
set mesh_opt=DEFAULT
set machine=DEFAULT
set decomp_method="-l inertial"
set nem_slice_flag="-c"
set pexmach=DEFAULT
set rootdir=DEFAULT
set subdir=DEFAULT
set offset=DEFAULT
set raids=DEFAULT
set scalar_mesh="yes"
set subdirectory="yes"

set userid = `echo $LOGNAME`
set curdir = `pwd`

set ACCESSBIN = $ACCESS/bin
set NEM_SLICE = $ACCESSBIN/nem_slice

set default_raids  = 1
set default_root   = `pwd`/
set default_sub    = .
set default_offset = 1 

set input_suffix   = i
set genesis_suffix = g
set exodus_suffix  = e
set spread_suffix  = g
set spreadit       = "NO"
  
env >! JUNK
grep "ALEGRA_EXE" JUNK > JUNK2
set alegra_rc = $status
if($alegra_rc == 0) then
  set input_suffix   = inp
  set genesis_suffix = gen
  set exodus_suffix  = exo
endif
/bin/rm -rf JUNK JUNK2

XCOMM Parse command line so that it can be used by the options program
if ($#argv == 0) goto USAGE
if ($#argv == 1 && "$argv[1]" == "-h") goto USAGE
@ i = 1
while ($i < $#argv)
    switch ($argv[$i]) 
    case -h:
        set argv[$i] = "-help"
        breaksw
    case -n*:
        set argv[$i] = "-nem_slice_flag"
        @ i++
        set testvar = `echo $argv[$i] | sed "s/.*\-l/\-l/" | sed "s/\-l.*//"`
        if ( "$testvar" == "" ) then
            set decomp_method = "$argv[$i]" 
        else
            set nem_slice_flag = "$argv[$i]" 
        endif
        set argv[$i] = "user_defined"
        breaksw
    case -o:
        set argv[$i] = "-offset"
        breaksw
    case -p:
        set argv[$i] = "-mesh_opt"
        breaksw
    case -r:
        set argv[$i] = "-raids"
        breaksw
    case -R:
        set argv[$i] = "-ROOTDIR"
        breaksw
    case -S:
        set argv[$i] = "-SUBDIR"
        breaksw
    default:
        breaksw
    endsw
    @ i++
end

XCOMM Parse command line
set argv  = (`$ACCESS/bin/options $*`)

XCOMM Set options exit condition
set errflg = $status
XCOMM echo command line input
echo "Input options: $argv"
XCOMM Check errflg - nonzero indicates error in options, print usage and exit:
if ($errflg != 0) then
        goto USAGE
endif
XCOMM Process options for this code
XCOMM Check for basename argument (Will follow "--" in argument list)
set temp = ($argv)
while ("$temp[1]" != "--")
        shift temp
end
XCOMM temp points to --
shift temp
XCOMM Set the basename
if ($#temp <= 0) then
        echo "ERROR:******************************************************************"
        echo "ERROR:******************************************************************"
        echo "ERROR:*************         No run id specified            *************"
        echo "ERROR:******************************************************************"
        echo "ERROR:******************************************************************"
        set errflg = 1
        goto USAGE
endif
set runid = $temp[1]
XCOMM Check for arguments and set corresponding variables 
while ("$argv[1]" != "--")
        switch ($argv[1])
        case -help:
                goto USAGE
                breaksw
        case -nem_slice_flag:
                shift argv
                breaksw
        case -offset:
                shift argv
                set offset = $argv[1] 
                breaksw
        case -mesh_opt:
                shift argv
                set mesh_opt = $argv[1] 
                breaksw
        case -raids:
                shift argv
                set raids = $argv[1] 
                breaksw
        case -ROOTDIR:
                shift argv
                set rootdir = $argv[1] 
                breaksw
        case -SUBDIR:
                shift argv
                set subdir = $argv[1] 
                breaksw
        case -spread:
	        set spreadit="yes"
		breaksw
        case -slit:
	        set nem_slice_flag = "-c"
		breaksw
        case -suffix_mesh:
                shift argv
                set genesis_suffix = $argv[1] 
                breaksw
        case -suffix_spread:
                shift argv
                set spread_suffix = $argv[1] 
                breaksw
        case -suffix_transient:
                shift argv
                set exodus_suffix = $argv[1] 
                breaksw
        case -No_scalar_mesh:
	        set scalar_mesh = "no"
		breaksw
        case -No_subdirectory:
	        set subdirectory = "no"
		breaksw
	case -No_01:
	        set subdirectory = "no"
		breaksw
        case -multikl:
	        set decomp_method="-l multikl"
                breaksw
        case -rcb:
	        set decomp_method="-l rcb"
		breaksw
        case -rib:
	        set decomp_method="-l rib"
		breaksw
        case -hsfc:
	        set decomp_method="-l hsfc"
		breaksw
	case -spectral:
	        set decomp_method="-l spectral"
                breaksw
	case -inertial:
	        set decomp_method="-l inertial"
                breaksw
	case -linear:
	        set decomp_method="-l linear"
                breaksw
	case -random:
	        set decomp_method="-l random"
                breaksw
	case -scattered:
	        set decomp_method="-l scattered"
                breaksw
	case -brick:
	        set decomp_method="-l brick"
		breaksw
	case -zpinch:
	        set decomp_method="-l zpinch"
		breaksw
	  
        default:
                echo "ERROR: unrecognized option $argv[1]"
                goto USAGE 
                breaksw
        endsw
        shift argv
end

if($mesh_opt == DEFAULT) then
  echo
  echo "ERROR:***************************************************"
  echo "ERROR:***************************************************"
  echo "ERROR:>>>>  Must specify -p option (number of processors)."
  echo "ERROR:***************************************************"
  echo "ERROR:***************************************************"
  echo
  goto USAGE
endif

if($runid == DEFAULT) then
  echo runid unknown. Specify an file prefix to run.
  goto USAGE
else
  set input   = $runid.$input_suffix
  set output  = $runid.lbd.out
  set error   = $runid.lbd.err
  set nemesis = $runid.nem
  set genesis = $runid.$genesis_suffix
  set exodus  = $runid.$exodus_suffix
  set pexsh   = $runid.pex
  set spreed  = $runid.spd
  set config  = $runid.cfg
  goto EXECUTE_LBD
endif

XCOMM *************************************************************************
XCOMM *************************************************************************

EXECUTE_LBD:

echo ""
echo "***************************************************"
echo "*"
echo "*    Starting loadbal calculation for $runid"
echo -n "*         at "; date
echo "*"
echo "*    .... begining decomposition ...."
echo "*         see $output for current status"


if(-f $pexsh) then
  /bin/rm -rf $pexsh
endif

echo $mesh_opt >! DUMMY
sed -e 's/\x/\*/g' < DUMMY >! DUMMY2
sed -e 's/\x/\ /g' < DUMMY >! DUMMY3
set procopt = `cat DUMMY3`
echo "quit" >> DUMMY2
/usr/bin/bc DUMMY2 >! DUMMY
set numproc = `cat DUMMY`
/bin/rm -rf DUMMY DUMMY2 DUMMY3

set date = `date '+%m/%d/%y'`
set time = `date '+%H:%M:%S'`
set prob_dir = `pwd | sed "s/.*\///g"`

echo "===========================================================" >! $output
echo "| Sandia Engineering Analysis Access procedure for: loadbal" >> $output
echo '| $Revision: 1.3 $, $Date: 2009/06/10 04:21:03 $'                                      >> $output   
echo "===========================================================" >> $output

echo "Executing:"
echo "($NEM_SLICE -e $decomp_method $nem_slice_flag -o $nemesis -m mesh=$mesh_opt -a $input $genesis"
if(-f $input) then
($NEM_SLICE -e $decomp_method $nem_slice_flag -o $nemesis -m mesh=$mesh_opt -a $input $genesis >> $output) >& $error
set load_rc = $status
else
($NEM_SLICE -e $decomp_method $nem_slice_flag -o $nemesis -m mesh=$mesh_opt $genesis >> $output) >& $error
set load_rc = $status
endif

if($load_rc != 0) then
  goto BOMBED
else
  goto LAN
endif

XCOMM *************************************************************************
XCOMM *************************************************************************

CONFIG:

echo "set machine     = $machine"                           >! $config
echo "set proc_conf   = $mesh_opt"                          >> $config
echo "set num_procs   = $numproc"                           >> $config
echo "set root_dir    = $rootdir"                           >> $config
echo "set sub_dir     = $subdir"                            >> $config
echo "set job_name    = $runid"                             >> $config
echo "set num_raids   = $raids"                             >> $config
echo "set raid_offset = $offset"                            >> $config
echo "set nem_date    = $date"                              >> $config
echo "set nem_time    = $time"                              >> $config
echo "set zero = 0"                                         >> $config

chmod 755 $spreed
set mpexe = local

if($spreadit == "yes") then
  echo ""
  echo "Executing: ./$spreed  ..."
  (./$spreed  >> $output) >& $error
endif

echo "*"
echo "*    Completed loadbal calculation for $runid"
echo -n "*         at "; date
echo "*"
echo "*    For details of the decomposition, see"
echo "*        $output (output) and"
echo "*        $error (possible errors/warnings)" 
echo "*"
echo "*    The following files may be required for parallel runs:"
echo "*          $input"
echo "*          $genesis"
echo "*          $nemesis"
echo "*          $spreed"
echo "*          $config"
echo "*"
echo "***************************************************"
echo " "
/* Log information */
#include "log.h"
exit $load_rc

XCOMM *************************************************************************
XCOMM *************************************************************************

LAN:

if($rootdir == DEFAULT) then
  set rootdir=$default_root
endif

if($subdir == DEFAULT) then
  set subdir=$default_sub
endif

if($offset == DEFAULT) then
  set offset=$default_offset
endif

if($raids == DEFAULT) then
  set raids=$default_raids
endif

if($raids > $numproc) then
  set raids = $numproc
endif

set pexcmd  = $ACCESSBIN/nem_spread

if ($subdirectory == "no") then
  set do_sub = ", nosubdirectory"
else
  set do_sub = 
endif
  
set zero = "zeros"
set stage =

echo "#\!/bin/csh -f"                                               >! $spreed
echo "cat << 'EOF' >! $pexsh"                                       >> $spreed
echo "Input FEM file                   = $genesis"                  >> $spreed
echo "LB file                          = $nemesis"                  >> $spreed
echo "File Extension for Spread Files  = .$spread_suffix"           >> $spreed
echo "Parallel Results file base name  = $exodus "                  >> $spreed
echo "Number of Processors             = $numproc "                 >> $spreed
echo "Use Scalar Mesh File             = $scalar_mesh "             >> $spreed
echo "------------------------------------------------------------" >> $spreed
echo "                Parallel I/O section"                         >> $spreed
echo "------------------------------------------------------------" >> $spreed
echo "Parallel Disk Info= number=$raids, offset=$offset $stage, $zero $do_sub" >> $spreed
echo "Parallel file location = root=$rootdir, subdir=$subdir"       >> $spreed
echo "'EOF'"                                                        >> $spreed
echo ""                                                             >> $spreed
if ($subdirectory == "yes") then
  echo "set root = $rootdir"                                        >> $spreed
  echo "set subdir = $subdir"                                       >> $spreed
  echo "set numraid = $raids"                                       >> $spreed
  echo "set i = $offset"                                            >> $spreed
  echo "set j = 1"                                                  >> $spreed
  echo "set stride = 1"                                             >> $spreed
  echo "set zero = 0"                                               >> $spreed
  echo 'while($j <= $numraid)'                                      >> $spreed
  echo '  if($i < 10) then'                                         >> $spreed
  echo '    set drive = $root$zero$i'                               >> $spreed
  echo '  else'                                                     >> $spreed
  echo '    set drive = $root$i'                                    >> $spreed
  echo '  endif'                                                    >> $spreed
  echo '  set dir = $drive/$subdir'                                 >> $spreed
  echo '  if(!(-d $dir)) then'                                      >> $spreed
  echo '    echo "making directory $dir"'                           >> $spreed
  echo '    mkdir -p $dir'                                          >> $spreed
  echo '  endif'                                                    >> $spreed
  echo '  @ i += $stride'                                           >> $spreed
  echo '  @ j++'                                                    >> $spreed
  echo 'end'                                                        >> $spreed
else
  if ($subdir != $default_sub) then
    echo "set root = $rootdir"                                      >> $spreed
    echo "set subdir = $subdir"                                     >> $spreed
    echo 'set dir = $root/$subdir'                                  >> $spreed
    echo 'if(!(-d $dir)) then'                                      >> $spreed
    echo '  echo "making directory $dir"'                           >> $spreed
    echo '  mkdir -p $dir'                                          >> $spreed
    echo 'endif'                                                    >> $spreed
  endif
endif
echo ""                                                             >> $spreed
echo "$pexcmd $pexsh"                                               >> $spreed

goto CONFIG 

XCOMM *************************************************************************
XCOMM *************************************************************************

BOMBED:

echo ""
echo ""
echo "ERROR:***************************************************"
echo "ERROR:***************************************************"
echo "ERROR:>>>>   loadbal exiting with status: $load_rc"
echo "ERROR:>>>>   This suggests that a problem occurred."
echo "ERROR:>>>>   The output of $error is:"
echo "ERROR:***************************************************"
echo "ERROR:***************************************************"
echo ""
cat $error
echo ""
exit $load_rc 

XCOMM *************************************************************************
XCOMM *************************************************************************

USAGE:
cat << 'EOF'
Version: $Id: loadbal.c,v 1.3 2009/06/10 04:21:03 gdsjaar Exp $
@@
Usage:  loadbal [-h] -p <processor layout> [-n <nemslice options>]
                [-r <number of disks>] [-o <disk offset>] [-slit]
                [-R <root directory>] [-S <sub directory] [-spread]
                [-multikl] [-spectral] [-inertial] [-linear]
                [-rcb] [-rib] [-hsfc] [-random] [-scattered]
                [...others...] meshfile_basename
@@
Decomposition methods: [0..3] = speed ranking 0=fastest
  -multikl:   [3] Multilevel KL. Gives high quality partitions.
		  Slow, high memory use.
  -spectral:  [2] use eigenvectors of a matrix constructed from the 
                  graph to partition the graph.
  -hsfc       [?] Hilbert Space-Filling Curve (uses Zoltan)
  -rib:       [?] Recursive Inertial Bisection (uses Zoltan)
  -rcb:       [?] Recursive Coordinate Bisection (uses Zoltan)
  -inertial:  [1] (default) vertices divided into sets of equal mass by planes
                  orthogonal to the principle axis. Good, fast, medium memory
  -linear:    [0] vertices in order first n/p to proc 0, next to proc 1. 
                  (fast and sometimes good).
  -random:    [0] vertices are assigned randomly to sets in a way that 
                  preserves balance.
  -scattered: [0] vertices are handed out in order with the next vertex 
                  going to whichever set is smallest.
  -brick      [-] special decomposition method; not useful for general use.
  -zpinch     [-] special decomposition method; not useful for general use.
      (See http://jal.sandia.gov/SEACAS/Documentation/chaco.pdf and 
           http://www.cs.sandia.gov/Zoltan/ug_html/ug.html for details)
@@
Other options:
-slit           Do not flag error if mesh contains slit/crack/sipe 
                (two quad faces sharing 3 nodes) [set by default now]
-spread         Execute the {runid}.spd file automatically as part of the
                loadbal process.
-h              print this message
-n options      options for nem_slice. Example: -n -c    
-o offset       disk drive number to begin with
-p proc_layout  select a one-, two-, three-dimensional mesh layout
                Examples: -p 4       a one-dimensional mesh of 4 processors
                          -p 4x4     a two-dimensional mesh of 16 processors
                          -p 3x4x2   a three-dimensional mesh of 24 processors
-r num_disks    number of separate disk drives to use
-R root_dir     root directory to begin the path to on the separate disks
-S sub_dir      continuation of the path on the separate disks to the files
-suffix_mesh suf      file extension on input mesh file (default = g)
-suffix_spread suf    file extension on spread files (default = g)
-suffix_transient suf file extension on results files (default = e)
-No_scalar_mesh       Do not use the scalar mesh in nem_join; 
                      use only results files.
-No_subdirectory      Do not create the 01 subdirectory; 
                      write files in root_dir/sub_dir.
@@
   help-email: gsjaardema@gmail.com (code, script)
'EOF'
exit 11

