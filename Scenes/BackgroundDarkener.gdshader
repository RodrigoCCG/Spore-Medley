shader_type canvas_item;

void fragment() {
	COLOR.x *= (117.0 / 255.0) * 0.5;
	COLOR.y *= (125.0 / 255.0) * 0.5;
	COLOR.z *= (132.0 / 255.0) * 0.5;
}

//void fragment() {
//	COLOR.x = COLOR.x / 4.0;
//	COLOR.y = COLOR.y / 3.0;
//	COLOR.z = COLOR.z / 2.0;
//}