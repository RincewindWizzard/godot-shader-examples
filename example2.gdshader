shader_type canvas_item;

const float CHECKER_WIDTH = 0.05;

const vec2 origin = vec2(0.5);
const vec2 scale = vec2(2.0);
const mat3 CENTERED_COORD = mat3(
	vec3(2., 0., -1),
	vec3(0., 2., -1.),
	vec3(0., 0., 1.)
);

vec3 checker(vec2 pos) {
	int x = int((pos.x) / CHECKER_WIDTH);
	int y = int((pos.y) / CHECKER_WIDTH);
	if((x + y) % 2 == 0) {
		return vec3(0.6);
	} else {
		return vec3(0.4);
	}
}



void fragment() {
	vec3 background = checker(UV);
	
//	vec2 pos = (UV - origin) * scale;
	vec2 pos = (vec3(UV, 1.0) * CENTERED_COORD).xy;
	

	
	COLOR = vec4(ceil(pos.x), ceil(pos.y), 0.0, 1.0);
}
