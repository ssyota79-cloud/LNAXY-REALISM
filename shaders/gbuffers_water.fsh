#version 120

#define LNAXY_WATER_TINT 0.35 // [0.00 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 1.00]
#define LNAXY_WATER_OPACITY 0.90 // [0.30 0.40 0.50 0.60 0.70 0.80 0.90 1.00]

uniform sampler2D gtexture;
uniform sampler2D lightmap;
varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 vertexColor;

void main() {
    vec4 albedo = texture2D(gtexture, texcoord) * vertexColor;
    vec3 lighting = texture2D(lightmap, lmcoord).rgb;
    vec3 waterTint = vec3(0.74, 0.91, 1.0);
    vec3 tinted = mix(albedo.rgb, albedo.rgb * waterTint, LNAXY_WATER_TINT);
    gl_FragData[0] = vec4(tinted * lighting, albedo.a * LNAXY_WATER_OPACITY);
}
