#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

void main() {
  vec3 color = vec3(0., 0., 0.);
  color.z = 0.8;

  vec3 yellow, magenta, green; // 만들고자 하는 색상 변수들을 선언함.

  // Making Yellow
  yellow.rg = vec2(1.);
  yellow[2] = 0.; // 결과적으로 vec3 yellow 에는 (1., 1., 0.) 이 들어가게 됨. 만약 [2] 번째 값을 따로 할당하지 않으면 해당 성분에는 알아서 0.0 이 자동으로 할당됨.

  // Making Magenta
  // yellow.rgb = (1., 1., 0.)이기 때문에, 두 번째와 세 번째 성분 순서를 바꿔서 할당하기 위해 yellow.rbg 로 넣어준 것.
  // 따라서 vec3 magenta 에는 (1., 0., 1.) 이 들어가게 됨.
  // 이처럼 어떤 값의 r, g, b 성분값들을 동시에 할당할 때, 반드시 순서를 지켜야 한다는 고정관념을 버릴 것.
  // 위에 방법 말고도, yellow.rrr 이런 식으로 하나의 성분값만 반복해서 넣어줄수도 있음.
  // 이런 식으로 r, g, b, a / x, y, z, w 의 값을 마음대로 순서를 바꿔가면서 벡터의 성분에 접근하는 것을 'swizzle'이라고 함. 
  magenta = yellow.rbg;

  gl_FragColor = vec4(magenta, 1.0);
}

/*
  이미 만들어놓은 vec3 색상값의 각 성분을 접근 및 수정하는 법

  vec3 color = vec3(0., 0., 0.);
  color.g = 0.8;

  위와 같은 코드에서 처음에 vec3 color 는 black으로 할당되었지만,
  color.g = 0.8; 이런 식으로 g 성분값에 접근하여 값을 수정하면 수정된 색상값이 캔버스에 찍힘.


  이처럼 vec3, vec4 이런 식으로 데이터를 선언할 때,
  각각의 요소에 개별적으로 접근하는 방법은 다음과 같음.

  vec4 vector;
  vector[0] = vector.r = vector.x = vector.s;
  vector[1] = vector.g = vector.y = vector.t;
  vector[2] = vector.b = vector.z = vector.p;
  vector[3] = vector.a = vector.w = vector.q;

  vec4 타입의 vector라는 데이터에 대하여
  각 성분에 대해 위와 같이 4가지 방법으로 접근할 수 있음.

  예를 들어, vector.b 로 접근하나, vector.z 로 접근하나
  결국 vector라는 vec4가 갖는 3번째 성분 요소에 동일하게 접근할 수 있다는 뜻.

  일반적으로는 r, g, b, a / x, y, z, w 방식으로 접근하는 경우가 많다고 함.
*/