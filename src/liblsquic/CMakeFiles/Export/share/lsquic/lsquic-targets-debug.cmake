#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "lsquic::lsquic" for configuration "Debug"
set_property(TARGET lsquic::lsquic APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(lsquic::lsquic PROPERTIES
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/x86_64-linux-gnu/liblsquic.so"
  IMPORTED_SONAME_DEBUG "liblsquic.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS lsquic::lsquic )
list(APPEND _IMPORT_CHECK_FILES_FOR_lsquic::lsquic "${_IMPORT_PREFIX}/lib/x86_64-linux-gnu/liblsquic.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
