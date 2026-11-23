#version 120

uniform sampler2D colortex0;
uniform vec3 sunPosition;
uniform vec3 fogColor;
uniform float far;
uniform float LNAXY_FOG_DENSITY;
uniform float LNAXY_FOG_DISTANCE;
uniform float LNAXY_SKY_STRENGTH;

varying vec2 texcoord;

void main() {
    vec3 scene = texture2D(colortex0, texcoord).rgb;
    float depth = texture2D(depthtex0, texcoord).r;

    float viewY = texcoord.y;
    float night = smoothstep(-0.15, 0.25, normalize(sunPosition).y);
    vec3 horizon = mix(vec3(0.18, 0.25, 0.36), vec3(0.58, 0.72, 0.92), night);
    vec3 skyGlow = mix(horizon, vec3(0.88, 0.86, 0.76), pow(max(0.0, 1.0 - abs(viewY - 0.66)), 5.0));

    float linearDepth = depth * far;
    float fogAmount = 1.0 - exp(-linearDepth / max(far * 0.12 / LNAXY_FOG_DISTANCE, 1.0));
    fogAmount *= LNAXY_FOG_DENSITY;
    fogAmount *= step(depth, 0.999); // Preserve the clear sky output.

    scene = mix(scene, skyGlow * LNAXY_SKY_STRENGTH + scene * 0.08, clamp(fogAmount, 0.0, 0.78));
    gl_FragData[0] = vec4(scene, 1.0);
}
