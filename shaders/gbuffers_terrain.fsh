#version 120

uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform sampler2D normals;
uniform sampler2D specular;
uniform sampler2D shadow;
uniform vec3 shadowLightPosition;
uniform float LNAXY_PBR;
uniform float LNAXY_NORMAL_STRENGTH;
uniform float LNAXY_SPECULAR_STRENGTH;
uniform float LNAXY_EMISSIVE_STRENGTH;
uniform float LNAXY_METALLIC_STRENGTH;
uniform float LNAXY_AO;
uniform float LNAXY_AO_STRENGTH;

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec3 normal;

void main() {
    vec4 albedo = texture2D(gtexture, texcoord);
    vec3 blockLight = texture2D(lightmap, lmcoord).rgb;

    vec3 mappedNormal = normal;
    vec4 normalData = texture2D(normals, texcoord);
    if (LNAXY_PBR > 0.5 && normalData.a > 0.001) {
        vec3 tangentNormal = normalData.xyz * 2.0 - 1.0;
        mappedNormal = normalize(normal + tangentNormal * LNAXY_NORMAL_STRENGTH);
    }

    float diffuse = max(dot(normalize(mappedNormal), normalize(shadowLightPosition)), 0.0);
    float hemi = mappedNormal.y * 0.5 + 0.5;
    vec3 materialLight = blockLight * (0.58 + diffuse * 0.62);

    float ao = mix(1.0, 0.72 + 0.28 * hemi, LNAXY_AO_STRENGTH * LNAXY_AO);
    materialLight *= ao;

    vec4 specularData = texture2D(specular, texcoord);
    float roughness = clamp(specularData.g, 0.0, 1.0);
    float metallic = clamp(specularData.r, 0.0, 1.0);
    float gloss = (1.0 - roughness) * LNAXY_SPECULAR_STRENGTH;
    float facing = clamp(dot(normalize(mappedNormal), normalize(shadowLightPosition)), 0.0, 1.0);

    vec3 specularColor = mix(vec3(0.16), albedo.rgb * metallic * LNAXY_METALLIC_STRENGTH, metallic);
    specularColor *= gloss * pow(facing, 8.0) * diffuse;

    float emission = specularData.b * LNAXY_EMISSIVE_STRENGTH;
    vec3 result = albedo.rgb * materialLight + specularColor + albedo.rgb * emission;
    gl_FragData[0] = vec4(result, albedo.a);
}
