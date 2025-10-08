shader_type canvas_item;

uniform float flash_strength : hint_range(0.0, 1.0) = 0.0;
uniform vec4 flash_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); // 🔴 Rojo por defecto

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    // Mezcla el color del sprite con el color de flash (rojo)
    COLOR = mix(tex_color, flash_color, flash_strength) * tex_color.a;
}