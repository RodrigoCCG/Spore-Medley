shader_type canvas_item;

void fragment() {
	vec4 filter_color = vec4(0.0, 0.0, 0.0, 1.0);
	vec4 input_color = texture(TEXTURE, UV);
	float threshold = 5.0;
	float color_diff = length(input_color - filter_color);

    if (color_diff < threshold) {
        discard;
    }
	COLOR.a = 0.3;
}