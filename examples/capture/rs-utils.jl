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
    device_info = rs2_get_device_info(dev, RS2_CAMERA_INFO_NAME, err)
    check_error(err)
    println("This device is an $(unsafe_string(device_info))")
    device_info = rs2_get_device_info(dev, RS2_CAMERA_INFO_SERIAL_NUMBER, err)
    check_error(err)
    println("  Serial number: $(unsafe_string(device_info))")
    device_info = rs2_get_device_info(dev, RS2_CAMERA_INFO_FIRMWARE_VERSION, err)
    check_error(err)
    println("  Firmware version: $(unsafe_string(device_info))")
    device_info = rs2_get_device_info(dev, RS2_CAMERA_INFO_PHYSICAL_PORT, err)
    check_error(err)
    println("  Physical port: $(unsafe_string(device_info))")
    device_info = rs2_get_device_info(dev, RS2_CAMERA_INFO_ADVANCED_MODE, err)
    check_error(err)
    println("  Advanced mode: $(unsafe_string(device_info))")
    device_info = rs2_get_device_info(dev, RS2_CAMERA_INFO_PRODUCT_ID, err)
    check_error(err)
    println("  Product ID: $(unsafe_string(device_info))")
end
