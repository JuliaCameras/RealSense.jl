using MicroLogging

function checkerror(err)
    if err[] != C_NULL
        funcname = unsafe_string(rs2_get_failed_function(err[]))
        funcargs = unsafe_string(rs2_get_failed_args(err[]))
        message = unsafe_string(rs2_get_error_message(err[]))
        @error "rs_error was raised when calling $funcname($funcargs):\n    $message"
    end
end

function get_device_name(device)
    err = Ref{Ptr{rs2_error}}(C_NULL)
    name = "Unknown Device"
    result = rs2_supports_device_info(device, RS2_CAMERA_INFO_NAME, err)
    checkerror(err)
    if result > 0
        info = rs2_get_device_info(device, RS2_CAMERA_INFO_NAME, err)
        checkerror(err)
        name = unsafe_string(info)
    end
    serialNumber = "########"
    result = rs2_supports_device_info(device, RS2_CAMERA_INFO_SERIAL_NUMBER, err)
    checkerror(err)
    if result > 0
        info = rs2_get_device_info(device, RS2_CAMERA_INFO_SERIAL_NUMBER, err)
        checkerror(err)
        serialNumber = "#" * unsafe_string(info)
    end
    return "$name $serialNumber"
end

function get_a_realsense_device(ctx)
    err = Ref{Ptr{rs2_error}}(C_NULL)
    deviceList = rs2_query_devices(ctx, err)
    checkerror(err)
    deviceCount = rs2_get_device_count(deviceList, err)
    checkerror(err)
    device = Ptr{rs2_device}(C_NULL)
    if deviceCount == 0
        @error "no device connected, please connect a RealSense device."
        hub = rs2_create_device_hub(ctx, err)
        checkerror(err)
        device = rs2_device_hub_wait_for_device(ctx, hub, err)
        checkerror(err)
        rs2_delete_device_hub(hub)
    else
        devices = Dict()
        @info "Found the following devices:"
        for i = 0:deviceCount-1
            dev = rs2_create_device(deviceList, i, err)
            checkerror(err)
            println("    $i: $(get_device_name(dev))")
            devices[i] = dev
        end
        @info "Select a device by index: "
        input = readline()
        idx = parse(Int, input)
        idx ≥ deviceCount && error("selected device index is out of range")
        device = devices[idx]
        delete!(devices, idx)
        for k in keys(devices)
            rs2_delete_device(devices[k])
            delete!(devices, k)
        end
        @assert isempty(devices)
    end
    rs2_delete_device_list(deviceList)
    return device
end

function print_device_information(device)
    err = Ref{Ptr{rs2_error}}(C_NULL)
    @info "Device information: "
    for i = 0:Int(RS2_CAMERA_INFO_COUNT)-1
        info_type = rs2_camera_info(i)
        result = rs2_supports_device_info(device, info_type, err)
        checkerror(err)
        if result > 0
            info = rs2_get_device_info(device, info_type, err)
            checkerror(err)
            @info "    $info_type: $(unsafe_string(info))"
        else
            @info "    $info_type: N/A"
        end
    end
end


function get_sensor_name(sensor)
    err = Ref{Ptr{rs2_error}}(C_NULL)
    result = rs2_supports_sensor_info(sensor, RS2_CAMERA_INFO_NAME, err)
    checkerror(err)
    name = "Unknown Sensor"
    if result > 0
        info = rs2_get_sensor_info(sensor, RS2_CAMERA_INFO_NAME, err)
        checkerror(err)
        name = unsafe_string(info)
    end
    return name
end


function get_a_sensor_from_a_device(device)
    err = Ref{Ptr{rs2_error}}(C_NULL)
    sensorList = rs2_query_sensors(device, err)
    checkerror(err)
    sensorCount = rs2_get_sensors_count(sensorList, err)
    checkerror(err)
    @info "Device consists of $sensorCount sensors:"
    sensors = Dict()
    @info "Found the following devices:"
    for i = 0:sensorCount-1
        sensor = rs2_create_sensor(sensorList, i, err)
        checkerror(err)
        println("    $i: $(get_sensor_name(sensor))")
        sensors[i] = sensor
    end
    @info "Select a device by index: "
    input = readline()
    idx = parse(Int, input)
    idx ≥ sensorCount && error("selected sensor index is out of range")
    sensor = sensors[idx]
    delete!(sensors, idx)
    for k in keys(sensors)
        rs2_delete_sensor(sensors[k])
        delete!(sensors, k)
    end
    @assert isempty(sensors)
    rs2_delete_sensor_list(sensorList)
    return sensor
end

function choose_a_streaming_profile(sensor)
    err = Ref{Ptr{rs2_error}}(C_NULL)
    profileList = rs2_get_stream_profiles(sensor, err)
    checkerror(err)
    profileCount = rs2_get_stream_profiles_count(profileList, err)
    checkerror(err)
    profiles = []
    for i = 0:profileCount-1
        profile = rs2_get_stream_profile(profileList, i, err)
        checkerror(err)
        push!(profiles, profile)
    end

    @info "Sensor provides the following stream profiles:"
    for (profile_num, profile) in enumerate(profiles)
        formatRef, typeRef = Ref{rs2_format}(0), Ref{rs2_stream}(0)
        indexRef, uidRef, framerateRef = Ref{Cint}(0), Ref{Cint}(0), Ref{Cint}(0)
        rs2_get_stream_profile_data(profile, typeRef, formatRef, indexRef, uidRef, framerateRef, err)
        checkerror(err)
        stream_data_type = typeRef[]
        stream_index = indexRef[]
        stream_name = unsafe_string(rs2_stream_to_string(stream_data_type))
        stream_index != 0 && (stream_name = "$stream_name $stream_index";)
        unique_stream_id = uidRef[]
        @info "$profile_num: $stream_name | index: $stream_index | id: $unique_stream_id |"

        is_extendable = rs2_stream_profile_is(profile, RS2_EXTENSION_VIDEO_PROFILE, err)
        checkerror(err)
        if is_extendable > 0
            widthRef, heightRef = Ref{Cint}(0), Ref{Cint}(0)
            rs2_get_video_stream_resolution(profile, widthRef, heightRef, err)
            width, height = widthRef[], heightRef[]
            stream_format = formatRef[]
            stream_fps = framerateRef[]
            @info "  (Video Stream: $(stream_format) $(width)x$height @$(stream_fps)Hz)"
        end
    end
    @info "Please select the desired streaming profile: "
    input = readline()
    idx = parse(Int, input)
    (idx < 1 || idx > profileCount) && error("requested profile index is out of range")
    rs2_delete_stream_profiles_list(profileList)
    return profiles[idx]
end
