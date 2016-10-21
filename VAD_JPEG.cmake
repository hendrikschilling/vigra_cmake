include(VigraAddDep)

function(vad_system)
  vad_system_default(${ARGN})
  if(JPEG_FOUND)
    message(STATUS "Creating the JPEG::JPEG imported target.")
    add_library(JPEG::JPEG UNKNOWN IMPORTED)
    set_target_properties(JPEG::JPEG PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${JPEG_INCLUDE_DIRS}")
    set_property(TARGET JPEG::JPEG APPEND PROPERTY IMPORTED_LOCATION "${JPEG_LIBRARIES}")
    make_imported_targets_global()
  endif()
endfunction()
