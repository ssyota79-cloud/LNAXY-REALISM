#version 120

uniform sampler2D gtexture;
uniform sampler2D lightmap;

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 vertexColor;

void main() {
    vec4 albedo = texture2D(gtexture, texcoord) * vertexColor;
    vec3 lighting = texture2D(lightmap, lmcoord).rgb;
    vec3 waterTint = vec3(0.82, 0.94, 1.0);
    gl_FragData[0] = vec4(albedo.rgb * lighting * waterTint, albedo.a);
}
