using RealSense

include("rs-utils.jl")
include("gl-utils.jl")

# initialize GLFW window
glfwWidth = 1280
glfwHeight = 720
window = create_window_context(glfwWidth, glfwHeight)

# prepare drawing via OpenGL
depth_window = GLfloat[-1.0,-1.0,   0.0,-1.0,   0.0, 1.0,
                        0.0, 1.0,  -1.0, 1.0,  -1.0,-1.0]
rgb_window = GLfloat[0.0,-1.0,   1.0,-1.0,   1.0, 1.0,
                     1.0, 1.0,   0.0, 1.0,   0.0,-1.0]
vertex_texcoords = GLfloat[1.0,1.0,  0.0,1.0,  0.0,0.0,
                           0.0,0.0,  1.0,0.0,  1.0,1.0]
# create Vertex Buffer Objects
depthVBO = Ref{GLuint}(0)
glGenBuffers(1, depthVBO)
glBindBuffer(GL_ARRAY_BUFFER, depthVBO[])
glBufferData(GL_ARRAY_BUFFER, sizeof(depth_window), depth_window, GL_STATIC_DRAW)
rgbVBO = Ref{GLuint}(0)
glGenBuffers(1, rgbVBO)
glBindBuffer(GL_ARRAY_BUFFER, rgbVBO[])
glBufferData(GL_ARRAY_BUFFER, sizeof(rgb_window), rgb_window, GL_STATIC_DRAW)
texcoordsVBO = Ref{GLuint}(0)
glGenBuffers(1, texcoordsVBO)
glBindBuffer(GL_ARRAY_BUFFER, texcoordsVBO[])
glBufferData(GL_ARRAY_BUFFER, sizeof(vertex_texcoords), vertex_texcoords, GL_STATIC_DRAW)
# create Vertex Array Objects
depthVAO = Ref{GLuint}(0)
glGenVertexArrays(1, depthVAO)
glBindVertexArray(depthVAO[])
glBindBuffer(GL_ARRAY_BUFFER, depthVBO[])
glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, C_NULL)
glBindBuffer(GL_ARRAY_BUFFER, texcoordsVBO[])
glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 0, C_NULL)
glEnableVertexAttribArray(0)
glEnableVertexAttribArray(1)
rgbVAO = Ref{GLuint}(0)
glGenVertexArrays(1, rgbVAO)
glBindVertexArray(rgbVAO[])
glBindBuffer(GL_ARRAY_BUFFER, rgbVBO[])
glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, C_NULL)
glBindBuffer(GL_ARRAY_BUFFER, texcoordsVBO[])
glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 0, C_NULL)
glEnableVertexAttribArray(0)
glEnableVertexAttribArray(1)
# create shader program
vertSource= joinpath(@__DIR__, "capture.vert")
fragSource = joinpath(@__DIR__, "capture.frag")
shaderProgramID = createprogram(vertSource, fragSource)
# generate texture handle
depthTex = Ref{GLuint}(0)
glGenTextures(1, depthTex)
rgbTex = Ref{GLuint}(0)
glGenTextures(1, rgbTex)

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
# start the pipeline streaming
@static if is_apple()
    # we sleep 1s on MacOS, otherwise it will hit issue #1586:
    # https://github.com/IntelRealSense/librealsense/issues/1586
    sleep(1)
end
pipeline_profile = rs2_pipeline_start(_pipeline, err)
@assert err[] == C_NULL "Failed to start pipeline!"

# create Depth-Colorizer processing block that can be used to quickly visualize the depth data
color_map = rs2_create_colorizer(err)
checkerror(err)
# create target output queue for the results
frame_queue = rs2_create_frame_queue(1, err)
checkerror(err)
# set the output of the processing block to be the queue
rs2_start_processing_queue(color_map, frame_queue, err)
checkerror(err)

# OpenGL rendering loop
while !GLFW.WindowShouldClose(window)
    updatefps!(window)
    # clear drawing surface
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glViewport(0, 0, glfwWidth, glfwHeight)
    glUseProgram(shaderProgramID)

    # wait next frame set
    frames = rs2_pipeline_wait_for_frames(_pipeline, 5000, err)
    checkerror(err)
    # get the number of frames embedded within the composite frame
    num_of_frames = rs2_embedded_frames_count(frames, err)
    checkerror(err)
    for i = 0:num_of_frames-1
        # extract frame
        frame = rs2_extract_frame(frames, i, err)
        checkerror(err)
        # extract stream profile
        profile = rs2_get_frame_stream_profile(frame, err)
        checkerror(err)
        stream, format = Ref{rs2_stream}(0), Ref{rs2_format}(0)
        index, unique_id, framerate = Ref{Cint}(0), Ref{Cint}(0), Ref{Cint}(0)
        rs2_get_stream_profile_data(profile, stream, format, index, unique_id, framerate, err)
        checkerror(err)
        # select stream
        if stream[] == RS2_STREAM_DEPTH
            # frame reference is being "moved" into processing, so unless you
            # don't need frame anymore you must add an extra rs2_frame_add_ref
            rs2_frame_add_ref(frame, err)
            checkerror(err)
            # invoke processing
            rs2_process_frame(color_map, frame, err)
            checkerror(err)
            colorized_frame = rs2_wait_for_frame(frame_queue, 5000, err)
            checkerror(err)
            # get data
            depth_data = Ptr{UInt8}(rs2_get_frame_data(colorized_frame, err))
            checkerror(err)
            width = rs2_get_frame_width(frame, err)
            height = rs2_get_frame_height(frame, err)
            glBindTexture(GL_TEXTURE_2D, depthTex[])
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, depth_data)
            mipmap()
            glBindVertexArray(depthVAO[])
            glDrawArrays(GL_TRIANGLES, 0, 6)
            rs2_release_frame(colorized_frame)
        elseif stream[] == RS2_STREAM_COLOR
            rgb_data = Ptr{UInt8}(rs2_get_frame_data(frame, err))
            checkerror(err)
            width = rs2_get_frame_width(frame, err)
            height = rs2_get_frame_height(frame, err)
            glBindTexture(GL_TEXTURE_2D, rgbTex[])
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, rgb_data)
            mipmap()
            glBindVertexArray(rgbVAO[])
            glDrawArrays(GL_TRIANGLES, 0, 6)
        end
        # release resource
        rs2_release_frame(frame)
    end
    rs2_release_frame(frames)
    # check and call events
    GLFW.PollEvents()
    # swap the buffers
    GLFW.SwapBuffers(window)
end

# stop the pipeline streaming
rs2_pipeline_stop(_pipeline, err)
checkerror(err)

# release rs2 resources
rs2_delete_frame_queue(frame_queue)
rs2_delete_processing_block(color_map)
rs2_delete_pipeline_profile(pipeline_profile)
rs2_delete_pipeline(_pipeline)
rs2_delete_device_list(device_list)
rs2_delete_context(ctx)

# release OpenGL resources
GLFW.DestroyWindow(window)
