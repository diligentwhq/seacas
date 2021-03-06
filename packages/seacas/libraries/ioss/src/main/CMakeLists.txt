INCLUDE(TribitsLibraryMacros)
INCLUDE(TribitsAddExecutable)
INCLUDE(CheckIncludeFile)

SET(HEADERS "")
SET(SOURCES "")

SET_AND_INC_DIRS(DIR ${CMAKE_CURRENT_SOURCE_DIR})
APPEND_GLOB(HEADERS ${DIR}/*.h)
APPEND_GLOB(SOURCES ${DIR}/*.C)

INCLUDE_DIRECTORIES(
  "${CMAKE_CURRENT_SOURCE_DIR}/../"
  "${CMAKE_CURRENT_BINARY_DIR}/../"
)

ASSERT_DEFINED(${PACKAGE_NAME}_ENABLE_SEACASExodus)
IF (NOT ${PACKAGE_NAME}_ENABLE_SEACASExodus)
ADD_DEFINITIONS(-DNO_EXODUS_SUPPORT)
ENDIF()

ASSERT_DEFINED(${PACKAGE_NAME}_ENABLE_XDMF)
IF (NOT ${PACKAGE_NAME}_ENABLE_XDMF)
ADD_DEFINITIONS(-DNO_XDMF_SUPPORT)
ENDIF()

TRIBITS_ADD_EXECUTABLE(
  cth_pressure_map
  NOEXEPREFIX
  NOEXESUFFIX
  SOURCES cth_pressure_map.C vector3d.C
  )
TRIBITS_ADD_EXECUTABLE(
  io_shell
  NOEXEPREFIX
  NOEXESUFFIX
  SOURCES io_shell.C shell_interface.C Ioss_GetLongOpt.C
  )
TRIBITS_ADD_EXECUTABLE(
  shell_to_hex
  NOEXEPREFIX
  NOEXESUFFIX
  SOURCES shell_to_hex.C vector3d.C
  )
TRIBITS_ADD_EXECUTABLE(
  io_info
  NOEXEPREFIX
  NOEXESUFFIX
  SOURCES io_info.C volume.C info_interface.C Ioss_GetLongOpt.C
  )
TRIBITS_ADD_EXECUTABLE(
  sphgen
  NOEXEPREFIX
  NOEXESUFFIX
  SOURCES sphgen.C
  )

install_executable(cth_pressure_map)
install_executable(io_shell)
install_executable(shell_to_hex)
install_executable(io_info)
install_executable(sphgen)
