#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359 // 아래에서 sin값에 넣어줄 라디안 각도를 구하기 위해 PI 상수값을 정의한 것 같음.

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 colorA = vec3(0.149, 0.141, 0.912);
vec3 colorB = vec3(1.000, 0.833, 0.224);

// 이 함수는 smoothstep 예제에 올려둔 캔버스 구간별 리턴값 캡처 이미지를 참고하면 이해가 쉬움.
float plot(vec2 st, float pct) {
  return smoothstep(pct - 0.01, pct, st.y) -
    smoothstep(pct, pct + 0.01, st.y);
}

void main() {
  vec2 st = gl_FragCoord.xy / u_resolution.xy; // 각 픽셀의 좌표값을 0 ~ 1 사이로 normalize
  vec3 color = vec3(0.0); // 색깔 변수 color를 만들고 초기값은 black으로 지정함.

  // 각 픽셀의 정규화된 x좌표값을 pct로 지정함.
  // 이 때, pct의 r, g, b에는 모두 동일한 x좌표값이 할당되겠지
  vec3 pct = vec3(st.x); 

  // 아래의 코드들은 pct의 r, g, b에 서로 다른 방식으로 변화를 줘서
  // colorA와 colorB의 r, g, b 성분들이 각각 섞이는 비율을 다르게 지정하도록 함.
  // 따라서, 각각의 주석을 한줄씩 풀어주면 캔버스에 찍히는 색상이 약간씩 바뀌게 됨.
  pct.r = smoothstep(0.0, 1.0, st.x);
  pct.g = sin(st.x * PI); // st.x 를 라디안 각도로 변환한 뒤에 sin() 함수에 넣어줘야 해서 PI값을 곱한것임.
  pct.b = pow(st.x, 0.5); // 이거는 그냥 단순하게 각 픽셀들의 x좌표값을 0.5 거듭제곱 해준거임.

  // pct값을 기준으로 두 색상을 혼합해 줌.
  // 근데, 이전과 다르게 pct값에 float이 아닌 vec3 데이터가 들어갔지?
  // 이러면 어떻게 mix를 하게 되는걸까?
  // 간단함. colorA.r 과 colorB.r 을 pct.r 을 기준으로 섞어서 color.r 값으로 들어가게 됨. 
  // 나머지 성분들도 동일한 계산이 적용됨.
  color = mix(colorA, colorB, pct);

  // Plot transition lines for each channel -> smoothstep 예제 필기 참고!
  // 위에 pct.r, g, b 값을 각각 다르게 계산하는 주석들을 풀어주면 
  // '동일한 x좌표값을 공유하는 하나의 열 안에 존재하는 픽셀들의 각 성분값'이 어떻게 변하는지 그래프로 찍어줌.
  // 만약에 위에 주석들을 하나도 풀지 않는다면, pct.r, g, b 모두 동일한 값(y = x 그래프)이 되므로,
  // 픽셀들의 성분값도 동일한 그래프를 찍게 되어 각 그래프들이 겹쳐지면서 가장 마지막에 그려지는 파란색 (즉, b 채널 그래프)만 보여지게 됨.
  color = mix(color, vec3(1.0, 0.0, 0.0), plot(st, pct.r));
  color = mix(color, vec3(0.0, 1.0, 0.0), plot(st, pct.g));
  color = mix(color, vec3(0.0, 0.0, 1.0), plot(st, pct.b));

  gl_FragColor = vec4(color, 1.0);
}

/*
  마지막 커밋의 예제같은 경우
  shader-smoothstep의 구간 나누기 관련 캡처 이미지와 필기 정리,
  코드를 이해하는 데 전반적으로 도움이 될 것임.
*/

/*
  #ifdef GL_ES
  precision mediump float;
  #endif

  uniform vec2 u_resolution;
  uniform float u_time;

  vec3 colorA = vec3(0.149, 0.141, 0.912);
  vec3 colorB = vec3(1.000, 0.833, 0.224);

  void main() {
    vec3 color = vec3(0.0);

    // sin은 u_time의 사인값을 리턴해주므로, 시간의 경과에 따라 -1 ~ 1 사이의 값을 주기적으로 리턴해줄거임.
    // 반면 abs는 모든 값을 절댓값으로 변환해주니까, 사인값을 0 ~ 1 사이의 값이 오가도록 변환해줄거임. 
    float pct = abs(sin(u_time));

    // Mix uses pct (a value from 0-1) to
    // mix the two colors
    // color = colorB * pct + colorA * (1. - pct); // smoothstep 예제에서 배웠듯이 아래의 mix() 내장함수를 그대로 구현한 코드라고 보면 됨.
    // 즉, 위에서 살펴봤듯이, pct는 0 ~ 1 사이의 값을 오가는데,
    // 이 때, pct가 0이면 color에는 colorA 값이 들어가고, pct가 1이면 color에는 colorB 값이 들어가게 됨.
    // pct가 0 ~ 1 사이라면, 위의 공식에 따라 두 색상을 pct 비율에 맞게 혼합해서 나오겠지
    color = mix(colorA, colorB, pct); // 이제 내장함수 mix() 를 활용해서 좀 더 편하게 코딩하면 됨.

    gl_FragColor = vec4(color, 1.0);
  }
*/

/*
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
*/

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