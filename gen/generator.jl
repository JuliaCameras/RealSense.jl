using Clang.Generators
using librealsense_jll

# cd(@__DIR__)
cd("/home/user/.julia/packages/RealSense/RzHVf/gen")

include_dir = joinpath(librealsense_jll.artifact_dir, "include") |> normpath

const RS_INCLUDE = joinpath(include_dir, "librealsense2")
const RS_HEADERS = [joinpath(root, header) for (root, dirs, files) in walkdir(RS_INCLUDE) for header in files if endswith(header, ".h")]

options = load_options(joinpath(@__DIR__, "generator.toml"))


# add compiler flags, e.g. "-DXXXXXXXXX"
args = get_default_args()
push!(args, "-I$include_dir")

ctx = create_context(RS_HEADERS, args, options)

# run generator
build!(ctx)
