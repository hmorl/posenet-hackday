
precision mediump int;
precision mediump float;
#define PI (3.141592653589793)
#define TAU (6.283185307179586)
#define HALF_PI (1.570796326794896)

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;
uniform float u_frame;

vec2 aspectCorrectedUV(vec2 _s6u, vec2 _s6v) {
  vec2 _s6w = _s6u / _s6v * 2.0 - 1.0;
  _s6w.x = _s6w.x * (_s6v.x / _s6v.y);
  return _s6w;
}

vec4 creation(vec2 uv, float time) {
  vec3 c;
  float l,
    z = abs(time);

  for (int i = 0; i < 3; i++) {
    vec2 u,
      p = uv / 2.0;
    u = p;
    z += 0.07;
    l = length(p);
    u += p / l * (sin(z) + 1.0) * abs(sin(l * 9.0 - z - z));
    c[i] = 0.01 / length(mod(u, 1.0) - 0.5);
  }

  return vec4(c / l, abs(time));
}
void main() {
  gl_FragColor = creation(
    aspectCorrectedUV(gl_FragCoord.xy, u_resolution),
    abs(
      length(aspectCorrectedUV(gl_FragCoord.xy, u_resolution)*length(u_mouse)) * -1.0 + cos(length(u_frame))
    ) + 2.0
  );
}