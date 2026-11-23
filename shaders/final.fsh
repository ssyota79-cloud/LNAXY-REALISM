#version 120

uniform sampler2D colortex0;
uniform float LNAXY_EXPOSURE;
uniform float LNAXY_CONTRAST;
uniform float LNAXY_SATURATION;
uniform float LNAXY_TONEMAP;
uniform float LNAXY_VIGNETTE;
uniform float LNAXY_BLOOM;
uniform float LNAXY_WARMTH;
uniform float LNAXY_GREEN_TINT;
uniform float viewWidth;
uniform float viewHeight;

varying vec2 texcoord;

vec3 aces(vec3 x) {
    float a = 2.51;
    float b = 0.03;
    float c = 2.43;
    float d = 0.59;
    float e = 0.14;
    return clamp((x * (a * x + b)) / (x * (c * x + d) + e), 0.0, 1.0);
}

void main() {
    vec3 color = texture2D(colortex0, texcoord).rgb * LNAXY_EXPOSURE;

    vec2 px = vec2(1.0 / max(viewWidth, 1.0), 1.0 / max(viewHeight, 1.0));
    vec3 glow = texture2D(colortex0, texcoord + vec2(px.x * 3.0, 0.0)).rgb;
    glow += texture2D(colortex0, texcoord - vec2(px.x * 3.0, 0.0)).rgb;
    glow += texture2D(colortex0, texcoord + vec2(0.0, px.y * 3.0)).rgb;
    glow += texture2D(colortex0, texcoord - vec2(0.0, px.y * 3.0)).rgb;
    glow *= 0.25;
    glow = max(glow - vec3(0.60), vec3(0.0));
    color += glow * LNAXY_BLOOM;

    if (LNAXY_TONEMAP > 1.5) color = aces(color);
    else if (LNAXY_TONEMAP > 0.5) color = color / (vec3(1.0) + max(color, vec3(0.0)));

    color = (color - 0.5) * LNAXY_CONTRAST + 0.5;
    float luminance = dot(color, vec3(0.2126, 0.7152, 0.0722));
    color = mix(vec3(luminance), color, LNAXY_SATURATION);

    color.r *= 1.0 + LNAXY_WARMTH * 0.20;
    color.b *= 1.0 - LNAXY_WARMTH * 0.10;
    color.g *= 1.0 + LNAXY_GREEN_TINT;

    vec2 centered = texcoord * 2.0 - 1.0;
    float vignette = dot(centered, centered);
    color *= 1.0 - clamp(vignette * LNAXY_VIGNETTE, 0.0, 0.85);

    gl_FragData[0] = vec4(clamp(color, 0.0, 1.0), 1.0);
}
