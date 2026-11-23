#version 120

uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform float frameTimeCounter;
uniform float LNAXY_WATER_ENABLE;
uniform float LNAXY_WATER_TINT;
uniform float LNAXY_WATER_OPACITY;
uniform float LNAXY_WATER_FRESNEL;
uniform float LNAXY_WATER_WAVE;
uniform float LNAXY_WATER_SPEED;

varying vec2 texcoord;
varying vec2 lmcoord;

void main() {
    vec2 uv = texcoord;
    float time = frameTimeCounter * LNAXY_WATER_SPEED;
    uv.x += sin(uv.y * 34.0 + time) * 0.0022 * LNAXY_WATER_WAVE;
    uv.y += cos(uv.x * 29.0 - time * 0.75) * 0.0018 * LNAXY_WATER_WAVE;

    vec4 albedo = texture2D(gtexture, uv);
    vec3 light = texture2D(lightmap, lmcoord).rgb;
    vec3 deepColor = vec3(0.055, 0.31, 0.48);
    vec3 shallowColor = vec3(0.20, 0.58, 0.68);

    float facing = clamp(length(texcoord - vec2(0.5)) * 0.9, 0.0, 1.0);
    float fresnel = pow(facing, 2.2) * LNAXY_WATER_FRESNEL;
    vec3 water = mix(deepColor, shallowColor, 0.42 + fresnel * 0.35);

    vec3 result = mix(albedo.rgb * light, water * light * 1.14, LNAXY_WATER_TINT * LNAXY_WATER_ENABLE);
    float ripple = pow(max(0.0, sin(uv.x * 310.0 + time) * cos(uv.y * 280.0 - time * 0.8)), 12.0);
    result += ripple * fresnel * 0.20;

    gl_FragData[0] = vec4(result, LNAXY_WATER_OPACITY);
}
