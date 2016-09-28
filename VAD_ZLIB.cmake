set(GIT_REPO "https://github.com/madler/zlib.git")

function(vad_live NAME)
  git_clone(${VAD_${NAME}_GIT_REPO} ZLIB)
  add_subdirectory("${VAD_EXTERNAL_ROOT}/ZLIB" "${VAD_EXTERNAL_ROOT}/ZLIB/build_external_dep")
  add_library(ZLIB INTERFACE)
  # The ZLIB library provides two public includes, zconf.h and zlib.h. In the live build
  # they sit in different directories.
  list(APPEND _ZLIB_INCLUDE_DIRS "${VAD_EXTERNAL_ROOT}/ZLIB" "${VAD_EXTERNAL_ROOT}/ZLIB/build_external_dep")
  set_property(TARGET ZLIB PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${_ZLIB_INCLUDE_DIRS})
  if(VAD_PREFER_STATIC OR VAD_ZLIB_PREFER_STATIC)
      set_target_properties(ZLIB PROPERTIES INTERFACE_LINK_LIBRARIES zlibstatic)
  else()
      set_target_properties(ZLIB PROPERTIES INTERFACE_LINK_LIBRARIES zlib)
  endif()
  add_library(ZLIB::ZLIB ALIAS ZLIB)
  set(ZLIB_FOUND TRUE CACHE INTERNAL "")
  message(STATUS "Setting ZLIB_INCLUDE_DIRS to '${_ZLIB_INCLUDE_DIRS}'.")
  set(ZLIB_INCLUDE_DIRS "${_ZLIB_INCLUDE_DIRS}" CACHE PATH "")
  message(STATUS "Setting ZLIB_LIBRARIES to the zlib target from the live dependency.")
  if(VAD_PREFER_STATIC OR VAD_ZLIB_PREFER_STATIC)
    set(ZLIB_LIBRARIES zlibstatic CACHE FILEPATH "")
  else()
    set(ZLIB_LIBRARIES zlib CACHE FILEPATH "")
  endif()
  # The zlib build system does not correctly set the include path for its executables when zlib
  # is built as a sub project. Fix it by adding explicitly the missing path.
  function(_zlib_exec_fix_include_dir TRG)
    get_property(_include_dir TARGET ${TRG} PROPERTY INCLUDE_DIRECTORIES)
    list(APPEND _include_dir "${VAD_EXTERNAL_ROOT}/ZLIB")
    set_property(TARGET ${TRG} PROPERTY INCLUDE_DIRECTORIES ${_include_dir})
  endfunction()
  _zlib_exec_fix_include_dir(minigzip)
  _zlib_exec_fix_include_dir(example)
  _zlib_exec_fix_include_dir(example64)
  _zlib_exec_fix_include_dir(minigzip64)
endfunction()
