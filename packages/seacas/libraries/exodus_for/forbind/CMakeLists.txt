INCLUDE(TribitsLibraryMacros)
INCLUDE(FortranSettings)

INCLUDE_DIRECTORIES(
  "${CMAKE_CURRENT_SOURCE_DIR}/include"
  )

SET(SOURCES "")
SET_AND_INC_DIRS(DIR ${CMAKE_CURRENT_SOURCE_DIR})

APPEND_GLOB(SOURCES ${DIR}/src/*.c ${DIR}/src/*.F)
LIST(REMOVE_ITEM SOURCES "${DIR}/src/exo_jack-windows.c")

SET(HEADERS
  include/exodusII.inc
  )

TRIBITS_ADD_LIBRARY(
  exodus_for
  HEADERS ${HEADERS}
  SOURCES ${SOURCES}
  )

TRIBITS_ADD_TEST_DIRECTORIES(test)

