using Base.Test
using MicroLogging

function checkerror(err)
    if err[] != C_NULL
        funcname = unsafe_string(rs2_get_failed_function(err[]))
        funcargs = unsafe_string(rs2_get_failed_args(err[]))
        message = unsafe_string(rs2_get_error_message(err[]))
        @error "rs_error was raised when calling $funcname($funcargs):\n    $message"
    end
    @test err[] == C_NULL
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

function disable_sensitive_options_for(device)
    err = Ref{Ptr{rs2_error}}(0)
    sensorList = rs2_query_sensors(device, err)
    checkerror(err)
    sensorCount = rs2_get_sensors_count(sensorList, err)
    checkerror(err)
    for i = 0:sensorCount-1
        sensor = rs2_create_sensor(sensorList, i, err)
        checkerror(err)
        result = rs2_supports_option(sensor, RS2_OPTION_ERROR_POLLING_ENABLED, err)
        checkerror(err)
        if result > 0
            rs2_set_option(sensor, RS2_OPTION_ERROR_POLLING_ENABLED, 0, err)
            checkerror(err)
        end
        result = rs2_supports_option(sensor, RS2_OPTION_ENABLE_AUTO_EXPOSURE, err)
        checkerror(err)
        if result > 0
            rs2_set_option(sensor, RS2_OPTION_ENABLE_AUTO_EXPOSURE, 0, err)
            checkerror(err)
        end
        result = rs2_supports_option(sensor, RS2_OPTION_EXPOSURE, err)
        checkerror(err)
        if result > 0
            minRef, maxRef, stepRef, defRef = Ref{Cfloat}(0), Ref{Cfloat}(0), Ref{Cfloat}(0), Ref{Cfloat}(0)
            rs2_get_option_range(sensor, RS2_OPTION_EXPOSURE, minRef, maxRef, stepRef, defRef, err)
            checkerror(err)
            rs2_set_option(sensor, RS2_OPTION_EXPOSURE, defRef[], err)
            checkerror(err)
        end
        rs2_delete_sensor(sensor)
    end
    rs2_delete_sensor_list(sensorList)
end

function configure_all_supported_streams(device, width=640, height=480, fps=30)
    err = Ref{Ptr{rs2_error}}(C_NULL)
    sensorList = rs2_query_sensors(device, err)
    checkerror(err)
    sensorCount = rs2_get_sensors_count(sensorList, err)
    checkerror(err)
    profiles = []
    sensors = Vector{Ptr{rs2_sensor}}()
    for i = 0:sensorCount-1
        sensor = rs2_create_sensor(sensorList, i, err)
        checkerror(err)
        result = configure_all_supported_profiles(sensor, width, height, fps)
        !isempty(result) && append!(profiles, result)
        push!(sensors, sensor)
    end
    rs2_delete_sensor_list(sensorList)
    return sensors, profiles
end

struct StreamProfile
    stream::rs2_stream
    format::rs2_format
    width::Cint
    height::Cint
    index::Cint
end

function configure_all_supported_profiles(sensor, width=640, height=480, fps=60)
    all_profiles = [StreamProfile(RS2_STREAM_DEPTH, RS2_FORMAT_Z16, width, height, 0),
                    StreamProfile(RS2_STREAM_COLOR, RS2_FORMAT_RGB8, width, height, 0),
                    StreamProfile(RS2_STREAM_INFRARED, RS2_FORMAT_Y8, width, height, 1),
                    StreamProfile(RS2_STREAM_INFRARED, RS2_FORMAT_Y8, width, height, 2),
                    StreamProfile(RS2_STREAM_FISHEYE, RS2_FORMAT_RAW8, width, height, 0),
                    # StreamProfile(RS2_STREAM_GYRO, 0, 0, 0, RS2_FORMAT_MOTION_XYZ32F, 0),
                    # StreamProfile(RS2_STREAM_ACCEL, 0,  0, 0, RS2_FORMAT_MOTION_XYZ32F, 0),
                   ]
    err = Ref{Ptr{rs2_error}}(C_NULL)
    profileList = rs2_get_stream_profiles(sensor, err)
    checkerror(err)
    profileCount = rs2_get_stream_profiles_count(profileList, err)
    checkerror(err)
    profiles = StreamProfile[]
    modes = Vector{Ptr{rs2_stream_profile}}()
    for i = 0:profileCount-1
        profile = rs2_get_stream_profile(profileList, i, err)
        checkerror(err)
        is_extendable = rs2_stream_profile_is(profile, RS2_EXTENSION_VIDEO_PROFILE, err)
        checkerror(err)
        is_extendable > 0 || continue
        formatRef, typeRef = Ref{rs2_format}(0), Ref{rs2_stream}(0)
        indexRef, uidRef, framerateRef = Ref{Cint}(0), Ref{Cint}(0), Ref{Cint}(0)
        rs2_get_stream_profile_data(profile, typeRef, formatRef, indexRef, uidRef, framerateRef, err)
        checkerror(err)
        widthRef, heightRef = Ref{Cint}(0), Ref{Cint}(0)
        rs2_get_video_stream_resolution(profile, widthRef, heightRef, err)
        for sp in all_profiles
            framerateRef[] == fps || continue
            indexRef[] == sp.index || continue
            typeRef[] == sp.stream || continue
            formatRef[] == sp.format || continue
            widthRef[] == sp.width || continue
            heightRef[] == sp.height || continue
            push!(modes, profile)
            push!(profiles, sp)
        end
    end
    if !isempty(modes)
        rs2_open_multiple(sensor, modes, length(modes), err)
        checkerror(err)
    end
    rs2_delete_stream_profiles_list(profileList)
    return profiles
end


function query_sensors(device)
    err = Ref{Ptr{rs2_error}}(C_NULL)
    sensorList = rs2_query_sensors(device, err)
    checkerror(err)
    sensorCount = rs2_get_sensors_count(sensorList, err)
    checkerror(err)
    sensors = []
    for i = 0:sensorCount-1
        sensor = rs2_create_sensor(sensorList, i, err)
        checkerror(err)
        push!(sensors, sensor)
    end
    rs2_delete_sensor_list(sensorList)
    return sensors
end


function on_frame_callback(f::Ptr{rs2_frame}, u::Ptr{Void})
    err = Ptr{Ptr{rs2_error}}(0)
    rs2_process_frame(u, f, err)
end
on_frame_ptr = cfunction(on_frame_callback, Void, (Ptr{rs2_frame},Ptr{Void}))
