module LibRealSense

# Load in `deps.jl`, complaining if it does not exist
const depsjl_path = joinpath(@__DIR__, "..", "deps", "deps.jl")
if !isfile(depsjl_path)
    error("RealSense was not build properly. Please run Pkg.build(\"RealSense\").")
end
include(depsjl_path)

# Module initialization function
function __init__()
    check_deps()
end

const RS2_API_VERSION = RS2_API_MAJOR_VERSION * 10000 + RS2_API_MINOR_VERSION * 100 + RS2_API_PATCH_VERSION
const RS2_API_VERSION_STR = "$(RS2_API_MAJOR_VERSION).$(RS2_API_MINOR_VERSION).$(RS2_API_PATCH_VERSION)"

include(joinpath(@__DIR__, "..", "gen", "api", "rs2_common.jl"))
include(joinpath(@__DIR__, "..", "gen", "api", "rs2_api.jl"))

include("export.jl")

end # module
