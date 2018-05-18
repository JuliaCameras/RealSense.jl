using RealSense

include("rs-utils.jl")

err = Ref{Ptr{rs2_error}}(C_NULL)

ctx = rs2_create_context(RS2_API_VERSION, err)
checkerror(err)

device = get_a_realsense_device(ctx)
print_device_information(device)

@info "Please choose a sensor and then a stream that will be used as the origin of extrinsic transformation:"
from_sensor = get_a_sensor_from_a_device(device)
from = choose_a_streaming_profile(from_sensor)

@info "Please choose a sensor and then a stream that will be used as the target of extrinsic transformation:"
to_sensor = get_a_sensor_from_a_device(device)
to = choose_a_streaming_profile(to_sensor)

extrinsicsRef = Ref{rs2_extrinsics}(rs2_extrinsics(ntuple(x->0,Val{9}),(0,0,0)))
rs2_get_extrinsics(from, to, extrinsicsRef, err)
checkerror(err)

extrinsics = extrinsicsRef[]
@info "Rotation Matrix: "
@info extrinsics.rotation[1:3]
@info extrinsics.rotation[4:6]
@info extrinsics.rotation[7:9]
@info "Translation Vector: " extrinsics.translation
