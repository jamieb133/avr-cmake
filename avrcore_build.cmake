cmake_minimum_required(VERSION 3.16.0)

SET(ARDUINO_BUILD on CACHE INTERNAL "")

IF(NOT DEFINED AVRCORE_DIR)
message(STATUS "Error! AVRCORE_DIR not defined")
endif()

# Sources.
file(GLOB asm_sources ${AVRCORE_DIR}/cores/arduino/*S)
file(GLOB c_sources ${AVRCORE_DIR}/cores/arduino/*c)
file(GLOB cpp_sources ${AVRCORE_DIR}/cores/arduino/*cpp)
SET(cpp_sources ${cpp_sources}
					${AVRCORE_DIR}/libraries/SoftwareSerial/src/SoftwareSerial.cpp)

add_library(avrcore ${cpp_sources}
						${c_sources}
						${asm_sources})

get_filename_component(AVRCORE_DIR "${AVRCORE_DIR}" ABSOLUTE CACHE INTERNAL "")
set(AVRCORE_INCLUDES "${AVRCORE_DIR}/cores/arduino ${AVRCORE_DIR}/variants/standard ${AVRCORE_DIR}/libraries/SoftwareSerial/src"
						CACHE INTERNAL "")

target_include_directories(avrcore PRIVATE ${AVRCORE_DIR}/cores/arduino
											${AVRCORE_DIR}/variants/standard
											${AVRCORE_DIR}/libraries/SoftwareSerial/src
                                            ${AVRSTL_DIR}/src)

function(add_avr_core target)
	target_link_libraries(${target} PRIVATE avrcore)
	target_include_directories(${target} PRIVATE ${AVRCORE_DIR}/cores/arduino
													${AVRCORE_DIR}/variants/standard
													${AVRCORE_DIR}/libraries/SoftwareSerial/src)
endfunction()

function(avr_post_build target)
	# Convert .elf to .hex.
    add_custom_command(
        TARGET ${target}
        POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} 
		ARGS -O ihex ${target} ${target}.hex
    )

endfunction()