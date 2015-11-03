SET(LIB_REQUIRED_DEP_PACKAGES)
if(CMAKE_PROJECT_NAME STREQUAL "SEACASProj")
  SET(LIB_OPTIONAL_DEP_PACKAGES SEACASExodus Zoltan)
  SET(LIB_OPTIONAL_DEP_TPLS XDMF HDF5 Pamgen)
else()
  SET(LIB_OPTIONAL_DEP_PACKAGES SEACASExodus Pamgen Zoltan)
  SET(LIB_OPTIONAL_DEP_TPLS XDMF HDF5)
endif()
SET(TEST_REQUIRED_DEP_PACKAGES)
SET(TEST_OPTIONAL_DEP_PACKAGES)
SET(LIB_REQUIRED_DEP_TPLS)
SET(TEST_REQUIRED_DEP_TPLS)
SET(TEST_OPTIONAL_DEP_TPLS)