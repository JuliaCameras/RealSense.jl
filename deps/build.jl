include(joinpath(@__DIR__, "..", "deps", "version.jl"))

@static if is_windows()
    info("This package assumes you've already installed Intel RealSense SDK 2.0.")
    const WINDOWS_SDK_DIR = joinpath(homedir(), "..", "..", "Program Files (x86)") |> normpath
    const WINDOWS_DLL_DIR = joinpath(WINDOWS_SDK_DIR, "Intel RealSense SDK 2.0", "bin", "x$(Sys.WORD_SIZE)")
    # possible shared library locations, you could also add yours here
    locations = [WINDOWS_DLL_DIR]
    # try to find the lib
    lib = Libdl.find_library(["realsense2"], locations)
    if lib == ""
        error("Couldn't find realsense2.dll in the path $WINDOWS_DLL_DIR. Please install Intel RealSense SDK 2.0 and then run Pkg.build(\"RealSense\").")
    else
        const librealsense = Libdl.dlpath(lib) |> x->replace(x, "\\", "\\\\")
    end
end

@static if is_apple()
    const HOMEBREW = "/usr/local/Homebrew/bin/brew"
    const MACOS_LIB_DIR = joinpath("usr", "local", "lib")
    # possible shared library locations, you could also add yours here
    locations = [MACOS_LIB_DIR]
    # try to find the lib
    lib = Libdl.find_library(["librealsense2"], locations)
    if lib == ""
        warn("Couldn't find librealsense2.dylib in the path $MACOS_LIB_DIR. Attempting to install Intel RealSense SDK 2.0 locally.")
        # clone SDK source code locally
        librealsenseDIR = joinpath(@__DIR__, "librealsense")
        if !isdir(librealsenseDIR)
            run(`git clone --branch v$LIBREALSENSE_VERSION --depth 1 https://github.com/IntelRealSense/librealsense.git $librealsenseDIR`)
        elseif readchomp(`git -C $librealsenseDIR rev-parse HEAD`) != LIBREALSENSE_SHA
            rm(librealsenseDIR, force=true, recursive=true)
            run(`git clone --branch v$LIBREALSENSE_VERSION --depth 1 https://github.com/IntelRealSense/librealsense.git $librealsenseDIR`)
        end
        # install dependencies
        if success(`$HOMEBREW list`)
            info("Attempting to install Intel RealSense SDK 2.0 via homebrew...")
            !success(`$HOMEBREW ls libusb`) && run(`$HOMEBREW install libusb`)
            !success(`$HOMEBREW ls pkg-config`) && run(`$HOMEBREW install pkg-config`)
            !success(`$HOMEBREW ls glfw`) && run(`$HOMEBREW install glfw`)
            !success(`$HOMEBREW ls cmake`) && run(`$HOMEBREW install cmake`)
        else
            error("Couldn't find homebrew. Please install homebrew from this link: https://brew.sh and then run Pkg.build(\"RealSense\").")
        end
        # build
        buildDIR = joinpath(librealsenseDIR, "build")
        rm(buildDIR, force=true, recursive=true)
        mkdir(buildDIR)
        cd(buildDIR)
        run(`cmake .. -DBUILD_EXAMPLES=false -DBUILD_GRAPHICAL_EXAMPLES=false -DBUILD_UNIT_TESTS=false -DBUILD_WITH_OPENMP=false -DHWM_OVER_XU=false`)
        run(`make -j$(Sys.CPU_CORES)`)
        const librealsense = joinpath(buildDIR, "librealsense2.dylib")
    else
        const librealsense = Libdl.dlpath(lib)
    end
end


@static if is_linux()

end


open(joinpath(@__DIR__, "deps.jl"), "w") do f
    println(f, """
    include("version.jl")

    const librealsense2 = "$librealsense"

    function check_deps()
        global librealsense2
        if !isfile(librealsense2)
            error("\$(librealsense2) does not exist, Please re-run Pkg.build(\\"RealSense\\"), and restart Julia.")
        end

        hdl = Libdl.dlopen_e(librealsense2)
        if hdl == C_NULL
            error("\$(librealsense2) cannot be opened, Please re-run Pkg.build(\\"RealSense\\"), and restart Julia.")
        else
            get_api_version = Libdl.dlsym_e(hdl, :rs2_get_api_version)
            @assert get_api_version != C_NULL "Could not find `rs2_get_api_version` within \$(librealsense2)."
            err = Ref{Ptr{Void}}(0)
            version = ccall(get_api_version, Cint, (Ptr{Ptr{Void}},), err)
            @assert err[] == C_NULL "Something happened when calling `rs2_get_api_version`."
            major = version ÷ 10000
            minor = (version - 10000*major) ÷ 100
            patch = (version - 10000*major - 100*minor)
            if major != LIBREALSENSE_VERSION.major && minor != LIBREALSENSE_VERSION.minor
                error(\"\"\"API version mismatch:
                      The librealsense's API version is v\$(major).\$(minor).\$(patch), but the one used in RealSense.jl is \$(LIBREALSENSE_VERSION).
                      Please either upgrade Intel RealSense SDK or RealSense.jl.\"\"\")
            end
        end
    end
    """)
end
