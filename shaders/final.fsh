#version 120

// LNAXY REALISM post-processing controls.
// Iris/OptiFine shader options are edited from Shader Pack Settings.
#define LNAXY_EXPOSURE 1.00 // [0.50 0.60 0.70 0.80 0.90 1.00 1.10 1.20 1.30 1.40 1.50]
#define LNAXY_CONTRAST 1.05 // [0.70 0.80 0.90 1.00 1.10 1.20 1.30]
#define LNAXY_SATURATION 1.05 // [0.00 0.25 0.50 0.75 1.00 1.10 1.20 1.30 1.50]
#define LNAXY_VIGNETTE 0.10 // [0.00 0.05 0.10 0.15 0.20 0.30 0.40]
#define LNAXY_BLOOM 0.10 // [0.00 0.05 0.10 0.15 0.20 0.30 0.40]

uniform sampler2D colortex0;
uniform float viewWidth;
uniform float viewHeight;
varying vec2 texcoord;

vec3 lnaxyToneMap(vec3 color) {
    // Exposure followed by a compact Reinhard curve.
    color *= LNAXY_EXPOSURE;
    return color / (vec3(1.0) + max(color, vec3(0.0)));
}

void main() {
    vec3 color = texture2D(colortex0, texcoord).rgb;

    // Small, inexpensive 4-tap glow approximation. Set LNAXY_BLOOM to 0 to disable.
    vec2 px = 1.0 / max(vec2(viewWidth, viewHeight), vec2(1.0));
    vec3 glow = vec3(0.0);
    glow += texture2D(colortex0, texcoord + vec2(px.x, 0.0)).rgb;
    glow += texture2D(colortex0, texcoord - vec2(px.x, 0.0)).rgb;
    glow += texture2D(colortex0, texcoord + vec2(0.0, px.y)).rgb;
    glow += texture2D(colortex0, texcoord - vec2(0.0, px.y)).rgb;
    glow *= 0.25;
    glow = max(glow - vec3(0.72), vec3(0.0));
    color += glow * LNAXY_BLOOM;

    color = lnaxyToneMap(color);
    color = (color - 0.5) * LNAXY_CONTRAST + 0.5;
    float luminance = dot(color, vec3(0.2126, 0.7152, 0.0722));
    color = mix(vec3(luminance), color, LNAXY_SATURATION);

    vec2 centered = texcoord * 2.0 - 1.0;
    float vignette = dot(centered, centered);
    color *= 1.0 - clamp(vignette * LNAXY_VIGNETTE, 0.0, 0.85);

    gl_FragData[0] = vec4(clamp(color, 0.0, 1.0), 1.0);
}
