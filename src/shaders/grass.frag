#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec3 frag_normal;

layout(location = 0) out vec4 outColor;

const vec3 lightDir = vec3(1, -1, 0);

void main() {
    float lambert = abs(dot(lightDir, frag_normal));
    // TODO: Compute fragment color
    // outColor = vec4((frag_normal + 1) / 2, 1) - vec4(0, 0.5, 0, 0);
    outColor = vec4(0, lambert, 0, 1);
}
