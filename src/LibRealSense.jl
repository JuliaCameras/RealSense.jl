module LibRealSense

const LIBREALSENSE_VERSION = v"2.31.1"

@static if Sys.iswindows()
    import Libdl

    const WINDOWS_SDK_DIR = joinpath(homedir(), "..", "..", "Program Files (x86)") |> normpath
    const WINDOWS_DEFAULT_DIR = Sys.WORD_SIZE == 64 ? joinpath(WINDOWS_SDK_DIR, "Intel RealSense SDK 2.0", "bin", "x64") : joinpath(WINDOWS_SDK_DIR, "Intel RealSense SDK 2.0", "bin", "x86")
    # try to find the lib
    libdir =  get(ENV, "JULIA_LIBREALSENSE_PATH", WINDOWS_DEFAULT_DIR)
    lib = Libdl.find_library(["realsense2"], [libdir])
    lib == "" && error("Couldn't find realsense2.dll in $libdir. Please install Intel RealSense SDK 2.0 or set environment variable `JULIA_LIBREALSENSE_PATH`.")
    const librealsense2 = Libdl.dlpath(lib) |> x->replace(x, "\\"=>"\\\\")
    !isfile(librealsense2) && error("$librealsense2 does not exist.")

    hdl = Libdl.dlopen_e(librealsense2)
    if hdl == C_NULL
        error("$librealsense2 cannot be opened.")
    else
        get_api_version = Libdl.dlsym_e(hdl, :rs2_get_api_version)
        @assert get_api_version != C_NULL "Could not find `rs2_get_api_version` within $librealsense2."
        err = Ref{Ptr{Cvoid}}(0)
        version = ccall(get_api_version, Cint, (Ptr{Ptr{Cvoid}},), err)
        @assert err[] == C_NULL "Something happened when calling `rs2_get_api_version`."
        major = version ÷ 10000
        minor = (version - 10000*major) ÷ 100
        patch = (version - 10000*major - 100*minor)
        if major != LIBREALSENSE_VERSION.major && minor != LIBREALSENSE_VERSION.minor
            @warn("""API version mismatch:
                  The system librealsense's API version is v$(major).$(minor).$(patch), but the one used in RealSense.jl is $LIBREALSENSE_VERSION.
                  Please either upgrade Intel RealSense SDK or RealSense.jl.""")
        end
    end
else
    using librealsense_jll
    export librealsense_jll
end

using CSyntax.CEnum

const Ctm = Base.Libc.TmStruct
const Ctime_t = UInt
const Cclock_t = UInt
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
