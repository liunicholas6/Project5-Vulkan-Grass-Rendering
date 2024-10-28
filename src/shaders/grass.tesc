#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 tesc_v0[];
layout(location = 1) in vec4 tesc_v1[];
layout(location = 2) in vec4 tesc_v2[];
layout(location = 3) in vec4 tesc_up[];

layout(location = 0) out vec4 tese_v0[];
layout(location = 1) out vec4 tese_v1[];
layout(location = 2) out vec4 tese_v2[];
layout(location = 3) out vec4 tese_up[];

int tes_level = 16;

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    tese_v0[gl_InvocationID] = tesc_v0[gl_InvocationID];
    tese_v1[gl_InvocationID] = tesc_v1[gl_InvocationID];
    tese_v2[gl_InvocationID] = tesc_v2[gl_InvocationID];
    tese_up[gl_InvocationID] = tesc_up[gl_InvocationID];

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = tes_level;
    gl_TessLevelInner[1] = tes_level;
    gl_TessLevelOuter[0] = tes_level;
    gl_TessLevelOuter[1] = tes_level;
    gl_TessLevelOuter[2] = tes_level;
    gl_TessLevelOuter[3] = tes_level;
}
