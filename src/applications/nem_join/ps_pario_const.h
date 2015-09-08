/* Global variables. */

extern char    *Coord_Name[];                   /* The name(s) of the */
/* coordinate axes.   */

extern double   PIO_Time_Array[];		/* Vector for timings */

/*
 * The following variables are used when a single processor is to write
 * info for a processor other than itself.
 */
extern int     Proc_For;
extern int     Raid_For;
extern int     Num_Proc_For;
extern int     Proc_Info[];
extern int    *Proc_Ids;


/* Structure used to store the information necessary for parallel I/O. */
#define MAX_FNL		2048

struct Parallel_IO
{
  int     Dsk_List_Cnt;

  int    *Dsk_List;
  int   **RDsk_List;

  int     Num_Dsk_Ctrlrs;            /* The number of disk controllers.     */
  int     Num_Dsks_PCtrlr;           /* The number of disks per controller. */
  int     PDsk_Add_Fact;             /* The offset from zero used by the    */
                                     /* the target machine.                 */

  int     Zeros;        /* 1 - if the target machine uses leading zeros when */
                        /*     designating the disk number (eg - the paragon */
                        /*     uses /pfs/io_01)                              */
                        /* 0 - if it does not (eg - the tflop uses           */
                        /*     /pfs/tmp_1)                                   */

  /* The root location of the parallel disks */
  char    Par_Dsk_Root[MAX_FNL+1];

  /* The subdirectory to write files to */
  char    Par_Dsk_SubDirec[MAX_FNL+1];

  /* The name of the scalar load-balance file */
  char    Scalar_LB_File_Name[MAX_FNL+1];

  /* The name of the scalar mesh file. */
  char    Scalar_Exo_File_Name[MAX_FNL+1];

  /* The base name of the parallel results file. */
  char    Par_Exo_Res_File_Name[MAX_FNL+1];

  char    Staged_Writes[5];

};

extern struct Parallel_IO PIO_Info;

extern char    Par_Nem_File_Name[];        /* The parallel nemesis file name */


/* Function prototypes. */
extern void     write_parExo_data(int, int, int, int, char **, int, char **,
                                  char **, int *,
                                  int *, int *, int *, int *, int *,
                                  ELEM_COMM_MAP *, NODE_COMM_MAP *);
extern void     write_parLB_data(int, int, int);
extern void     gen_par_filename(char *, char *, int, int);
extern void     gen_disk_map(struct Parallel_IO *,
                             int Proc_Info[],
                             int Proc,
                             int Num_Proc);
extern void     par_check_out_specs(void);
extern void     add_fname_ext(char *, char *);
extern void     pdisk_stage_begin(struct Parallel_IO *, int my_proc_id,
                                  int proc_info[], int proc_ids[],
                                  int pindx, int *glob_indx);
extern void     pdisk_stage_end(struct Parallel_IO *, int my_proc_id,
                                int proc_info[], int proc_ids[],
                                int pindx, int glob_pindx);
extern void     write_var_timestep(int exoid, int proc, int num_nodes,
                                   int *eb_ids_global, int io_ws);


#define LB_NUM_NS         9   /* The number of node sets used to hold */
/* load-balance information. */

#define LB_INT_NODE      -1   /* Number of internal FEM nodes */
#define LB_BOR_NODE      -2   /* Number of border FEM nodes */
#define LB_EXT_NODE      -3   /* Number of external FEM nodes */
#define LB_EXT_PROC      -4   /* Number of external processors */
#define LB_INT_ELEM      -5   /* Number of internal elements */
#define LB_NODAL         -6   /* Vector of nodal load-balance info */
#define LB_PROC          -7   /* Vector of external processor IDs */
#define LB_ELEM          -8   /* Vector or internal element IDs */
#define LB_NUM_PROC      -9   /* Number of processors for the decomposition */

/*
 * The following are node set IDs for information unique to
 * parallel ExodusII. It is assumed that none of the true node sets
 * in the file contain any of these IDs.
 */
#define PE_NUM_NS         5   /* The number of node sets used to hold info *
                               * unique to parallel ExodusII.              */

#define PE_GLOB_CNT     -10   /* Vector of global info counts, containing:
                               *   Number of global FEM nodes in the problem
                               *   Number of global node sets
                               *   Number of global side sets
                               *   Number of global elemenet blocks
                               */
#define PE_GLOB_NSID    -11   /* Vector of global node set IDs */
#define PE_GLOB_NINNS   -12   /* Vector of node counts in each node set */
#define PE_GLOB_SSID    -13   /* Vector of global side set IDs */
#define PE_GLOB_ELBLKID -14   /* Vector of global element block IDs */
