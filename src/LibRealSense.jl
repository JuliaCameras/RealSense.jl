module LibRealSense

# Load in `deps.jl`, complaining if it does not exist
const depsjl_path = joinpath(@__DIR__, "..", "deps", "deps.jl")
if !isfile(depsjl_path)
    error("LibRealSense was not build properly. Please run Pkg.build(\"LibRealSense\").")
end
include(depsjl_path)

# Module initialization function
function __init__()
    check_deps()
end

include("CEnum.jl")
using .CEnum

include("ctypes.jl")
export Ctm, Ctime_t, Cclock_t

include(joinpath(@__DIR__, "..", "gen", "rs2_common.jl"))
include(joinpath(@__DIR__, "..", "gen", "rs2_api.jl"))

foreach(names(@__MODULE__, all=true)) do s
    if startswith(string(s), "rs2_") || startswith(string(s), "RS2_")
        @eval export $s
    end
end

const RS2_API_VERSION = RS2_API_MAJOR_VERSION * 10000 + RS2_API_MINOR_VERSION * 100 + RS2_API_PATCH_VERSION
const RS2_API_VERSION_STR = "$(RS2_API_MAJOR_VERSION).$(RS2_API_MINOR_VERSION).$(RS2_API_PATCH_VERSION)"

export RS2_API_VERSION, RS2_API_VERSION_STR


end # module
