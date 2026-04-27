
// Billiard

float bx, by;    // ボールの位置
float b_vx, b_vy;  // ボールの速度
float b_r = 15; // ボールの半径

void setup() {
  size(600, 400);
  colorMode(HSB, 360, 100, 100);
  
  // ボールの初期化
  bx = width / 2;
  by = height / 2;
  b_vx = 3;  // 水平方向の速度
  b_vy = 4;  // 垂直方向の速度
  
}

void draw() {
  
  // ビリヤード台の枠を描画
  strokeWeight(20);
  stroke(30, 90, 50); // 茶色の枠
  fill(138, 90, 50); // 緑色の背景
  rect(10, 10, width - 20, height - 20);
  
  // ボールの移動
  bx = bx + b_vx;
  by = by + b_vy;
  
  // 壁での反射（左）
  if (bx < 20) {
    b_vx = -b_vx;
    bx = 20;
  }
  
  // 壁での反射（右）
  if (bx > width - 20) {
    b_vx = -b_vx;
    bx = width - 20;
  }
  
  // 壁での反射（上）
  if (by < 20) {
    b_vy = -b_vy;
    by = 20;
  }
  
  // 壁での反射（下）
  if (by > height - 20) {
    b_vy = -b_vy;
    by = height - 20;
  }
  
  // ボールを描画
  fill(0, 0, 100);
  noStroke();
  ellipse(bx, by, b_r * 2, b_r * 2);
}
