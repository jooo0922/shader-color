#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
  vec3 color = vec3(1., 0., 0.);

  gl_FragColor = vec4(color, 1.0);
}