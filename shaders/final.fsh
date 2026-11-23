#version 120

// Iris shader options are preprocessor values, not runtime uniforms.
#define LNAXY_EXPOSURE 1.04 // [0.80 0.90 1.00 1.04 1.10 1.20 1.30]
#define LNAXY_CONTRAST 1.08 // [0.80 0.90 1.00 1.05 1.10 1.15 1.20]
#define LNAXY_SATURATION 1.08 // [0.70 0.85 1.00 1.08 1.15 1.25 1.40]
#define LNAXY_VIGNETTE 0.06 // [0.00 0.03 0.06 0.10 0.15 0.20]
#define LNAXY_BLOOM 0.08 // [0.00 0.04 0.08 0.12 0.18 0.25]
#define LNAXY_WARMTH 0.04 // [0.00 0.03 0.06 0.10 0.15]
#define LNAXY_GREEN_TINT 0.02 // [0.00 0.02 0.04 0.08 0.12]
#define LNAXY_TONEMAP 1 // [0 1 2]

uniform sampler2D colortex1;
uniform float viewWidth;
uniform float viewHeight;
varying vec2 texcoord;

vec3 lnaxyACES(vec3 x) {
    return clamp((x * (2.51 * x + 0.03)) / (x * (2.43 * x + 0.59) + 0.14), 0.0, 1.0);
}

void main() {
    vec3 color = texture2D(colortex1, texcoord).rgb * LNAXY_EXPOSURE;

    // Guard zero-sized viewport uniforms reported by some mod/render combinations.
    vec2 pixel = vec2(1.0 / max(viewWidth, 1.0), 1.0 / max(viewHeight, 1.0));
    vec3 glow = texture2D(colortex1, texcoord + vec2(pixel.x * 2.0, 0.0)).rgb;
    glow += texture2D(colortex1, texcoord - vec2(pixel.x * 2.0, 0.0)).rgb;
    glow += texture2D(colortex1, texcoord + vec2(0.0, pixel.y * 2.0)).rgb;
    glow += texture2D(colortex1, texcoord - vec2(0.0, pixel.y * 2.0)).rgb;
    glow *= 0.25;
    glow = max(glow - vec3(0.72), vec3(0.0));
    color += glow * LNAXY_BLOOM;

#if LNAXY_TONEMAP == 2
    color = lnaxyACES(color);
#elif LNAXY_TONEMAP == 1
    color = color / (vec3(1.0) + max(color, vec3(0.0)));
#endif

    color = (color - 0.5) * LNAXY_CONTRAST + 0.5;
    float luminance = dot(color, vec3(0.2126, 0.7152, 0.0722));
    color = mix(vec3(luminance), color, LNAXY_SATURATION);
    color.r *= 1.0 + LNAXY_WARMTH * 0.20;
    color.b *= 1.0 - LNAXY_WARMTH * 0.12;
    color.g *= 1.0 + LNAXY_GREEN_TINT;

    vec2 centered = texcoord * 2.0 - 1.0;
    float vignette = dot(centered, centered);
    color *= 1.0 - clamp(vignette * LNAXY_VIGNETTE, 0.0, 0.75);

    gl_FragColor = vec4(clamp(color, 0.0, 1.0), 1.0);
}
