module RealSense

using librealsense_jll
export librealsense_jll
librealsense2 = "/home/user/src/librealsense/bb/librealsense2.so"
using CEnum

mutable struct rs2_raw_data_buffer end

mutable struct rs2_error end

function rs2_get_raw_data_size(buffer, error)
    ccall((:rs2_get_raw_data_size, librealsense2), Cint, (Ptr{rs2_raw_data_buffer}, Ptr{Ptr{rs2_error}}), buffer, error)
end

function rs2_delete_raw_data(buffer)
    ccall((:rs2_delete_raw_data, librealsense2), Cvoid, (Ptr{rs2_raw_data_buffer},), buffer)
end

function rs2_get_raw_data(buffer, error)
    ccall((:rs2_get_raw_data, librealsense2), Ptr{Cuchar}, (Ptr{rs2_raw_data_buffer}, Ptr{Ptr{rs2_error}}), buffer, error)
end

function rs2_get_api_version(error)
    ccall((:rs2_get_api_version, librealsense2), Cint, (Ptr{Ptr{rs2_error}},), error)
end

@cenum rs2_log_severity::UInt32 begin
    RS2_LOG_SEVERITY_DEBUG = 0
    RS2_LOG_SEVERITY_INFO = 1
    RS2_LOG_SEVERITY_WARN = 2
    RS2_LOG_SEVERITY_ERROR = 3
    RS2_LOG_SEVERITY_FATAL = 4
    RS2_LOG_SEVERITY_NONE = 5
    RS2_LOG_SEVERITY_COUNT = 6
    RS2_LOG_SEVERITY_ALL = 0
end

function rs2_log_to_console(min_severity, error)
    ccall((:rs2_log_to_console, librealsense2), Cvoid, (rs2_log_severity, Ptr{Ptr{rs2_error}}), min_severity, error)
end

function rs2_log_to_file(min_severity, file_path, error)
    ccall((:rs2_log_to_file, librealsense2), Cvoid, (rs2_log_severity, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), min_severity, file_path, error)
end

mutable struct rs2_log_callback end

function rs2_log_to_callback_cpp(min_severity, callback, error)
    ccall((:rs2_log_to_callback_cpp, librealsense2), Cvoid, (rs2_log_severity, Ptr{rs2_log_callback}, Ptr{Ptr{rs2_error}}), min_severity, callback, error)
end

# typedef void ( * rs2_log_callback_ptr ) ( rs2_log_severity , rs2_log_message const * , void * arg )
const rs2_log_callback_ptr = Ptr{Cvoid}

function rs2_log_to_callback(min_severity, callback, arg, error)
    ccall((:rs2_log_to_callback, librealsense2), Cvoid, (rs2_log_severity, rs2_log_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), min_severity, callback, arg, error)
end

mutable struct rs2_log_message end

function rs2_get_log_message_line_number(msg, error)
    ccall((:rs2_get_log_message_line_number, librealsense2), Cuint, (Ptr{rs2_log_message}, Ptr{Ptr{rs2_error}}), msg, error)
end

function rs2_get_log_message_filename(msg, error)
    ccall((:rs2_get_log_message_filename, librealsense2), Ptr{Cchar}, (Ptr{rs2_log_message}, Ptr{Ptr{rs2_error}}), msg, error)
end

function rs2_get_raw_log_message(msg, error)
    ccall((:rs2_get_raw_log_message, librealsense2), Ptr{Cchar}, (Ptr{rs2_log_message}, Ptr{Ptr{rs2_error}}), msg, error)
end

function rs2_get_full_log_message(msg, error)
    ccall((:rs2_get_full_log_message, librealsense2), Ptr{Cchar}, (Ptr{rs2_log_message}, Ptr{Ptr{rs2_error}}), msg, error)
end

function rs2_log(severity, message, error)
    ccall((:rs2_log, librealsense2), Cvoid, (rs2_log_severity, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), severity, message, error)
end

mutable struct rs2_frame end

function rs2_depth_frame_get_distance(frame_ref, x, y, error)
    ccall((:rs2_depth_frame_get_distance, librealsense2), Cfloat, (Ptr{rs2_frame}, Cint, Cint, Ptr{Ptr{rs2_error}}), frame_ref, x, y, error)
end

const rs2_time_t = Cdouble

function rs2_get_time(error)
    ccall((:rs2_get_time, librealsense2), rs2_time_t, (Ptr{Ptr{rs2_error}},), error)
end

mutable struct rs2_device end

function rs2_toggle_advanced_mode(dev, enable, error)
    ccall((:rs2_toggle_advanced_mode, librealsense2), Cvoid, (Ptr{rs2_device}, Cint, Ptr{Ptr{rs2_error}}), dev, enable, error)
end

function rs2_is_enabled(dev, enabled, error)
    ccall((:rs2_is_enabled, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Cint}, Ptr{Ptr{rs2_error}}), dev, enabled, error)
end

struct STDepthControlGroup
    plusIncrement::UInt32
    minusDecrement::UInt32
    deepSeaMedianThreshold::UInt32
    scoreThreshA::UInt32
    scoreThreshB::UInt32
    textureDifferenceThreshold::UInt32
    textureCountThreshold::UInt32
    deepSeaSecondPeakThreshold::UInt32
    deepSeaNeighborThreshold::UInt32
    lrAgreeThreshold::UInt32
end

