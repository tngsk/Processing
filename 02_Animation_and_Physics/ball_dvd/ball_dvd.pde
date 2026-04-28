
// Flying DVD Logo


float bx, by;    // ボールの位置
float b_vx, b_vy;  // ボールの速度

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
  
  background(0, 0, 0);
  
  // 画像の移動
  bx = bx + b_vx;
  by = by + b_vy;
  
  // 壁での反射（左）
  if (bx < 25) {
    b_vx = -b_vx;
    bx = 25;
  }
  
  // 壁での反射（右）
  if (bx > width - 25) {
    b_vx = -b_vx;
    bx = width - 25;
  }
  
  // 壁での反射（上）
  if (by < 25) {
    b_vy = -b_vy;
    by = 25;
  }
  
  // 壁での反射（下）
  if (by > height - 25) {
    b_vy = -b_vy;
    by = height - 25;
  }
  
  // ボールを表示
  ellipse(bx, by, 50 , 50);
  
}
