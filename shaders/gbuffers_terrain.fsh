#version 330 compatibility

uniform sampler2D texture;
uniform sampler2D normals;
uniform sampler2D specular;
uniform vec3 shadowLightPosition;
uniform float LNAXY_EXPOSURE;
uniform float LNAXY_CONTRAST;
uniform float LNAXY_ATMOSPHERE;

varying vec2 texcoord;
varying vec3 normal;
varying vec3 worldPosition;

void main() {
    vec4 albedo = texture2D(texture, texcoord);

    vec3 nNormal = normalize(normal);
    vec3 nSpec = vec3(0.5);
    vec4 specularData = texture2D(specular, texcoord);

    float light = max(dot(nNormal, normalize(shadowLightPosition)), 0.0);
    float ambient = 0.18 + 0.10 * LNAXY_ATMOSPHERE;
    float diffuse = ambient + light * 0.82;

    vec3 color = albedo.rgb * diffuse * LNAXY_EXPOSURE;
    color = (color - 0.5) * LNAXY_CONTRAST + 0.5;
    color += specularData.rgb * specularData.a * light * 0.12;

    gl_FragData[0] = vec4(max(color, 0.0), albedo.a);
}
