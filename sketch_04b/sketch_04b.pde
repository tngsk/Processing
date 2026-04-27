
// ボールの位置
float bx;
float by;

// ボールの速度
float b_vx;
float b_vy;
float b_r = 15; // ボールの半径

void setup() {
  size(600, 400);
  colorMode(HSB, 360, 100, 100);
  frameRate(60);
  
  // ボールの初期化
  bx = width / 2;
  by = height / 2;
  b_vx = 3;  // 水平方向の速度
  
}

void draw() {
  background(0,0,0);
  
  // ボールの移動
  bx = bx + b_vx;
  
  // 壁での反射（左）
  if (bx < 0) {
    b_vx = -b_vx;
    bx = 0;
  }
  
  // 壁での反射（右）
  if (bx > width) {
    b_vx = -b_vx;
    bx = width;
  }
  
  // ボールを描画
  fill(0, 0, 100);
  noStroke();
  ellipse(bx, by, b_r * 2, b_r * 2);
}
