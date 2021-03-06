INCLUDE(TribitsLibraryMacros)

CONFIGURE_FILE(
  ${CMAKE_CURRENT_SOURCE_DIR}/include/exodusII_cfg.h.in
  ${CMAKE_CURRENT_BINARY_DIR}/include/exodusII_cfg.h
  @ONLY IMMEDIATE)

IF(NOT SEACAS_ENABLE_NETCDF4_SUPPORT)
  ADD_DEFINITIONS("-DNOT_NETCDF4")
ENDIF()

INCLUDE_DIRECTORIES(
  "${CMAKE_CURRENT_SOURCE_DIR}/include"
  "${CMAKE_CURRENT_BINARY_DIR}/include"
)

FILE(GLOB SOURCES src/*.c)

SET_AND_INC_DIRS(DIR ${CMAKE_CURRENT_SOURCE_DIR})


SET(HEADERS
  include/exodusII.h
  include/exodusII_par.h
)

IF (NOT SEACASExodus_ENABLE_MPI)
  LIST(REMOVE_ITEM SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/src/ex_create_par.c")
  LIST(REMOVE_ITEM SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/src/ex_open_par.c")
  LIST(REMOVE_ITEM HEADERS "${CMAKE_CURRENT_SOURCE_DIR}/include/exodusII_par.h")
ENDIF()

TRIBITS_ADD_LIBRARY(
	exodus
	HEADERS	${HEADERS}
	SOURCES ${SOURCES}
)

TRIBITS_ADD_TEST_DIRECTORIES(test)

