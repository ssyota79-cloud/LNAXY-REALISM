#version 330 compatibility

uniform int worldTime;
uniform float viewWidth;
uniform float viewHeight;

varying vec2 texcoord;

vec3 lnaxyDaySky() {
    float y = clamp(gl_FragCoord.y / max(viewHeight, 1.0), 0.0, 1.0);
    vec3 horizon = vec3(0.58, 0.73, 0.94);
    vec3 zenith = vec3(0.12, 0.38, 0.78);
    return mix(horizon, zenith, smoothstep(0.0, 1.0, y));
}

void main() {
    vec3 sky = lnaxyDaySky();
    gl_FragColor = vec4(sky, 1.0);
}
