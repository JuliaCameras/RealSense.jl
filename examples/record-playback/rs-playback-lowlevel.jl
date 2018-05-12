using RealSense

include(joinpath(@__DIR__, "..", "sensor-control", "rs-utils.jl"))
include("gl-utils.jl")

# initialize GLFW window
glfwWidth = 1280
glfwHeight = 720
window = create_window_context(glfwWidth, glfwHeight)

# prepare drawing via OpenGL
window_frame = GLfloat[-1.0,-1.0,   1.0,-1.0,   1.0, 1.0,
                        1.0, 1.0,  -1.0, 1.0,  -1.0,-1.0]
vertex_texcoords = GLfloat[0.0,1.0,  1.0,1.0,  1.0,0.0,
                           1.0,0.0,  0.0,0.0,  0.0,1.0]
# create Vertex Buffer Objects
vbo = Ref{GLuint}(0)
glGenBuffers(1, vbo)
glBindBuffer(GL_ARRAY_BUFFER, vbo[])
glBufferData(GL_ARRAY_BUFFER, sizeof(window_frame), window_frame, GL_STATIC_DRAW)
texcoordsVBO = Ref{GLuint}(0)
glGenBuffers(1, texcoordsVBO)
glBindBuffer(GL_ARRAY_BUFFER, texcoordsVBO[])
glBufferData(GL_ARRAY_BUFFER, sizeof(vertex_texcoords), vertex_texcoords, GL_STATIC_DRAW)
# create Vertex Array Objects
vao = Ref{GLuint}(0)
glGenVertexArrays(1, vao)
glBindVertexArray(vao[])
glBindBuffer(GL_ARRAY_BUFFER, vao[])
glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, C_NULL)
glBindBuffer(GL_ARRAY_BUFFER, texcoordsVBO[])
glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 0, C_NULL)
glEnableVertexAttribArray(0)
glEnableVertexAttribArray(1)
# create shader program
vertSource= joinpath(@__DIR__, "rp.vert")
fragSource = joinpath(@__DIR__, "rp.frag")
shaderProgramID = createprogram(vertSource, fragSource)
# generate texture handle
tex = Ref{GLuint}(0)
glGenTextures(1, tex)


# initialize RealSense camera
err = Ref{Ptr{rs2_error}}(0)
ctx = rs2_create_context(RS2_API_VERSION, err)
checkerror(err)

device = rs2_context_add_device(ctx, joinpath(@__DIR__, "a.bag"), err)
checkerror(err)
print_device_information(device)

sensor = get_a_sensor_from_a_device(device)

profile = choose_a_streaming_profile(sensor)
sleep(1)

function on_frame_callback(f::Ptr{rs2_frame}, u::Ptr{Void})
    rs2_enqueue_frame(f, u)
end
on_frame_ptr = cfunction(on_frame_callback, Void, (Ptr{rs2_frame},Ptr{Void}))


rs2_open(sensor, profile, err)
checkerror(err)

frame_queue = rs2_create_frame_queue(1, err)
rs2_start(sensor, on_frame_ptr, frame_queue, err)
checkerror(err)

# OpenGL rendering loop
while !GLFW.WindowShouldClose(window)
    updatefps!(window)
    # clear drawing surface
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glViewport(0, 0, glfwWidth, glfwHeight)
    glUseProgram(shaderProgramID)

    frame = rs2_wait_for_frame(frame_queue, 5000, err)
    checkerror(err)
    data = Ptr{UInt8}(rs2_get_frame_data(frame, err))
    checkerror(err)
    width = rs2_get_frame_width(frame, err)
    height = rs2_get_frame_height(frame, err)
    glBindTexture(GL_TEXTURE_2D, tex[])
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, data)
    mipmap()
    glBindVertexArray(vao[])
    glDrawArrays(GL_TRIANGLES, 0, 6)
    rs2_release_frame(frame)

    # check and call events
    GLFW.PollEvents()
    # swap the buffers
    GLFW.SwapBuffers(window)
end

rs2_stop(sensor, err)
checkerror(err)

rs2_close(sensor, err)
checkerror(err)

# release rs2 resources
rs2_delete_frame_queue(frame_queue)
rs2_delete_sensor(sensor)
rs2_delete_device(device)
rs2_delete_context(ctx)

# release OpenGL resources
GLFW.DestroyWindow(window)
