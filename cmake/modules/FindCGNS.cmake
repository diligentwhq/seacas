# -*- mode: cmake -*-

#
# MSTK CGNS Find Module
#
# Usage:
#    Control the search through CGNS_DIR or setting environment variable
#    CGNS_ROOT to the CGNS installation prefix.
#
#    This module does not search default paths! 
#
#    Following variables are set:
#    CGNS_FOUND            (BOOL)       Flag indicating if CGNS was found
#    CGNS_INCLUDE_DIR      (PATH)       Path to the CGNS include file
#    CGNS_INCLUDE_DIRS     (LIST)       List of all required include files
#    CGNS_LIBRARY_DIR      (PATH)       Path to the CGNS library
#    CGNS_LIBRARY          (FILE)       CGNS library
#    CGNS_LIBRARIES        (LIST)       List of all required CGNS libraries
#
# #############################################################################

# Standard CMake modules see CMAKE_ROOT/Modules
include(FindPackageHandleStandardArgs)

# MSTK CMake functions see <root>/cmake/modules for source
include(PrintVariable)
include(AddPackageDependency)

# If CGNS_ROOT was defined in the environment, use it.
# Definition from the command line will take precedence.
if (NOT CGNS_ROOT AND NOT $ENV{CGNS_ROOT} STREQUAL "")
  set(CGNS_ROOT $ENV{CGNS_ROOT})
endif()

# CGNS_DIR is DEPRECATED WARN THE USER if it is set
if (NOT CGNS_ROOT AND CGNS_DIR )
  message(WARNING "The configuration parameter CGNS_DIR is deprecated."
                  " Please use CGNS_ROOT instead to define the CGNS installation")
  set(CGNS_ROOT ${CGNS_DIR})
endif()  

# Add the usual paths for searching using the CGNS_ROOT variable
if (CGNS_ROOT)
  list(APPEND _cgns_INCLUDE_SEARCH_DIRS 
              ${CGNS_ROOT}/include
              ${CGNS_ROOT})
 
  list(APPEND _cgns_LIBRARY_SEARCH_DIRS 
              ${CGNS_ROOT}/lib
              ${CGNS_ROOT})
  
            list(APPEND _cgns_BINARY_SEARCH_DIRS 
              ${CGNS_ROOT}/bin
              ${CGNS_ROOT})
endif()
 
if ( CGNS_LIBRARIES AND CGNS_INCLUDE_DIRS )

    # Do nothing. Variables are set. No need to search again

