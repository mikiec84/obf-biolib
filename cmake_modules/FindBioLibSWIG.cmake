# CMake file for BioLib SWIG configuration
#
# Using
#
#   USE_LANGUAGE=ruby|perl
#   USE_LANGUAGE_LIBRARY=(RUBY|PERL)_LIBRARY
#   USE_SWIG_FLAGS=";-prefix;'biolib::'"

# ---- SWIG 

message(STATUS "USE_LANGUAGE=${USE_LANGUAGE}")
message(STATUS "USE_LANGUAGE_LIBRARY=${USE_LANGUAGE_LIBRARY}")
message(STATUS "USE_SWIG_FLAGS=${USE_SWIG_FLAGS}")

FIND_PACKAGE(SWIG REQUIRED)
INCLUDE(${SWIG_USE_FILE})

SET_SOURCE_FILES_PROPERTIES(${INTERFACE} PROPERTIES CPLUSPLUS ON)
if (USE_SWIG_INCLUDEALL)
  SET_SOURCE_FILES_PROPERTIES(${INTERFACE} PROPERTIES SWIG_FLAGS "-includeall${USE_SWIG_FLAGS}'")
else (USE_SWIG_INCLUDEALL)
  SET_SOURCE_FILES_PROPERTIES(${INTERFACE} PROPERTIES SWIG_FLAGS "${USE_SWIG_FLAGS}")
endif (USE_SWIG_INCLUDEALL)

SWIG_ADD_MODULE(${M_MODULE} ${USE_LANGUAGE} ${INTERFACE} ${SOURCES} )
SWIG_LINK_LIBRARIES(${M_MODULE} ${MODULE_LIBRARY} ${USE_LANGUAGE_LIBRARY} ${BIOLIB_LIBRARY} ${R_LIBRARY} ${ZLIB_LIBRARY})

# this is used when searching for include files e.g. using the FIND_PATH() command.
MESSAGE( STATUS "CMAKE_INCLUDE_PATH=" ${CMAKE_INCLUDE_PATH} )
# this is used when searching for libraries e.g. using the FIND_LIBRARY() command.
MESSAGE( STATUS "CMAKE_LIBRARY_PATH=" ${CMAKE_LIBRARY_PATH} )
