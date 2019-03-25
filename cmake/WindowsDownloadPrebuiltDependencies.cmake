#set(DEPENDENCIES_VERSION 1.0.1)
set(DEPENDENCIES_VERSION 1.1.0)
set(DEPENDENCIES_NAME_1800_27 libraries_v120_x64_py27_${DEPENDENCIES_VERSION})
set(DEPENDENCIES_NAME_1900_27 libraries_v140_x64_py27_${DEPENDENCIES_VERSION})
set(DEPENDENCIES_NAME_1900_35 libraries_v140_x64_py35_${DEPENDENCIES_VERSION})

set(DEPENDENCIES_URL_BASE https://github.com/willyd/caffe-builder/releases/download)
set(DEPENDENCIES_FILE_EXT .tar.bz2)
set(DEPENDENCIES_URL_1800_27 "${DEPENDENCIES_URL_BASE}/v${DEPENDENCIES_VERSION}/${DEPENDENCIES_NAME_1800_27}${DEPENDENCIES_FILE_EXT}")
set(DEPENDENCIES_SHA_1800_27 "ba833d86d19b162a04d68b09b06df5e0dad947d4")
set(DEPENDENCIES_URL_1900_27 "${DEPENDENCIES_URL_BASE}/v${DEPENDENCIES_VERSION}/${DEPENDENCIES_NAME_1900_27}${DEPENDENCIES_FILE_EXT}")
set(DEPENDENCIES_SHA_1900_27 "17eecb095bd3b0774a87a38624a77ce35e497cd2")
set(DEPENDENCIES_URL_1900_35 "${DEPENDENCIES_URL_BASE}/v${DEPENDENCIES_VERSION}/${DEPENDENCIES_NAME_1900_35}${DEPENDENCIES_FILE_EXT}")
set(DEPENDENCIES_SHA_1900_35 "f060403fd1a7448d866d27c0e5b7dced39c0a607")
#set(DEPENDENCIES_SHA_1900_35 "1f55dac54aeab7ae3a1cda145ca272dea606bdf9")


#message(STATUS "=================================DEPENDENCIES_URL_1900_35 = ${DEPENDENCIES_URL_1900_35}")

caffe_option(USE_PREBUILT_DEPENDENCIES "Download and use the prebuilt dependencies" ON IF MSVC)
if(MSVC)
  file(TO_CMAKE_PATH $ENV{USERPROFILE} USERPROFILE_DIR)
  if(NOT EXISTS ${USERPROFILE_DIR})
    message(FATAL_ERROR "Could not find %USERPROFILE% directory. Please specify an alternate CAFFE_DEPENDENCIES_ROOT_DIR")
  endif()
  set(CAFFE_DEPENDENCIES_ROOT_DIR ${USERPROFILE_DIR}/.caffe/dependencies CACHE PATH "Prebuild depdendencies root directory")
  set(CAFFE_DEPENDENCIES_DOWNLOAD_DIR ${CAFFE_DEPENDENCIES_ROOT_DIR}/download CACHE PATH "Download directory for prebuilt dependencies")
endif()
if(USE_PREBUILT_DEPENDENCIES)
    # Determine the python version
    if(BUILD_python)
        if(NOT PYTHONINTERP_FOUND)
            if(NOT "${python_version}" VERSION_LESS "3.0.0")
                find_package(PythonInterp 3.5)
            else()
                find_package(PythonInterp 2.7)
            endif()
        endif()
        set(_pyver ${PYTHON_VERSION_MAJOR}${PYTHON_VERSION_MINOR})
    else()
        message(STATUS "Building without python. Prebuilt dependencies will default to Python 2.7")
        set(_pyver 27)
    endif()
    if(NOT DEFINED DEPENDENCIES_URL_${MSVC_VERSION}_${_pyver})
        message(FATAL_ERROR "Could not find url for MSVC version = ${MSVC_VERSION} and Python version = ${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}.")
    endif()
    # set the dependencies URL and SHA1
	
	
	#message(STATUS "============================download url =======MSVC_VERSION ==${MSVC_VERSION}, ========_pyver=${_pyver}")
	#message(STATUS "============================DEPENDENCIES_URL_ =======${DEPENDENCIES_URL_}")
    set(DEPENDENCIES_URL ${DEPENDENCIES_URL_${MSVC_VERSION}_${_pyver}})
	#message(STATUS "============================DEPENDENCIES_URL =======${DEPENDENCIES_URL}")
	
	
    set(DEPENDENCIES_SHA ${DEPENDENCIES_SHA_${MSVC_VERSION}_${_pyver}})
    set(CAFFE_DEPENDENCIES_DIR ${CAFFE_DEPENDENCIES_ROOT_DIR}/${DEPENDENCIES_NAME_${MSVC_VERSION}_${_pyver}})

    foreach(_dir ${CAFFE_DEPENDENCIES_ROOT_DIR}
                 ${CAFFE_DEPENDENCIES_DOWNLOAD_DIR}
                 ${CAFFE_DEPENDENCIES_DIR})
      # create the directory if it does not exist
      if(NOT EXISTS ${_dir})
        file(MAKE_DIRECTORY ${_dir})
      endif()
    endforeach()
    # download and extract the file if it does not exist or if does not match the sha1
    get_filename_component(_download_filename ${DEPENDENCIES_URL} NAME)

	#message(STATUS "============================DEPENDENCIES_URL =======${DEPENDENCIES_URL}")

	#message(STATUS "============================_download_filename =======${_download_filename}")

    set(_download_path ${CAFFE_DEPENDENCIES_DOWNLOAD_DIR}/${_download_filename})
	#message(STATUS "============================_download_path =======${_download_path}")
    set(_download_file 1)
    if(EXISTS ${_download_path})
        file(SHA1 ${_download_path} _file_sha)
		#message(STATUS "============================_file_sha =======${_file_sha}")
		#message(STATUS "============================DEPENDENCIES_SHA =======${DEPENDENCIES_SHA}")
		
        if("${_file_sha}" STREQUAL "${DEPENDENCIES_SHA}")
            set(_download_file 0)
        else()
            set(_download_file 1)
            message(STATUS "Removing file because sha1 does not match.")
            file(REMOVE ${_download_path})
        endif()
    endif()
	#message(STATUS "============================_download_file =======${_download_file}")

    if(_download_file)
	
		#message(STATUS "1111111111111111111111111111111111111111111111")

        #message(STATUS "Downloading prebuilt dependencies to ${_download_path}")
		
		#message(STATUS "============================DEPENDENCIES_URL=======${DEPENDENCIES_URL}")
		
        file(DOWNLOAD "${DEPENDENCIES_URL}"
                      "${_download_path}"
                      EXPECTED_HASH SHA1=${DEPENDENCIES_SHA}
                      SHOW_PROGRESS
                      )
        if(EXISTS ${CAFFE_DEPENDENCIES_DIR}/libraries)
            file(REMOVE_RECURSE ${CAFFE_DEPENDENCIES_DIR}/libraries)
        endif()
    endif()
    if(EXISTS ${_download_path} AND NOT EXISTS ${CAFFE_DEPENDENCIES_DIR}/libraries)
        message(STATUS "Extracting dependencies")
        execute_process(COMMAND ${CMAKE_COMMAND} -E tar xjf ${_download_path}
                        WORKING_DIRECTORY ${CAFFE_DEPENDENCIES_DIR}
        )
    endif()
    if(EXISTS ${CAFFE_DEPENDENCIES_DIR}/libraries/caffe-builder-config.cmake)
        include(${CAFFE_DEPENDENCIES_DIR}/libraries/caffe-builder-config.cmake)
    else()
        message(FATAL_ERROR "Something went wrong while dowloading dependencies could not open caffe-builder-config.cmake")
    endif()
endif()

