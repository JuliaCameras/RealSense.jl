# this example is translated and tweaked from the following link:
# https://github.com/IntelRealSense/librealsense/blob/master/examples/C/distance/rs-distance.c
using RealSense

include("rs-utils.jl")

STREAM        = RS2_STREAM_DEPTH  # rs2_stream is a types of data provided by RealSense device
FORMAT        = RS2_FORMAT_Z16    # rs2_format is identifies how binary data is encoded within a frame
WIDTH         = 640               # defines the number of columns for each frame
HEIGHT        = 480               # defines the number of lines for each frame
FPS           = 30                # defines the rate of frames per second
STREAM_INDEX  = 0                 # defines the stream index, used for multiple streams of the same type

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

# create a config instance
config = rs2_create_config(err)
check_error(err)

# request a specific configuration
rs2_config_enable_stream(config, STREAM, STREAM_INDEX, WIDTH, HEIGHT, FORMAT, FPS, err)
check_error(err)

# start the pipeline streaming
@static if is_apple()
    # we sleep 1s on MacOS, otherwise it will hit issue #1586:
    # https://github.com/IntelRealSense/librealsense/issues/1586
    sleep(1)
end
pipeline_profile = rs2_pipeline_start_with_config(_pipeline, config, err)
@assert err[] == C_NULL "The connected device doesn't support depth streaming!"

while true
    frames = rs2_pipeline_wait_for_frames(_pipeline, 5000, err)
    check_error(err)

    # returns the number of frames embedded within the composite frame
    num_of_frames = rs2_embedded_frames_count(frames, err)
    check_error(err)

    imgDepth = zeros(UInt16, WIDTH, HEIGHT)
    for i = 0:num_of_frames-1
        # the retunred object should be released with rs2_release_frame(...)
        frame = rs2_extract_frame(frames, i, err)
        check_error(err)

        # check if the given frame can be extended to depth frame interface
        # accept only depth frames and skip other frames
        0 == rs2_is_frame_extendable_to(frame, RS2_EXTENSION_DEPTH_FRAME, err) && continue

        # retrieve depth frame's dimensions
        width = rs2_get_frame_width(frame, err)
        check_error(err)
        height = rs2_get_frame_height(frame, err)
        check_error(err)

        dist_to_center = rs2_depth_frame_get_distance(frame, width/2, height/2, err)
        check_error(err)

        println("The camera is facing an object $dist_to_center meters away.")

        rs2_release_frame(frame)
    end
    rs2_release_frame(frames)
end

# stop the pipeline streaming
rs2_pipeline_stop(_pipeline, err)
check_error(err)

# release resources
rs2_delete_pipeline_profile(pipeline_profile)
rs2_delete_config(config)
rs2_delete_pipeline(_pipeline)
rs2_delete_device(dev)
rs2_delete_device_list(device_list)
rs2_delete_context(ctx)
