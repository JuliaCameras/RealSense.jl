import Libdl

@info "This package assumes you've already installed Intel RealSense SDK 2.0 on Windows."
const WINDOWS_SDK_DIR = joinpath(homedir(), "..", "..", "Program Files (x86)") |> normpath
const WINDOWS_DEFAULT_DIR = Sys.WORD_SIZE == 64 ? joinpath(WINDOWS_SDK_DIR, "Intel RealSense SDK 2.0", "bin", "x64") : joinpath(WINDOWS_SDK_DIR, "Intel RealSense SDK 2.0", "bin", "x86")
# possible shared library locations, you could also add yours if you installed the SDK in other place
locations = [WINDOWS_DEFAULT_DIR]
# try to find the lib
lib = Libdl.find_library(["realsense2"], locations)
if lib == ""
    error("Couldn't find realsense2.dll in the default directory $WINDOWS_DEFAULT_DIR. Please install Intel RealSense SDK 2.0 and then run Pkg.build(\"LibRealSense\").")
else
    const librealsense = Libdl.dlpath(lib) |> x->replace(x, "\\"=>"\\\\")
end


open(joinpath(@__DIR__, "deps.jl"), "w") do f
    println(f, """
    import Libdl

    const LIBREALSENSE_VERSION = v"2.15.0"
    const librealsense2 = "$librealsense"

    function check_deps()
        global librealsense2
        if !isfile(librealsense2)
            error("\$(librealsense2) does not exist, Please re-run Pkg.build(\\"LibRealSense\\"), and restart Julia.")
        end

        hdl = Libdl.dlopen_e(librealsense2)
        if hdl == C_NULL
            error("\$(librealsense2) cannot be opened, Please re-run Pkg.build(\\"LibRealSense\\"), and restart Julia.")
        else
            get_api_version = Libdl.dlsym_e(hdl, :rs2_get_api_version)
            @assert get_api_version != C_NULL "Could not find `rs2_get_api_version` within \$(librealsense2)."
            err = Ref{Ptr{Cvoid}}(0)
            version = ccall(get_api_version, Cint, (Ptr{Ptr{Cvoid}},), err)
            @assert err[] == C_NULL "Something happened when calling `rs2_get_api_version`."
            major = version ÷ 10000
            minor = (version - 10000*major) ÷ 100
            patch = (version - 10000*major - 100*minor)
            if major != LIBREALSENSE_VERSION.major && minor != LIBREALSENSE_VERSION.minor
                error(\"\"\"API version mismatch:
                      The system librealsense's API version is v\$(major).\$(minor).\$(patch), but the one used in LibRealSense.jl is \$(LIBREALSENSE_VERSION).
                      Please either upgrade Intel RealSense SDK or LibRealSense.jl.\"\"\")
            end
        end
    end
    """)
end
