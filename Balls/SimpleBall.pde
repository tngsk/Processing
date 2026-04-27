// シンプルなボールのプログラム - クラスと配列を使わないバージョン

// ボールの変数
float ballX, ballY;       // ボールの位置
float ballVelocityX, ballVelocityY;  // ボールの速度
float ballAccelerationX, ballAccelerationY;  // ボールの加速度
float ballSize;           // ボールのサイズ
color ballColor;          // ボールの色
float gravity = 0.3;      // 重力
float bounce = 0.8;       // バウンス係数

void setup() {
  size(800, 600);
  
  // ボールの初期化
  ballX = random(width);
  ballY = random(height/4);
  ballSize = random(20, 50);
  ballColor = color(random(255), random(255), random(255));
  ballVelocityX = random(-2, 2);
  ballVelocityY = random(-2, 2);
  ballAccelerationX = 0;
  ballAccelerationY = 0;
}

void draw() {
  background(240);
  
  // 重力の適用
  applyForce(0, gravity);
  
  // ボールの更新
  updateBall();
  
  // 衝突の確認
  checkEdges();
  
  // ボールの描画
  displayBall();
  
  // 説明テキストを表示
  fill(0);
  textSize(16);
  text("Simple Ball Demo", 20, 50);
}

void updateBall() {
  // 加速度から速度を更新
  ballVelocityX += ballAccelerationX;
  ballVelocityY += ballAccelerationY;
  
  // 速度から位置を更新
  ballX += ballVelocityX;
  ballY += ballVelocityY;
  
  // 加速度をリセット
  ballAccelerationX = 0;
  ballAccelerationY = 0;
}

void applyForce(float forceX, float forceY) {
  // 力を加速度に加える
  ballAccelerationX += forceX;
  ballAccelerationY += forceY;
}

void checkEdges() {
  // 下端との衝突
  if (ballY > height - ballSize/2) {
    ballY = height - ballSize/2;
    ballVelocityY *= -bounce;
  }
  
  // 上端との衝突
  if (ballY < ballSize/2) {
    ballY = ballSize/2;
    ballVelocityY *= -bounce;
  }
  
  // 右端との衝突
  if (ballX > width - ballSize/2) {
    ballX = width - ballSize/2;
    ballVelocityX *= -bounce;
  }
  
  // 左端との衝突
  if (ballX < ballSize/2) {
    ballX = ballSize/2;
    ballVelocityX *= -bounce;
  }
  
  // 微小な速度をゼロにする（床に静止させる）
  if (abs(ballVelocityY) < 0.1 && ballY > height - ballSize/2 - 1) {
    ballVelocityY = 0;
  }
}

void displayBall() {
  // ボールを描画
  noStroke();
  fill(ballColor);
  ellipse(ballX, ballY, ballSize, ballSize);
}

void mousePressed() {
  // クリックした場所にボールを移動
  ballX = mouseX;
  ballY = mouseY;
  // 新しい速度を設定
  ballVelocityX = random(-2, 2);
  ballVelocityY = random(-2, 2);
  // 色とサイズをランダムに変更
  ballSize = random(20, 50);
  ballColor = color(random(255), random(255), random(255));
}