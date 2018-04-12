# This script is tweaked from https://github.com/JuliaGPU/VulkanCore.jl/blob/master/gen/generator.jl.
using Clang.wrap_c
using Clang.cindex

llvmcfg = "llvm-config"

@static if is_apple()
    using Homebrew
    !Homebrew.installed("llvm") && Homebrew.add("llvm")
    llvmcfg = joinpath(Homebrew.prefix(), "opt/llvm/bin/llvm-config")
end

const LLVM_VERSION = readchomp(`$llvmcfg --version`)
const LLVM_LIBDIR  = readchomp(`$llvmcfg --libdir`)
const LLVM_INCLUDE = joinpath(LLVM_LIBDIR, "clang", LLVM_VERSION, "include")

# since the SDK repo is a little bit large, we only clone the source code at a specific version
include(joinpath(@__DIR__, "..", "deps", "version.jl"))
librealsenseDIR = joinpath(@__DIR__, "librealsense")
if !isdir(librealsenseDIR)
    run(`git clone --branch v$LIBREALSENSE_VERSION --depth 1 https://github.com/IntelRealSense/librealsense.git $librealsenseDIR`)
elseif readchomp(`git -C $librealsenseDIR rev-parse HEAD`) != LIBREALSENSE_SHA
    rm(librealsenseDIR, force=true, recursive=true)
    run(`git clone --branch v$LIBREALSENSE_VERSION --depth 1 https://github.com/IntelRealSense/librealsense.git $librealsenseDIR`)
end

const FT_INCLUDE = joinpath(@__DIR__, "librealsense", "include", "librealsense2") |> normpath
const FT_HEADERS = [joinpath(root, file) for (root, dirs, files) in walkdir(FT_INCLUDE) for file in files if endswith(file, ".h")]

# These rewriters are taken from CUDArt.jl
function rewriter(ex :: Expr)
  # Empty types get converted to Void
  # This is important for opaque handles
  if ex.head == :type
    a3 = ex.args[3]
    if isempty(a3.args)
      objname = ex.args[2]
      return :($objname = Void)
    end
  end

  # Early exit for everything but functions
  ex.head == :function || return ex

  decl, body = ex.args[1], ex.args[2]
  # omit types from function prototypes
  for i = 2:length(decl.args)
    a = decl.args[i]
    # a can be a symbol (and thus already have no type information attached)
    if !(typeof(a) == Symbol) && a.head == :(::)
      decl.args[i] = a.args[1]
    end
  end

  return ex
end

rewriter(A::Array) = [rewriter(a) for a in A]

rewriter(arg) = arg

function wrap_header(top_hdr::String, cursor_header::String)
    startswith(dirname(cursor_header), FT_INCLUDE) && (top_hdr == cursor_header)
end

wc = wrap_c.init(;
                headers = FT_HEADERS,
                output_file = joinpath(@__DIR__, "api", "rs2_api.jl"),
                common_file = joinpath(@__DIR__, "api", "rs2_common.jl"),
                clang_includes = vcat(LLVM_INCLUDE, FT_INCLUDE),
                header_wrapped = wrap_header,
                header_library = x->"librealsense2",
                clang_diagnostics = true,
                rewriter=rewriter)

# wrap_structs, immutable_structs
wc.options = wrap_c.InternalOptions(true, true)
run(wc)
