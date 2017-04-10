# FIXME multiple urls? authentication?
set(GIT_REPO "http://hci-repo.iwr.uni-heidelberg.de/light-field/snoptimizer.git")



function(vad_system)
  vad_add_var(snoptimizer_FOUND false)
endfunction()

function(vad_deps)
  vad_autodep_pkg(ceres "snoptimizer")
  vad_autodep_pkg(opencv "snoptimizer")
endfunction()

function(vad_live)

  vad_deps(${ARGN})
  
  git_clone(snoptimizer)
  
  add_subdirectory("${VAD_EXTERNAL_ROOT}/BRDF-SNOptimizer" "${CMAKE_BINARY_DIR}/external/BRDF-SNOptimizer")

  set(clif_FOUND true CACHE BOOL "" FORCE)
endfunction()
