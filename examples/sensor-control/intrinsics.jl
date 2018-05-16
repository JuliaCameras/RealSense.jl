using RealSense

include("rs-utils.jl")

err = Ref{Ptr{rs2_error}}(C_NULL)

ctx = rs2_create_context(RS2_API_VERSION, err)
checkerror(err)

device = get_a_realsense_device(ctx)
print_device_information(device)

sensor = get_a_sensor_from_a_device(device)

profile = choose_a_streaming_profile(sensor)

is_extendable = rs2_stream_profile_is(profile, RS2_EXTENSION_VIDEO_PROFILE, err)
checkerror(err)
if is_extendable > 0
    intrinsicsRef = Ref{rs2_intrinsics}(rs2_intrinsics(0,0,0,0,0,0,0,(-1,-1,-1,-1,-1)))
    rs2_get_video_stream_intrinsics(profile, intrinsicsRef, err)
    checkerror(err)
    intrinsics = intrinsicsRef[]
    @info "Principal Point: $(intrinsics.ppx), $(intrinsics.ppy)"
    @info "Focal Length: $(intrinsics.fx), $(intrinsics.fy)"
    @info "Distortion Model: $(intrinsics.model)"
    @info "Distortion Coefficients: " intrinsics.coeffs
end

is_extendable = rs2_stream_profile_is(profile, RS2_EXTENSION_MOTION_PROFILE, err)
checkerror(err)
if is_extendable > 0
    intrinsicsRef = Ref{rs2_motion_device_intrinsic}(rs2_motion_device_intrinsic(ntuple(x->ntuple(x->0,Val{4}),Val{3}), ntuple(x->0,Val{3}), ntuple(x->0,Val{3})))
    rs2_get_motion_intrinsics(profile, intrinsicsRef, err)
    checkerror(err)
    intrinsics = intrinsicsRef[]
    println(" Scale X      cross axis      cross axis  Bias X")
    println(" cross axis    Scale Y        cross axis  Bias Y")
    println(" cross axis    cross axis     Scale Z     Bias Z")
    for i in intrinsics.data
        for j in i
            print("  $j    ")
        end
        print("\n")
    end
    println("Variance of noise for X, Y, Z axis:")
    @info intrinsics.noise_variances
    println("Variance of bias for X, Y, Z axis:")
    @info intrinsics.bias_variances
end

rs2_delete_sensor(sensor)
rs2_delete_device(device)
rs2_delete_context(ctx)
