function(add_avr_core target)
	target_link_libraries(${target} PUBLIC avrcore)
	target_include_directories(${target} PRIVATE ${AVRCORE_DIR}/cores/arduino
													${AVRCORE_DIR}/variants/standard
													${AVRCORE_DIR}/libraries/SoftwareSerial/src)
endfunction()

function(add_avr_core_from_source target main_sources)
    foreach (s ${main_sources})
        set(sources ${sources} ${s})
    endforeach()

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
)

    set(sources ${main_sources} ${sources})
    add_executable(${target} ${sources})

	target_include_directories(${target} PRIVATE ${AVRCORE_DIR}/cores/arduino
													${AVRCORE_DIR}/variants/standard
													${AVRCORE_DIR}/libraries/SoftwareSerial/src)
endfunction()

function(avr_post_build target)
	set_target_properties(${target} PROPERTIES SUFFIX ".elf")

	add_custom_command(
        TARGET ${target}
        POST_BUILD
        COMMAND ${AVR_ROOT}/${TOOLCHAIN_ROOT}/bin/avr-size
		ARGS -A "$<TARGET_FILE:${target}>"
		USES_TERMINAL
    )

    add_custom_command(
        TARGET ${target}
        POST_BUILD
		BYPRODUCTS ${target}.eep
        COMMAND ${CMAKE_OBJCOPY} 
		ARGS -O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load 
			--no-change-warnings --change-section-lma .eeprom=0 
			"$<TARGET_FILE:${target}>" ${target}.eep
    )

	# Convert .elf to .hex.
    add_custom_command(
        TARGET ${target}
        POST_BUILD
		BYPRODUCTS ${target}.hex
        COMMAND ${CMAKE_OBJCOPY} 
		ARGS -O ihex -R .eeptom "$<TARGET_FILE:${target}>" ${target}.hex
    )

    add_custom_command(
        TARGET ${target}
        POST_BUILD
        COMMAND ${AVR_ROOT}/${TOOLCHAIN_ROOT}/bin/avr-size
		ARGS -A ${target}.hex
		USES_TERMINAL
    )
endfunction()
