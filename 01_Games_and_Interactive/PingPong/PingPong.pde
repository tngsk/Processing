
// ボールの位置
float ball_x;
float ball_y;

// ボールの速度
float vx;
float vy;
// ボールの半径
float ball_size = 15;

//パッドの基本サイズ
float pad_w = 10;
float pad_h = 80;

// 左側のパッド
float player_x = 30;
float player_y;
float player_pad_speed = 8;

// 右側のパッド（コンピュータ）
float computer_x;
float computer_y;
float comp_player_pad_speed = 5;  // コンピュータパッドの速度

//ステージマージン
float margin = 20;

void setup() {
  size(600, 400);
  colorMode(HSB, 360, 100, 100);

  // ボールの初期化
  ball_x = width / 2;
  ball_y = height / 2;

  vx = random(4,8);  // 水平方向の速度
  vy = random(-4, 4);  // 垂直方向の速度をランダムに

  // パッドの初期位置
  player_y = height / 2;

  computer_x = width - 30;
  computer_y = height / 2;
}

void draw() {
  // 背景（卓球台）を描画
  background(138, 90, 50);
  strokeWeight(4);
  stroke(0, 0, 100);
  line(width/2, margin, width/2, height-margin); // 中央の線

  // プレイヤーのパッド操作
  if (keyPressed) {
    if (keyCode == UP) {
      player_y -= player_pad_speed;
    }
    if (keyCode == DOWN) {
      player_y += player_pad_speed;
    }
  }

  // パッドが画面外に出ないようにする
  // constrain(現在の数値, 最小値, 最大値);
  player_y = constrain(player_y, margin + pad_h/2, height - margin - pad_h/2);

  // コンピュータのパッド動作（ボールを追いかける）
  if (ball_y > computer_y && computer_y < height - margin - pad_h/2) {
    // ボールはコンピュータパッドよりも下にある ＆＆ コンピュータパッドはステージ下部より上にある
    computer_y += comp_player_pad_speed;
  }
  if (ball_y < computer_y && computer_y > margin + pad_h/2) {
    // ボールはコンピュータパッドよりも上にある　＆＆ ステージ上部より下にある
    computer_y -= comp_player_pad_speed;
  }

  // ボールの移動
  ball_x = ball_x + vx;
  ball_y = ball_y + vy;

  // 左側のパッドとの衝突判定
  if (ball_x - ball_size < player_x + pad_w/2 && ball_x - ball_size > player_x - pad_w/2) {
    if (ball_y > player_y - pad_h/2 && ball_y < player_y + pad_h/2) {
      // 右向きに反射
      // abs() 数値を絶対値にするファンクション
      vx = abs(vx);
      // パッドの当たった位置で反射角を変える
      vy += (ball_y - player_y) / 10;
    }
  }

  // 右側のパッドとの衝突判定
  if (ball_x + ball_size > computer_x - pad_w/2 && ball_x + ball_size < computer_x + pad_w/2) {
    if (ball_y > computer_y - pad_h/2 && ball_y < computer_y + pad_h/2) {
      // 左向きに反射
      // 数値を絶対値にした後にマイナスにする → 必ずマイナス値になる
      vx = -abs(vx);
      // パッドの当たった位置で反射角を変える
      vy += (ball_y - computer_y) / 10;
    }
  }

  // ボールが左右の壁を超えたらリセット（得点）
  if (ball_x < 0) {
    // 右側（コンピュータ）の得点
    resetBall();
  }

  if (ball_x > width) {
    // 左側（プレイヤー）の得点
    resetBall();
  }

  // 壁での反射（上）
  if (ball_y < margin) {
    vy = -vy;
    ball_y = margin;
  }

  // 壁での反射（下）
  if (ball_y > height - margin) {
    vy = -vy;
    ball_y = height - margin;
  }

  // パッドを描画
  fill(0, 0, 100); // 白
  noStroke();

  // 左側のパッド（プレイヤー）
  rectMode(CENTER);
  rect(player_x, player_y, pad_w, pad_h);

  // 右側のパッド（コンピュータ）
  rect(computer_x, computer_y, pad_w, pad_h);

  // ボールを描画
  ellipse(ball_x, ball_y, ball_size * 2, ball_size * 2);
}

// ボールをリセットする関数
void resetBall() {
  ball_x = width / 2;
  ball_y = height / 2;

  // ランダムな方向に発射
  if (random(1) > 0.5) {
    vx = random(4,8);
  } else {
    vx = -random(4,8);
  }

  vy = random(-3, 3);
}
