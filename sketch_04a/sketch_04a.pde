
// ボールの位置
float bx;
float by;

// ボールの速度
float b_vx;
float b_vy;
// ボールの半径
float b_r;

void setup() {
  size(600, 400);
  colorMode(HSB, 360, 100, 100);
  frameRate(60);
  
  // ボールの初期化
  bx = 0;
  by = height / 2;
  b_vx = 3;  // 水平方向の速度
  b_r = 15;
  
}

void draw() {
  background(0,0,0);
  
  // ボールの移動
  bx = bx + b_vx;
  
  
  // ボールを描画
  fill(0, 0, 100);
  noStroke();
  ellipse(bx, by, b_r * 2, b_r * 2);
}
