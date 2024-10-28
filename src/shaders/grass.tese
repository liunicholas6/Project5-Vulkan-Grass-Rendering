#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 tese_v0[];
layout(location = 1) in vec4 tese_v1[];
layout(location = 2) in vec4 tese_v2[];
layout(location = 3) in vec4 tese_up[];

void main() {
    // TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    vec3 v0 = tese_v0[0].xyz;
    vec3 v1 = tese_v1[0].xyz;
    vec3 v2 = tese_v2[0].xyz;
    vec3 up = tese_up[0].xyz;

    float orientation = tese_v0[0].w;
    vec3 t1 = vec3(cos(orientation), 0, sin(orientation));

    float h = tese_v1[0].w;
    float w = tese_v2[0].w;

    // De Casteljeau's bezier
    vec3 a = mix(v0, v1, v);
    vec3 b = mix(v1, v2, v);
    vec3 c = mix(a, b, v);

    vec3 c0 = c - w * t1;
    vec3 c1 = c + w * t1;
    vec3 pos = mix(c0, c1, (u - 0.5) * (1 - v) + 0.5);

    gl_Position = camera.proj * camera.view * vec4(pos, 1);
}
