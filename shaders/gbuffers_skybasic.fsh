#version 120

uniform sampler2D gtexture;
uniform float LNAXY_SKY_BLUE;
uniform float LNAXY_HORIZON_STRENGTH;
uniform float LNAXY_SUN_GLOW;

varying vec2 texcoord;

void main() {
    vec3 zenith = vec3(0.18, 0.43, 0.82);
    vec3 horizon = vec3(0.62, 0.76, 0.92);
    vec3 sky = mix(horizon, zenith, smoothstep(0.05, 0.95, texcoord.y));
    sky.b *= 1.0 + LNAXY_SKY_BLUE * 0.12;

    vec3 sunGlow = vec3(1.0, 0.86, 0.62);
    float glow = pow(max(0.0, 1.0 - length(texcoord - vec2(0.68, 0.60))), 7.0);
    sky += sunGlow * glow * LNAXY_SUN_GLOW;

    float horizonLine = pow(1.0 - texcoord.y, 5.0) * LNAXY_HORIZON_STRENGTH;
    sky = mix(sky, horizon, horizonLine);

    gl_FragData[0] = vec4(sky, 1.0);
}
