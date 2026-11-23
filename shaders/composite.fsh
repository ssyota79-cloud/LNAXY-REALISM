#version 120

uniform sampler2D colortex0;
uniform float LNAXY_SKY_BLUE;
uniform float LNAXY_HORIZON_STRENGTH;
uniform float LNAXY_FOG_STRENGTH;
uniform float LNAXY_SUN_GLOW;

varying vec2 texcoord;

void main() {
    vec3 scene = texture2D(colortex0, texcoord).rgb;
    vec3 zenith = vec3(0.20, 0.47, 0.82);
    vec3 horizon = vec3(0.62, 0.74, 0.88);

    vec2 centered = texcoord * 2.0 - 1.0;
    float vertical = clamp(texcoord.y * 1.35, 0.0, 1.0);
    vec3 skyTint = mix(horizon, zenith, vertical);

    float sunBand = pow(max(0.0, 1.0 - abs(texcoord.y - 0.57)), 7.0);
    skyTint += vec3(0.22, 0.18, 0.09) * sunBand * LNAXY_SUN_GLOW;

    float top = smoothstep(0.18, 0.95, texcoord.y);
    skyTint = mix(skyTint, skyTint * (0.95 + LNAXY_SKY_BLUE * 0.12), top);

    float haze = pow(1.0 - texcoord.y, 3.0) * LNAXY_HORIZON_STRENGTH;
    scene = mix(scene, mix(scene, skyTint, haze), LNAXY_FOG_STRENGTH * 0.18);

    gl_FragData[0] = vec4(clamp(scene, 0.0, 1.0), 1.0);
}
