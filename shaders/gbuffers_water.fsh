#version 120

uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform float frameTimeCounter;
uniform float LNAXY_WATER_TINT;
uniform float LNAXY_WATER_OPACITY;
uniform float LNAXY_WATER_FRESNEL;
uniform float LNAXY_WATER_DEPTH;
uniform float LNAXY_WATER_WAVE;
uniform float LNAXY_WATER_WAVE_SPEED;

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec3 normal;
varying vec3 viewPos;

void main() {
    vec2 animatedUV = texcoord;
    float t = frameTimeCounter * LNAXY_WATER_WAVE_SPEED;
    animatedUV.x += sin(texcoord.y * 38.0 + t) * 0.0025 * LNAXY_WATER_WAVE;
    animatedUV.y += cos(texcoord.x * 31.0 + t * 0.74) * 0.0025 * LNAXY_WATER_WAVE;

    vec4 albedo = texture2D(gtexture, animatedUV);
    vec3 lighting = texture2D(lightmap, lmcoord).rgb;

    vec3 facingNormal = normalize(normal);
    float facing = clamp(facingNormal.z * 0.5 + 0.5, 0.0, 1.0);
    float fresnel = pow(1.0 - facing, 3.0) * LNAXY_WATER_FRESNEL;

    vec3 shallow = vec3(0.18, 0.58, 0.62);
    vec3 deep = vec3(0.015, 0.12, 0.26);
    vec3 depthColor = mix(shallow, deep, LNAXY_WATER_DEPTH);
    vec3 waterColor = mix(depthColor, vec3(0.62, 0.84, 0.96), fresnel);

    vec3 result = mix(albedo.rgb * lighting * waterColor, waterColor * lighting * 1.12, LNAXY_WATER_TINT);
    float sparkle = pow(max(0.0, sin(animatedUV.x * 420.0 + t * 1.7) * sin(animatedUV.y * 390.0 - t)), 18.0);
    result += sparkle * fresnel * 0.32;

    gl_FragData[0] = vec4(result, LNAXY_WATER_OPACITY + fresnel * 0.04);
}
