#version 330 compatibility

uniform sampler2D texture;
uniform float LNAXY_WATER_ROUGHNESS;

varying vec2 texcoord;
varying vec3 normal;

void main() {
    vec4 albedo = texture2D(texture, texcoord);
    float facing = clamp(normal.z * 0.5 + 0.5, 0.0, 1.0);
    float fresnel = pow(1.0 - facing, 3.0);

    vec3 water = mix(vec3(0.02, 0.20, 0.28), vec3(0.06, 0.62, 0.78), fresnel);
    vec3 color = mix(water, albedo.rgb, LNAXY_WATER_ROUGHNESS);

    gl_FragColor = vec4(color, 0.62 + fresnel * 0.25);
}
