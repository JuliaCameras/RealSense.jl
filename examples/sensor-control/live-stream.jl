using RealSense

include("rs-utils.jl")

err = Ref{Ptr{rs2_error}}(C_NULL)
# create a context
ctx = rs2_create_context(RS2_API_VERSION, err)
checkerror(err)

device = get_a_realsense_device(ctx)
print_device_information(device)

sensor = get_a_sensor_from_a_device(device)

profile = choose_a_streaming_profile(sensor)
