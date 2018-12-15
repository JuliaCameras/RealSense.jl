# Julia wrapper for header: /Users/gnimuc/.julia/dev/LibRealSense/deps/usr/include/librealsense2/rs.h
# Automatically generated using Clang.jl


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

function rs2_log_to_console(min_severity, error)
    ccall((:rs2_log_to_console, librealsense2), Cvoid, (rs2_log_severity, Ptr{Ptr{rs2_error}}), min_severity, error)
end

function rs2_log_to_file(min_severity, file_path, error)
    ccall((:rs2_log_to_file, librealsense2), Cvoid, (rs2_log_severity, Cstring, Ptr{Ptr{rs2_error}}), min_severity, file_path, error)
end

function rs2_log(severity, message, error)
    ccall((:rs2_log, librealsense2), Cvoid, (rs2_log_severity, Cstring, Ptr{Ptr{rs2_error}}), severity, message, error)
end

function rs2_depth_frame_get_distance(frame_ref, x, y, error)
    ccall((:rs2_depth_frame_get_distance, librealsense2), Cfloat, (Ptr{rs2_frame}, Cint, Cint, Ptr{Ptr{rs2_error}}), frame_ref, x, y, error)
end

function rs2_get_time(error)
    ccall((:rs2_get_time, librealsense2), rs2_time_t, (Ptr{Ptr{rs2_error}},), error)
end
# Julia wrapper for header: /Users/gnimuc/.julia/dev/LibRealSense/deps/usr/include/librealsense2/rs_advanced_mode.h
# Automatically generated using Clang.jl


function rs2_toggle_advanced_mode(dev, enable, error)
    ccall((:rs2_toggle_advanced_mode, librealsense2), Cvoid, (Ptr{rs2_device}, Cint, Ptr{Ptr{rs2_error}}), dev, enable, error)
end

function rs2_is_enabled(dev, enabled, error)
    ccall((:rs2_is_enabled, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Cint}, Ptr{Ptr{rs2_error}}), dev, enabled, error)
end

