#version 410

layout (location = 0) in vec2 vertex_position;
layout (location = 1) in vec2 vertex_tex; // per-vertex texture coordinates

out vec2 texture_coordinates;

void main() {
	texture_coordinates = vertex_tex;
	gl_Position = vec4(vertex_position, 0.0, 1.0);
}
