# this example is translated from https://github.com/IntelRealSense/librealsense/blob/master/examples/C/depth/rs-color.c
using RealSense
using Images

const STREAM            = RS2_STREAM_COLOR      # rs2_stream is a types of data provided by RealSense device
const FORMAT            = RS2_FORMAT_RGB8       # rs2_format is identifies how binary data is encoded within a frame
const WIDTH             = 640                   # defines the number of columns for each frame
const HEIGHT            = 480                   # defines the number of lines for each frame
const FPS               = 30                    # defines the rate of frames per second
const STREAM_INDEX      = 0                     # defines the stream index, used for multiple streams of the same type

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
    device_info = unsafe_string(rs2_get_device_info(dev, RS2_CAMERA_INFO_NAME, err))
    println("\nUsing device 0, an $device_info")
    check_error(err)
    device_info = unsafe_string(rs2_get_device_info(dev, RS2_CAMERA_INFO_SERIAL_NUMBER, err))
    println("    Serial number: $device_info")
    check_error(err)
    device_info = unsafe_string(rs2_get_device_info(dev, RS2_CAMERA_INFO_FIRMWARE_VERSION, err))
    println("    Firmware version: $device_info")
    check_error(err)
end


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
pipeline = rs2_create_pipeline(ctx, err)
check_error(err)

# create a config instance
config = rs2_create_config(err)
check_error(err)

# request a specific configuration
rs2_config_enable_stream(config, STREAM, STREAM_INDEX, WIDTH, HEIGHT, FORMAT, FPS, err)
check_error(err)

# start the pipeline streaming
pipeline_profile = rs2_pipeline_start_with_config(pipeline, config, err)
@assert err[] == C_NULL "The connected device doesn't support color streaming!"

frames = rs2_pipeline_wait_for_frames(pipeline, 5000, err)
check_error(err)

# returns the number of frames embedded within the composite frame
num_of_frames = rs2_embedded_frames_count(frames, err)
check_error(err)

imgDepth = zeros(UInt16, WIDTH, HEIGHT)
for i = 0:num_of_frames-1
    # the retunred object should be released with rs2_release_frame(...)
    frame = rs2_extract_frame(frames, i, err)
    check_error(err)

    # retrieve depth data, configured as 16-bit depth values
    rgb_frame_data = Ptr{UInt8}(rs2_get_frame_data(frame, err))
    check_error(err)
    imgRGB = unsafe_wrap(Array, rgb_frame_data, (WIDTH,HEIGHT))

    frame_number = rs2_get_frame_number(frame, err)
    check_error(err)

    frame_timestamp = rs2_get_frame_timestamp(frame, err)
    check_error(err)

    frame_timestamp_domain = rs2_get_frame_timestamp_domain(frame, err)
    check_error(err)
    frame_timestamp_domain_str = unsafe_string(rs2_timestamp_domain_to_string(frame_timestamp_domain))
    frame_metadata_time_of_arrival = rs2_get_frame_metadata(frame, RS2_FRAME_METADATA_TIME_OF_ARRIVAL, err)
    check_error(err)

    println("RGB frame arrived.")
    println("First 10 bytes: $(imgRGB[1:10])")
    println("Frame No.$frame_number")
    println("Timestamp: $frame_timestamp")
    println("Timestamp domain: $frame_timestamp_domain_str")
    println("Time of arrival: $frame_metadata_time_of_arrival")

    rs2_release_frame(frame)
end

rs2_release_frame(frames)

# stop the pipeline streaming
rs2_pipeline_stop(pipeline, err)
check_error(err)

# release resources
rs2_delete_pipeline_profile(pipeline_profile)
rs2_delete_config(config)
rs2_delete_pipeline(pipeline)
rs2_delete_device(dev)
rs2_delete_device_list(device_list)
rs2_delete_context(ctx)
