using RealSense.LibRealSense
using Test

err = Ref{Ptr{rs2_error}}(0)

ctx = rs2_create_context(RS2_API_VERSION, err)
@test err[] == C_NULL

device_list = rs2_query_devices(ctx, err)
@test err[] == C_NULL

dev_count = rs2_get_device_count(device_list, err)
@test err[] == C_NULL
println("There are $dev_count connected RealSense devices.")

rs2_delete_device_list(device_list)
rs2_delete_context(ctx)
