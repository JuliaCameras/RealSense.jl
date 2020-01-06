# RealSense

Julia wrapper for [Intel RealSense SDK](https://github.com/IntelRealSense/librealsense), a cross-platform library for Intel® RealSense™ depth cameras (D400 series and the SR300).  

## Installation
This package is not officially registered, yet.
```julia
pkg> add https://github.com/JuliaPerception/LibRealSense.jl.git
```
Note that, you should install [Intel RealSense SDK](https://github.com/IntelRealSense/librealsense) firstly if you're on Windows.

## Usage
The interface is exactly the same as librealsense's C API. The example below is translated from [here](https://github.com/IntelRealSense/librealsense/blob/master/examples/C/depth/rs-depth.c).
The Julia code is very similar to C, but it's more concise and convenient to work with arrays
and other high-level packages. More examples can be found in the `examples` folder.
