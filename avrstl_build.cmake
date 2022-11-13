cmake_minimum_required(VERSION 3.16.0)

IF(NOT DEFINED AVRSTL_DIR)
message(STATUS "Error! AVRCORE_DIR not defined")
endif()

# Sources.
file(GLOB asm_sources ${AVRSTL_DIR}/src/*S)
file(GLOB c_sources ${AVRSTL_DIR}/src/*c)
file(GLOB cpp_sources ${AVRSTL_DIR}/src/*cpp)
set(cpp_sources ${cpp_sources} ${AVRSTL_DIR}/src/abi/abi.cpp)

get_filename_component(AVRSTL_DIR "${AVRSTL_DIR}" ABSOLUTE CACHE INTERNAL "")

add_library(avrstl ${cpp_sources}
						${c_sources}
						${asm_sources})

target_include_directories(avrstl PRIVATE ${AVRCORE_DIR}/cores/arduino
											${AVRCORE_DIR}/variants/standard
											${AVRCORE_DIR}/libraries/SoftwareSerial/src
                                            ${AVRSTL_DIR}/src)
