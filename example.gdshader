shader_type canvas_item;

const vec2 origin = vec2(0, 0);
uniform vec2 mouse_position;
const float ring_thickness = 0.01;
const float ring_amplitude = 0.01;
const float speed = 1.0;

float normalize_radian(float phi) {
	return phi / (2.0 * PI) + 0.5;
}

vec2 transform_coords_into(vec2 xy) {
	return vec2(
		(xy.x + 1.0) / 2.0,
		(xy.y + 1.0) / 2.0
	);
}

vec2 transform_coords_from(vec2 xy) {
	return vec2(
		xy.x * 2.0 - 1.0,
		xy.y * 2.0 - 1.0
	);
}

float ring_radius(float phi, float base_radius, float amplitude) {

	
	vec2 curves[4] = {
		vec2(50.0, 1.0),
		vec2(20.0, 1.2),
		vec2(30.0, 2),
		vec2(0.5, 20)
	};

    float curve_sum = 0.0;
	for(int i = 0; i < 4; i++) {
		curve_sum += sin(phi * PI * curves[i][0] + TIME * speed) * amplitude * curves[i][1];
	}
	
	float radius = base_radius + curve_sum; 
	return radius;
}

bool ring_line(vec2 pos, float base_radius, float thickness, float amplitude, float phase, float dist) {
	
	for(int i = 0; i < 5; i++) {
		float phi = normalize_radian(atan(pos.x, pos.y)) + 1.0 * float(i);
		float radius = ring_radius(phi, base_radius, amplitude);
		if(abs(distance(vec2(0.0, 0.0), pos) - radius) < thickness) {
			return true;
		}
	}

	return false;
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
	vec2 position = transform_coords_from(UV);
	vec2 mouse = transform_coords_from(mouse_position);
	
	//COLOR = vec4(1.0, 0.0, 0.9, 1.0);
	
	
	float d = distance(origin, position);
	float mouse_distance = distance(origin, mouse);
	float mouse_phi = normalize_radian(atan(mouse.x, mouse.y));
	
	if(ring_line(position, 0.5, ring_thickness, ring_amplitude, mouse_phi, mouse_distance)) {
		float phi = normalize_radian(atan(position.x, position.y));
		
		float saturation = 1.0;//pow(2.0 - d, 1.10);
		COLOR = vec4(hsv2rgb(vec3(mod(mouse_phi + phi + TIME * 0.2 + d * 1.0, 1.0), saturation, 1.0)), 1.0);
		
	} else {
		//COLOR = texture(TEXTURE, UV);
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	}
//	float phi = atan(UV - origin);
//	float norm_angle = normalize_radian(phi);
//
//	COLOR = vec4(norm_angle, 0.0, 0.0, 1.0);
}




