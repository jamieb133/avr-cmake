cmake_minimum_required(VERSION 3.16.0)

SET(ARDUINO_BUILD on CACHE INTERNAL "")

IF(NOT DEFINED AVRCORE_DIR)
message(STATUS "Error! AVRCORE_DIR not defined")
endif()

# Sources.
set(ARDUINO_CORE_PATH ${AVRCORE_DIR}/cores/arduino)
set(sources
	${sources}
	${ARDUINO_CORE_PATH}/abi.cpp
	${ARDUINO_CORE_PATH}/CDC.cpp
	${ARDUINO_CORE_PATH}/HardwareSerial0.cpp
	${ARDUINO_CORE_PATH}/HardwareSerial1.cpp
	${ARDUINO_CORE_PATH}/HardwareSerial2.cpp
	${ARDUINO_CORE_PATH}/HardwareSerial3.cpp
	${ARDUINO_CORE_PATH}/HardwareSerial.cpp
	${ARDUINO_CORE_PATH}/IPAddress.cpp
	${ARDUINO_CORE_PATH}/new.cpp
	${ARDUINO_CORE_PATH}/PluggableUSB.cpp
	${ARDUINO_CORE_PATH}/Print.cpp
	${ARDUINO_CORE_PATH}/Stream.cpp
	${ARDUINO_CORE_PATH}/Tone.cpp
	${ARDUINO_CORE_PATH}/USBCore.cpp
	${ARDUINO_CORE_PATH}/WMath.cpp
	${ARDUINO_CORE_PATH}/WString.cpp
	${ARDUINO_CORE_PATH}/hooks.c
	${ARDUINO_CORE_PATH}/WInterrupts.c
	${ARDUINO_CORE_PATH}/wiring_analog.c
	${ARDUINO_CORE_PATH}/wiring.c
	${ARDUINO_CORE_PATH}/wiring_digital.c
	${ARDUINO_CORE_PATH}/wiring_pulse.c
	${ARDUINO_CORE_PATH}/wiring_shift.c
	${ARDUINO_CORE_PATH}/wiring_pulse.S
	${AVRCORE_DIR}/libraries/SoftwareSerial/src/SoftwareSerial.cpp
)

add_library(avrcore ${sources})

get_filename_component(AVRCORE_DIR "${AVRCORE_DIR}" ABSOLUTE CACHE INTERNAL "")
set(AVRCORE_INCLUDES "${AVRCORE_DIR}/cores/arduino ${AVRCORE_DIR}/variants/standard ${AVRCORE_DIR}/libraries/SoftwareSerial/src"
						CACHE INTERNAL "")

target_include_directories(avrcore PRIVATE ${AVRCORE_DIR}/cores/arduino
											${AVRCORE_DIR}/variants/standard
											${AVRCORE_DIR}/libraries/SoftwareSerial/src
                                            ${AVRSTL_DIR}/src)

