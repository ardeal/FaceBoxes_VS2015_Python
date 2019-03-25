# Collect source files
file(GLOB_RECURSE srcs ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)

# Build each source file independently
foreach(source ${srcs})
  get_filename_component(name ${source} NAME_WE)


  #message(STATUS "========================= Generate project files =============> src names: ============ ${name}")

  # caffe target already exits
  if(name MATCHES "caffe")
    set(name ${name}.bin)
	
  endif()
  

	#set( CMAKE_BUILD_TYPE "Release" )

  # target
  #message(STATUS "========================= Generate project files =============> exe names: ============ ${name}")
  
  add_executable(${name} ${source})
  
  
  target_link_libraries(${name} PUBLIC ${Caffe_LINK})
  #if(NOT name  MATCHES "caffe.bin")
  #    target_link_libraries(${name} PUBLIC ${Caffe_LINK})
  #endif()
  
  #target_link_libraries(${name} ${Caffe_LINK})
  #message(STATUS "========================= Generate project files =============> Caffe_LINK : ============ ${Caffe_LINK}")

  caffe_default_properties(${name})

  if(MSVC AND COPY_PREREQUISITES)
    caffe_copy_prerequisites(${name} USE_HARD_LINKS)
  endif()

  # set back RUNTIME_OUTPUT_DIRECTORY
  
  #message(STATUS "========================================================================== PROJECT_BINARY_DIR ========== ${PROJECT_BINARY_DIR}")
  caffe_set_runtime_directory(${name} "${PROJECT_BINARY_DIR}/tools")
  caffe_set_solution_folder(${name} tools)

  # restore output name without suffix
  if(name MATCHES "caffe.bin")
    set_target_properties(${name} PROPERTIES OUTPUT_NAME caffe)
      if(MSVC)
    	# the exectuable will have an import library with the same name as the caffe lib
	    # so change the import library to avoid name clashes
      set_target_properties(${name} PROPERTIES IMPORT_SUFFIX ".bin.lib")
      endif()
  endif()
  
  #message(STATUS "========================= Generate project files =============> exe final names: ============ ${name}")


  # Install
  #install(TARGETS ${name} DESTINATION bin)
  #message(STATUS "========================================================================== CMAKE_INSTALL_BINDIR ========== ${CMAKE_INSTALL_BINDIR}")
  install(TARGETS ${name} DESTINATION ${CMAKE_INSTALL_BINDIR})

  if(MSVC AND INSTALL_PREREQUISITES)
    caffe_install_prerequisites(${name} DESTINATION ${CMAKE_INSTALL_BINDIR})
  endif()
endforeach(source)
