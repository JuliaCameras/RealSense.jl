using RealSense
using Base.Test

err = Ref{Ptr{rs2_error}}(0)
ctx = rs2_create_context(RS2_API_VERSION, err)
@test err[] == C_NULL
rs2_delete_context(ctx)
