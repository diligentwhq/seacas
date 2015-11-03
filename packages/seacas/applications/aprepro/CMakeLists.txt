INCLUDE(TribitsSubPackageMacros)
INCLUDE(TribitsAddExecutable)

TRIBITS_SUBPACKAGE(Aprepro)

INCLUDE_DIRECTORIES(
  "${CMAKE_CURRENT_SOURCE_DIR}"
  "${CMAKE_CURRENT_BINARY_DIR}"
)

ADD_DEFINITIONS(-DNO_EXODUSII)

SET(HEADERS "")
SET(SOURCES
  ap_builtin.c
  ap_stat.c
  y.tab.c
  ap_util.c
  ap_init.c
  ap_hash.c
  ap_liballoc.c
  ap_units.c
  ap_aprepro.c
  ap_array.c
  )

TRIBITS_ADD_EXECUTABLE(
  aprepro
  NOEXEPREFIX
  NOEXESUFFIX
  SOURCES ${SOURCES}
  IMPORTEDLIBS m
  COMM serial mpi
  )
install_executable(aprepro)

TRIBITS_SUBPACKAGE_POSTPROCESS()
