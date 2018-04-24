using RealSense
using GLFW, ModernGL

include("rs-utils.jl")

err = Ref{Ptr{rs2_error}}(0)

# create context
ctx = rs2_create_context(RS2_API_VERSION, err)
check_error(err)

# get a list of all the connected devices
device_list = rs2_query_devices(ctx, err)
check_error(err)

dev_count = rs2_get_device_count(device_list, err)
check_error(err)
println("There are $dev_count connected RealSense devices.")

# get the first connected device
dev = rs2_create_device(device_list, 0, err)
print_device_info(dev)

# create pipeline
_pipeline = rs2_create_pipeline(ctx, err)
check_error(err)

# start the pipeline streaming
pipeline_profile = rs2_pipeline_start(_pipeline, err)
@assert err[] == C_NULL "Failed to start pipeline!"

# create Depth-Colorizer processing block that can be used to quickly visualize the depth data
color_map = rs2_create_colorizer(err)
check_error(err)

while true
    frames = rs2_pipeline_wait_for_frames(_pipeline, 5000, err)
    check_error(err)

    # returns the number of frames embedded within the composite frame
    num_of_frames = rs2_embedded_frames_count(frames, err)
    check_error(err)

    for i = 0:num_of_frames-1
        frame = rs2_extract_frame(frames, i, err)
        check_error(err)

        profile = rs2_get_frame_stream_profile(frame, err)
        check_error(err)

        stream = Ref{rs2_stream}(0)
        format = Ref{rs2_format}(0)
        index =  Ref{Cint}(0)
        unique_id = Ref{Cint}(0)
        framerate = Ref{Cint}(0)
        rs2_get_stream_profile_data(profile, stream, format, index, unique_id, framerate, err)
        check_error(err)

        if stream[] == RS2_STREAM_DEPTH
            # colorize the depth data
            rs2_process_frame(color_map, frame, err)
            check_error(err)
            # get data
            depth_data = Ptr{UInt8}(rs2_get_frame_data(frame, err))
            check_error(err)
            width = rs2_get_frame_width(frame, err)
            height = rs2_get_frame_height(frame, err)
            depth = unsafe_wrap(Array, depth_data, 3*width*height)
            println("depth", width)
        elseif stream[] == RS2_STREAM_COLOR
            rgb_data = Ptr{UInt8}(rs2_get_frame_data(frame, err))
            check_error(err)
            width = rs2_get_frame_width(frame, err)
            height = rs2_get_frame_height(frame, err)
            rgb = unsafe_wrap(Array, rgb_data, 3*width*height)
            println("color", width)
        end

        # render

        rs2_release_frame(frame)
    end
    rs2_release_frame(frames)
end

# stop the pipeline streaming
rs2_pipeline_stop(_pipeline, err)
check_error(err)

# release resources
rs2_delete_processing_block(color_map)
rs2_delete_pipeline_profile(pipeline_profile)
rs2_delete_pipeline(_pipeline)
rs2_delete_device(dev)
rs2_delete_device_list(device_list)
rs2_delete_context(ctx)
