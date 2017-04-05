# FIXME multiple urls? authentication?
set(GIT_REPO "git@hci-repo.iwr.uni-heidelberg.de:mgutsche/BRDF-SNOptimizer.git")



function(vad_system)
  vad_add_var(snoptimizer_FOUND false)
endfunction()

function(vad_deps)
  vad_autodep_pkg(Ceres "BRDF-SNOptimizer")
  vad_autodep_pkg(OpenCV "BRDF-SNOptimizer")
endfunction()

function(vad_live)

  vad_deps(${ARGN})
  
  git_clone(BRDF-SNOptimizer)
  
  add_subdirectory("${VAD_EXTERNAL_ROOT}/BRDF-SNOptimizer" "${CMAKE_BINARY_DIR}/external/BRDF-SNOptimizer")

  set(clif_FOUND true CACHE BOOL "" FORCE)
endfunction()
