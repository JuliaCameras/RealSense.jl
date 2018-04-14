__precompile__(true)

module RealSense

if VERSION >= v"0.7.0-DEV.3382"
    import Libdl
end

# Load in `deps.jl`, complaining if it does not exist
const depsjl_path = joinpath(@__DIR__, "..", "deps", "deps.jl")
if !isfile(depsjl_path)
    error("RealSense was not build properly. Please run Pkg.build(\"RealSense\")")
end
include(depsjl_path)

# Module initialization function
function __init__()
    # Always check your dependencies from `deps.jl`
    check_deps()
end

include("CEnum.jl")
using .CEnum

include(joinpath(@__DIR__, "..", "gen", "api", "rs2_common.jl"))
include(joinpath(@__DIR__, "..", "gen", "api", "rs2_api.jl"))

include("export.jl")

end # module
