#version 120

uniform sampler2D colortex0;
varying vec2 texcoord;

void main() {
    vec4 scene = texture2D(colortex0, texcoord);
    vec3 color = max(scene.rgb, vec3(0.0));
    color = color / (vec3(1.0) + color * 0.08);
    gl_FragData[0] = vec4(color, scene.a);
}
