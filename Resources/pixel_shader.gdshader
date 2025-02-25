shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}

uniform float pixelSize = 240;
uniform float randomDarkness = 0.04;
void fragment() {
	//we would like to make the color the original color averaged
	// round the UV to the nearest .1
	vec2 nearestUV = vec2(UV.x, UV.y);
	nearestUV.x = float(int(nearestUV.x * pixelSize)) / pixelSize;
	nearestUV.y = float(int(nearestUV.y * pixelSize)) / pixelSize;
	float randomNumber = random(nearestUV);
	COLOR = texture(TEXTURE, nearestUV) + randomNumber * 
	vec4(-randomDarkness, -randomDarkness, -randomDarkness, 0.1);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
