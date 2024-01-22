shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 filter_color = vec4(0.0, 0.0, 0.0, 1.0);
	vec4 input_color = texture(TEXTURE, UV);
	float threshold = 1.1;
	float color_diff = length(input_color - filter_color);

    if (color_diff < threshold) {
        discard;
    }
	COLOR.a = 0.3;
}