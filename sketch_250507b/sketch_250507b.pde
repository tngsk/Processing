// 非常にシンプルなボールのプログラム - 加速度なしバージョン

// ボールの変数
float ball_x, ball_y;          // ボールの位置
float ball_velocity_x, ball_velocity_y;  // ボールの速度
float ball_size;              // ボールのサイズ
color ball_color;             // ボールの色
float gravity = 0.3;         // 重力
float bounce = 0.8;          // バウンス係数

void setup() {
  size(800, 600);
  
  // ボールの初期化
  ball_x = random(width);
  ball_y = random(height/4);
  ball_size = random(20, 50);
  ball_color = color(random(255), random(255), random(255));
  ball_velocity_x = random(-2, 2);
  ball_velocity_y = random(-2, 2);
}

void draw() {
  background(240);
  
  // ボールの更新 - 加速度の代わりに直接重力を速度に加算
  update_ball();
  
  // 衝突の確認
  check_edges();
  
  // ボールの描画
  display_ball();
  
  // 説明テキストを表示
  fill(0);
  textSize(16);
  text("Very Simple Ball Demo", 20, 50);
}

void update_ball() {
  // 重力を直接速度に加算
  ball_velocity_y += gravity;
  
  // 速度から位置を更新
  ball_x += ball_velocity_x;
  ball_y += ball_velocity_y;
}

void check_edges() {
  // 下端との衝突
  if (ball_y > height - ball_size/2) {
    ball_y = height - ball_size/2;
    ball_velocity_y *= -bounce;
  }
  
  // 上端との衝突
  if (ball_y < ball_size/2) {
    ball_y = ball_size/2;
    ball_velocity_y *= -bounce;
  }
  
  // 右端との衝突
  if (ball_x > width - ball_size/2) {
    ball_x = width - ball_size/2;
    ball_velocity_x *= -bounce;
  }
  
  // 左端との衝突
  if (ball_x < ball_size/2) {
    ball_x = ball_size/2;
    ball_velocity_x *= -bounce;
  }
  
  // 微小な速度をゼロにする（床に静止させる）
  if (abs(ball_velocity_y) < 0.1 && ball_y > height - ball_size/2 - 1) {
    ball_velocity_y = 0;
  }
}

void display_ball() {
  // ボールを描画
  noStroke();
  fill(ball_color);
  ellipse(ball_x, ball_y, ball_size, ball_size);
}

void mousePressed() {
  // クリックした場所にボールを移動
  ball_x = mouseX;
  ball_y = mouseY;
  // 新しい速度を設定
  ball_velocity_x = random(-2, 2);
  ball_velocity_y = random(-2, 2);
  // 色とサイズをランダムに変更
  ball_size = random(20, 50);
  ball_color = color(random(255), random(255), random(255));
}
