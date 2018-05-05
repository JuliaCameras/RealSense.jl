using RealSense

include("rs-utils.jl")
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
device_list = rs2_query_devices(ctx, err)
checkerror(err)
dev_count = rs2_get_device_count(device_list, err)
checkerror(err)
@info "There are $dev_count connected RealSense devices."
_pipeline = rs2_create_pipeline(ctx, err)
checkerror(err)
# start with a playback config
config = rs2_create_config(err)
checkerror(err)
rs2_config_enable_device_from_file(config, joinpath(@__DIR__, "a.bag"), err)
checkerror(err)
# start the pipeline streaming
@static if is_apple()
    # we sleep 1s on MacOS, otherwise it will hit issue #1586:
    # https://github.com/IntelRealSense/librealsense/issues/1586
    sleep(1)
end
rs2_pipeline_start_with_config(_pipeline, config, err)
checkerror(err)
@assert err[] == C_NULL "Failed to start playback pipeline!"
pipeline_profile = rs2_pipeline_get_active_profile(_pipeline, err)
checkerror(err)
dev = rs2_pipeline_profile_get_device(pipeline_profile, err)
checkerror(err)

# create Depth-Colorizer processing block that can be used to quickly visualize the depth data
color_map = rs2_create_colorizer(err)
checkerror(err)
# create target output queue for the results
frame_queue = rs2_create_frame_queue(1, err)
checkerror(err)
# set the output of the processing block to be the queue
rs2_start_processing_queue(color_map, frame_queue, err)
checkerror(err)
@info "Playing back..."
# OpenGL rendering loop
while !GLFW.WindowShouldClose(window)
    updatefps!(window)
    # clear drawing surface
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glViewport(0, 0, glfwWidth, glfwHeight)
    glUseProgram(shaderProgramID)

    # poll next frame set and extract depth frame
    framesRef = Ref{Ptr{rs2_frame}}(C_NULL)
    has_frames = rs2_pipeline_poll_for_frames(_pipeline, framesRef, err)
    checkerror(err)
    frames = framesRef[]
    has_frames == 0 && (rs2_release_frame(frames); continue)
    depth_frame = get_depth_frame(frames)
    # select stream
    if depth_frame != C_NULL
        # frame reference is being "moved" into processing, so unless you
        # don't need frame anymore you must add an extra rs2_frame_add_ref
        rs2_frame_add_ref(depth_frame, err)
        checkerror(err)
        # invoke processing
        rs2_process_frame(color_map, depth_frame, err)
        checkerror(err)
        colorized_frame = rs2_wait_for_frame(frame_queue, 5000, err)
        checkerror(err)
        # get data
        depth_data = Ptr{UInt8}(rs2_get_frame_data(colorized_frame, err))
        checkerror(err)
        width = rs2_get_frame_width(depth_frame, err)
        height = rs2_get_frame_height(depth_frame, err)
        glBindTexture(GL_TEXTURE_2D, tex[])
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, depth_data)
        mipmap()
        glBindVertexArray(vao[])
        glDrawArrays(GL_TRIANGLES, 0, 6)
        # release resource
        rs2_release_frame(colorized_frame)
    end
    # release resource
    rs2_release_frame(depth_frame)
    rs2_release_frame(frames)
    # check and call events
    GLFW.PollEvents()
    # swap the buffers
    GLFW.SwapBuffers(window)
end

# release rs2 resources
rs2_delete_frame_queue(frame_queue)
rs2_delete_processing_block(color_map)
rs2_delete_pipeline_profile(pipeline_profile)
rs2_delete_config(config)
rs2_delete_pipeline(_pipeline)
rs2_delete_device(dev)
rs2_delete_device_list(device_list)
rs2_delete_context(ctx)

# release OpenGL resources
GLFW.DestroyWindow(window)