function rs2_set_depth_control(dev, group, error)
    ccall((:rs2_set_depth_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STDepthControlGroup}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_depth_control(dev, group, mode, error)
    ccall((:rs2_get_depth_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STDepthControlGroup}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

function rs2_set_rsm(dev, group, error)
    ccall((:rs2_set_rsm, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STRsm}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_rsm(dev, group, mode, error)
    ccall((:rs2_get_rsm, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STRsm}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

function rs2_set_rau_support_vector_control(dev, group, error)
    ccall((:rs2_set_rau_support_vector_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STRauSupportVectorControl}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_rau_support_vector_control(dev, group, mode, error)
    ccall((:rs2_get_rau_support_vector_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STRauSupportVectorControl}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

function rs2_set_color_control(dev, group, error)
    ccall((:rs2_set_color_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STColorControl}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_color_control(dev, group, mode, error)
    ccall((:rs2_get_color_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STColorControl}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

function rs2_set_rau_thresholds_control(dev, group, error)
    ccall((:rs2_set_rau_thresholds_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STRauColorThresholdsControl}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_rau_thresholds_control(dev, group, mode, error)
    ccall((:rs2_get_rau_thresholds_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STRauColorThresholdsControl}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

function rs2_set_slo_color_thresholds_control(dev, group, error)
    ccall((:rs2_set_slo_color_thresholds_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STSloColorThresholdsControl}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_slo_color_thresholds_control(dev, group, mode, error)
    ccall((:rs2_get_slo_color_thresholds_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STSloColorThresholdsControl}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

function rs2_set_slo_penalty_control(dev, group, error)
    ccall((:rs2_set_slo_penalty_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STSloPenaltyControl}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_slo_penalty_control(dev, group, mode, error)
    ccall((:rs2_get_slo_penalty_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STSloPenaltyControl}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

function rs2_set_hdad(dev, group, error)
    ccall((:rs2_set_hdad, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STHdad}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_hdad(dev, group, mode, error)
    ccall((:rs2_get_hdad, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STHdad}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

function rs2_set_color_correction(dev, group, error)
    ccall((:rs2_set_color_correction, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STColorCorrection}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_color_correction(dev, group, mode, error)
    ccall((:rs2_get_color_correction, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STColorCorrection}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

function rs2_set_depth_table(dev, group, error)
    ccall((:rs2_set_depth_table, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STDepthTableControl}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_depth_table(dev, group, mode, error)
    ccall((:rs2_get_depth_table, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STDepthTableControl}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

function rs2_set_ae_control(dev, group, error)
    ccall((:rs2_set_ae_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STAEControl}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_ae_control(dev, group, mode, error)
    ccall((:rs2_get_ae_control, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STAEControl}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

function rs2_set_census(dev, group, error)
    ccall((:rs2_set_census, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STCensusRadius}, Ptr{Ptr{rs2_error}}), dev, group, error)
end

function rs2_get_census(dev, group, mode, error)
    ccall((:rs2_get_census, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{STCensusRadius}, Cint, Ptr{Ptr{rs2_error}}), dev, group, mode, error)
end

function rs2_load_json(dev, json_content, content_size, error)
    ccall((:rs2_load_json, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Cvoid}, UInt32, Ptr{Ptr{rs2_error}}), dev, json_content, content_size, error)
end

function rs2_serialize_json(dev, error)
    ccall((:rs2_serialize_json, librealsense2), Ptr{rs2_raw_data_buffer}, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), dev, error)
end
# Julia wrapper for header: /Users/gnimuc/.julia/dev/LibRealSense/deps/usr/include/librealsense2/rs_advanced_mode_command.h
# Automatically generated using Clang.jl

# Julia wrapper for header: /Users/gnimuc/.julia/dev/LibRealSense/deps/usr/include/librealsense2/rs_context.h
# Automatically generated using Clang.jl


function rs2_create_context(api_version, error)
    ccall((:rs2_create_context, librealsense2), Ptr{rs2_context}, (Cint, Ptr{Ptr{rs2_error}}), api_version, error)
end

function rs2_delete_context(context)
    ccall((:rs2_delete_context, librealsense2), Cvoid, (Ptr{rs2_context},), context)
end

function rs2_set_devices_changed_callback_cpp(context, callback, error)
    ccall((:rs2_set_devices_changed_callback_cpp, librealsense2), Cvoid, (Ptr{rs2_context}, Ptr{rs2_devices_changed_callback}, Ptr{Ptr{rs2_error}}), context, callback, error)
end

function rs2_set_devices_changed_callback(context, callback, user, error)
    ccall((:rs2_set_devices_changed_callback, librealsense2), Cvoid, (Ptr{rs2_context}, rs2_devices_changed_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), context, callback, user, error)
end

function rs2_context_add_device(ctx, file, error)
    ccall((:rs2_context_add_device, librealsense2), Ptr{rs2_device}, (Ptr{rs2_context}, Cstring, Ptr{Ptr{rs2_error}}), ctx, file, error)
end

function rs2_context_remove_device(ctx, file, error)
    ccall((:rs2_context_remove_device, librealsense2), Cvoid, (Ptr{rs2_context}, Cstring, Ptr{Ptr{rs2_error}}), ctx, file, error)
end

function rs2_query_devices(context, error)
    ccall((:rs2_query_devices, librealsense2), Ptr{rs2_device_list}, (Ptr{rs2_context}, Ptr{Ptr{rs2_error}}), context, error)
end

function rs2_query_devices_ex(context, product_mask, error)
    ccall((:rs2_query_devices_ex, librealsense2), Ptr{rs2_device_list}, (Ptr{rs2_context}, Cint, Ptr{Ptr{rs2_error}}), context, product_mask, error)
end

function rs2_create_device_hub(context, error)
    ccall((:rs2_create_device_hub, librealsense2), Ptr{rs2_device_hub}, (Ptr{rs2_context}, Ptr{Ptr{rs2_error}}), context, error)
end

function rs2_delete_device_hub(hub)
    ccall((:rs2_delete_device_hub, librealsense2), Cvoid, (Ptr{rs2_device_hub},), hub)
end

function rs2_device_hub_wait_for_device(ctx, hub, error)
    ccall((:rs2_device_hub_wait_for_device, librealsense2), Ptr{rs2_device}, (Ptr{rs2_context}, Ptr{rs2_device_hub}, Ptr{Ptr{rs2_error}}), ctx, hub, error)
end

function rs2_device_hub_is_device_connected(hub, device, error)
    ccall((:rs2_device_hub_is_device_connected, librealsense2), Cint, (Ptr{rs2_device_hub}, Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), hub, device, error)
end
# Julia wrapper for header: /Users/gnimuc/.julia/dev/LibRealSense/deps/usr/include/librealsense2/rs_device.h
# Automatically generated using Clang.jl


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

function rs2_get_device_info(device, info, error)
    ccall((:rs2_get_device_info, librealsense2), Cstring, (Ptr{rs2_device}, rs2_camera_info, Ptr{Ptr{rs2_error}}), device, info, error)
end

function rs2_supports_device_info(device, info, error)
    ccall((:rs2_supports_device_info, librealsense2), Cint, (Ptr{rs2_device}, rs2_camera_info, Ptr{Ptr{rs2_error}}), device, info, error)
end

function rs2_hardware_reset(device, error)
    ccall((:rs2_hardware_reset, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_send_and_receive_raw_data(device, raw_data_to_send, size_of_raw_data_to_send, error)
    ccall((:rs2_send_and_receive_raw_data, librealsense2), Ptr{rs2_raw_data_buffer}, (Ptr{rs2_device}, Ptr{Cvoid}, UInt32, Ptr{Ptr{rs2_error}}), device, raw_data_to_send, size_of_raw_data_to_send, error)
end

function rs2_is_device_extendable_to(device, extension, error)
    ccall((:rs2_is_device_extendable_to, librealsense2), Cint, (Ptr{rs2_device}, rs2_extension, Ptr{Ptr{rs2_error}}), device, extension, error)
end

function rs2_query_sensors(device, error)
    ccall((:rs2_query_sensors, librealsense2), Ptr{rs2_sensor_list}, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_loopback_enable(device, from_file, error)
    ccall((:rs2_loopback_enable, librealsense2), Cvoid, (Ptr{rs2_device}, Cstring, Ptr{Ptr{rs2_error}}), device, from_file, error)
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
# Julia wrapper for header: /Users/gnimuc/.julia/dev/LibRealSense/deps/usr/include/librealsense2/rs_frame.h
# Automatically generated using Clang.jl


function rs2_timestamp_domain_to_string(info)
    ccall((:rs2_timestamp_domain_to_string, librealsense2), Cstring, (rs2_timestamp_domain,), info)
end

function rs2_frame_metadata_to_string(metadata)
    ccall((:rs2_frame_metadata_to_string, librealsense2), Cstring, (rs2_frame_metadata_value,), metadata)
end

function rs2_frame_metadata_value_to_string(metadata)
    ccall((:rs2_frame_metadata_value_to_string, librealsense2), Cstring, (rs2_frame_metadata_value,), metadata)
end

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

function rs2_get_frame_number(frame, error)
    ccall((:rs2_get_frame_number, librealsense2), Culonglong, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
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

function rs2_get_frame_vertices(frame, error)
    ccall((:rs2_get_frame_vertices, librealsense2), Ptr{rs2_vertex}, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_export_to_ply(frame, fname, texture, error)
    ccall((:rs2_export_to_ply, librealsense2), Cvoid, (Ptr{rs2_frame}, Cstring, Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, fname, texture, error)
end

function rs2_get_frame_texture_coordinates(frame, error)
    ccall((:rs2_get_frame_texture_coordinates, librealsense2), Ptr{rs2_pixel}, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_get_frame_points_count(frame, error)
    ccall((:rs2_get_frame_points_count, librealsense2), Cint, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_get_frame_stream_profile(frame, error)
    ccall((:rs2_get_frame_stream_profile, librealsense2), Ptr{rs2_stream_profile}, (Ptr{rs2_frame}, Ptr{Ptr{rs2_error}}), frame, error)
end

function rs2_is_frame_extendable_to(frame, extension_type, error)
    ccall((:rs2_is_frame_extendable_to, librealsense2), Cint, (Ptr{rs2_frame}, rs2_extension, Ptr{Ptr{rs2_error}}), frame, extension_type, error)
end

function rs2_allocate_synthetic_video_frame(source, new_stream, original, new_bpp, new_width, new_height, new_stride, frame_type, error)
    ccall((:rs2_allocate_synthetic_video_frame, librealsense2), Ptr{rs2_frame}, (Ptr{rs2_source}, Ptr{rs2_stream_profile}, Ptr{rs2_frame}, Cint, Cint, Cint, Cint, rs2_extension, Ptr{Ptr{rs2_error}}), source, new_stream, original, new_bpp, new_width, new_height, new_stride, frame_type, error)
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

function rs2_pose_frame_get_pose_data(frame, pose, error)
    ccall((:rs2_pose_frame_get_pose_data, librealsense2), Cvoid, (Ptr{rs2_frame}, Ptr{rs2_pose}, Ptr{Ptr{rs2_error}}), frame, pose, error)
end
# Julia wrapper for header: /Users/gnimuc/.julia/dev/LibRealSense/deps/usr/include/librealsense2/rs_internal.h
# Automatically generated using Clang.jl


function rs2_create_recording_context(api_version, filename, section, mode, error)
    ccall((:rs2_create_recording_context, librealsense2), Ptr{rs2_context}, (Cint, Cstring, Cstring, rs2_recording_mode, Ptr{Ptr{rs2_error}}), api_version, filename, section, mode, error)
end

function rs2_create_mock_context(api_version, filename, section, error)
    ccall((:rs2_create_mock_context, librealsense2), Ptr{rs2_context}, (Cint, Cstring, Cstring, Ptr{Ptr{rs2_error}}), api_version, filename, section, error)
end

function rs2_create_mock_context_versioned(api_version, filename, section, min_api_version, error)
    ccall((:rs2_create_mock_context_versioned, librealsense2), Ptr{rs2_context}, (Cint, Cstring, Cstring, Cstring, Ptr{Ptr{rs2_error}}), api_version, filename, section, min_api_version, error)
end

function rs2_create_software_device(error)
    ccall((:rs2_create_software_device, librealsense2), Ptr{rs2_device}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_software_device_add_sensor(dev, sensor_name, error)
    ccall((:rs2_software_device_add_sensor, librealsense2), Ptr{rs2_sensor}, (Ptr{rs2_device}, Cstring, Ptr{Ptr{rs2_error}}), dev, sensor_name, error)
end

function rs2_software_sensor_on_video_frame(sensor, frame, error)
    ccall((:rs2_software_sensor_on_video_frame, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_software_video_frame, Ptr{Ptr{rs2_error}}), sensor, frame, error)
end

function rs2_software_sensor_set_metadata(sensor, value, type, error)
    ccall((:rs2_software_sensor_set_metadata, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_frame_metadata_value, rs2_metadata_type, Ptr{Ptr{rs2_error}}), sensor, value, type, error)
end

function rs2_software_device_create_matcher(dev, matcher, error)
    ccall((:rs2_software_device_create_matcher, librealsense2), Cvoid, (Ptr{rs2_device}, rs2_matchers, Ptr{Ptr{rs2_error}}), dev, matcher, error)
end

function rs2_software_sensor_add_video_stream(sensor, video_stream, error)
    ccall((:rs2_software_sensor_add_video_stream, librealsense2), Ptr{rs2_stream_profile}, (Ptr{rs2_sensor}, rs2_video_stream, Ptr{Ptr{rs2_error}}), sensor, video_stream, error)
end

function rs2_software_sensor_add_read_only_option(sensor, option, val, error)
    ccall((:rs2_software_sensor_add_read_only_option, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_option, Cfloat, Ptr{Ptr{rs2_error}}), sensor, option, val, error)
end

function rs2_software_sensor_update_read_only_option(sensor, option, val, error)
    ccall((:rs2_software_sensor_update_read_only_option, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_option, Cfloat, Ptr{Ptr{rs2_error}}), sensor, option, val, error)
end
# Julia wrapper for header: /Users/gnimuc/.julia/dev/LibRealSense/deps/usr/include/librealsense2/rs_option.h
# Automatically generated using Clang.jl


function rs2_option_to_string(option)
    ccall((:rs2_option_to_string, librealsense2), Cstring, (rs2_option,), option)
end

function rs2_sr300_visual_preset_to_string(preset)
    ccall((:rs2_sr300_visual_preset_to_string, librealsense2), Cstring, (rs2_sr300_visual_preset,), preset)
end

function rs2_rs400_visual_preset_to_string(preset)
    ccall((:rs2_rs400_visual_preset_to_string, librealsense2), Cstring, (rs2_rs400_visual_preset,), preset)
end

function rs2_is_option_read_only(options, option, error)
    ccall((:rs2_is_option_read_only, librealsense2), Cint, (Ptr{rs2_options}, rs2_option, Ptr{Ptr{rs2_error}}), options, option, error)
end

function rs2_get_option(options, option, error)
    ccall((:rs2_get_option, librealsense2), Cfloat, (Ptr{rs2_options}, rs2_option, Ptr{Ptr{rs2_error}}), options, option, error)
end

function rs2_set_option(options, option, value, error)
    ccall((:rs2_set_option, librealsense2), Cvoid, (Ptr{rs2_options}, rs2_option, Cfloat, Ptr{Ptr{rs2_error}}), options, option, value, error)
end

function rs2_supports_option(options, option, error)
    ccall((:rs2_supports_option, librealsense2), Cint, (Ptr{rs2_options}, rs2_option, Ptr{Ptr{rs2_error}}), options, option, error)
end

function rs2_get_option_range(sensor, option, min, max, step, def, error)
    ccall((:rs2_get_option_range, librealsense2), Cvoid, (Ptr{rs2_options}, rs2_option, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Ptr{rs2_error}}), sensor, option, min, max, step, def, error)
end

function rs2_get_option_description(options, option, error)
    ccall((:rs2_get_option_description, librealsense2), Cstring, (Ptr{rs2_options}, rs2_option, Ptr{Ptr{rs2_error}}), options, option, error)
end

function rs2_get_option_value_description(options, option, value, error)
    ccall((:rs2_get_option_value_description, librealsense2), Cstring, (Ptr{rs2_options}, rs2_option, Cfloat, Ptr{Ptr{rs2_error}}), options, option, value, error)
end
# Julia wrapper for header: /Users/gnimuc/.julia/dev/LibRealSense/deps/usr/include/librealsense2/rs_pipeline.h
# Automatically generated using Clang.jl


function rs2_create_pipeline(ctx, error)
    ccall((:rs2_create_pipeline, librealsense2), Ptr{rs2_pipeline}, (Ptr{rs2_context}, Ptr{Ptr{rs2_error}}), ctx, error)
end

function rs2_pipeline_stop(pipe, error)
    ccall((:rs2_pipeline_stop, librealsense2), Cvoid, (Ptr{rs2_pipeline}, Ptr{Ptr{rs2_error}}), pipe, error)
end

function rs2_pipeline_wait_for_frames(pipe, timeout_ms, error)
    ccall((:rs2_pipeline_wait_for_frames, librealsense2), Ptr{rs2_frame}, (Ptr{rs2_pipeline}, UInt32, Ptr{Ptr{rs2_error}}), pipe, timeout_ms, error)
end

function rs2_pipeline_poll_for_frames(pipe, output_frame, error)
    ccall((:rs2_pipeline_poll_for_frames, librealsense2), Cint, (Ptr{rs2_pipeline}, Ptr{Ptr{rs2_frame}}, Ptr{Ptr{rs2_error}}), pipe, output_frame, error)
end

function rs2_pipeline_try_wait_for_frames(pipe, output_frame, timeout_ms, error)
    ccall((:rs2_pipeline_try_wait_for_frames, librealsense2), Cint, (Ptr{rs2_pipeline}, Ptr{Ptr{rs2_frame}}, UInt32, Ptr{Ptr{rs2_error}}), pipe, output_frame, timeout_ms, error)
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

function rs2_pipeline_get_active_profile(pipe, error)
    ccall((:rs2_pipeline_get_active_profile, librealsense2), Ptr{rs2_pipeline_profile}, (Ptr{rs2_pipeline}, Ptr{Ptr{rs2_error}}), pipe, error)
end

function rs2_pipeline_profile_get_device(profile, error)
    ccall((:rs2_pipeline_profile_get_device, librealsense2), Ptr{rs2_device}, (Ptr{rs2_pipeline_profile}, Ptr{Ptr{rs2_error}}), profile, error)
end

function rs2_pipeline_profile_get_streams(profile, error)
    ccall((:rs2_pipeline_profile_get_streams, librealsense2), Ptr{rs2_stream_profile_list}, (Ptr{rs2_pipeline_profile}, Ptr{Ptr{rs2_error}}), profile, error)
end

function rs2_delete_pipeline_profile(profile)
    ccall((:rs2_delete_pipeline_profile, librealsense2), Cvoid, (Ptr{rs2_pipeline_profile},), profile)
end

function rs2_create_config(error)
    ccall((:rs2_create_config, librealsense2), Ptr{rs2_config}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_delete_config(config)
    ccall((:rs2_delete_config, librealsense2), Cvoid, (Ptr{rs2_config},), config)
end

function rs2_config_enable_stream(config, stream, index, width, height, format, framerate, error)
    ccall((:rs2_config_enable_stream, librealsense2), Cvoid, (Ptr{rs2_config}, rs2_stream, Cint, Cint, Cint, rs2_format, Cint, Ptr{Ptr{rs2_error}}), config, stream, index, width, height, format, framerate, error)
end

function rs2_config_enable_all_stream(config, error)
    ccall((:rs2_config_enable_all_stream, librealsense2), Cvoid, (Ptr{rs2_config}, Ptr{Ptr{rs2_error}}), config, error)
end

function rs2_config_enable_device(config, serial, error)
    ccall((:rs2_config_enable_device, librealsense2), Cvoid, (Ptr{rs2_config}, Cstring, Ptr{Ptr{rs2_error}}), config, serial, error)
end

function rs2_config_enable_device_from_file(config, file, error)
    ccall((:rs2_config_enable_device_from_file, librealsense2), Cvoid, (Ptr{rs2_config}, Cstring, Ptr{Ptr{rs2_error}}), config, file, error)
end

function rs2_config_enable_device_from_file_repeat_option(config, file, repeat_playback, error)
    ccall((:rs2_config_enable_device_from_file_repeat_option, librealsense2), Cvoid, (Ptr{rs2_config}, Cstring, Cint, Ptr{Ptr{rs2_error}}), config, file, repeat_playback, error)
end

function rs2_config_enable_record_to_file(config, file, error)
    ccall((:rs2_config_enable_record_to_file, librealsense2), Cvoid, (Ptr{rs2_config}, Cstring, Ptr{Ptr{rs2_error}}), config, file, error)
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

function rs2_config_resolve(config, pipe, error)
    ccall((:rs2_config_resolve, librealsense2), Ptr{rs2_pipeline_profile}, (Ptr{rs2_config}, Ptr{rs2_pipeline}, Ptr{Ptr{rs2_error}}), config, pipe, error)
end

function rs2_config_can_resolve(config, pipe, error)
    ccall((:rs2_config_can_resolve, librealsense2), Cint, (Ptr{rs2_config}, Ptr{rs2_pipeline}, Ptr{Ptr{rs2_error}}), config, pipe, error)
end
# Julia wrapper for header: /Users/gnimuc/.julia/dev/LibRealSense/deps/usr/include/librealsense2/rs_processing.h
# Automatically generated using Clang.jl


function rs2_create_colorizer(error)
    ccall((:rs2_create_colorizer, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_sync_processing_block(error)
    ccall((:rs2_create_sync_processing_block, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_pointcloud(error)
    ccall((:rs2_create_pointcloud, librealsense2), Ptr{rs2_processing_block}, (Ptr{Ptr{rs2_error}},), error)
end

function rs2_create_processing_block(proc, error)
    ccall((:rs2_create_processing_block, librealsense2), Ptr{rs2_processing_block}, (Ptr{rs2_frame_processor_callback}, Ptr{Ptr{rs2_error}}), proc, error)
end

function rs2_create_processing_block_fptr(proc, context, error)
    ccall((:rs2_create_processing_block_fptr, librealsense2), Ptr{rs2_processing_block}, (rs2_frame_processor_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), proc, context, error)
end

function rs2_start_processing(block, on_frame, error)
    ccall((:rs2_start_processing, librealsense2), Cvoid, (Ptr{rs2_processing_block}, Ptr{rs2_frame_callback}, Ptr{Ptr{rs2_error}}), block, on_frame, error)
end

function rs2_start_processing_fptr(block, on_frame, user, error)
    ccall((:rs2_start_processing_fptr, librealsense2), Cvoid, (Ptr{rs2_processing_block}, rs2_frame_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), block, on_frame, user, error)
end

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
    ccall((:rs2_wait_for_frame, librealsense2), Ptr{rs2_frame}, (Ptr{rs2_frame_queue}, UInt32, Ptr{Ptr{rs2_error}}), queue, timeout_ms, error)
end

function rs2_poll_for_frame(queue, output_frame, error)
    ccall((:rs2_poll_for_frame, librealsense2), Cint, (Ptr{rs2_frame_queue}, Ptr{Ptr{rs2_frame}}, Ptr{Ptr{rs2_error}}), queue, output_frame, error)
end

function rs2_try_wait_for_frame(queue, timeout_ms, output_frame, error)
    ccall((:rs2_try_wait_for_frame, librealsense2), Cint, (Ptr{rs2_frame_queue}, UInt32, Ptr{Ptr{rs2_frame}}, Ptr{Ptr{rs2_error}}), queue, timeout_ms, output_frame, error)
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
# Julia wrapper for header: /Users/gnimuc/.julia/dev/LibRealSense/deps/usr/include/librealsense2/rs_record_playback.h
# Automatically generated using Clang.jl


function rs2_playback_status_to_string(status)
    ccall((:rs2_playback_status_to_string, librealsense2), Cstring, (rs2_playback_status,), status)
end

function rs2_create_record_device(device, file, error)
    ccall((:rs2_create_record_device, librealsense2), Ptr{rs2_device}, (Ptr{rs2_device}, Cstring, Ptr{Ptr{rs2_error}}), device, file, error)
end

function rs2_record_device_pause(device, error)
    ccall((:rs2_record_device_pause, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_record_device_resume(device, error)
    ccall((:rs2_record_device_resume, librealsense2), Cvoid, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_record_device_filename(device, error)
    ccall((:rs2_record_device_filename, librealsense2), Cstring, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
end

function rs2_create_playback_device(file, error)
    ccall((:rs2_create_playback_device, librealsense2), Ptr{rs2_device}, (Cstring, Ptr{Ptr{rs2_error}}), file, error)
end

function rs2_playback_device_get_file_path(device, error)
    ccall((:rs2_playback_device_get_file_path, librealsense2), Cstring, (Ptr{rs2_device}, Ptr{Ptr{rs2_error}}), device, error)
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
# Julia wrapper for header: /Users/gnimuc/.julia/dev/LibRealSense/deps/usr/include/librealsense2/rs_sensor.h
# Automatically generated using Clang.jl


function rs2_camera_info_to_string(info)
    ccall((:rs2_camera_info_to_string, librealsense2), Cstring, (rs2_camera_info,), info)
end

function rs2_stream_to_string(stream)
    ccall((:rs2_stream_to_string, librealsense2), Cstring, (rs2_stream,), stream)
end

function rs2_format_to_string(format)
    ccall((:rs2_format_to_string, librealsense2), Cstring, (rs2_format,), format)
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
    ccall((:rs2_get_sensor_info, librealsense2), Cstring, (Ptr{rs2_sensor}, rs2_camera_info, Ptr{Ptr{rs2_error}}), sensor, info, error)
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

function rs2_set_notifications_callback(sensor, on_notification, user, error)
    ccall((:rs2_set_notifications_callback, librealsense2), Cvoid, (Ptr{rs2_sensor}, rs2_notification_callback_ptr, Ptr{Cvoid}, Ptr{Ptr{rs2_error}}), sensor, on_notification, user, error)
end

function rs2_set_notifications_callback_cpp(sensor, callback, error)
    ccall((:rs2_set_notifications_callback_cpp, librealsense2), Cvoid, (Ptr{rs2_sensor}, Ptr{rs2_notifications_callback}, Ptr{Ptr{rs2_error}}), sensor, callback, error)
end

function rs2_get_notification_description(notification, error)
    ccall((:rs2_get_notification_description, librealsense2), Cstring, (Ptr{rs2_notification}, Ptr{Ptr{rs2_error}}), notification, error)
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
    ccall((:rs2_get_notification_serialized_data, librealsense2), Cstring, (Ptr{rs2_notification}, Ptr{Ptr{rs2_error}}), notification, error)
end

function rs2_get_stream_profiles(device, error)
    ccall((:rs2_get_stream_profiles, librealsense2), Ptr{rs2_stream_profile_list}, (Ptr{rs2_sensor}, Ptr{Ptr{rs2_error}}), device, error)
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

function rs2_get_video_stream_intrinsics(mode, intrinsics, error)
    ccall((:rs2_get_video_stream_intrinsics, librealsense2), Cvoid, (Ptr{rs2_stream_profile}, Ptr{rs2_intrinsics}, Ptr{Ptr{rs2_error}}), mode, intrinsics, error)
end
# Julia wrapper for header: /Users/gnimuc/.julia/dev/LibRealSense/deps/usr/include/librealsense2/rs_types.h
# Automatically generated using Clang.jl


function rs2_notification_category_to_string(category)
    ccall((:rs2_notification_category_to_string, librealsense2), Cstring, (rs2_notification_category,), category)
end

function rs2_exception_type_to_string(type)
    ccall((:rs2_exception_type_to_string, librealsense2), Cstring, (rs2_exception_type,), type)
end

function rs2_distortion_to_string(distortion)
    ccall((:rs2_distortion_to_string, librealsense2), Cstring, (rs2_distortion,), distortion)
end

function rs2_log_severity_to_string(info)
    ccall((:rs2_log_severity_to_string, librealsense2), Cstring, (rs2_log_severity,), info)
end

function rs2_extension_type_to_string(type)
    ccall((:rs2_extension_type_to_string, librealsense2), Cstring, (rs2_extension,), type)
end

function rs2_extension_to_string(type)
    ccall((:rs2_extension_to_string, librealsense2), Cstring, (rs2_extension,), type)
end

function rs2_get_librealsense_exception_type(error)
    ccall((:rs2_get_librealsense_exception_type, librealsense2), rs2_exception_type, (Ptr{rs2_error},), error)
end

function rs2_get_failed_function(error)
    ccall((:rs2_get_failed_function, librealsense2), Cstring, (Ptr{rs2_error},), error)
end

function rs2_get_failed_args(error)
    ccall((:rs2_get_failed_args, librealsense2), Cstring, (Ptr{rs2_error},), error)
end

function rs2_get_error_message(error)
    ccall((:rs2_get_error_message, librealsense2), Cstring, (Ptr{rs2_error},), error)
end

function rs2_free_error(error)
    ccall((:rs2_free_error, librealsense2), Cvoid, (Ptr{rs2_error},), error)
end
# Julia wrapper for header: /Users/gnimuc/.julia/dev/LibRealSense/deps/usr/include/librealsense2/rsutil.h
# Automatically generated using Clang.jl


function rs2_project_point_to_pixel(pixel, intrin, point)
    ccall((:rs2_project_point_to_pixel, librealsense2), Cvoid, (NTuple{2, Cfloat}, Ptr{rs2_intrinsics}, NTuple{3, Cfloat}), pixel, intrin, point)
end

function rs2_deproject_pixel_to_point(point, intrin, pixel, depth)
    ccall((:rs2_deproject_pixel_to_point, librealsense2), Cvoid, (NTuple{3, Cfloat}, Ptr{rs2_intrinsics}, NTuple{2, Cfloat}, Cfloat), point, intrin, pixel, depth)
end

function rs2_transform_point_to_point(to_point, extrin, from_point)
    ccall((:rs2_transform_point_to_point, librealsense2), Cvoid, (NTuple{3, Cfloat}, Ptr{rs2_extrinsics}, NTuple{3, Cfloat}), to_point, extrin, from_point)
end

function rs2_fov(intrin, to_fov)
    ccall((:rs2_fov, librealsense2), Cvoid, (Ptr{rs2_intrinsics}, NTuple{2, Cfloat}), intrin, to_fov)
end
