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

include(joinpath(@__DIR__, "..", "gen", "api", "rs2_common.jl"))
include(joinpath(@__DIR__, "..", "gen", "api", "rs2_api.jl"))

include("export.jl")

end # module
