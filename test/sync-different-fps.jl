@testset "Sync different fps" begin

err = Ref{Ptr{rs2_error}}(0)

filename = joinpath(@__DIR__, "d415_fw_5.9.8_USB3_single.rec")
section = "Sync__different__fps.1.test"
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

sensors = query_sensors(device)
for s in sensors
    result = rs2_supports_option(s, RS2_OPTION_EXPOSURE, err)
    checkerror(err)
    if result > 0
        minRef, maxRef, stepRef, defRef = Ref{Cfloat}(0), Ref{Cfloat}(0), Ref{Cfloat}(0), Ref{Cfloat}(0)
        rs2_get_option_range(s, RS2_OPTION_EXPOSURE, minRef, maxRef, stepRef, defRef, err)
        checkerror(err)
        rs2_set_option(s, RS2_OPTION_EXPOSURE, minRef[], err)
        checkerror(err)
    end
end

fps_step = 30
fps = zeros(length(sensors))
for i = 1:length(fps)
    fps[i] = (length(fps) - i) * fps_step % 90 + fps_step
end

frame_queue = rs2_create_frame_queue(1, err)
checkerror(err)
sync = rs2_create_sync_processing_block(err)
checkerror(err)
rs2_start_processing_queue(sync, frame_queue, err)
checkerror(err)

profiles2sensors = Dict{rs2_stream,Ptr{rs2_sensor}}()
sensors2profiles = Dict{Ptr{rs2_sensor},rs2_stream}()
for i = 1:length(sensors)
    profs = configure_all_supported_profiles(sensors[i], 640, 480, fps[i])
    for p in profs
        profiles2sensors[p.stream] = sensors[i]
        sensors2profiles[sensors[i]] = p.stream
    end
    if length(profs) > 0
        rs2_start(sensors[i], on_frame_ptr, sync, err)
        checkerror(err)
    end
end
streams_groups = []
for i = 1:length(sensors)
    group = Set{Ptr{rs2_sensor}}()
    for j = 1:length(sensors)
        if fps[j] / fps[i] ≥ 1
            push!(group, sensors[j])
        end
    end
    push!(streams_groups, group)
end

frames_arrived = []
for i = 1:200
    frames = rs2_wait_for_frame(frame_queue, 5000, err)
    checkerror(err)
    is_extendable = rs2_is_frame_extendable_to(frames, RS2_EXTENSION_COMPOSITE_FRAME, err)
    checkerror(err)
    @test is_extendable > 0
    num_of_frames = rs2_embedded_frames_count(frames, err)
    checkerror(err)
    @test num_of_frames > 0

    streams_arrived = Vector{rs2_stream}()
    for j = 0:num_of_frames-1
        frame = rs2_extract_frame(frames, j, err)
        checkerror(err)
        profile = rs2_get_frame_stream_profile(frame, err)
        checkerror(err)
        formatRef, typeRef = Ref{rs2_format}(0), Ref{rs2_stream}(0)
        indexRef, uidRef, framerateRef = Ref{Cint}(0), Ref{Cint}(0), Ref{Cint}(0)
        rs2_get_stream_profile_data(profile, typeRef, formatRef, indexRef, uidRef, framerateRef, err)
        checkerror(err)
        push!(streams_arrived, typeRef[])
        rs2_release_frame(frame)
    end
    push!(frames_arrived, streams_arrived)
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


streams_groups_arrived = zeros(Int,length(streams_groups))
for streams in frames_arrived
    stream_group = Set()
    for s in streams
        push!(stream_group, profiles2sensors[s])
    end
    idx = find(stream_group .== streams_groups)
    isempty(idx) && continue
    streams_groups_arrived[idx[]] += 1
end

arrivedLen = length(streams_groups_arrived)
for i = 1:arrivedLen, j = 1:arrivedLen
    @test streams_groups_arrived[j] > 0
    num1 = streams_groups_arrived[i]
    num2 = streams_groups_arrived[j]
    @info "sensor: ", sensors2profiles[sensors[i]], "  num:", num1
    @info "sensor: ", sensors2profiles[sensors[j]], "  num:", num2
    @test num1 / num2 ≤ 5 * fps[i] / fps[j]
end

end
