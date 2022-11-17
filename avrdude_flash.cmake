cmake_minimum_required(VERSION 3.16.0)

function(flash_target target)
    add_custom_command(
        TARGET ${target}
        POST_BUILD
        COMMAND ${AVR_ROOT}/${AVRDUDE} 
        ARGS -C${AVR_ROOT}/${AVRDUDE_CONF} -v -patmega328p -carduino -P${TARGET_DEVICE} -b${TARGET_BAUDRATE} -D "-Uflash:w:$<TARGET_FILE_BASE_NAME:${target}>.hex:i"
    )
endfunction()