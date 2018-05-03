using MicroLogging

function checkerror(err)
    if err[] != C_NULL
        funcname = unsafe_string(rs2_get_failed_function(err[]))
        funcargs = unsafe_string(rs2_get_failed_args(err[]))
        message = unsafe_string(rs2_get_error_message(err[]))
        @error "rs_error was raised when calling $funcname($funcargs):\n    $message"
    end
end

function deviceinfo(dev)
    err = Ref{Ptr{rs2_error}}(0)
    device_info = rs2_get_device_info(dev, RS2_CAMERA_INFO_NAME, err)
    checkerror(err)
    @info "This device is an $(unsafe_string(device_info))"
    device_info = rs2_get_device_info(dev, RS2_CAMERA_INFO_SERIAL_NUMBER, err)
    checkerror(err)
    @info "  Serial number: $(unsafe_string(device_info))"
    device_info = rs2_get_device_info(dev, RS2_CAMERA_INFO_FIRMWARE_VERSION, err)
    checkerror(err)
    @info "  Firmware version: $(unsafe_string(device_info))"
    device_info = rs2_get_device_info(dev, RS2_CAMERA_INFO_PHYSICAL_PORT, err)
    checkerror(err)
    @info "  Physical port: $(unsafe_string(device_info))"
    device_info = rs2_get_device_info(dev, RS2_CAMERA_INFO_ADVANCED_MODE, err)
    checkerror(err)
    @info "  Advanced mode: $(unsafe_string(device_info))"
    device_info = rs2_get_device_info(dev, RS2_CAMERA_INFO_PRODUCT_ID, err)
    checkerror(err)
    @info "  Product ID: $(unsafe_string(device_info))"
end

function get_depth_frame(frames)
    # get the number of frames embedded within the composite frame
    num_of_frames = rs2_embedded_frames_count(frames, err)
    checkerror(err)
    for i = 0:num_of_frames-1
        # extract frame
        frame = rs2_extract_frame(frames, i, err)
        checkerror(err)
        # extract stream profile
        profile = rs2_get_frame_stream_profile(frame, err)
        checkerror(err)
        stream, format = Ref{rs2_stream}(0), Ref{rs2_format}(0)
        index, unique_id, framerate = Ref{Cint}(0), Ref{Cint}(0), Ref{Cint}(0)
        rs2_get_stream_profile_data(profile, stream, format, index, unique_id, framerate, err)
        checkerror(err)
        stream[] == RS2_STREAM_DEPTH && return frame
    end
    return C_NULL
end
