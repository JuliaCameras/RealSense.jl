using ModernGL, GLFW
using MicroLogging

# GLFW callbacks
error_callback(error::Cint, description::Ptr{GLchar}) = error("GLFW ERROR: code $error msg: $description")
function window_size_callback(window::GLFW.Window, width::Cint, height::Cint)
    global glfwWidth = width
    global glfwHeight = height
    return nothing
end

function create_window_context(width, height)
    @static if is_apple()
        GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 4)
        GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 1)
        GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE)
        GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, true)
    else
        GLFW.DefaultWindowHints()
    end
    # create window
    window = GLFW.CreateWindow(width, height, "Initializing...")
    window == C_NULL && error("could not open window with GLFW3.")
    # set callbacks
    GLFW.SetErrorCallback(error_callback)
    GLFW.SetWindowSizeCallback(window, window_size_callback)
    GLFW.MakeContextCurrent(window)
    GLFW.WindowHint(GLFW.SAMPLES, 4)
    return window
end

let previousTime = time()
    frameCount = 0
    global function updatefps!(window::GLFW.Window)
        currentTime = time()
        elapsedTime = currentTime - previousTime
        if elapsedTime > 0.25
            previousTime = currentTime
            fps = frameCount / elapsedTime
            s = @sprintf "RealSense @ fps: %.2f" fps
            GLFW.SetWindowTitle(window, s)
            frameCount = 0
        end
        frameCount = frameCount + 1
    end
end

function mipmap()
    glGenerateMipmap(GL_TEXTURE_2D)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR)
end


# shader program
function shaderinfo(shaderID::GLuint)
    maxLength = Ref{GLsizei}(0)
    glGetShaderiv(shaderID, GL_INFO_LOG_LENGTH, maxLength)
    actualLength = Ref{GLsizei}(0)
    log = Vector{GLchar}(maxLength[])
    glGetShaderInfoLog(shaderID, maxLength[], actualLength, log)
    @info "Shader $shaderID info log: \n $(String(log))"
end

function compileshader(source::AbstractString, shaderType::GLenum)
    @info "Compiling GLSL shader from $source..."
    shader = readstring(source)
    shaderID = glCreateShader(shaderType)
    glShaderSource(shaderID, 1, Ptr{GLchar}[pointer(shader)], C_NULL)
    glCompileShader(shaderID)
    shaderTypeName = GLENUM(shaderType).name
    # get shader compile status
    compileResult = Ref{GLint}(-1)
    glGetShaderiv(shaderID, GL_COMPILE_STATUS, compileResult)
    shaderinfo(shaderID)
    compileResult[] == GL_FALSE && error("$shaderTypeName $shaderID did not compile!")
    @info "$shaderTypeName $shaderID compiled successfully."
    return shaderID
end

function programinfo(programID::GLuint)
    maxLength = Ref{GLsizei}(0)
    glGetProgramiv(programID, GL_INFO_LOG_LENGTH, maxLength)
    actualLength = Ref{GLsizei}(0)
    log = Vector{GLchar}(maxLength[])
    glGetProgramInfoLog(programID, maxLength[], actualLength, log)
    @info "Program $programID info log: \n $(String(log))"
end

function program_verbose_info(programID::GLuint)
    result = Ref{GLint}(-1)
    @debug "Program $programID verbose info:"
    glGetProgramiv(programID, GL_LINK_STATUS, result)
    @debug "GL_LINK_STATUS = $(result[])"
    glGetProgramiv(programID, GL_ATTACHED_SHADERS, result)
    @debug "GL_ATTACHED_SHADERS = $(result[])"
    glGetProgramiv(programID, GL_ACTIVE_ATTRIBUTES, result)
    @debug "GL_ACTIVE_ATTRIBUTES = $(result[])"
    for i in 0:result[]-1
        maxLength = Ref{GLsizei}(0)
        glGetProgramiv(programID, GL_ACTIVE_ATTRIBUTE_MAX_LENGTH, maxLength)
        actualLength = Ref{GLsizei}(0)
        attributeSize = Ref{GLint}(0)
        attributeType = Ref{GLenum}(0)
        name = Vector{GLchar}(maxLength[])
        glGetActiveAttrib(programID, i, maxLength[], actualLength, attributeSize, attributeType, name)
        attributeTypeName = GLENUM(attributeType[]).name
        if attributeSize[] > 1
            for j = 1:attributeSize[]
                longName = @sprintf "%s[%i]" name j
                location = glGetAttribLocation(programID, longName)
                @debug "  $attributeTypeName $(String(longName)) at location $location"
            end
        else
            location = glGetAttribLocation(programID, name)
            @debug "  $attributeTypeName $(String(name)) at location $location"
        end
    end
    glGetProgramiv(programID, GL_ACTIVE_UNIFORMS, result)
    @debug "GL_ACTIVE_UNIFORMS = $(result[])"
    for i in 0:result[]-1
        maxLength = Ref{GLsizei}(0)
        glGetProgramiv(programID, GL_ACTIVE_UNIFORM_MAX_LENGTH, maxLength)
        actualLength = Ref{GLsizei}(0)
        attributeSize = Ref{GLint}(0)
        attributeType = Ref{GLenum}(0)
        name = Vector{GLchar}(maxLength[])
        glGetActiveUniform(programID, i, maxLength[], actualLength, attributeSize, attributeType, name)
        attributeTypeName = GLENUM(attributeType[]).name
        if attributeSize[] > 1
            for j = 1:attributeSize[]
                longName = @sprintf "%s[%i]" name j
                location = glGetUniformLocation(programID, longName)
                @debug "  $attributeTypeName $(String(longName)) at location $location"
            end
        else
            location = glGetUniformLocation(programID, name)
            @debug "  $attributeTypeName $(String(name)) at location $location"
        end
    end
    programinfo(programID)
end

function validateprogram(programID::GLuint)
    validResult = Ref{GLint}(-1)
    glValidateProgram(programID)
    glGetProgramiv(programID, GL_VALIDATE_STATUS, validResult)
    @info "Program $programID: GL_VALIDATE_STATUS = $(validResult[])"
    program_verbose_info(programID)
    validResult[] == GL_FALSE && return false
    @info "Program $programID created successfully."
    return true
end

function createprogram(vertID::GLuint, fragID::GLuint)
    programID = glCreateProgram()
    @info "Creating program $programID..."
    @info "Attaching shaders: $vertID and $fragID..."
    glAttachShader(programID, vertID)
    glAttachShader(programID, fragID)
    glLinkProgram(programID)
    # checkout programe linking status
    linkingResult = Ref{GLint}(-1)
    glGetProgramiv(programID, GL_LINK_STATUS, linkingResult)
    linkingResult[] == GL_FALSE && @error "Program $programID did not created!"
    @assert validateprogram(programID)
    glDeleteShader(vertID)
    glDeleteShader(fragID)
    return programID
end

function createprogram(vertSource::AbstractString, fragSource::AbstractString)
    vertexShader = compileshader(vertSource, GL_VERTEX_SHADER)
    fragmentShader = compileshader(fragSource, GL_FRAGMENT_SHADER)
    return createprogram(vertexShader, fragmentShader)
end
