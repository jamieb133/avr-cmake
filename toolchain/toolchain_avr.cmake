cmake_minimum_required(VERSION 3.19.0)

# Set system name for cross compiling.
SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_VERSION TRUE)
SET(CMAKE_CROSSCOMPILING TRUE)
SET(CMAKE_USE_RELATIVE_PATHS TRUE)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# Toolchain SETup.
SET(TOOLS_ROOT ${AVR_ROOT}/${TOOLCHAIN_ROOT})
SET(CMAKE_CXX_COMPILER ${TOOLS_ROOT}/bin/avr-g++ CACHE INTERNAL "")
SET(CMAKE_C_COMPILER ${TOOLS_ROOT}/bin/avr-gcc CACHE INTERNAL "")
SET(CMAKE_ASM_COMPILER ${TOOLS_ROOT}/bin/avr-gcc CACHE INTERNAL "")
SET(CMAKE_LINKER ${TOOLS_ROOT}/bin/avr-gcc CACHE INTERNAL "")
SET(CMAKE_OBJCOPY ${TOOLS_ROOT}/bin/avr-objcopy CACHE INTERNAL "")
SET(CMAKE_AR ${TOOLS_ROOT}/bin/avr-gcc-ar CACHE INTERNAL "")
SET(AVRSIZE ${TOOLS_ROOT}/bin/avr-size CACHE INTERNAL "")


SET(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${AVRSTL_DIR}/src)

message(STATUS ${CMAKE_CXX_FLAGS})

# Compiler/linker flags etc.
SET(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "")
SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")
SET(CMAKE_C_COMPILER_WORKS TRUE)
SET(CMAKE_CXX_COMPILER_WORKS TRUE)
SET(CMAKE_CROSSCOMPILING TRUE)
SET(BOARD_DEFS "-mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10607 -DARDUINO_AVR_UNO -DARDUINO_ARCH_AVR " CACHE INTERNAL "" FORCE)
SET(CMAKE_CXX_FLAGS "-MMD -Os -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics ${BOARD_DEFS}" CACHE INTERNAL "" FORCE)
SET(CMAKE_C_FLAGS "-MMD -Os -fno-exceptions -ffunction-sections -fdata-sections ${BOARD_DEFS}" CACHE INTERNAL "" FORCE)
SET(CMAKE_ASM_FLAGS "-MMD -x assembler-with-cpp ${BOARD_DEFS}" CACHE INTERNAL "" FORCE)
SET(CMAKE_EXE_LINKER_FLAGS "-w -Os -fuse-linker-plugin -Wl,--gc-sections" CACHE INTERNAL "" FORCE)
SET(EEP_FLAGS "-O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0" CACHE INTERNAL "" FORCE)
SET(ELF2HEX_FLAGS "-O ihex -R .eeprom" CACHE INTERNAL "" FORCE)
SET(AVRDUDE_FLAGS "-C$(AVRDUDE_CONF) -v -patmega328p -carduino -P$(TARGET_DEVICE) -b$(TARGET_BAUDRATE) -D -Uflash:w:${TARGET_NAME}.hex:i" CACHE INTERNAL "")

