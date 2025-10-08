shader_type canvas_item;

uniform float flash_strength : hint_range(0.0, 1.0) = 0.0;
uniform vec4 flash_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);

uniform float ready_strength : hint_range(0.0, 1.0) = 0.0;
uniform vec4 ready_color : source_color = vec4(1.0, 1.0, 1.0, 1.0); 

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    vec4 color_damage = mix(tex_color, flash_color, flash_strength);
    
    COLOR = mix(color_damage, ready_color, ready_strength) * tex_color.a;
}