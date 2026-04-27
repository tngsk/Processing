// 等加速度直線運動シミュレーション
// x = x0 + v0 * t + 0.5 * a * t^2 の公式を使用

float x0 = 50;      // 初期位置 (画面左端からの距離) [ピクセル]
float y0 = 300;     // 初期高さ (画面上部からの距離) [ピクセル]
float v0x = 100;    // x方向の初速度 [ピクセル/秒]
float v0y = -250;   // y方向の初速度 [ピクセル/秒] (上向きを負とする)
float ax = 0;       // x方向の加速度 [ピクセル/秒^2]
float ay = 300;     // y方向の加速度（重力） [ピクセル/秒^2]

float x, y;         // ボールの現在位置
float t = 0;        // 経過時間 [秒]
float dt = 0.02;    // 時間ステップ [秒]
float ballRadius = 20; // ボールの半径

void setup() {
  size(800, 600);
  frameRate(60);
  x = x0;
  y = y0;
}

void draw() {
  background(240);
  
  // 時間の更新
  t += dt;
  
  // 等加速度直線運動の公式を使ってx, y座標を計算
  x = x0 + v0x * t + 0.5 * ax * t * t;
  y = y0 + v0y * t + 0.5 * ay * t * t;
  
  // ボールが画面の底に到達したら反射する
  if (y > height - ballRadius) {
    y = height - ballRadius;
    t = 0;  // 時間をリセット
    x0 = x; // 新しい初期位置
    y0 = y;
    v0y = -v0y * 0.8; // 反発係数0.8で跳ね返る
  }
  
  // ボールが画面の左右に到達したら反射する
  if (x < ballRadius || x > width - ballRadius) {
    if (x < ballRadius) {
      x = ballRadius;
    } else {
      x = width - ballRadius;
    }
    t = 0;  // 時間をリセット
    x0 = x; // 新しい初期位置
    y0 = y;
    v0x = -v0x * 0.8; // 反発係数0.8で跳ね返る
  }
  
  // ボールを描画
  fill(255, 0, 0);
  noStroke();
  ellipse(x, y, ballRadius * 2, ballRadius * 2);
  
  // 情報表示
  fill(0);
  textSize(16);
  text("時間: " + nf(t, 0, 2) + " 秒", 20, 30);
  text("位置: (" + nf(x, 0, 1) + ", " + nf(y, 0, 1) + ")", 20, 50);
  text("速度: (" + nf(v0x + ax * t, 0, 1) + ", " + nf(v0y + ay * t, 0, 1) + ") ピクセル/秒", 20, 70);
  
  // 床を描画
  stroke(0);
  line(0, height - 1, width, height - 1);
}

void mousePressed() {
  // マウスクリックでボールをリセット
  t = 0;
  x0 = mouseX;
  y0 = mouseY;
  x = x0;
  y = y0;
  v0x = random(-200, 200);
  v0y = random(-300, -100);
}

void keyPressed() {
  // スペースキーで時間を一時停止
  if (key == ' ') {
    if (dt > 0) {
      dt = 0;
    } else {
      dt = 0.02;
    }
  }
}