else(CGNS_LIBRARIES AND CGNS_INCLUDE_DIRS)

    # Cache variables
    if(CGNS_DIR)
        set(CGNS_DIR "${CGNS_DIR}" CACHE PATH "Path to search for CGNS include and library files")
    endif()

    if(CGNS_INCLUDE_DIR)
        set(CGNS_INCLUDE_DIR "${CGNS_INCLUDE_DIR}" CACHE PATH "Path to search for CGNS include files")
    endif()

    if(CGNS_LIBRARY_DIR)
        set(CGNS_LIBRARY_DIR "${CGNS_LIBRARY_DIR}" CACHE PATH "Path to search for CGNS library files")
    endif()

    
    # Search for include files
    # Search order preference:
    #  (1) CGNS_INCLUDE_DIR - check existence of path AND if the include files exist
    #  (2) CGNS_DIR/<include>
    #  (3) Default CMake paths See cmake --html-help=out.html file for more information.
    #
    set(cgns_inc_names "cgnslib.h")
    if (CGNS_INCLUDE_DIR)

        if (EXISTS "${CGNS_INCLUDE_DIR}")

            find_path(cdf_test_include_path
                      NAMES ${cgns_inc_names}
                      HINTS ${CGNS_INCLUDE_DIR}
                      NO_DEFAULT_PATH)
            if(NOT cdf_test_include_path)
                message(SEND_ERROR "Can not locate ${cgns_inc_names} in ${CGNS_INCLUDE_DIR}")
            endif()
            set(CGNS_INCLUDE_DIR "${cdf_test_include_path}")

        else()
            message(SEND_ERROR "CGNS_INCLUDE_DIR=${CGNS_INCLUDE_DIR} does not exist")
            set(CGNS_INCLUDE_DIR "CGNS_INCLUDE_DIR-NOTFOUND")
        endif()

    else() 

        set(cgns_inc_suffixes "include")
        if(CGNS_DIR)

            if (EXISTS "${CGNS_DIR}" )

                find_path(CGNS_INCLUDE_DIR
                          NAMES ${cgns_inc_names}
                          HINTS ${CGNS_DIR}/include
                          PATH_SUFFIXES ${cgns_inc_suffixes}
                          NO_DEFAULT_PATH)

            else()
                 message(SEND_ERROR "CGNS_DIR=${CGNS_DIR} does not exist")
                 set(CGNS_INCLUDE_DIR "CGNS_INCLUDE_DIR-NOTFOUND")
            endif()    


        else()

            find_path(CGNS_INCLUDE_DIR
                      NAMES ${cgns_inc_names}
                      PATH_SUFFIXES ${cgns_inc_suffixes})

        endif()

    endif()


    if ( NOT CGNS_INCLUDE_DIR )
        message(SEND_ERROR "Can not locate CGNS include directory")
    endif()

    # Search for libraries 
    # Search order preference:
    #  (1) CGNS_LIBRARY_DIR - check existence of path AND if the include files exist
    #  (2) CGNS_DIR/<lib,Lib>
    #  (3) Default CMake paths See cmake --html-help=out.html file for more information.
    #
    if (CGNS_LIBRARY_DIR)

        if (EXISTS "${CGNS_LIBRARY_DIR}")

            find_library(CGNS_LIBRARY
                         NAMES cgns
                         HINTS ${CGNS_LIBRARY_DIR}
                         NO_DEFAULT_PATH)

        else()
            message(SEND_ERROR "CGNS_LIBRARY_DIR=${CGNS_LIBRARY_DIR} does not exist")
            set(CGNS_LIBRARY "CGNS_LIBRARY-NOTFOUND")
        endif()

    else() 

        if(CGNS_DIR)

            if (EXISTS "${CGNS_DIR}" )

                find_library(CGNS_LIBRARY
                             NAMES cgns
                             HINTS ${CGNS_DIR}
                             PATH_SUFFIXES "lib" "Lib"
                             NO_DEFAULT_PATH)

            else()
                 message(SEND_ERROR "CGNS_DIR=${CGNS_DIR} does not exist")
                 set(CGNS_LIBRARY "CGNS_LIBRARY-NOTFOUND")
            endif()    


        else()

            find_library(CGNS_LIBRARY
                         NAMES cgns
                         PATH_SUFFIXES ${cgns_lib_suffixes})
            
        endif()

    endif()

    if ( NOT CGNS_LIBRARY )
        message(SEND_ERROR "Can not locate CGNS library")
    endif()    
    
    # Define the LIBRARIES and INCLUDE_DORS
    set(CGNS_INCLUDE_DIRS ${CGNS_INCLUDE_DIR})
    set(CGNS_LIBRARIES    ${CGNS_CXX_LIBRARY} ${CGNS_LIBRARY})

    # Need to find the CGNS config script to check for HDF5
    message(STATUS "CGNS requires HDF5")
    if ( NOT TARGET hdf5)
      add_package_dependency(CGNS DEPENDS_ON HDF5)
    endif()

endif(CGNS_LIBRARIES AND CGNS_INCLUDE_DIRS )    

# Send useful message if everything is found
find_package_handle_standard_args(CGNS DEFAULT_MSG
                                        CGNS_LIBRARIES
                                        CGNS_INCLUDE_DIRS)

# find_package)handle)standard_args should set CGNS_FOUND but it does not!
if ( CGNS_LIBRARIES AND CGNS_INCLUDE_DIRS)
    set(CGNS_FOUND TRUE)
else()
    set(CGNS_FOUND FALSE)
endif()

# --- Provide a summary of what the module found
if ( NOT CGNS_FIND_QUIETLY )

  # Create a not found list
  message(STATUS "\tCGNS_INCLUDE_DIRS      = ${CGNS_INCLUDE_DIRS}")
  message(STATUS "\tCGNS_LIBRARIES         = ${CGNS_LIBRARIES}")

endif()
# For compatability with TriBITS:
SET(DOCSTR "List of semi-colon separated paths to look for the TPL CGNS")

set(TPL_CGNS_LIBRARIES ${CGNS_LIBRARIES} CACHE PATH ${DOCSTR})
set(TPL_CGNS_INCLUDE_DIRS ${CGNS_INCLUDE_DIRS} CACHE PATH ${DOCSTR})

mark_as_advanced(
  CGNS_INCLUDE_DIR
  CGNS_INCLUDE_DIRS
  CGNS_LIBRARY
  CGNS_CXX_LIBRARY
  CGNS_LIBRARIES
  CGNS_LIBRARY_DIR
)
