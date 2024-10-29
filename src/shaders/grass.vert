
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 vert_v0;
layout(location = 1) in vec4 vert_v1;
layout(location = 2) in vec4 vert_v2;
layout(location = 3) in vec4 vert_up;

layout(location = 0) out vec4 tesc_v0;
layout(location = 1) out vec4 tesc_v1;
layout(location = 2) out vec4 tesc_v2;
layout(location = 3) out vec4 tesc_up;

// out gl_PerVertex {
//     vec4 gl_Position;
// };

vec4 apply_model(vec4 v) {
    vec4 res = model * vec4(v.xyz, 1);
    res.w = v.w;
    return res;
}

void main() {
	// TODO: Write gl_Position and any other shader outputs
    tesc_v0 = apply_model(vert_v0);
    tesc_v1 = apply_model(vert_v1);
    tesc_v2 = apply_model(vert_v2);
    tesc_up = apply_model(vert_up);

    gl_Position = tesc_v0;
}
