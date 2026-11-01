shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform float fisheye_strength : hint_range(0.0, 0.5) = 0.12;
uniform float scanline_strength : hint_range(0.0, 1.0) = 0.16;
uniform float noise_strength : hint_range(0.0, 0.2) = 0.035;
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.35;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

void fragment() {
    vec2 centered_uv = SCREEN_UV * 2.0 - 1.0;

    // Bend the image outward from the center
    float radius_squared = dot(centered_uv, centered_uv);
    vec2 warped_uv = centered_uv * (1.0 + fisheye_strength * radius_squared);
    vec2 screen_uv = warped_uv * 0.5 + 0.5;

    // Blacken the areas outside the warped screen
    float inside = float(
        screen_uv.x >= 0.0 && screen_uv.x <= 1.0 &&
        screen_uv.y >= 0.0 && screen_uv.y <= 1.0
    );

    vec3 color = texture(screen_texture, clamp(screen_uv, vec2(0.0), vec2(1.0))).rgb;
    color *= inside;

    float scanline = sin(FRAGCOORD.y * 3.14159);
    color *= 1.0 - scanline_strength * (0.5 + 0.5 * scanline);

    float noise = hash(floor(FRAGCOORD.xy) + floor(TIME * 24.0)) - 0.5;
    color += noise * noise_strength * inside;

    float edge = dot(centered_uv, centered_uv);
    color *= 1.0 - vignette_strength * smoothstep(0.25, 1.4, edge);

    //float gray = dot(color, vec3(0.299, 0.587, 0.114));
    //color = mix(color, vec3(gray), 0.05);
    //color *= vec3(0.92, 1.0, 0.88);

    COLOR = vec4(color, 1.0);
}
