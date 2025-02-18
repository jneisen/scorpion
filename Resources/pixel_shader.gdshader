shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform float pixelSize = 50;
void fragment() {
	//we would like to make the color the original color averaged
	// round the UV to the nearest .1
	vec2 nearestUV = vec2(UV.x, UV.y);
	nearestUV.x = float(int(nearestUV.x * pixelSize)) / pixelSize;
	nearestUV.y = float(int(nearestUV.y * pixelSize)) / pixelSize;
	COLOR = texture(TEXTURE, nearestUV);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
