@testset "Sync sanity" begin

err = Ref{Ptr{rs2_error}}(0)

filename = joinpath(@__DIR__, "d415_fw_5.9.8_USB3_single.rec")
section = "Sync__sanity.1.test"
ctx = rs2_create_mock_context(RS2_API_VERSION, filename, section, err)
checkerror(err)

deviceList = rs2_query_devices(ctx, err)
checkerror(err)
deviceCount = rs2_get_device_count(deviceList, err)
checkerror(err)
@test deviceCount ≥ 1

device = rs2_create_device(deviceList, 0, err)
checkerror(err)
print_device_information(device)
disable_sensitive_options_for(device)

frame_queue = rs2_create_frame_queue(1, err)
checkerror(err)
sync = rs2_create_sync_processing_block(err)
checkerror(err)
rs2_start_processing_queue(sync, frame_queue, err)
checkerror(err)

fps = 30
profiles = configure_all_supported_streams(device, 640, 480, fps)

sensors = query_sensors(device)
for s in sensors
    rs2_start(s, on_frame_ptr, sync, err)
    checkerror(err)
end

all_timestamps = []
actual_fps = fps
hw_timestamp_domain = false
system_timestamp_domain = false
for i = 1:200
    frames = rs2_wait_for_frame(frame_queue, 5000, err)
    checkerror(err)
    is_extendable = rs2_is_frame_extendable_to(frames, RS2_EXTENSION_COMPOSITE_FRAME, err)
    checkerror(err)
    @test is_extendable > 0
    num_of_frames = rs2_embedded_frames_count(frames, err)
    checkerror(err)
    @test num_of_frames > 0

    timestemps = []
    for j = 0:num_of_frames-1
        frame = rs2_extract_frame(frames, j, err)
        checkerror(err)
        is_support = rs2_supports_frame_metadata(frame, RS2_FRAME_METADATA_ACTUAL_FPS, err)
        checkerror(err)
        if is_support > 0
            value = rs2_get_frame_metadata(frame, RS2_FRAME_METADATA_ACTUAL_FPS, err)
            checkerror(err)
            value < actual_fps && (actual_fps = value;)
        end
        value = rs2_get_frame_timestamp_domain(frame, err)
        checkerror(err)
        if value == RS2_TIMESTAMP_DOMAIN_HARDWARE_CLOCK
            hw_timestamp_domain = true
        end
        if value == RS2_TIMESTAMP_DOMAIN_SYSTEM_TIME
            system_timestamp_domain = true
        end
        ts = rs2_get_frame_timestamp(frame, err)
        checkerror(err)
        push!(timestemps, ts)
        rs2_release_frame(frame)
    end
    push!(all_timestamps, timestemps)
    rs2_release_frame(frames)
end

for i = 1:30
    frames = rs2_wait_for_frame(frame_queue, 500, err)
    checkerror(err)
    rs2_release_frame(frames)
end

for s in sensors
    rs2_stop(s, err)
    checkerror(err)
    rs2_delete_sensor(s)
end

rs2_delete_frame_queue(frame_queue)
rs2_delete_processing_block(sync)
rs2_delete_device(device)
rs2_delete_device_list(deviceList)
rs2_delete_context(ctx)


@info "Which timestamp domain: " hw_timestamp_domain, system_timestamp_domain
@test hw_timestamp_domain != system_timestamp_domain

num_of_partial_sync_sets = 0
for i in eachindex(all_timestamps)
    set_timestamps = all_timestamps[i]
    length(set_timestamps) < length(profiles[2]) && (num_of_partial_sync_sets += 1;)
    length(set_timestamps) ≤ 1 && continue
    tmin, tmax = extrema(set_timestamps)
    if !(tmax - tmin ≤ 1000/fps)
        @error "tmax - tmin > 1000/fps :", i, set_timestamps
    end
end
@info "Number of partial sync sets: $num_of_partial_sync_sets"

num_of_timestamps = length(all_timestamps)
@info "Number of timestamps: $num_of_timestamps"
@test num_of_partial_sync_sets/num_of_timestamps < 0.9

end
