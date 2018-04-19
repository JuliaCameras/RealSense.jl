function check_error(err)
    if err[] != C_NULL
        funcname = unsafe_string(rs2_get_failed_function(err[]))
        funcargs = unsafe_string(rs2_get_failed_args(err[]))
        message = unsafe_string(rs2_get_error_message(err[]))
        println("rs_error was raised when calling $funcname($funcargs):")
        println("    $message")
    end
end

function print_device_info(dev)
    err = Ref{Ptr{rs2_error}}(0)
    device_info = unsafe_string(rs2_get_device_info(dev, RS2_CAMERA_INFO_NAME, err))
    println("\nUsing device 0, an $device_info")
    check_error(err)
    device_info = unsafe_string(rs2_get_device_info(dev, RS2_CAMERA_INFO_SERIAL_NUMBER, err))
    println("    Serial number: $device_info")
    check_error(err)
    device_info = unsafe_string(rs2_get_device_info(dev, RS2_CAMERA_INFO_FIRMWARE_VERSION, err))
    println("    Firmware version: $device_info")
    check_error(err)
end
