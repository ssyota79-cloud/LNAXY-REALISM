#version 120

// Composite reads the scene from colortex0 and writes to a DIFFERENT target.
// Reading and writing colortex0 in the same pass caused undefined feedback,
// which is why the previous build could turn the whole frame gray.
#define LNAXY_FOG_STRENGTH 0.45 // [0.00 0.15 0.30 0.45 0.60 0.75 0.90]
#define LNAXY_HORIZON_STRENGTH 0.65 // [0.00 0.20 0.40 0.60 0.80 1.00]

uniform sampler2D colortex0;
varying vec2 texcoord;

/* DRAWBUFFERS:1 */
void main() {
    vec3 scene = texture2D(colortex0, texcoord).rgb;

    // Subtle cool atmospheric grading, strongest near the horizon of the image.
    float horizon = pow(clamp(1.0 - texcoord.y, 0.0, 1.0), 2.2);
    vec3 hazeColor = vec3(0.60, 0.72, 0.88);
    float haze = horizon * LNAXY_HORIZON_STRENGTH * LNAXY_FOG_STRENGTH * 0.20;
    scene = mix(scene, hazeColor, haze);

    gl_FragData[0] = vec4(scene, 1.0);
}