function rs2_set_depth_control(dev, group, error)
    ccall((:rs2_set_depth_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STDepthControlGroup}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_depth_control(dev, group, mode, error)
    ccall((:rs2_get_depth_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STDepthControlGroup}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

struct STRsm
    rsmBypass::UInt32
    diffThresh::Cfloat
    sloRauDiffThresh::Cfloat
    removeThresh::UInt32
end

function rs2_set_rsm(dev, group, error)
    ccall((:rs2_set_rsm, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STRsm}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_rsm(dev, group, mode, error)
    ccall((:rs2_get_rsm, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STRsm}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

struct STRauSupportVectorControl
    minWest::UInt32
    minEast::UInt32
    minWEsum::UInt32
    minNorth::UInt32
    minSouth::UInt32
    minNSsum::UInt32
    uShrink::UInt32
    vShrink::UInt32
end

function rs2_set_rau_support_vector_control(dev, group, error)
    ccall((:rs2_set_rau_support_vector_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STRauSupportVectorControl}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_rau_support_vector_control(dev, group, mode, error)
    ccall((:rs2_get_rau_support_vector_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STRauSupportVectorControl}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

struct STColorControl
    disableSADColor::UInt32
    disableRAUColor::UInt32
    disableSLORightColor::UInt32
    disableSLOLeftColor::UInt32
    disableSADNormalize::UInt32
end

function rs2_set_color_control(dev, group, error)
    ccall((:rs2_set_color_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STColorControl}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_color_control(dev, group, mode, error)
    ccall((:rs2_get_color_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STColorControl}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

struct STRauColorThresholdsControl
    rauDiffThresholdRed::UInt32
    rauDiffThresholdGreen::UInt32
    rauDiffThresholdBlue::UInt32
end

function rs2_set_rau_thresholds_control(dev, group, error)
    ccall((:rs2_set_rau_thresholds_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STRauColorThresholdsControl}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_rau_thresholds_control(dev, group, mode, error)
    ccall((:rs2_get_rau_thresholds_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STRauColorThresholdsControl}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

struct STSloColorThresholdsControl
    diffThresholdRed::UInt32
    diffThresholdGreen::UInt32
    diffThresholdBlue::UInt32
end

function rs2_set_slo_color_thresholds_control(dev, group, error)
    ccall((:rs2_set_slo_color_thresholds_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STSloColorThresholdsControl}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_slo_color_thresholds_control(dev, group, mode, error)
    ccall((:rs2_get_slo_color_thresholds_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STSloColorThresholdsControl}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

struct STSloPenaltyControl
    sloK1Penalty::UInt32
    sloK2Penalty::UInt32
    sloK1PenaltyMod1::UInt32
    sloK2PenaltyMod1::UInt32
    sloK1PenaltyMod2::UInt32
    sloK2PenaltyMod2::UInt32
end

function rs2_set_slo_penalty_control(dev, group, error)
    ccall((:rs2_set_slo_penalty_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STSloPenaltyControl}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_slo_penalty_control(dev, group, mode, error)
    ccall((:rs2_get_slo_penalty_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STSloPenaltyControl}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

struct STHdad
    lambdaCensus::Cfloat
    lambdaAD::Cfloat
    ignoreSAD::UInt32
end

function rs2_set_hdad(dev, group, error)
    ccall((:rs2_set_hdad, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STHdad}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_hdad(dev, group, mode, error)
    ccall((:rs2_get_hdad, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STHdad}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

struct STColorCorrection
    colorCorrection1::Cfloat
    colorCorrection2::Cfloat
    colorCorrection3::Cfloat
    colorCorrection4::Cfloat
    colorCorrection5::Cfloat
    colorCorrection6::Cfloat
    colorCorrection7::Cfloat
    colorCorrection8::Cfloat
    colorCorrection9::Cfloat
    colorCorrection10::Cfloat
    colorCorrection11::Cfloat
    colorCorrection12::Cfloat
end

function rs2_set_color_correction(dev, group, error)
    ccall((:rs2_set_color_correction, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STColorCorrection}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_color_correction(dev, group, mode, error)
    ccall((:rs2_get_color_correction, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STColorCorrection}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

struct STDepthTableControl
    depthUnits::UInt32
    depthClampMin::Int32
    depthClampMax::Int32
    disparityMode::UInt32
    disparityShift::Int32
end

function rs2_set_depth_table(dev, group, error)
    ccall((:rs2_set_depth_table, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STDepthTableControl}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_depth_table(dev, group, mode, error)
    ccall((:rs2_get_depth_table, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STDepthTableControl}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

struct STAEControl
    meanIntensitySetPoint::UInt32
end

function rs2_set_ae_control(dev, group, error)
    ccall((:rs2_set_ae_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STAEControl}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_ae_control(dev, group, mode, error)
    ccall((:rs2_get_ae_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STAEControl}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

struct STCensusRadius
    uDiameter::UInt32
    vDiameter::UInt32
end

function rs2_set_census(dev, group, error)
    ccall((:rs2_set_census, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STCensusRadius}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_census(dev, group, mode, error)
    ccall((:rs2_get_census, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STCensusRadius}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

struct STAFactor
    amplitude::Cfloat
end

function rs2_set_amp_factor(dev, group, error)
    ccall((:rs2_set_amp_factor, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STAFactor}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_amp_factor(dev, group, mode, error)
    ccall((:rs2_get_amp_factor, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STAFactor}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

@cenum rs2_distortion::UInt32 begin
    RS2_DISTORTION_NONE = 0
    RS2_DISTORTION_MODIFIED_BROWN_CONRADY = 1
    RS2_DISTORTION_INVERSE_BROWN_CONRADY = 2
    RS2_DISTORTION_FTHETA = 3
    RS2_DISTORTION_BROWN_CONRADY = 4
    RS2_DISTORTION_KANNALA_BRANDT4 = 5
    RS2_DISTORTION_COUNT = 6
end

struct rs2_intrinsics
    width::Cint
    height::Cint
    ppx::Cfloat
    ppy::Cfloat
    fx::Cfloat
    fy::Cfloat
    model::rs2_distortion
    coeffs::NTuple{5, Cfloat}
end

function rs2_project_point_to_pixel(pixel, intrin, point)
    ccall((:rs2_project_point_to_pixel, librealsense2), Cvoid, (Ptr{Cfloat}, Ptr{rs2_intrinsics}, Ptr{Cfloat}), pixel, intrin, point)
end

function rs2_deproject_pixel_to_point(point, intrin, pixel, depth)
    ccall((:rs2_deproject_pixel_to_point, librealsense2), Cvoid, (Ptr{Cfloat}, Ptr{rs2_intrinsics}, Ptr{Cfloat}, Cfloat), point, intrin, pixel, depth)
end

struct rs2_extrinsics
    rotation::NTuple{9, Cfloat}
    translation::NTuple{3, Cfloat}
end

function rs2_transform_point_to_point(to_point, extrin, from_point)
    ccall((:rs2_transform_point_to_point, librealsense2), Cvoid, (Ptr{Cfloat}, Ptr{rs2_extrinsics}, Ptr{Cfloat}), to_point, extrin, from_point)
end

function rs2_fov(intrin, to_fov)
    ccall((:rs2_fov, librealsense2), Cvoid, (Ptr{rs2_intrinsics}, Ptr{Cfloat}), intrin, to_fov)
end

function next_pixel_in_line(curr, start, _end)
    ccall((:next_pixel_in_line, librealsense2), Cvoid, (Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), curr, start, _end)
end

function is_pixel_in_line(curr, start, _end)
    ccall((:is_pixel_in_line, librealsense2), Bool, (Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), curr, start, _end)
end

function adjust_2D_point_to_boundary(p, width, height)
    ccall((:adjust_2D_point_to_boundary, librealsense2), Cvoid, (Ptr{Cfloat}, Cint, Cint), p, width, height)
end

function rs2_project_color_pixel_to_depth_pixel(to_pixel, data, depth_scale, depth_min, depth_max, depth_intrin, color_intrin, color_to_depth, depth_to_color, from_pixel)
    ccall((:rs2_project_color_pixel_to_depth_pixel, librealsense2), Cvoid, (Ptr{Cfloat}, Ptr{UInt16}, Cfloat, Cfloat, Cfloat, Ptr{rs2_intrinsics}, Ptr{rs2_intrinsics}, Ptr{rs2_extrinsics}, Ptr{rs2_extrinsics}, Ptr{Cfloat}), to_pixel, data, depth_scale, depth_min, depth_max, depth_intrin, color_intrin, color_to_depth, depth_to_color, from_pixel)
end

mutable struct rs2_config end

function rs2_create_config(error)
    ccall((:rs2_create_config, librealsense2), Ptr{rs2_config}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_delete_config(config)
    ccall((:rs2_delete_config, librealsense2), Cvoid, (Ptr{rs2_config},), config)
end

@cenum rs2_stream::UInt32 begin
    RS2_STREAM_ANY = 0
    RS2_STREAM_DEPTH = 1
    RS2_STREAM_COLOR = 2
    RS2_STREAM_INFRARED = 3
    RS2_STREAM_FISHEYE = 4
    RS2_STREAM_GYRO = 5
    RS2_STREAM_ACCEL = 6
    RS2_STREAM_GPIO = 7
    RS2_STREAM_POSE = 8
    RS2_STREAM_CONFIDENCE = 9
    RS2_STREAM_COUNT = 10
end

@cenum rs2_format::UInt32 begin
    RS2_FORMAT_ANY = 0
    RS2_FORMAT_Z16 = 1
    RS2_FORMAT_DISPARITY16 = 2
    RS2_FORMAT_XYZ32F = 3
    RS2_FORMAT_YUYV = 4
    RS2_FORMAT_RGB8 = 5
    RS2_FORMAT_BGR8 = 6
    RS2_FORMAT_RGBA8 = 7
    RS2_FORMAT_BGRA8 = 8
    RS2_FORMAT_Y8 = 9
    RS2_FORMAT_Y16 = 10
    RS2_FORMAT_RAW10 = 11
    RS2_FORMAT_RAW16 = 12
    RS2_FORMAT_RAW8 = 13
    RS2_FORMAT_UYVY = 14
    RS2_FORMAT_MOTION_RAW = 15
    RS2_FORMAT_MOTION_XYZ32F = 16
    RS2_FORMAT_GPIO_RAW = 17
    RS2_FORMAT_6DOF = 18
    RS2_FORMAT_DISPARITY32 = 19
    RS2_FORMAT_Y10BPACK = 20
    RS2_FORMAT_DISTANCE = 21
    RS2_FORMAT_MJPEG = 22
    RS2_FORMAT_Y8I = 23
    RS2_FORMAT_Y12I = 24
    RS2_FORMAT_INZI = 25
    RS2_FORMAT_INVI = 26
    RS2_FORMAT_W10 = 27
    RS2_FORMAT_Z16H = 28
    RS2_FORMAT_FG = 29
    RS2_FORMAT_COUNT = 30
end

function rs2_config_enable_stream(config, stream, index, width, height, format, framerate, error)
    ccall((:rs2_config_enable_stream, librealsense2), Cvoid, (Ptr{rs2_config}, rs2_stream, Cint, Cint, Cint, rs2_format, Cint, Ptr{Ptr{rs2_error}}), config, stream, index, width, height, format, framerate, error)
end

function rs2_config_enable_all_stream(config, error)
    ccall((:rs2_config_enable_all_stream, librealsense2), Cvoid, (Ptr{rs2_config}, Ptr{Ptr{rs2_error}}), config, error)
end

function rs2_config_enable_device(config, serial, error)
    ccall((:rs2_config_enable_device, librealsense2), Cvoid, (Ptr{rs2_config}, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), config, serial, error)
end

function rs2_config_enable_device_from_file(config, file, error)
    ccall((:rs2_config_enable_device_from_file, librealsense2), Cvoid, (Ptr{rs2_config}, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), config, file, error)
end

function rs2_config_enable_device_from_file_repeat_option(config, file, repeat_playback, error)
    ccall((:rs2_config_enable_device_from_file_repeat_option, librealsense2), Cvoid, (Ptr{rs2_config}, Ptr{Cchar}, Cint, Ptr{Ptr{rs2_error}}), config, file, repeat_playback, error)
end

function rs2_config_enable_record_to_file(config, file, error)
    ccall((:rs2_config_enable_record_to_file, librealsense2), Cvoid, (Ptr{rs2_config}, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), config, file, error)
end

function rs2_config_disable_stream(config, stream, error)
    ccall((:rs2_config_disable_stream, librealsense2), Cvoid, (Ptr{rs2_config}, rs2_stream, Ptr{Ptr{rs2_error}}), config, stream, error)
end

function rs2_config_disable_indexed_stream(config, stream, index, error)
    ccall((:rs2_config_disable_indexed_stream, librealsense2), Cvoid, (Ptr{rs2_config}, rs2_stream, Cint, Ptr{Ptr{rs2_error}}), config, stream, index, error)
end

function rs2_config_disable_all_streams(config, error)
    ccall((:rs2_config_disable_all_streams, librealsense2), Cvoid, (Ptr{rs2_config}, Ptr{Ptr{rs2_error}}), config, error)
end

mutable struct rs2_pipeline end

mutable struct rs2_pipeline_profile end

function rs2_config_resolve(config, pipe, error)
    ccall((:rs2_config_resolve, librealsense2), Ptr{rs2_pipeline_profile}, (Ptr{rs2_config}, Ptr{rs2_pipeline}, Ptr{Ptr{rs2_error}}), config, pipe, error)
end

function rs2_config_can_resolve(config, pipe, error)
    ccall((:rs2_config_can_resolve, librealsense2), Cint, (Ptr{rs2_config}, Ptr{rs2_pipeline}, Ptr{Ptr{rs2_error}}), config, pipe, error)
end

mutable struct rs2_context end

function rs2_create_context(api_version, error)
    ccall((:rs2_create_context, librealsense2), Ptr{rs2_context}, (Cint, Ptr{Ptr{rs2_error}}), api_version, error)
end

function rs2_delete_context(context)
    ccall((:rs2_delete_context, librealsense2), Cvoid, (Ptr{rs2_context},), context)
end

mutable struct rs2_devices_changed_callback end

function rs2_set_devices_changed_callback_cpp(context, callback, error)
    ccall((:rs2_set_devices_changed_callback_cpp, librealsense2), Cvoid, (Ptr{rs2_context}, Ptr{rs2_devices_changed_callback}, Ptr{Ptr{rs2_error}}), context, callback, error)
end

# typedef void ( * rs2_devices_changed_callback_ptr ) ( rs2_device_list * , rs2_device_list * , void * )
const rs2_devices_changed_callback_ptr = Ptr{Cvoid}

function rs2_set_devices_changed_callback(context, callback, user, error)
    ccall((:rs2_set_devices_changed_callback, librealsense2), Cvoid, (Ptr{rs2_context}, rs2_devices_changed_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), context, callback, user, error)
end

function rs2_context_add_device(ctx, file, error)
    ccall((:rs2_context_add_device, librealsense2), Ptr{rs2_device}, (Ptr{rs2_context}, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), ctx, file, error)
end

function rs2_context_add_software_device(ctx, dev, error)
    ccall((:rs2_context_add_software_device, librealsense2), Cvoid, (Ptr{rs2_context}, Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), ctx, dev, error)
end

function rs2_context_remove_device(ctx, file, error)
    ccall((:rs2_context_remove_device, librealsense2), Cvoid, (Ptr{rs2_context}, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), ctx, file, error)
end

function rs2_context_unload_tracking_module(ctx, error)
    ccall((:rs2_context_unload_tracking_module, librealsense2), Cvoid, (Ptr{rs2_context}, Ptr{Ptr{rs2_error}}), ctx, error)
end

mutable struct rs2_device_list end

function rs2_query_devices(context, error)
    ccall((:rs2_query_devices, librealsense2), Ptr{rs2_device_list}, (Ptr{rs2_context}, Ptr{Ptr{rs2_error}}), context, error)
end

function rs2_query_devices_ex(context, product_mask, error)
    ccall((:rs2_query_devices_ex, librealsense2), Ptr{rs2_device_list}, (Ptr{rs2_context}, Cint, Ptr{Ptr{rs2_error}}), context, product_mask, error)
end

mutable struct rs2_device_hub end

function rs2_create_device_hub(context, error)
    ccall((:rs2_create_device_hub, librealsense2), Ptr{rs2_device_hub}, (Ptr{rs2_context}, Ptr{Ptr{rs2_error}}), context, error)
end

function rs2_delete_device_hub(hub)
    ccall((:rs2_delete_device_hub, librealsense2), Cvoid, (Ptr{rs2_device_hub},), hub)
end

function rs2_device_hub_wait_for_device(hub, error)
    ccall((:rs2_device_hub_wait_for_device, librealsense2), Ptr{rs2_device}, (Ptr{rs2_device_hub}, Ptr{Ptr{rs2_error}}), hub, error)
end

function rs2_device_hub_is_device_connected(hub, device, error)
    ccall((:rs2_device_hub_is_device_connected, librealsense2), Cint, (Ptr{rs2_device_hub}, Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), hub, device, error)
end

function rs2_get_device_count(info_list, error)
    ccall((:rs2_get_device_count, librealsense2), Cint, (Ptr{rs2_device_list}, Ptr{Ptr{rs2_error}}), info_list, error)
end

function rs2_delete_device_list(info_list)
    ccall((:rs2_delete_device_list, librealsense2), Cvoid, (Ptr{rs2_device_list},), info_list)
end

function rs2_device_list_contains(info_list, device, error)
    ccall((:rs2_device_list_contains, librealsense2), Cint, (Ptr{rs2_device_list}, Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), info_list, device, error)
end

function rs2_create_device(info_list, index, error)
    ccall((:rs2_create_device, librealsense2), Ptr{rs2_device}, (Ptr{rs2_device_list}, Cint, Ptr{Ptr{rs2_error}}), info_list, index, error)
end

function rs2_delete_device(device)
    ccall((:rs2_delete_device, librealsense2), Cvoid, (Ptr{rs2_device},), device)
end

@cenum rs2_camera_info::UInt32 begin
    RS2_CAMERA_INFO_NAME = 0
    RS2_CAMERA_INFO_SERIAL_NUMBER = 1
    RS2_CAMERA_INFO_FIRMWARE_VERSION = 2
    RS2_CAMERA_INFO_RECOMMENDED_FIRMWARE_VERSION = 3
    RS2_CAMERA_INFO_PHYSICAL_PORT = 4
    RS2_CAMERA_INFO_DEBUG_OP_CODE = 5
    RS2_CAMERA_INFO_ADVANCED_MODE = 6
    RS2_CAMERA_INFO_PRODUCT_ID = 7
    RS2_CAMERA_INFO_CAMERA_LOCKED = 8
    RS2_CAMERA_INFO_USB_TYPE_DESCRIPTOR = 9
    RS2_CAMERA_INFO_PRODUCT_LINE = 10
    RS2_CAMERA_INFO_ASIC_SERIAL_NUMBER = 11
    RS2_CAMERA_INFO_FIRMWARE_UPDATE_ID = 12
    RS2_CAMERA_INFO_IP_ADDRESS = 13
    RS2_CAMERA_INFO_COUNT = 14
end

function rs2_get_device_info(device, info, error)
    ccall((:rs2_get_device_info, librealsense2), Ptr{Cchar}, (Ptr{rs2_device}, rs2_camera_info, Ptr{Ptr{rs2_error}}), device, info, error)
end

function rs2_supports_device_info(device, info, error)
    ccall((:rs2_supports_device_info, librealsense2), Cint, (Ptr{rs2_device}, rs2_camera_info, Ptr{Ptr{rs2_error}}), device, info, error)
end

function rs2_hardware_reset(device, error)
    ccall((:rs2_hardware_reset, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_send_and_receive_raw_data(device, raw_data_to_send, size_of_raw_data_to_send, error)
    ccall((:rs2_send_and_receive_raw_data, librealsense2), Ptr{rs2_raw_data_buffer}, (Ptr{rs2_device}, Ptr{Cvoid}, Cuint, Ptr{Ptr{rs2_error}}), device, raw_data_to_send, size_of_raw_data_to_send, error)
end

@cenum rs2_extension::UInt32 begin
    RS2_EXTENSION_UNKNOWN = 0
    RS2_EXTENSION_DEBUG = 1
    RS2_EXTENSION_INFO = 2
    RS2_EXTENSION_MOTION = 3
    RS2_EXTENSION_OPTIONS = 4
    RS2_EXTENSION_VIDEO = 5
    RS2_EXTENSION_ROI = 6
    RS2_EXTENSION_DEPTH_SENSOR = 7
    RS2_EXTENSION_VIDEO_FRAME = 8
    RS2_EXTENSION_MOTION_FRAME = 9
    RS2_EXTENSION_COMPOSITE_FRAME = 10
    RS2_EXTENSION_POINTS = 11
    RS2_EXTENSION_DEPTH_FRAME = 12
    RS2_EXTENSION_ADVANCED_MODE = 13
    RS2_EXTENSION_RECORD = 14
    RS2_EXTENSION_VIDEO_PROFILE = 15
    RS2_EXTENSION_PLAYBACK = 16
    RS2_EXTENSION_DEPTH_STEREO_SENSOR = 17
    RS2_EXTENSION_DISPARITY_FRAME = 18
    RS2_EXTENSION_MOTION_PROFILE = 19
    RS2_EXTENSION_POSE_FRAME = 20
    RS2_EXTENSION_POSE_PROFILE = 21
    RS2_EXTENSION_TM2 = 22
    RS2_EXTENSION_SOFTWARE_DEVICE = 23
    RS2_EXTENSION_SOFTWARE_SENSOR = 24
    RS2_EXTENSION_DECIMATION_FILTER = 25
    RS2_EXTENSION_THRESHOLD_FILTER = 26
    RS2_EXTENSION_DISPARITY_FILTER = 27
    RS2_EXTENSION_SPATIAL_FILTER = 28
    RS2_EXTENSION_TEMPORAL_FILTER = 29
    RS2_EXTENSION_HOLE_FILLING_FILTER = 30
    RS2_EXTENSION_ZERO_ORDER_FILTER = 31
    RS2_EXTENSION_RECOMMENDED_FILTERS = 32
    RS2_EXTENSION_POSE = 33
    RS2_EXTENSION_POSE_SENSOR = 34
    RS2_EXTENSION_WHEEL_ODOMETER = 35
    RS2_EXTENSION_GLOBAL_TIMER = 36
    RS2_EXTENSION_UPDATABLE = 37
    RS2_EXTENSION_UPDATE_DEVICE = 38
    RS2_EXTENSION_L500_DEPTH_SENSOR = 39
    RS2_EXTENSION_TM2_SENSOR = 40
    RS2_EXTENSION_AUTO_CALIBRATED_DEVICE = 41
    RS2_EXTENSION_COLOR_SENSOR = 42
    RS2_EXTENSION_MOTION_SENSOR = 43
    RS2_EXTENSION_FISHEYE_SENSOR = 44
    RS2_EXTENSION_DEPTH_HUFFMAN_DECODER = 45
    RS2_EXTENSION_SERIALIZABLE = 46
    RS2_EXTENSION_FW_LOGGER = 47
    RS2_EXTENSION_AUTO_CALIBRATION_FILTER = 48
    RS2_EXTENSION_DEVICE_CALIBRATION = 49
    RS2_EXTENSION_CALIBRATED_SENSOR = 50
    RS2_EXTENSION_HDR_MERGE = 51
    RS2_EXTENSION_SEQUENCE_ID_FILTER = 52
    RS2_EXTENSION_MAX_USABLE_RANGE_SENSOR = 53
    RS2_EXTENSION_DEBUG_STREAM_SENSOR = 54
    RS2_EXTENSION_COUNT = 55
end

function rs2_is_device_extendable_to(device, extension, error)
    ccall((:rs2_is_device_extendable_to, librealsense2), Cint, (Ptr{rs2_device}, rs2_extension, Ptr{Ptr{rs2_error}}), device, extension, error)
end

mutable struct rs2_sensor_list end

function rs2_query_sensors(device, error)
    ccall((:rs2_query_sensors, librealsense2), Ptr{rs2_sensor_list}, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_loopback_enable(device, from_file, error)
    ccall((:rs2_loopback_enable, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), device, from_file, error)
end

function rs2_loopback_disable(device, error)
    ccall((:rs2_loopback_disable, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_loopback_is_enabled(device, error)
    ccall((:rs2_loopback_is_enabled, librealsense2), Cint, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_connect_tm2_controller(device, mac_addr, error)
    ccall((:rs2_connect_tm2_controller, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Cuchar}, Ptr{Ptr{rs2_error}}), device, mac_addr, error)
end

function rs2_disconnect_tm2_controller(device, id, error)
    ccall((:rs2_disconnect_tm2_controller, librealsense2), Cvoid, (Ptr{rs2_device}, Cint, Ptr{Ptr{rs2_error}}), device, id, error)
end

function rs2_reset_to_factory_calibration(device, e)
    ccall((:rs2_reset_to_factory_calibration, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, e)
end

function rs2_write_calibration(device, e)
    ccall((:rs2_write_calibration, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, e)
end

mutable struct rs2_update_progress_callback end

function rs2_update_firmware_cpp(device, fw_image, fw_image_size, callback, error)
    ccall((:rs2_update_firmware_cpp, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Cvoid}, Cint, Ptr{rs2_update_progress_callback}, Ptr{Ptr{rs2_error}}), device, fw_image, fw_image_size, callback, error)
end

# typedef void ( * rs2_update_progress_callback_ptr ) ( const float , void * )
const rs2_update_progress_callback_ptr = Ptr{Cvoid}

function rs2_update_firmware(device, fw_image, fw_image_size, callback, client_data, error)
    ccall((:rs2_update_firmware, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Cvoid}, Cint, rs2_update_progress_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), device, fw_image, fw_image_size, callback, client_data, error)
end

function rs2_create_flash_backup_cpp(device, callback, error)
    ccall((:rs2_create_flash_backup_cpp, librealsense2), Ptr{rs2_raw_data_buffer}, (Ptr{rs2_device}, Ptr{rs2_update_progress_callback}, Ptr{Ptr{rs2_error}}), device, callback, error)
end

function rs2_create_flash_backup(device, callback, client_data, error)
    ccall((:rs2_create_flash_backup, librealsense2), Ptr{rs2_raw_data_buffer}, (Ptr{rs2_device}, rs2_update_progress_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), device, callback, client_data, error)
end

function rs2_update_firmware_unsigned_cpp(device, fw_image, fw_image_size, callback, update_mode, error)
    ccall((:rs2_update_firmware_unsigned_cpp, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Cvoid}, Cint, Ptr{rs2_update_progress_callback}, Cint, Ptr{Ptr{rs2_error}}), device, fw_image, fw_image_size, callback, update_mode, error)
end

function rs2_update_firmware_unsigned(device, fw_image, fw_image_size, callback, client_data, update_mode, error)
    ccall((:rs2_update_firmware_unsigned, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Cvoid}, Cint, rs2_update_progress_callback_ptr, Ptr{Cvoid}, Cint, Ptr{Ptr{rs2_error}}), device, fw_image, fw_image_size, callback, client_data, update_mode, error)
end

function rs2_enter_update_state(device, error)
    ccall((:rs2_enter_update_state, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_run_on_chip_calibration_cpp(device, json_content, content_size, health, progress_callback, timeout_ms, error)
    ccall((:rs2_run_on_chip_calibration_cpp, librealsense2), Ptr{rs2_raw_data_buffer}, (Ptr{rs2_device}, Ptr{Cvoid}, Cint, Ptr{Cfloat}, Ptr{rs2_update_progress_callback}, Cint, Ptr{Ptr{rs2_error}}), device, json_content, content_size, health, progress_callback, timeout_ms, error)
end

function rs2_run_on_chip_calibration(device, json_content, content_size, health, callback, client_data, timeout_ms, error)
    ccall((:rs2_run_on_chip_calibration, librealsense2), Ptr{rs2_raw_data_buffer}, (Ptr{rs2_device}, Ptr{Cvoid}, Cint, Ptr{Cfloat}, rs2_update_progress_callback_ptr, Ptr{Cvoid}, Cint, Ptr{Ptr{rs2_error}}), device, json_content, content_size, health, callback, client_data, timeout_ms, error)
end

function rs2_run_tare_calibration_cpp(dev, ground_truth_mm, json_content, content_size, progress_callback, timeout_ms, error)
    ccall((:rs2_run_tare_calibration_cpp, librealsense2), Ptr{rs2_raw_data_buffer}, (Ptr{rs2_device}, Cfloat, Ptr{Cvoid}, Cint, Ptr{rs2_update_progress_callback}, Cint, Ptr{Ptr{rs2_error}}), dev, ground_truth_mm, json_content, content_size, progress_callback, timeout_ms, error)
end

@cenum rs2_calibration_type::UInt32 begin
    RS2_CALIBRATION_AUTO_DEPTH_TO_RGB = 0
    RS2_CALIBRATION_MANUAL_DEPTH_TO_RGB = 1
    RS2_CALIBRATION_TYPE_COUNT = 2
end

function rs2_calibration_type_to_string(arg1)
    ccall((:rs2_calibration_type_to_string, librealsense2), Ptr{Cchar}, (rs2_calibration_type,), arg1)
end

@cenum rs2_calibration_status::Int32 begin
    RS2_CALIBRATION_TRIGGERED = 0
    RS2_CALIBRATION_SPECIAL_FRAME = 1
    RS2_CALIBRATION_STARTED = 2
    RS2_CALIBRATION_NOT_NEEDED = 3
    RS2_CALIBRATION_SUCCESSFUL = 4
    RS2_CALIBRATION_RETRY = -1
    RS2_CALIBRATION_FAILED = -2
    RS2_CALIBRATION_SCENE_INVALID = -3
    RS2_CALIBRATION_BAD_RESULT = -4
    RS2_CALIBRATION_BAD_CONDITIONS = -5
    RS2_CALIBRATION_STATUS_FIRST = -5
    RS2_CALIBRATION_STATUS_LAST = 4
    RS2_CALIBRATION_STATUS_COUNT = 10
end

function rs2_calibration_status_to_string(arg1)
    ccall((:rs2_calibration_status_to_string, librealsense2), Ptr{Cchar}, (rs2_calibration_status,), arg1)
end

mutable struct rs2_calibration_change_callback end

# typedef void ( * rs2_calibration_change_callback_ptr ) ( rs2_calibration_status , void * arg )
const rs2_calibration_change_callback_ptr = Ptr{Cvoid}

function rs2_register_calibration_change_callback(dev, callback, user, error)
    ccall((:rs2_register_calibration_change_callback, librealsense2), Cvoid, (Ptr{rs2_device}, rs2_calibration_change_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), dev, callback, user, error)
end

function rs2_register_calibration_change_callback_cpp(dev, callback, error)
    ccall((:rs2_register_calibration_change_callback_cpp, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{rs2_calibration_change_callback}, Ptr{Ptr{rs2_error}}), dev, callback, error)
end

function rs2_trigger_device_calibration(dev, type, error)
    ccall((:rs2_trigger_device_calibration, librealsense2), Cvoid, (Ptr{rs2_device}, rs2_calibration_type, Ptr{Ptr{rs2_error}}), dev, type, error)
end

function rs2_run_tare_calibration(dev, ground_truth_mm, json_content, content_size, callback, client_data, timeout_ms, error)
    ccall((:rs2_run_tare_calibration, librealsense2), Ptr{rs2_raw_data_buffer}, (Ptr{rs2_device}, Cfloat, Ptr{Cvoid}, Cint, rs2_update_progress_callback_ptr, Ptr{Cvoid}, Cint, Ptr{Ptr{rs2_error}}), dev, ground_truth_mm, json_content, content_size, callback, client_data, timeout_ms, error)
end

function rs2_get_calibration_table(dev, error)
    ccall((:rs2_get_calibration_table, librealsense2), Ptr{rs2_raw_data_buffer}, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), dev, error)
end

function rs2_set_calibration_table(device, calibration, calibration_size, error)
    ccall((:rs2_set_calibration_table, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Cvoid}, Cint, Ptr{Ptr{rs2_error}}), device, calibration, calibration_size, error)
end

function rs2_serialize_json(dev, error)
    ccall((:rs2_serialize_json, librealsense2), Ptr{rs2_raw_data_buffer}, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), dev, error)
end

function rs2_load_json(dev, json_content, content_size, error)
    ccall((:rs2_load_json, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Cvoid}, Cuint, Ptr{Ptr{rs2_error}}), dev, json_content, content_size, error)
end

@cenum rs2_timestamp_domain::UInt32 begin
    RS2_TIMESTAMP_DOMAIN_HARDWARE_CLOCK = 0
    RS2_TIMESTAMP_DOMAIN_SYSTEM_TIME = 1
    RS2_TIMESTAMP_DOMAIN_GLOBAL_TIME = 2
    RS2_TIMESTAMP_DOMAIN_COUNT = 3
end

function rs2_timestamp_domain_to_string(info)
    ccall((:rs2_timestamp_domain_to_string, librealsense2), Ptr{Cchar}, (rs2_timestamp_domain,), info)
end

@cenum rs2_frame_metadata_value::UInt32 begin
    RS2_FRAME_METADATA_FRAME_COUNTER = 0
    RS2_FRAME_METADATA_FRAME_TIMESTAMP = 1
    RS2_FRAME_METADATA_SENSOR_TIMESTAMP = 2
    RS2_FRAME_METADATA_ACTUAL_EXPOSURE = 3
    RS2_FRAME_METADATA_GAIN_LEVEL = 4
    RS2_FRAME_METADATA_AUTO_EXPOSURE = 5
    RS2_FRAME_METADATA_WHITE_BALANCE = 6
    RS2_FRAME_METADATA_TIME_OF_ARRIVAL = 7
    RS2_FRAME_METADATA_TEMPERATURE = 8
    RS2_FRAME_METADATA_BACKEND_TIMESTAMP = 9
    RS2_FRAME_METADATA_ACTUAL_FPS = 10
    RS2_FRAME_METADATA_FRAME_LASER_POWER = 11
    RS2_FRAME_METADATA_FRAME_LASER_POWER_MODE = 12
    RS2_FRAME_METADATA_EXPOSURE_PRIORITY = 13
    RS2_FRAME_METADATA_EXPOSURE_ROI_LEFT = 14
    RS2_FRAME_METADATA_EXPOSURE_ROI_RIGHT = 15
    RS2_FRAME_METADATA_EXPOSURE_ROI_TOP = 16
    RS2_FRAME_METADATA_EXPOSURE_ROI_BOTTOM = 17
    RS2_FRAME_METADATA_BRIGHTNESS = 18
    RS2_FRAME_METADATA_CONTRAST = 19
    RS2_FRAME_METADATA_SATURATION = 20
    RS2_FRAME_METADATA_SHARPNESS = 21
    RS2_FRAME_METADATA_AUTO_WHITE_BALANCE_TEMPERATURE = 22
    RS2_FRAME_METADATA_BACKLIGHT_COMPENSATION = 23
    RS2_FRAME_METADATA_HUE = 24
    RS2_FRAME_METADATA_GAMMA = 25
    RS2_FRAME_METADATA_MANUAL_WHITE_BALANCE = 26
    RS2_FRAME_METADATA_POWER_LINE_FREQUENCY = 27
    RS2_FRAME_METADATA_LOW_LIGHT_COMPENSATION = 28
    RS2_FRAME_METADATA_FRAME_EMITTER_MODE = 29
    RS2_FRAME_METADATA_FRAME_LED_POWER = 30
    RS2_FRAME_METADATA_RAW_FRAME_SIZE = 31
    RS2_FRAME_METADATA_GPIO_INPUT_DATA = 32
    RS2_FRAME_METADATA_SEQUENCE_NAME = 33
    RS2_FRAME_METADATA_SEQUENCE_ID = 34
    RS2_FRAME_METADATA_SEQUENCE_SIZE = 35
    RS2_FRAME_METADATA_COUNT = 36
end

function rs2_frame_metadata_to_string(metadata)
    ccall((:rs2_frame_metadata_to_string, librealsense2), Ptr{Cchar}, (rs2_frame_metadata_value,), metadata)
end

function rs2_frame_metadata_value_to_string(metadata)
    ccall((:rs2_frame_metadata_value_to_string, librealsense2), Ptr{Cchar}, (rs2_frame_metadata_value,), metadata)
end

const rs2_metadata_type = Clonglong

function rs2_get_frame_metadata(frame, frame_metadata, error)
    ccall((:rs2_get_frame_metadata, librealsense2), rs2_metadata_type, (Ptr{rs2_frame}, rs2_frame_metadata_value, Ptr{Ptr{rs2_error}}), frame, frame_metadata, error)
end

function rs2_supports_frame_metadata(frame, frame_metadata, error)
    ccall((:rs2_supports_frame_metadata, librealsense2), Cint, (Ptr{rs2_frame}, rs2_frame_metadata_value, Ptr{Ptr{rs2_error}}), frame, frame_metadata, error)
end

function rs2_get_frame_timestamp_domain(frameset, error)
    ccall((:rs2_get_frame_timestamp_domain, librealsense2), rs2_timestamp_domain, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frameset, error)
end

function rs2_get_frame_timestamp(frame, error)
    ccall((:rs2_get_frame_timestamp, librealsense2), rs2_time_t, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

mutable struct rs2_sensor end

function rs2_get_frame_sensor(frame, error)
    ccall((:rs2_get_frame_sensor, librealsense2), Ptr{rs2_sensor}, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_get_frame_number(frame, error)
    ccall((:rs2_get_frame_number, librealsense2), Culonglong, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_get_frame_data_size(frame, error)
    ccall((:rs2_get_frame_data_size, librealsense2), Cint, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_get_frame_data(frame, error)
    ccall((:rs2_get_frame_data, librealsense2), Ptr{Cvoid}, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_get_frame_width(frame, error)
    ccall((:rs2_get_frame_width, librealsense2), Cint, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_get_frame_height(frame, error)
    ccall((:rs2_get_frame_height, librealsense2), Cint, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_depth_frame_get_units(frame, error)
    ccall((:rs2_depth_frame_get_units, librealsense2), Cfloat, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_get_frame_stride_in_bytes(frame, error)
    ccall((:rs2_get_frame_stride_in_bytes, librealsense2), Cint, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_get_frame_bits_per_pixel(frame, error)
    ccall((:rs2_get_frame_bits_per_pixel, librealsense2), Cint, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_frame_add_ref(frame, error)
    ccall((:rs2_frame_add_ref, librealsense2), Cvoid, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_release_frame(frame)
    ccall((:rs2_release_frame, librealsense2), Cvoid, (Ptr{rs2_frame},), frame)
end

function rs2_keep_frame(frame)
    ccall((:rs2_keep_frame, librealsense2), Cvoid, (Ptr{rs2_frame},), frame)
end

struct rs2_vertex
    xyz::NTuple{3, Cfloat}
end

function rs2_get_frame_vertices(frame, error)
    ccall((:rs2_get_frame_vertices, librealsense2), Ptr{rs2_vertex}, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_export_to_ply(frame, fname, texture, error)
    ccall((:rs2_export_to_ply, librealsense2), Cvoid, (Ptr{rs2_frame}, Ptr{Cchar}, Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, fname, texture, error)
end

struct rs2_pixel
    ij::NTuple{2, Cint}
end

function rs2_get_frame_texture_coordinates(frame, error)
    ccall((:rs2_get_frame_texture_coordinates, librealsense2), Ptr{rs2_pixel}, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_get_frame_points_count(frame, error)
    ccall((:rs2_get_frame_points_count, librealsense2), Cint, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

mutable struct rs2_stream_profile end

function rs2_get_frame_stream_profile(frame, error)
    ccall((:rs2_get_frame_stream_profile, librealsense2), Ptr{rs2_stream_profile}, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_is_frame_extendable_to(frame, extension_type, error)
    ccall((:rs2_is_frame_extendable_to, librealsense2), Cint, (Ptr{rs2_frame}, rs2_extension, Ptr{Ptr{rs2_error}}), frame, extension_type, error)
end

mutable struct rs2_source end

function rs2_allocate_synthetic_video_frame(source, new_stream, original, new_bpp, new_width, new_height, new_stride, frame_type, error)
    ccall((:rs2_allocate_synthetic_video_frame, librealsense2), Ptr{rs2_frame}, (Ptr{rs2_source}, Ptr{rs2_stream_profile}, Ptr{rs2_frame}, Cint, Cint, Cint, Cint, rs2_extension, Ptr{Ptr{rs2_error}}), source, new_stream, original, new_bpp, new_width, new_height, new_stride, frame_type, error)
end

function rs2_allocate_synthetic_motion_frame(source, new_stream, original, frame_type, error)
    ccall((:rs2_allocate_synthetic_motion_frame, librealsense2), Ptr{rs2_frame}, (Ptr{rs2_source}, Ptr{rs2_stream_profile}, Ptr{rs2_frame}, rs2_extension, Ptr{Ptr{rs2_error}}), source, new_stream, original, frame_type, error)
end

function rs2_allocate_points(source, new_stream, original, error)
    ccall((:rs2_allocate_points, librealsense2), Ptr{rs2_frame}, (Ptr{rs2_source}, Ptr{rs2_stream_profile}, Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), source, new_stream, original, error)
end

function rs2_allocate_composite_frame(source, frames, count, error)
    ccall((:rs2_allocate_composite_frame, librealsense2), Ptr{rs2_frame}, (Ptr{rs2_source}, Ptr{Ptr{rs2_frame}}, Cint, Ptr{Ptr{rs2_error}}), source, frames, count, error)
end

function rs2_extract_frame(composite, index, error)
    ccall((:rs2_extract_frame, librealsense2), Ptr{rs2_frame}, (Ptr{rs2_frame}, Cint, Ptr{Ptr{rs2_error}}), composite, index, error)
end

function rs2_embedded_frames_count(composite, error)
    ccall((:rs2_embedded_frames_count, librealsense2), Cint, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), composite, error)
end

function rs2_synthetic_frame_ready(source, frame, error)
    ccall((:rs2_synthetic_frame_ready, librealsense2), Cvoid, (Ptr{rs2_source}, Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), source, frame, error)
end

struct rs2_vector
    x::Cfloat
    y::Cfloat
    z::Cfloat
end

struct rs2_quaternion
    x::Cfloat
    y::Cfloat
    z::Cfloat
    w::Cfloat
end

struct rs2_pose
    translation::rs2_vector
    velocity::rs2_vector
    acceleration::rs2_vector
    rotation::rs2_quaternion
    angular_velocity::rs2_vector
    angular_acceleration::rs2_vector
    tracker_confidence::Cuint
    mapper_confidence::Cuint
end

function rs2_pose_frame_get_pose_data(frame, pose, error)
    ccall((:rs2_pose_frame_get_pose_data, librealsense2), Cvoid, (Ptr{rs2_frame}, Ptr{rs2_pose}, Ptr{Ptr{rs2_error}}), frame, pose, error)
end

@cenum rs2_recording_mode::UInt32 begin
    RS2_RECORDING_MODE_BLANK_FRAMES = 0
    RS2_RECORDING_MODE_COMPRESSED = 1
    RS2_RECORDING_MODE_BEST_QUALITY = 2
    RS2_RECORDING_MODE_COUNT = 3
end

struct rs2_video_stream
    type::rs2_stream
    index::Cint
    uid::Cint
    width::Cint
    height::Cint
    fps::Cint
    bpp::Cint
    fmt::rs2_format
    intrinsics::rs2_intrinsics
end

struct rs2_motion_device_intrinsic
    data::NTuple{3, NTuple{4, Cfloat}}
    noise_variances::NTuple{3, Cfloat}
    bias_variances::NTuple{3, Cfloat}
end

struct rs2_motion_stream
    type::rs2_stream
    index::Cint
    uid::Cint
    fps::Cint
    fmt::rs2_format
    intrinsics::rs2_motion_device_intrinsic
end

struct rs2_pose_stream
    type::rs2_stream
    index::Cint
    uid::Cint
    fps::Cint
    fmt::rs2_format
end

struct rs2_software_video_frame
    pixels::Ptr{Cvoid}
    deleter::Ptr{Cvoid}
    stride::Cint
    bpp::Cint
    timestamp::rs2_time_t
    domain::rs2_timestamp_domain
    frame_number::Cint
    profile::Ptr{rs2_stream_profile}
end

struct rs2_software_motion_frame
    data::Ptr{Cvoid}
    deleter::Ptr{Cvoid}
    timestamp::rs2_time_t
    domain::rs2_timestamp_domain
    frame_number::Cint
    profile::Ptr{rs2_stream_profile}
end

struct rs2_software_pose_frame
    data::Ptr{Cvoid}
    deleter::Ptr{Cvoid}
    timestamp::rs2_time_t
    domain::rs2_timestamp_domain
    frame_number::Cint
    profile::Ptr{rs2_stream_profile}
end

@cenum rs2_notification_category::UInt32 begin
    RS2_NOTIFICATION_CATEGORY_FRAMES_TIMEOUT = 0
    RS2_NOTIFICATION_CATEGORY_FRAME_CORRUPTED = 1
    RS2_NOTIFICATION_CATEGORY_HARDWARE_ERROR = 2
    RS2_NOTIFICATION_CATEGORY_HARDWARE_EVENT = 3
    RS2_NOTIFICATION_CATEGORY_UNKNOWN_ERROR = 4
    RS2_NOTIFICATION_CATEGORY_FIRMWARE_UPDATE_RECOMMENDED = 5
    RS2_NOTIFICATION_CATEGORY_POSE_RELOCALIZATION = 6
    RS2_NOTIFICATION_CATEGORY_COUNT = 7
end

struct rs2_software_notification
    category::rs2_notification_category
    type::Cint
    severity::rs2_log_severity
    description::Ptr{Cchar}
    serialized_data::Ptr{Cchar}
end

mutable struct rs2_software_device_destruction_callback end

function rs2_create_recording_context(api_version, filename, section, mode, error)
    ccall((:rs2_create_recording_context, librealsense2), Ptr{rs2_context}, (Cint, Ptr{Cchar}, Ptr{Cchar}, rs2_recording_mode, Ptr{Ptr{rs2_error}}), api_version, filename, section, mode, error)
end

function rs2_create_mock_context(api_version, filename, section, error)
    ccall((:rs2_create_mock_context, librealsense2), Ptr{rs2_context}, (Cint, Ptr{Cchar}, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), api_version, filename, section, error)
end

function rs2_create_mock_context_versioned(api_version, filename, section, min_api_version, error)
    ccall((:rs2_create_mock_context_versioned, librealsense2), Ptr{rs2_context}, (Cint, Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), api_version, filename, section, min_api_version, error)
end

function rs2_create_software_device(error)
    ccall((:rs2_create_software_device, librealsense2), Ptr{rs2_device}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_software_device_add_sensor(dev, sensor_name, error)
    ccall((:rs2_software_device_add_sensor, librealsense2), Ptr{rs2_sensor}, (Ptr{rs2_device}, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), dev, sensor_name, error)
end

function rs2_software_sensor_on_video_frame(sensor, frame, error)
    ccall((:rs2_software_sensor_on_video_frame, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_software_video_frame, Ptr{Ptr{rs2_error}}), sensor, frame, error)
end

function rs2_software_sensor_on_motion_frame(sensor, frame, error)
    ccall((:rs2_software_sensor_on_motion_frame, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_software_motion_frame, Ptr{Ptr{rs2_error}}), sensor, frame, error)
end

function rs2_software_sensor_on_pose_frame(sensor, frame, error)
    ccall((:rs2_software_sensor_on_pose_frame, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_software_pose_frame, Ptr{Ptr{rs2_error}}), sensor, frame, error)
end

function rs2_software_sensor_on_notification(sensor, notif, error)
    ccall((:rs2_software_sensor_on_notification, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_software_notification, Ptr{Ptr{rs2_error}}), sensor, notif, error)
end

function rs2_software_sensor_set_metadata(sensor, value, type, error)
    ccall((:rs2_software_sensor_set_metadata, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_frame_metadata_value, rs2_metadata_type, Ptr{Ptr{rs2_error}}), sensor, value, type, error)
end

# typedef void ( * rs2_software_device_destruction_callback_ptr ) ( void * )
const rs2_software_device_destruction_callback_ptr = Ptr{Cvoid}

function rs2_software_device_set_destruction_callback(dev, on_notification, user, error)
    ccall((:rs2_software_device_set_destruction_callback, librealsense2), Cvoid, (Ptr{rs2_device}, rs2_software_device_destruction_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), dev, on_notification, user, error)
end

function rs2_software_device_set_destruction_callback_cpp(dev, callback, error)
    ccall((:rs2_software_device_set_destruction_callback_cpp, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{rs2_software_device_destruction_callback}, Ptr{Ptr{rs2_error}}), dev, callback, error)
end

@cenum rs2_matchers::UInt32 begin
    RS2_MATCHER_DI = 0
    RS2_MATCHER_DI_C = 1
    RS2_MATCHER_DLR_C = 2
    RS2_MATCHER_DLR = 3
    RS2_MATCHER_DIC = 4
    RS2_MATCHER_DIC_C = 5
    RS2_MATCHER_DEFAULT = 6
    RS2_MATCHER_COUNT = 7
end

function rs2_software_device_create_matcher(dev, matcher, error)
    ccall((:rs2_software_device_create_matcher, librealsense2), Cvoid, (Ptr{rs2_device}, rs2_matchers, Ptr{Ptr{rs2_error}}), dev, matcher, error)
end

function rs2_software_device_register_info(dev, info, val, error)
    ccall((:rs2_software_device_register_info, librealsense2), Cvoid, (Ptr{rs2_device}, rs2_camera_info, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), dev, info, val, error)
end

function rs2_software_device_update_info(dev, info, val, error)
    ccall((:rs2_software_device_update_info, librealsense2), Cvoid, (Ptr{rs2_device}, rs2_camera_info, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), dev, info, val, error)
end

function rs2_software_sensor_add_video_stream(sensor, video_stream, error)
    ccall((:rs2_software_sensor_add_video_stream, librealsense2), Ptr{rs2_stream_profile}, (Ptr{rs2_sensor}, rs2_video_stream, Ptr{Ptr{rs2_error}}), sensor, video_stream, error)
end

function rs2_software_sensor_add_video_stream_ex(sensor, video_stream, is_default, error)
    ccall((:rs2_software_sensor_add_video_stream_ex, librealsense2), Ptr{rs2_stream_profile}, (Ptr{rs2_sensor}, rs2_video_stream, Cint, Ptr{Ptr{rs2_error}}), sensor, video_stream, is_default, error)
end

function rs2_software_sensor_add_motion_stream(sensor, motion_stream, error)
    ccall((:rs2_software_sensor_add_motion_stream, librealsense2), Ptr{rs2_stream_profile}, (Ptr{rs2_sensor}, rs2_motion_stream, Ptr{Ptr{rs2_error}}), sensor, motion_stream, error)
end

function rs2_software_sensor_add_motion_stream_ex(sensor, motion_stream, is_default, error)
    ccall((:rs2_software_sensor_add_motion_stream_ex, librealsense2), Ptr{rs2_stream_profile}, (Ptr{rs2_sensor}, rs2_motion_stream, Cint, Ptr{Ptr{rs2_error}}), sensor, motion_stream, is_default, error)
end

function rs2_software_sensor_add_pose_stream(sensor, pose_stream, error)
    ccall((:rs2_software_sensor_add_pose_stream, librealsense2), Ptr{rs2_stream_profile}, (Ptr{rs2_sensor}, rs2_pose_stream, Ptr{Ptr{rs2_error}}), sensor, pose_stream, error)
end

function rs2_software_sensor_add_pose_stream_ex(sensor, pose_stream, is_default, error)
    ccall((:rs2_software_sensor_add_pose_stream_ex, librealsense2), Ptr{rs2_stream_profile}, (Ptr{rs2_sensor}, rs2_pose_stream, Cint, Ptr{Ptr{rs2_error}}), sensor, pose_stream, is_default, error)
end

@cenum rs2_option::UInt32 begin
    RS2_OPTION_BACKLIGHT_COMPENSATION = 0
    RS2_OPTION_BRIGHTNESS = 1
    RS2_OPTION_CONTRAST = 2
    RS2_OPTION_EXPOSURE = 3
    RS2_OPTION_GAIN = 4
    RS2_OPTION_GAMMA = 5
    RS2_OPTION_HUE = 6
    RS2_OPTION_SATURATION = 7
    RS2_OPTION_SHARPNESS = 8
    RS2_OPTION_WHITE_BALANCE = 9
    RS2_OPTION_ENABLE_AUTO_EXPOSURE = 10
    RS2_OPTION_ENABLE_AUTO_WHITE_BALANCE = 11
    RS2_OPTION_VISUAL_PRESET = 12
    RS2_OPTION_LASER_POWER = 13
    RS2_OPTION_ACCURACY = 14
    RS2_OPTION_MOTION_RANGE = 15
    RS2_OPTION_FILTER_OPTION = 16
    RS2_OPTION_CONFIDENCE_THRESHOLD = 17
    RS2_OPTION_EMITTER_ENABLED = 18
    RS2_OPTION_FRAMES_QUEUE_SIZE = 19
    RS2_OPTION_TOTAL_FRAME_DROPS = 20
    RS2_OPTION_AUTO_EXPOSURE_MODE = 21
    RS2_OPTION_POWER_LINE_FREQUENCY = 22
    RS2_OPTION_ASIC_TEMPERATURE = 23
    RS2_OPTION_ERROR_POLLING_ENABLED = 24
    RS2_OPTION_PROJECTOR_TEMPERATURE = 25
    RS2_OPTION_OUTPUT_TRIGGER_ENABLED = 26
    RS2_OPTION_MOTION_MODULE_TEMPERATURE = 27
    RS2_OPTION_DEPTH_UNITS = 28
    RS2_OPTION_ENABLE_MOTION_CORRECTION = 29
    RS2_OPTION_AUTO_EXPOSURE_PRIORITY = 30
    RS2_OPTION_COLOR_SCHEME = 31
    RS2_OPTION_HISTOGRAM_EQUALIZATION_ENABLED = 32
    RS2_OPTION_MIN_DISTANCE = 33
    RS2_OPTION_MAX_DISTANCE = 34
    RS2_OPTION_TEXTURE_SOURCE = 35
    RS2_OPTION_FILTER_MAGNITUDE = 36
    RS2_OPTION_FILTER_SMOOTH_ALPHA = 37
    RS2_OPTION_FILTER_SMOOTH_DELTA = 38
    RS2_OPTION_HOLES_FILL = 39
    RS2_OPTION_STEREO_BASELINE = 40
    RS2_OPTION_AUTO_EXPOSURE_CONVERGE_STEP = 41
    RS2_OPTION_INTER_CAM_SYNC_MODE = 42
    RS2_OPTION_STREAM_FILTER = 43
    RS2_OPTION_STREAM_FORMAT_FILTER = 44
    RS2_OPTION_STREAM_INDEX_FILTER = 45
    RS2_OPTION_EMITTER_ON_OFF = 46
    RS2_OPTION_ZERO_ORDER_POINT_X = 47
    RS2_OPTION_ZERO_ORDER_POINT_Y = 48
    RS2_OPTION_LLD_TEMPERATURE = 49
    RS2_OPTION_MC_TEMPERATURE = 50
    RS2_OPTION_MA_TEMPERATURE = 51
    RS2_OPTION_HARDWARE_PRESET = 52
    RS2_OPTION_GLOBAL_TIME_ENABLED = 53
    RS2_OPTION_APD_TEMPERATURE = 54
    RS2_OPTION_ENABLE_MAPPING = 55
    RS2_OPTION_ENABLE_RELOCALIZATION = 56
    RS2_OPTION_ENABLE_POSE_JUMPING = 57
    RS2_OPTION_ENABLE_DYNAMIC_CALIBRATION = 58
    RS2_OPTION_DEPTH_OFFSET = 59
    RS2_OPTION_LED_POWER = 60
    RS2_OPTION_ZERO_ORDER_ENABLED = 61
    RS2_OPTION_ENABLE_MAP_PRESERVATION = 62
    RS2_OPTION_FREEFALL_DETECTION_ENABLED = 63
    RS2_OPTION_AVALANCHE_PHOTO_DIODE = 64
    RS2_OPTION_POST_PROCESSING_SHARPENING = 65
    RS2_OPTION_PRE_PROCESSING_SHARPENING = 66
    RS2_OPTION_NOISE_FILTERING = 67
    RS2_OPTION_INVALIDATION_BYPASS = 68
    RS2_OPTION_AMBIENT_LIGHT = 69
    RS2_OPTION_DIGITAL_GAIN = 69
    RS2_OPTION_SENSOR_MODE = 70
    RS2_OPTION_EMITTER_ALWAYS_ON = 71
    RS2_OPTION_THERMAL_COMPENSATION = 72
    RS2_OPTION_TRIGGER_CAMERA_ACCURACY_HEALTH = 73
    RS2_OPTION_RESET_CAMERA_ACCURACY_HEALTH = 74
    RS2_OPTION_HOST_PERFORMANCE = 75
    RS2_OPTION_HDR_ENABLED = 76
    RS2_OPTION_SEQUENCE_NAME = 77
    RS2_OPTION_SEQUENCE_SIZE = 78
    RS2_OPTION_SEQUENCE_ID = 79
    RS2_OPTION_HUMIDITY_TEMPERATURE = 80
    RS2_OPTION_ENABLE_MAX_USABLE_RANGE = 81
    RS2_OPTION_ALTERNATE_IR = 82
    RS2_OPTION_NOISE_ESTIMATION = 83
    RS2_OPTION_ENABLE_IR_REFLECTIVITY = 84
    RS2_OPTION_COUNT = 85
end

function rs2_software_sensor_add_read_only_option(sensor, option, val, error)
    ccall((:rs2_software_sensor_add_read_only_option, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_option, Cfloat, Ptr{Ptr{rs2_error}}), sensor, option, val, error)
end

function rs2_software_sensor_update_read_only_option(sensor, option, val, error)
    ccall((:rs2_software_sensor_update_read_only_option, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_option, Cfloat, Ptr{Ptr{rs2_error}}), sensor, option, val, error)
end

function rs2_software_sensor_add_option(sensor, option, min, max, step, def, is_writable, error)
    ccall((:rs2_software_sensor_add_option, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_option, Cfloat, Cfloat, Cfloat, Cfloat, Cint, Ptr{Ptr{rs2_error}}), sensor, option, min, max, step, def, is_writable, error)
end

function rs2_software_sensor_detach(sensor, error)
    ccall((:rs2_software_sensor_detach, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_error}}), sensor, error)
end

mutable struct rs2_firmware_log_message end

function rs2_create_fw_log_message(dev, error)
    ccall((:rs2_create_fw_log_message, librealsense2), Ptr{rs2_firmware_log_message}, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), dev, error)
end

function rs2_get_fw_log(dev, fw_log_msg, error)
    ccall((:rs2_get_fw_log, librealsense2), Cint, (Ptr{rs2_device}, Ptr{rs2_firmware_log_message}, Ptr{Ptr{rs2_error}}), dev, fw_log_msg, error)
end

function rs2_get_flash_log(dev, fw_log_msg, error)
    ccall((:rs2_get_flash_log, librealsense2), Cint, (Ptr{rs2_device}, Ptr{rs2_firmware_log_message}, Ptr{Ptr{rs2_error}}), dev, fw_log_msg, error)
end

function rs2_delete_fw_log_message(msg)
    ccall((:rs2_delete_fw_log_message, librealsense2), Cvoid, (Ptr{rs2_firmware_log_message},), msg)
end

function rs2_fw_log_message_data(msg, error)
    ccall((:rs2_fw_log_message_data, librealsense2), Ptr{Cuchar}, (Ptr{rs2_firmware_log_message}, Ptr{Ptr{rs2_error}}), msg, error)
end

function rs2_fw_log_message_size(msg, error)
    ccall((:rs2_fw_log_message_size, librealsense2), Cint, (Ptr{rs2_firmware_log_message}, Ptr{Ptr{rs2_error}}), msg, error)
end

function rs2_fw_log_message_timestamp(msg, error)
    ccall((:rs2_fw_log_message_timestamp, librealsense2), Cuint, (Ptr{rs2_firmware_log_message}, Ptr{Ptr{rs2_error}}), msg, error)
end

function rs2_fw_log_message_severity(msg, error)
    ccall((:rs2_fw_log_message_severity, librealsense2), rs2_log_severity, (Ptr{rs2_firmware_log_message}, Ptr{Ptr{rs2_error}}), msg, error)
end

function rs2_init_fw_log_parser(dev, xml_content, error)
    ccall((:rs2_init_fw_log_parser, librealsense2), Cint, (Ptr{rs2_device}, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), dev, xml_content, error)
end

mutable struct rs2_firmware_log_parsed_message end

function rs2_create_fw_log_parsed_message(dev, error)
    ccall((:rs2_create_fw_log_parsed_message, librealsense2), Ptr{rs2_firmware_log_parsed_message}, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), dev, error)
end

function rs2_delete_fw_log_parsed_message(fw_log_parsed_msg)
    ccall((:rs2_delete_fw_log_parsed_message, librealsense2), Cvoid, (Ptr{rs2_firmware_log_parsed_message},), fw_log_parsed_msg)
end

function rs2_parse_firmware_log(dev, fw_log_msg, parsed_msg, error)
    ccall((:rs2_parse_firmware_log, librealsense2), Cint, (Ptr{rs2_device}, Ptr{rs2_firmware_log_message}, Ptr{rs2_firmware_log_parsed_message}, Ptr{Ptr{rs2_error}}), dev, fw_log_msg, parsed_msg, error)
end

function rs2_get_number_of_fw_logs(dev, error)
    ccall((:rs2_get_number_of_fw_logs, librealsense2), Cuint, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), dev, error)
end

function rs2_get_fw_log_parsed_message(fw_log_parsed_msg, error)
    ccall((:rs2_get_fw_log_parsed_message, librealsense2), Ptr{Cchar}, (Ptr{rs2_firmware_log_parsed_message}, Ptr{Ptr{rs2_error}}), fw_log_parsed_msg, error)
end

function rs2_get_fw_log_parsed_file_name(fw_log_parsed_msg, error)
    ccall((:rs2_get_fw_log_parsed_file_name, librealsense2), Ptr{Cchar}, (Ptr{rs2_firmware_log_parsed_message}, Ptr{Ptr{rs2_error}}), fw_log_parsed_msg, error)
end

function rs2_get_fw_log_parsed_thread_name(fw_log_parsed_msg, error)
    ccall((:rs2_get_fw_log_parsed_thread_name, librealsense2), Ptr{Cchar}, (Ptr{rs2_firmware_log_parsed_message}, Ptr{Ptr{rs2_error}}), fw_log_parsed_msg, error)
end

function rs2_get_fw_log_parsed_severity(fw_log_parsed_msg, error)
    ccall((:rs2_get_fw_log_parsed_severity, librealsense2), rs2_log_severity, (Ptr{rs2_firmware_log_parsed_message}, Ptr{Ptr{rs2_error}}), fw_log_parsed_msg, error)
end

function rs2_get_fw_log_parsed_line(fw_log_parsed_msg, error)
    ccall((:rs2_get_fw_log_parsed_line, librealsense2), Cuint, (Ptr{rs2_firmware_log_parsed_message}, Ptr{Ptr{rs2_error}}), fw_log_parsed_msg, error)
end

function rs2_get_fw_log_parsed_timestamp(fw_log_parsed_msg, error)
    ccall((:rs2_get_fw_log_parsed_timestamp, librealsense2), Cuint, (Ptr{rs2_firmware_log_parsed_message}, Ptr{Ptr{rs2_error}}), fw_log_parsed_msg, error)
end

function rs2_get_fw_log_parsed_sequence_id(fw_log_parsed_msg, error)
    ccall((:rs2_get_fw_log_parsed_sequence_id, librealsense2), Cuint, (Ptr{rs2_firmware_log_parsed_message}, Ptr{Ptr{rs2_error}}), fw_log_parsed_msg, error)
end

mutable struct rs2_terminal_parser end

function rs2_create_terminal_parser(xml_content, error)
    ccall((:rs2_create_terminal_parser, librealsense2), Ptr{rs2_terminal_parser}, (Ptr{Cchar}, Ptr{Ptr{rs2_error}}), xml_content, error)
end

function rs2_delete_terminal_parser(terminal_parser)
    ccall((:rs2_delete_terminal_parser, librealsense2), Cvoid, (Ptr{rs2_terminal_parser},), terminal_parser)
end

function rs2_terminal_parse_command(terminal_parser, command, size_of_command, error)
    ccall((:rs2_terminal_parse_command, librealsense2), Ptr{rs2_raw_data_buffer}, (Ptr{rs2_terminal_parser}, Ptr{Cchar}, Cuint, Ptr{Ptr{rs2_error}}), terminal_parser, command, size_of_command, error)
end

function rs2_terminal_parse_response(terminal_parser, command, size_of_command, response, size_of_response, error)
    ccall((:rs2_terminal_parse_response, librealsense2), Ptr{rs2_raw_data_buffer}, (Ptr{rs2_terminal_parser}, Ptr{Cchar}, Cuint, Ptr{Cvoid}, Cuint, Ptr{Ptr{rs2_error}}), terminal_parser, command, size_of_command, response, size_of_response, error)
end

function rs2_option_to_string(option)
    ccall((:rs2_option_to_string, librealsense2), Ptr{Cchar}, (rs2_option,), option)
end

@cenum rs2_sr300_visual_preset::UInt32 begin
    RS2_SR300_VISUAL_PRESET_SHORT_RANGE = 0
    RS2_SR300_VISUAL_PRESET_LONG_RANGE = 1
    RS2_SR300_VISUAL_PRESET_BACKGROUND_SEGMENTATION = 2
    RS2_SR300_VISUAL_PRESET_GESTURE_RECOGNITION = 3
    RS2_SR300_VISUAL_PRESET_OBJECT_SCANNING = 4
    RS2_SR300_VISUAL_PRESET_FACE_ANALYTICS = 5
    RS2_SR300_VISUAL_PRESET_FACE_LOGIN = 6
    RS2_SR300_VISUAL_PRESET_GR_CURSOR = 7
    RS2_SR300_VISUAL_PRESET_DEFAULT = 8
    RS2_SR300_VISUAL_PRESET_MID_RANGE = 9
    RS2_SR300_VISUAL_PRESET_IR_ONLY = 10
    RS2_SR300_VISUAL_PRESET_COUNT = 11
end

function rs2_sr300_visual_preset_to_string(preset)
    ccall((:rs2_sr300_visual_preset_to_string, librealsense2), Ptr{Cchar}, (rs2_sr300_visual_preset,), preset)
end

@cenum rs2_rs400_visual_preset::UInt32 begin
    RS2_RS400_VISUAL_PRESET_CUSTOM = 0
    RS2_RS400_VISUAL_PRESET_DEFAULT = 1
    RS2_RS400_VISUAL_PRESET_HAND = 2
    RS2_RS400_VISUAL_PRESET_HIGH_ACCURACY = 3
    RS2_RS400_VISUAL_PRESET_HIGH_DENSITY = 4
    RS2_RS400_VISUAL_PRESET_MEDIUM_DENSITY = 5
    RS2_RS400_VISUAL_PRESET_REMOVE_IR_PATTERN = 6
    RS2_RS400_VISUAL_PRESET_COUNT = 7
end

function rs2_rs400_visual_preset_to_string(preset)
    ccall((:rs2_rs400_visual_preset_to_string, librealsense2), Ptr{Cchar}, (rs2_rs400_visual_preset,), preset)
end

@cenum rs2_l500_visual_preset::UInt32 begin
    RS2_L500_VISUAL_PRESET_CUSTOM = 0
    RS2_L500_VISUAL_PRESET_DEFAULT = 1
    RS2_L500_VISUAL_PRESET_NO_AMBIENT = 2
    RS2_L500_VISUAL_PRESET_LOW_AMBIENT = 3
    RS2_L500_VISUAL_PRESET_MAX_RANGE = 4
    RS2_L500_VISUAL_PRESET_SHORT_RANGE = 5
    RS2_L500_VISUAL_PRESET_COUNT = 6
end

function rs2_l500_visual_preset_to_string(preset)
    ccall((:rs2_l500_visual_preset_to_string, librealsense2), Ptr{Cchar}, (rs2_l500_visual_preset,), preset)
end

@cenum rs2_sensor_mode::UInt32 begin
    RS2_SENSOR_MODE_VGA = 0
    RS2_SENSOR_MODE_XGA = 1
    RS2_SENSOR_MODE_QVGA = 2
    RS2_SENSOR_MODE_COUNT = 3
end

function rs2_sensor_mode_to_string(preset)
    ccall((:rs2_sensor_mode_to_string, librealsense2), Ptr{Cchar}, (rs2_sensor_mode,), preset)
end

@cenum rs2_ambient_light::UInt32 begin
    RS2_AMBIENT_LIGHT_NO_AMBIENT = 1
    RS2_AMBIENT_LIGHT_LOW_AMBIENT = 2
end

function rs2_ambient_light_to_string(preset)
    ccall((:rs2_ambient_light_to_string, librealsense2), Ptr{Cchar}, (rs2_ambient_light,), preset)
end

@cenum rs2_digital_gain::UInt32 begin
    RS2_DIGITAL_GAIN_HIGH = 1
    RS2_DIGITAL_GAIN_LOW = 2
end

function rs2_digital_gain_to_string(preset)
    ccall((:rs2_digital_gain_to_string, librealsense2), Ptr{Cchar}, (rs2_digital_gain,), preset)
end

@cenum rs2_cah_trigger::UInt32 begin
    RS2_CAH_TRIGGER_MANUAL = 0
    RS2_CAH_TRIGGER_NOW = 1
    RS2_CAH_TRIGGER_AUTO = 2
    RS2_CAH_TRIGGER_COUNT = 3
end

function rs2_cah_trigger_to_string(preset)
    ccall((:rs2_cah_trigger_to_string, librealsense2), Ptr{Cchar}, (rs2_cah_trigger,), preset)
end

@cenum rs2_host_perf_mode::UInt32 begin
    RS2_HOST_PERF_DEFAULT = 0
    RS2_HOST_PERF_LOW = 1
    RS2_HOST_PERF_HIGH = 2
    RS2_HOST_PERF_COUNT = 3
end

function rs2_host_perf_mode_to_string(perf)
    ccall((:rs2_host_perf_mode_to_string, librealsense2), Ptr{Cchar}, (rs2_host_perf_mode,), perf)
end

mutable struct rs2_options end

function rs2_is_option_read_only(options, option, error)
    ccall((:rs2_is_option_read_only, librealsense2), Cint, (Ptr{rs2_options}, rs2_option, Ptr{Ptr{rs2_error}}), options, option, error)
end

function rs2_get_option(options, option, error)
    ccall((:rs2_get_option, librealsense2), Cfloat, (Ptr{rs2_options}, rs2_option, Ptr{Ptr{rs2_error}}), options, option, error)
end

function rs2_set_option(options, option, value, error)
    ccall((:rs2_set_option, librealsense2), Cvoid, (Ptr{rs2_options}, rs2_option, Cfloat, Ptr{Ptr{rs2_error}}), options, option, value, error)
end

mutable struct rs2_options_list end

function rs2_get_options_list(options, error)
    ccall((:rs2_get_options_list, librealsense2), Ptr{rs2_options_list}, (Ptr{rs2_options}, Ptr{Ptr{rs2_error}}), options, error)
end

function rs2_get_options_list_size(options, error)
    ccall((:rs2_get_options_list_size, librealsense2), Cint, (Ptr{rs2_options_list}, Ptr{Ptr{rs2_error}}), options, error)
end

function rs2_get_option_name(options, option, error)
    ccall((:rs2_get_option_name, librealsense2), Ptr{Cchar}, (Ptr{rs2_options}, rs2_option, Ptr{Ptr{rs2_error}}), options, option, error)
end

function rs2_get_option_from_list(options, i, error)
    ccall((:rs2_get_option_from_list, librealsense2), rs2_option, (Ptr{rs2_options_list}, Cint, Ptr{Ptr{rs2_error}}), options, i, error)
end

function rs2_delete_options_list(list)
    ccall((:rs2_delete_options_list, librealsense2), Cvoid, (Ptr{rs2_options_list},), list)
end

function rs2_supports_option(options, option, error)
    ccall((:rs2_supports_option, librealsense2), Cint, (Ptr{rs2_options}, rs2_option, Ptr{Ptr{rs2_error}}), options, option, error)
end

function rs2_get_option_range(sensor, option, min, max, step, def, error)
    ccall((:rs2_get_option_range, librealsense2), Cvoid, (Ptr{rs2_options}, rs2_option, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Ptr{rs2_error}}), sensor, option, min, max, step, def, error)
end

function rs2_get_option_description(options, option, error)
    ccall((:rs2_get_option_description, librealsense2), Ptr{Cchar}, (Ptr{rs2_options}, rs2_option, Ptr{Ptr{rs2_error}}), options, option, error)
end

function rs2_get_option_value_description(options, option, value, error)
    ccall((:rs2_get_option_value_description, librealsense2), Ptr{Cchar}, (Ptr{rs2_options}, rs2_option, Cfloat, Ptr{Ptr{rs2_error}}), options, option, value, error)
end

function rs2_create_pipeline(ctx, error)
    ccall((:rs2_create_pipeline, librealsense2), Ptr{rs2_pipeline}, (Ptr{rs2_context}, Ptr{Ptr{rs2_error}}), ctx, error)
end

function rs2_pipeline_stop(pipe, error)
    ccall((:rs2_pipeline_stop, librealsense2), Cvoid, (Ptr{rs2_pipeline}, Ptr{Ptr{rs2_error}}), pipe, error)
end

function rs2_pipeline_wait_for_frames(pipe, timeout_ms, error)
    ccall((:rs2_pipeline_wait_for_frames, librealsense2), Ptr{rs2_frame}, (Ptr{rs2_pipeline}, Cuint, Ptr{Ptr{rs2_error}}), pipe, timeout_ms, error)
end

function rs2_pipeline_poll_for_frames(pipe, output_frame, error)
    ccall((:rs2_pipeline_poll_for_frames, librealsense2), Cint, (Ptr{rs2_pipeline}, Ptr{Ptr{rs2_frame}}, Ptr{Ptr{rs2_error}}), pipe, output_frame, error)
end

function rs2_pipeline_try_wait_for_frames(pipe, output_frame, timeout_ms, error)
    ccall((:rs2_pipeline_try_wait_for_frames, librealsense2), Cint, (Ptr{rs2_pipeline}, Ptr{Ptr{rs2_frame}}, Cuint, Ptr{Ptr{rs2_error}}), pipe, output_frame, timeout_ms, error)
end

function rs2_delete_pipeline(pipe)
    ccall((:rs2_delete_pipeline, librealsense2), Cvoid, (Ptr{rs2_pipeline},), pipe)
end

function rs2_pipeline_start(pipe, error)
    ccall((:rs2_pipeline_start, librealsense2), Ptr{rs2_pipeline_profile}, (Ptr{rs2_pipeline}, Ptr{Ptr{rs2_error}}), pipe, error)
end

function rs2_pipeline_start_with_config(pipe, config, error)
    ccall((:rs2_pipeline_start_with_config, librealsense2), Ptr{rs2_pipeline_profile}, (Ptr{rs2_pipeline}, Ptr{rs2_config}, Ptr{Ptr{rs2_error}}), pipe, config, error)
end

# typedef void ( * rs2_frame_callback_ptr ) ( rs2_frame * , void * )
const rs2_frame_callback_ptr = Ptr{Cvoid}

function rs2_pipeline_start_with_callback(pipe, on_frame, user, error)
    ccall((:rs2_pipeline_start_with_callback, librealsense2), Ptr{rs2_pipeline_profile}, (Ptr{rs2_pipeline}, rs2_frame_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), pipe, on_frame, user, error)
end

mutable struct rs2_frame_callback end

function rs2_pipeline_start_with_callback_cpp(pipe, callback, error)
    ccall((:rs2_pipeline_start_with_callback_cpp, librealsense2), Ptr{rs2_pipeline_profile}, (Ptr{rs2_pipeline}, Ptr{rs2_frame_callback}, Ptr{Ptr{rs2_error}}), pipe, callback, error)
end

function rs2_pipeline_start_with_config_and_callback(pipe, config, on_frame, user, error)
    ccall((:rs2_pipeline_start_with_config_and_callback, librealsense2), Ptr{rs2_pipeline_profile}, (Ptr{rs2_pipeline}, Ptr{rs2_config}, rs2_frame_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), pipe, config, on_frame, user, error)
end

function rs2_pipeline_start_with_config_and_callback_cpp(pipe, config, callback, error)
    ccall((:rs2_pipeline_start_with_config_and_callback_cpp, librealsense2), Ptr{rs2_pipeline_profile}, (Ptr{rs2_pipeline}, Ptr{rs2_config}, Ptr{rs2_frame_callback}, Ptr{Ptr{rs2_error}}), pipe, config, callback, error)
end

function rs2_pipeline_get_active_profile(pipe, error)
    ccall((:rs2_pipeline_get_active_profile, librealsense2), Ptr{rs2_pipeline_profile}, (Ptr{rs2_pipeline}, Ptr{Ptr{rs2_error}}), pipe, error)
end

function rs2_pipeline_profile_get_device(profile, error)
    ccall((:rs2_pipeline_profile_get_device, librealsense2), Ptr{rs2_device}, (Ptr{rs2_pipeline_profile}, Ptr{Ptr{rs2_error}}), profile, error)
end

mutable struct rs2_stream_profile_list end

function rs2_pipeline_profile_get_streams(profile, error)
    ccall((:rs2_pipeline_profile_get_streams, librealsense2), Ptr{rs2_stream_profile_list}, (Ptr{rs2_pipeline_profile}, Ptr{Ptr{rs2_error}}), profile, error)
end

function rs2_delete_pipeline_profile(profile)
    ccall((:rs2_delete_pipeline_profile, librealsense2), Cvoid, (Ptr{rs2_pipeline_profile},), profile)
end

mutable struct rs2_processing_block end

function rs2_create_colorizer(error)
    ccall((:rs2_create_colorizer, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_sync_processing_block(error)
    ccall((:rs2_create_sync_processing_block, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_pointcloud(error)
    ccall((:rs2_create_pointcloud, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_yuy_decoder(error)
    ccall((:rs2_create_yuy_decoder, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_threshold(error)
    ccall((:rs2_create_threshold, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_units_transform(error)
    ccall((:rs2_create_units_transform, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

mutable struct rs2_frame_processor_callback end

function rs2_create_processing_block(proc, error)
    ccall((:rs2_create_processing_block, librealsense2), Ptr{rs2_processing_block}, (Ptr{rs2_frame_processor_callback}, Ptr{Ptr{rs2_error}}), proc, error)
end

# typedef void ( * rs2_frame_processor_callback_ptr ) ( rs2_frame * , rs2_source * , void * )
const rs2_frame_processor_callback_ptr = Ptr{Cvoid}

function rs2_create_processing_block_fptr(proc, context, error)
    ccall((:rs2_create_processing_block_fptr, librealsense2), Ptr{rs2_processing_block}, (rs2_frame_processor_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), proc, context, error)
end

function rs2_processing_block_register_simple_option(block, option_id, min, max, step, def, error)
    ccall((:rs2_processing_block_register_simple_option, librealsense2), Cint, (Ptr{rs2_processing_block}, rs2_option, Cfloat, Cfloat, Cfloat, Cfloat, Ptr{Ptr{rs2_error}}), block, option_id, min, max, step, def, error)
end

function rs2_start_processing(block, on_frame, error)
    ccall((:rs2_start_processing, librealsense2), Cvoid, (Ptr{rs2_processing_block}, Ptr{rs2_frame_callback}, Ptr{Ptr{rs2_error}}), block, on_frame, error)
end

function rs2_start_processing_fptr(block, on_frame, user, error)
    ccall((:rs2_start_processing_fptr, librealsense2), Cvoid, (Ptr{rs2_processing_block}, rs2_frame_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), block, on_frame, user, error)
end

mutable struct rs2_frame_queue end

function rs2_start_processing_queue(block, queue, error)
    ccall((:rs2_start_processing_queue, librealsense2), Cvoid, (Ptr{rs2_processing_block}, Ptr{rs2_frame_queue}, Ptr{Ptr{rs2_error}}), block, queue, error)
end

function rs2_process_frame(block, frame, error)
    ccall((:rs2_process_frame, librealsense2), Cvoid, (Ptr{rs2_processing_block}, Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), block, frame, error)
end

function rs2_delete_processing_block(block)
    ccall((:rs2_delete_processing_block, librealsense2), Cvoid, (Ptr{rs2_processing_block},), block)
end

function rs2_create_frame_queue(capacity, error)
    ccall((:rs2_create_frame_queue, librealsense2), Ptr{rs2_frame_queue}, (Cint, Ptr{Ptr{rs2_error}}), capacity, error)
end

function rs2_delete_frame_queue(queue)
    ccall((:rs2_delete_frame_queue, librealsense2), Cvoid, (Ptr{rs2_frame_queue},), queue)
end

function rs2_wait_for_frame(queue, timeout_ms, error)
    ccall((:rs2_wait_for_frame, librealsense2), Ptr{rs2_frame}, (Ptr{rs2_frame_queue}, Cuint, Ptr{Ptr{rs2_error}}), queue, timeout_ms, error)
end

function rs2_poll_for_frame(queue, output_frame, error)
    ccall((:rs2_poll_for_frame, librealsense2), Cint, (Ptr{rs2_frame_queue}, Ptr{Ptr{rs2_frame}}, Ptr{Ptr{rs2_error}}), queue, output_frame, error)
end

function rs2_try_wait_for_frame(queue, timeout_ms, output_frame, error)
    ccall((:rs2_try_wait_for_frame, librealsense2), Cint, (Ptr{rs2_frame_queue}, Cuint, Ptr{Ptr{rs2_frame}}, Ptr{Ptr{rs2_error}}), queue, timeout_ms, output_frame, error)
end

function rs2_enqueue_frame(frame, queue)
    ccall((:rs2_enqueue_frame, librealsense2), Cvoid, (Ptr{rs2_frame}, Ptr{Cvoid}), frame, queue)
end

function rs2_create_align(align_to, error)
    ccall((:rs2_create_align, librealsense2), Ptr{rs2_processing_block}, (rs2_stream, Ptr{Ptr{rs2_error}}), align_to, error)
end

function rs2_create_decimation_filter_block(error)
    ccall((:rs2_create_decimation_filter_block, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_temporal_filter_block(error)
    ccall((:rs2_create_temporal_filter_block, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_spatial_filter_block(error)
    ccall((:rs2_create_spatial_filter_block, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_disparity_transform_block(transform_to_disparity, error)
    ccall((:rs2_create_disparity_transform_block, librealsense2), Ptr{rs2_processing_block}, (Cuchar, Ptr{Ptr{rs2_error}}), transform_to_disparity, error)
end

function rs2_create_hole_filling_filter_block(error)
    ccall((:rs2_create_hole_filling_filter_block, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_rates_printer_block(error)
    ccall((:rs2_create_rates_printer_block, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_zero_order_invalidation_block(error)
    ccall((:rs2_create_zero_order_invalidation_block, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_huffman_depth_decompress_block(error)
    ccall((:rs2_create_huffman_depth_decompress_block, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_hdr_merge_processing_block(error)
    ccall((:rs2_create_hdr_merge_processing_block, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_sequence_id_filter(error)
    ccall((:rs2_create_sequence_id_filter, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_get_processing_block_info(block, info, error)
    ccall((:rs2_get_processing_block_info, librealsense2), Ptr{Cchar}, (Ptr{rs2_processing_block}, rs2_camera_info, Ptr{Ptr{rs2_error}}), block, info, error)
end

function rs2_supports_processing_block_info(block, info, error)
    ccall((:rs2_supports_processing_block_info, librealsense2), Cint, (Ptr{rs2_processing_block}, rs2_camera_info, Ptr{Ptr{rs2_error}}), block, info, error)
end

function rs2_is_processing_block_extendable_to(block, extension_type, error)
    ccall((:rs2_is_processing_block_extendable_to, librealsense2), Cint, (Ptr{rs2_processing_block}, rs2_extension, Ptr{Ptr{rs2_error}}), block, extension_type, error)
end

@cenum rs2_playback_status::UInt32 begin
    RS2_PLAYBACK_STATUS_UNKNOWN = 0
    RS2_PLAYBACK_STATUS_PLAYING = 1
    RS2_PLAYBACK_STATUS_PAUSED = 2
    RS2_PLAYBACK_STATUS_STOPPED = 3
    RS2_PLAYBACK_STATUS_COUNT = 4
end

function rs2_playback_status_to_string(status)
    ccall((:rs2_playback_status_to_string, librealsense2), Ptr{Cchar}, (rs2_playback_status,), status)
end

# typedef void ( * rs2_playback_status_changed_callback_ptr ) ( rs2_playback_status )
const rs2_playback_status_changed_callback_ptr = Ptr{Cvoid}

function rs2_create_record_device(device, file, error)
    ccall((:rs2_create_record_device, librealsense2), Ptr{rs2_device}, (Ptr{rs2_device}, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), device, file, error)
end

function rs2_create_record_device_ex(device, file, compression_enabled, error)
    ccall((:rs2_create_record_device_ex, librealsense2), Ptr{rs2_device}, (Ptr{rs2_device}, Ptr{Cchar}, Cint, Ptr{Ptr{rs2_error}}), device, file, compression_enabled, error)
end

function rs2_record_device_pause(device, error)
    ccall((:rs2_record_device_pause, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_record_device_resume(device, error)
    ccall((:rs2_record_device_resume, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_record_device_filename(device, error)
    ccall((:rs2_record_device_filename, librealsense2), Ptr{Cchar}, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_create_playback_device(file, error)
    ccall((:rs2_create_playback_device, librealsense2), Ptr{rs2_device}, (Ptr{Cchar}, Ptr{Ptr{rs2_error}}), file, error)
end

function rs2_playback_device_get_file_path(device, error)
    ccall((:rs2_playback_device_get_file_path, librealsense2), Ptr{Cchar}, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_playback_get_duration(device, error)
    ccall((:rs2_playback_get_duration, librealsense2), Culonglong, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_playback_seek(device, time, error)
    ccall((:rs2_playback_seek, librealsense2), Cvoid, (Ptr{rs2_device}, Clonglong, Ptr{Ptr{rs2_error}}), device, time, error)
end

function rs2_playback_get_position(device, error)
    ccall((:rs2_playback_get_position, librealsense2), Culonglong, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_playback_device_resume(device, error)
    ccall((:rs2_playback_device_resume, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_playback_device_pause(device, error)
    ccall((:rs2_playback_device_pause, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_playback_device_set_real_time(device, real_time, error)
    ccall((:rs2_playback_device_set_real_time, librealsense2), Cvoid, (Ptr{rs2_device}, Cint, Ptr{Ptr{rs2_error}}), device, real_time, error)
end

function rs2_playback_device_is_real_time(device, error)
    ccall((:rs2_playback_device_is_real_time, librealsense2), Cint, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

mutable struct rs2_playback_status_changed_callback end

function rs2_playback_device_set_status_changed_callback(device, callback, error)
    ccall((:rs2_playback_device_set_status_changed_callback, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{rs2_playback_status_changed_callback}, Ptr{Ptr{rs2_error}}), device, callback, error)
end

function rs2_playback_device_get_current_status(device, error)
    ccall((:rs2_playback_device_get_current_status, librealsense2), rs2_playback_status, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_playback_device_set_playback_speed(device, speed, error)
    ccall((:rs2_playback_device_set_playback_speed, librealsense2), Cvoid, (Ptr{rs2_device}, Cfloat, Ptr{Ptr{rs2_error}}), device, speed, error)
end

function rs2_playback_device_stop(device, error)
    ccall((:rs2_playback_device_stop, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_camera_info_to_string(info)
    ccall((:rs2_camera_info_to_string, librealsense2), Ptr{Cchar}, (rs2_camera_info,), info)
end

function rs2_stream_to_string(stream)
    ccall((:rs2_stream_to_string, librealsense2), Ptr{Cchar}, (rs2_stream,), stream)
end

function rs2_format_to_string(format)
    ccall((:rs2_format_to_string, librealsense2), Ptr{Cchar}, (rs2_format,), format)
end

function rs2_delete_sensor_list(info_list)
    ccall((:rs2_delete_sensor_list, librealsense2), Cvoid, (Ptr{rs2_sensor_list},), info_list)
end

function rs2_get_sensors_count(info_list, error)
    ccall((:rs2_get_sensors_count, librealsense2), Cint, (Ptr{rs2_sensor_list}, Ptr{Ptr{rs2_error}}), info_list, error)
end

function rs2_delete_sensor(sensor)
    ccall((:rs2_delete_sensor, librealsense2), Cvoid, (Ptr{rs2_sensor},), sensor)
end

function rs2_create_sensor(list, index, error)
    ccall((:rs2_create_sensor, librealsense2), Ptr{rs2_sensor}, (Ptr{rs2_sensor_list}, Cint, Ptr{Ptr{rs2_error}}), list, index, error)
end

function rs2_create_device_from_sensor(sensor, error)
    ccall((:rs2_create_device_from_sensor, librealsense2), Ptr{rs2_device}, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_error}}), sensor, error)
end

function rs2_get_sensor_info(sensor, info, error)
    ccall((:rs2_get_sensor_info, librealsense2), Ptr{Cchar}, (Ptr{rs2_sensor}, rs2_camera_info, Ptr{Ptr{rs2_error}}), sensor, info, error)
end

function rs2_supports_sensor_info(sensor, info, error)
    ccall((:rs2_supports_sensor_info, librealsense2), Cint, (Ptr{rs2_sensor}, rs2_camera_info, Ptr{Ptr{rs2_error}}), sensor, info, error)
end

function rs2_is_sensor_extendable_to(sensor, extension, error)
    ccall((:rs2_is_sensor_extendable_to, librealsense2), Cint, (Ptr{rs2_sensor}, rs2_extension, Ptr{Ptr{rs2_error}}), sensor, extension, error)
end

function rs2_get_depth_scale(sensor, error)
    ccall((:rs2_get_depth_scale, librealsense2), Cfloat, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_error}}), sensor, error)
end

function rs2_depth_stereo_frame_get_baseline(frame_ref, error)
    ccall((:rs2_depth_stereo_frame_get_baseline, librealsense2), Cfloat, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame_ref, error)
end

function rs2_get_stereo_baseline(sensor, error)
    ccall((:rs2_get_stereo_baseline, librealsense2), Cfloat, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_error}}), sensor, error)
end

function rs2_set_region_of_interest(sensor, min_x, min_y, max_x, max_y, error)
    ccall((:rs2_set_region_of_interest, librealsense2), Cvoid, (Ptr{rs2_sensor}, Cint, Cint, Cint, Cint, Ptr{Ptr{rs2_error}}), sensor, min_x, min_y, max_x, max_y, error)
end

function rs2_get_region_of_interest(sensor, min_x, min_y, max_x, max_y, error)
    ccall((:rs2_get_region_of_interest, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Ptr{rs2_error}}), sensor, min_x, min_y, max_x, max_y, error)
end

function rs2_open(device, profile, error)
    ccall((:rs2_open, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{rs2_stream_profile}, Ptr{Ptr{rs2_error}}), device, profile, error)
end

function rs2_open_multiple(device, profiles, count, error)
    ccall((:rs2_open_multiple, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_stream_profile}}, Cint, Ptr{Ptr{rs2_error}}), device, profiles, count, error)
end

function rs2_close(sensor, error)
    ccall((:rs2_close, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_error}}), sensor, error)
end

function rs2_start(sensor, on_frame, user, error)
    ccall((:rs2_start, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_frame_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), sensor, on_frame, user, error)
end

function rs2_start_cpp(sensor, callback, error)
    ccall((:rs2_start_cpp, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{rs2_frame_callback}, Ptr{Ptr{rs2_error}}), sensor, callback, error)
end

function rs2_start_queue(sensor, queue, error)
    ccall((:rs2_start_queue, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{rs2_frame_queue}, Ptr{Ptr{rs2_error}}), sensor, queue, error)
end

function rs2_stop(sensor, error)
    ccall((:rs2_stop, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_error}}), sensor, error)
end

# typedef void ( * rs2_notification_callback_ptr ) ( rs2_notification * , void * )
const rs2_notification_callback_ptr = Ptr{Cvoid}

function rs2_set_notifications_callback(sensor, on_notification, user, error)
    ccall((:rs2_set_notifications_callback, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_notification_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), sensor, on_notification, user, error)
end

mutable struct rs2_notifications_callback end

function rs2_set_notifications_callback_cpp(sensor, callback, error)
    ccall((:rs2_set_notifications_callback_cpp, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{rs2_notifications_callback}, Ptr{Ptr{rs2_error}}), sensor, callback, error)
end

mutable struct rs2_notification end

function rs2_get_notification_description(notification, error)
    ccall((:rs2_get_notification_description, librealsense2), Ptr{Cchar}, (Ptr{rs2_notification}, Ptr{Ptr{rs2_error}}), notification, error)
end

function rs2_get_notification_timestamp(notification, error)
    ccall((:rs2_get_notification_timestamp, librealsense2), rs2_time_t, (Ptr{rs2_notification}, Ptr{Ptr{rs2_error}}), notification, error)
end

function rs2_get_notification_severity(notification, error)
    ccall((:rs2_get_notification_severity, librealsense2), rs2_log_severity, (Ptr{rs2_notification}, Ptr{Ptr{rs2_error}}), notification, error)
end

function rs2_get_notification_category(notification, error)
    ccall((:rs2_get_notification_category, librealsense2), rs2_notification_category, (Ptr{rs2_notification}, Ptr{Ptr{rs2_error}}), notification, error)
end

function rs2_get_notification_serialized_data(notification, error)
    ccall((:rs2_get_notification_serialized_data, librealsense2), Ptr{Cchar}, (Ptr{rs2_notification}, Ptr{Ptr{rs2_error}}), notification, error)
end

function rs2_get_stream_profiles(sensor, error)
    ccall((:rs2_get_stream_profiles, librealsense2), Ptr{rs2_stream_profile_list}, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_error}}), sensor, error)
end

function rs2_get_debug_stream_profiles(sensor, error)
    ccall((:rs2_get_debug_stream_profiles, librealsense2), Ptr{rs2_stream_profile_list}, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_error}}), sensor, error)
end

function rs2_get_active_streams(sensor, error)
    ccall((:rs2_get_active_streams, librealsense2), Ptr{rs2_stream_profile_list}, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_error}}), sensor, error)
end

function rs2_get_stream_profile(list, index, error)
    ccall((:rs2_get_stream_profile, librealsense2), Ptr{rs2_stream_profile}, (Ptr{rs2_stream_profile_list}, Cint, Ptr{Ptr{rs2_error}}), list, index, error)
end

function rs2_get_stream_profile_data(mode, stream, format, index, unique_id, framerate, error)
    ccall((:rs2_get_stream_profile_data, librealsense2), Cvoid, (Ptr{rs2_stream_profile}, Ptr{rs2_stream}, Ptr{rs2_format}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Ptr{rs2_error}}), mode, stream, format, index, unique_id, framerate, error)
end

function rs2_set_stream_profile_data(mode, stream, index, format, error)
    ccall((:rs2_set_stream_profile_data, librealsense2), Cvoid, (Ptr{rs2_stream_profile}, rs2_stream, Cint, rs2_format, Ptr{Ptr{rs2_error}}), mode, stream, index, format, error)
end

function rs2_clone_stream_profile(mode, stream, index, format, error)
    ccall((:rs2_clone_stream_profile, librealsense2), Ptr{rs2_stream_profile}, (Ptr{rs2_stream_profile}, rs2_stream, Cint, rs2_format, Ptr{Ptr{rs2_error}}), mode, stream, index, format, error)
end

function rs2_clone_video_stream_profile(mode, stream, index, format, width, height, intr, error)
    ccall((:rs2_clone_video_stream_profile, librealsense2), Ptr{rs2_stream_profile}, (Ptr{rs2_stream_profile}, rs2_stream, Cint, rs2_format, Cint, Cint, Ptr{rs2_intrinsics}, Ptr{Ptr{rs2_error}}), mode, stream, index, format, width, height, intr, error)
end

function rs2_delete_stream_profile(mode)
    ccall((:rs2_delete_stream_profile, librealsense2), Cvoid, (Ptr{rs2_stream_profile},), mode)
end

function rs2_stream_profile_is(mode, type, error)
    ccall((:rs2_stream_profile_is, librealsense2), Cint, (Ptr{rs2_stream_profile}, rs2_extension, Ptr{Ptr{rs2_error}}), mode, type, error)
end

function rs2_get_video_stream_resolution(mode, width, height, error)
    ccall((:rs2_get_video_stream_resolution, librealsense2), Cvoid, (Ptr{rs2_stream_profile}, Ptr{Cint}, Ptr{Cint}, Ptr{Ptr{rs2_error}}), mode, width, height, error)
end

function rs2_get_motion_intrinsics(mode, intrinsics, error)
    ccall((:rs2_get_motion_intrinsics, librealsense2), Cvoid, (Ptr{rs2_stream_profile}, Ptr{rs2_motion_device_intrinsic}, Ptr{Ptr{rs2_error}}), mode, intrinsics, error)
end

function rs2_is_stream_profile_default(mode, error)
    ccall((:rs2_is_stream_profile_default, librealsense2), Cint, (Ptr{rs2_stream_profile}, Ptr{Ptr{rs2_error}}), mode, error)
end

function rs2_get_stream_profiles_count(list, error)
    ccall((:rs2_get_stream_profiles_count, librealsense2), Cint, (Ptr{rs2_stream_profile_list}, Ptr{Ptr{rs2_error}}), list, error)
end

function rs2_delete_stream_profiles_list(list)
    ccall((:rs2_delete_stream_profiles_list, librealsense2), Cvoid, (Ptr{rs2_stream_profile_list},), list)
end

function rs2_get_extrinsics(from, to, extrin, error)
    ccall((:rs2_get_extrinsics, librealsense2), Cvoid, (Ptr{rs2_stream_profile}, Ptr{rs2_stream_profile}, Ptr{rs2_extrinsics}, Ptr{Ptr{rs2_error}}), from, to, extrin, error)
end

function rs2_register_extrinsics(from, to, extrin, error)
    ccall((:rs2_register_extrinsics, librealsense2), Cvoid, (Ptr{rs2_stream_profile}, Ptr{rs2_stream_profile}, rs2_extrinsics, Ptr{Ptr{rs2_error}}), from, to, extrin, error)
end

function rs2_override_extrinsics(sensor, extrinsics, error)
    ccall((:rs2_override_extrinsics, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{rs2_extrinsics}, Ptr{Ptr{rs2_error}}), sensor, extrinsics, error)
end

function rs2_get_video_stream_intrinsics(mode, intrinsics, error)
    ccall((:rs2_get_video_stream_intrinsics, librealsense2), Cvoid, (Ptr{rs2_stream_profile}, Ptr{rs2_intrinsics}, Ptr{Ptr{rs2_error}}), mode, intrinsics, error)
end

mutable struct rs2_processing_block_list end

function rs2_get_recommended_processing_blocks(sensor, error)
    ccall((:rs2_get_recommended_processing_blocks, librealsense2), Ptr{rs2_processing_block_list}, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_error}}), sensor, error)
end

function rs2_get_processing_block(list, index, error)
    ccall((:rs2_get_processing_block, librealsense2), Ptr{rs2_processing_block}, (Ptr{rs2_processing_block_list}, Cint, Ptr{Ptr{rs2_error}}), list, index, error)
end

function rs2_get_recommended_processing_blocks_count(list, error)
    ccall((:rs2_get_recommended_processing_blocks_count, librealsense2), Cint, (Ptr{rs2_processing_block_list}, Ptr{Ptr{rs2_error}}), list, error)
end

function rs2_delete_recommended_processing_blocks(list)
    ccall((:rs2_delete_recommended_processing_blocks, librealsense2), Cvoid, (Ptr{rs2_processing_block_list},), list)
end

function rs2_import_localization_map(sensor, lmap_blob, blob_size, error)
    ccall((:rs2_import_localization_map, librealsense2), Cint, (Ptr{rs2_sensor}, Ptr{Cuchar}, Cuint, Ptr{Ptr{rs2_error}}), sensor, lmap_blob, blob_size, error)
end

function rs2_export_localization_map(sensor, error)
    ccall((:rs2_export_localization_map, librealsense2), Ptr{rs2_raw_data_buffer}, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_error}}), sensor, error)
end

function rs2_set_static_node(sensor, guid, pos, orient, error)
    ccall((:rs2_set_static_node, librealsense2), Cint, (Ptr{rs2_sensor}, Ptr{Cchar}, rs2_vector, rs2_quaternion, Ptr{Ptr{rs2_error}}), sensor, guid, pos, orient, error)
end

function rs2_get_static_node(sensor, guid, pos, orient, error)
    ccall((:rs2_get_static_node, librealsense2), Cint, (Ptr{rs2_sensor}, Ptr{Cchar}, Ptr{rs2_vector}, Ptr{rs2_quaternion}, Ptr{Ptr{rs2_error}}), sensor, guid, pos, orient, error)
end

function rs2_remove_static_node(sensor, guid, error)
    ccall((:rs2_remove_static_node, librealsense2), Cint, (Ptr{rs2_sensor}, Ptr{Cchar}, Ptr{Ptr{rs2_error}}), sensor, guid, error)
end

function rs2_load_wheel_odometry_config(sensor, odometry_config_buf, blob_size, error)
    ccall((:rs2_load_wheel_odometry_config, librealsense2), Cint, (Ptr{rs2_sensor}, Ptr{Cuchar}, Cuint, Ptr{Ptr{rs2_error}}), sensor, odometry_config_buf, blob_size, error)
end

function rs2_send_wheel_odometry(sensor, wo_sensor_id, frame_num, translational_velocity, error)
    ccall((:rs2_send_wheel_odometry, librealsense2), Cint, (Ptr{rs2_sensor}, Cchar, Cuint, rs2_vector, Ptr{Ptr{rs2_error}}), sensor, wo_sensor_id, frame_num, translational_velocity, error)
end

function rs2_set_intrinsics(sensor, profile, intrinsics, error)
    ccall((:rs2_set_intrinsics, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{rs2_stream_profile}, Ptr{rs2_intrinsics}, Ptr{Ptr{rs2_error}}), sensor, profile, intrinsics, error)
end

function rs2_override_intrinsics(sensor, intrinsics, error)
    ccall((:rs2_override_intrinsics, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{rs2_intrinsics}, Ptr{Ptr{rs2_error}}), sensor, intrinsics, error)
end

function rs2_set_extrinsics(from_sensor, from_profile, to_sensor, to_profile, extrinsics, error)
    ccall((:rs2_set_extrinsics, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{rs2_stream_profile}, Ptr{rs2_sensor}, Ptr{rs2_stream_profile}, Ptr{rs2_extrinsics}, Ptr{Ptr{rs2_error}}), from_sensor, from_profile, to_sensor, to_profile, extrinsics, error)
end

struct rs2_dsm_params
    timestamp::Culonglong
    version::Cushort
    model::Cuchar
    flags::NTuple{5, Cuchar}
    h_scale::Cfloat
    v_scale::Cfloat
    h_offset::Cfloat
    v_offset::Cfloat
    rtd_offset::Cfloat
    temp_x2::Cuchar
    reserved::NTuple{11, Cuchar}
end

function rs2_get_dsm_params(sensor, p_params_out, error)
    ccall((:rs2_get_dsm_params, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{rs2_dsm_params}, Ptr{Ptr{rs2_error}}), sensor, p_params_out, error)
end

function rs2_override_dsm_params(sensor, p_params, error)
    ccall((:rs2_override_dsm_params, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{rs2_dsm_params}, Ptr{Ptr{rs2_error}}), sensor, p_params, error)
end

function rs2_reset_sensor_calibration(sensor, error)
    ccall((:rs2_reset_sensor_calibration, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_error}}), sensor, error)
end

function rs2_set_motion_device_intrinsics(sensor, profile, intrinsics, error)
    ccall((:rs2_set_motion_device_intrinsics, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{rs2_stream_profile}, Ptr{rs2_motion_device_intrinsic}, Ptr{Ptr{rs2_error}}), sensor, profile, intrinsics, error)
end

function rs2_get_max_usable_depth_range(sensor, error)
    ccall((:rs2_get_max_usable_depth_range, librealsense2), Cfloat, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_error}}), sensor, error)
end

function rs2_notification_category_to_string(category)
    ccall((:rs2_notification_category_to_string, librealsense2), Ptr{Cchar}, (rs2_notification_category,), category)
end

@cenum rs2_exception_type::UInt32 begin
    RS2_EXCEPTION_TYPE_UNKNOWN = 0
    RS2_EXCEPTION_TYPE_CAMERA_DISCONNECTED = 1
    RS2_EXCEPTION_TYPE_BACKEND = 2
    RS2_EXCEPTION_TYPE_INVALID_VALUE = 3
    RS2_EXCEPTION_TYPE_WRONG_API_CALL_SEQUENCE = 4
    RS2_EXCEPTION_TYPE_NOT_IMPLEMENTED = 5
    RS2_EXCEPTION_TYPE_DEVICE_IN_RECOVERY_MODE = 6
    RS2_EXCEPTION_TYPE_IO = 7
    RS2_EXCEPTION_TYPE_COUNT = 8
end

function rs2_exception_type_to_string(type)
    ccall((:rs2_exception_type_to_string, librealsense2), Ptr{Cchar}, (rs2_exception_type,), type)
end

function rs2_distortion_to_string(distortion)
    ccall((:rs2_distortion_to_string, librealsense2), Ptr{Cchar}, (rs2_distortion,), distortion)
end

@cenum rs2_dsm_correction_model::UInt32 begin
    RS2_DSM_CORRECTION_NONE = 0
    RS2_DSM_CORRECTION_AOT = 1
    RS2_DSM_CORRECTION_TOA = 2
    RS2_DSM_CORRECTION_COUNT = 3
end

function rs2_log_severity_to_string(info)
    ccall((:rs2_log_severity_to_string, librealsense2), Ptr{Cchar}, (rs2_log_severity,), info)
end

function rs2_extension_type_to_string(type)
    ccall((:rs2_extension_type_to_string, librealsense2), Ptr{Cchar}, (rs2_extension,), type)
end

function rs2_extension_to_string(type)
    ccall((:rs2_extension_to_string, librealsense2), Ptr{Cchar}, (rs2_extension,), type)
end

mutable struct rs2_device_info end

mutable struct rs2_syncer end

mutable struct rs2_device_serializer end

mutable struct rs2_firmware_log_parser end

function rs2_create_error(what, name, args, type)
    ccall((:rs2_create_error, librealsense2), Ptr{rs2_error}, (Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}, rs2_exception_type), what, name, args, type)
end

function rs2_get_librealsense_exception_type(error)
    ccall((:rs2_get_librealsense_exception_type, librealsense2), rs2_exception_type, (Ptr{rs2_error},), error)
end

function rs2_get_failed_function(error)
    ccall((:rs2_get_failed_function, librealsense2), Ptr{Cchar}, (Ptr{rs2_error},), error)
end

function rs2_get_failed_args(error)
    ccall((:rs2_get_failed_args, librealsense2), Ptr{Cchar}, (Ptr{rs2_error},), error)
end

function rs2_get_error_message(error)
    ccall((:rs2_get_error_message, librealsense2), Ptr{Cchar}, (Ptr{rs2_error},), error)
end

function rs2_free_error(error)
    ccall((:rs2_free_error, librealsense2), Cvoid, (Ptr{rs2_error},), error)
end

const RS2_API_MAJOR_VERSION = 2

const RS2_API_MINOR_VERSION = 41

const RS2_API_PATCH_VERSION = 0

const RS2_API_BUILD_VERSION = 0

const RS2_API_VERSION = RS2_API_MAJOR_VERSION * 10000 + RS2_API_MINOR_VERSION * 100 + RS2_API_PATCH_VERSION

# Skipping MacroDefinition: RS2_API_VERSION_STR ( VAR_ARG_STRING ( RS2_API_MAJOR_VERSION . RS2_API_MINOR_VERSION . RS2_API_PATCH_VERSION ) )

# Skipping MacroDefinition: RS2_API_FULL_VERSION_STR ( VAR_ARG_STRING ( RS2_API_MAJOR_VERSION . RS2_API_MINOR_VERSION . RS2_API_PATCH_VERSION . RS2_API_BUILD_VERSION ) )

const RS2_DEFAULT_TIMEOUT = 15000

const RS2_PRODUCT_LINE_ANY = 0xff

const RS2_PRODUCT_LINE_ANY_INTEL = 0xfe

const RS2_PRODUCT_LINE_NON_INTEL = 0x01

const RS2_PRODUCT_LINE_D400 = 0x02

const RS2_PRODUCT_LINE_SR300 = 0x04

const RS2_PRODUCT_LINE_L500 = 0x08

const RS2_PRODUCT_LINE_T200 = 0x10

const RS2_PRODUCT_LINE_DEPTH = (RS2_PRODUCT_LINE_L500 | RS2_PRODUCT_LINE_SR300) | RS2_PRODUCT_LINE_D400

const RS2_PRODUCT_LINE_TRACKING = RS2_PRODUCT_LINE_T200

const RS2_UNSIGNED_UPDATE_MODE_UPDATE = 0

const RS2_UNSIGNED_UPDATE_MODE_READ_ONLY = 1

const RS2_UNSIGNED_UPDATE_MODE_FULL = 2

# exports
const PREFIXES = ["RS2_", "rs2_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
