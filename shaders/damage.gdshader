shader_type canvas_item;

uniform float flash_strength : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	// Mezcla entre el color original y blanco
	COLOR = mix(tex_color, vec4(1.0), flash_strength) * tex_color.a;
}