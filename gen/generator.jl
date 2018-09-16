using Clang.wrap_c
using Clang.cindex
import Clang.LLVM_CONFIG

const LLVM_VERSION = readchomp(`$LLVM_CONFIG --version`)
const LLVM_LIBDIR  = readchomp(`$LLVM_CONFIG --libdir`)
const LLVM_INCLUDE = joinpath(LLVM_LIBDIR, "clang", LLVM_VERSION, "include")

const RS_INCLUDE = joinpath(@__DIR__, "..", "deps", "usr", "include", "librealsense2") |> normpath
const RS_HEADERS = [joinpath(RS_INCLUDE, cHeader) for cHeader in readdir(RS_INCLUDE) if endswith(cHeader, ".h")]

function rewriter(ex::Expr)
    if Meta.isexpr(ex, :struct)
        block = ex.args[3]
        isempty(block.args) && (typename = ex.args[2]; return :(const $typename = Cvoid);)
    end
    Meta.isexpr(ex, :function) || return ex
    signature = ex.args[1]
    for i = 2:length(signature.args)
        func_arg = signature.args[i]
        if !(func_arg isa Symbol) && Meta.isexpr(func_arg, :(::))
            signature.args[i] = func_arg.args[1]
        end
    end
    return ex
end
rewriter(A::Array) = [rewriter(a) for a in A]
rewriter(arg) = arg

wrap_header(top_hdr::String, cursor_header::String) = startswith(dirname(cursor_header), RS_INCLUDE) && (top_hdr == cursor_header)

wc = wrap_c.init(; headers = RS_HEADERS,
                   output_file = joinpath(@__DIR__, "api", "rs2_api.jl"),
                   common_file = joinpath(@__DIR__, "api", "rs2_common.jl"),
                   clang_includes = vcat(LLVM_INCLUDE, RS_INCLUDE),
                   header_wrapped = wrap_header,
                   header_library = x->"librealsense2",
                   clang_diagnostics = true,
                   rewriter = rewriter)

run(wc)
