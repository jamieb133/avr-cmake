cmake_minimum_required(VERSION 3.16.0)

# Set system name for cross compiling.
SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_VERSION TRUE)
SET(CMAKE_CROSSCOMPILING TRUE)
SET(CMAKE_USE_RELATIVE_PATHS TRUE)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# Toolchain SETup.
SET(CMAKE_CXX_COMPILER ${TOOLCHAIN_ROOT}/bin/avr-g++)
SET(CMAKE_C_COMPILER ${TOOLCHAIN_ROOT}/bin/avr-gcc)
SET(CMAKE_ASM_COMPILER ${TOOLCHAIN_ROOT}/bin/avr-gcc)

SET(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${AVRSTL_DIR}/src)

message(STATUS ${CMAKE_CXX_FLAGS})

# Compiler/linker flags etc.
SET(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "")
SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")
SET(CMAKE_C_COMPILER_WORKS TRUE)
SET(CMAKE_CXX_COMPILER_WORKS TRUE)
SET(CMAKE_CROSSCOMPILING TRUE)
SET(BOARD_DEFS "-mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10607 -DARDUINO_AVR_UNO -DARDUINO_ARCH_AVR" CACHE INTERNAL "" FORCE)
SET(CMAKE_CXX_FLAGS "-Os -Wno-error=narrowing -ffunction-sections -fdata-sections -fno-exceptions -fno-threadsafe-statics ${BOARD_DEFS} --sysroot ${TOOLCHAIN_ROOT}" CACHE INTERNAL "" FORCE)
SET(CMAKE_C_FLAGS "-Os -w -std=gnu11 -ffunction-sections -fdata-sections ${BOARD_DEFS}" CACHE INTERNAL "" FORCE)
SET(CMAKE_ASM_FLAGS "--x assembler-with-cpp" CACHE INTERNAL "" FORCE)
SET(LDFLAGS "-w -Os -fuse-linker-plugin -Wl,--gc-sections")
SET(EEP_FLAGS "-O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0")
SET(ELF2HEX_FLAGS "-O ihex -R .eeprom")
