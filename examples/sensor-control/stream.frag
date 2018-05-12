#version 410

uniform sampler2D texture_image;
in vec2 texture_coordinates;
out vec4 color;

void main() {
	color = texture(texture_image, texture_coordinates);
}
