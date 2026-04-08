shader_type canvas_item;

uniform vec4  tint           : source_color = vec4(1.0);
uniform float shimmer_speed  : hint_range(0.0, 5.0) = 1.5;
uniform float shimmer_width  : hint_range(0.0, 1.0) = 0.15;
uniform float shimmer_bright : hint_range(0.0, 2.0) = 0.5;

void fragment() {
    vec4  tex      = texture(TEXTURE, UV);
    float sweep    = fract(UV.x + UV.y - TIME * shimmer_speed);
    float band     = smoothstep(0.0, shimmer_width, sweep)
                   * smoothstep(shimmer_width * 2.0, shimmer_width, sweep);
    vec3  colored  = tex.r * tint.rgb + band * shimmer_bright * tex.r;
    COLOR = vec4(colored, tex.a * tint.a);
}