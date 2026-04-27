
// ボールの位置（マウス座標で制御）
float ball_x;
float ball_y;
float ball_size = 20; // ボールの半径
// 当たり判定のフラグ
boolean collision = false;

// パッドの情報
float pad_w = 10;    // パッドの幅
float pad_h = 80;    // パッドの高さ

// プレイヤーのパッド
float pad_x = 30;
float pad_y;
float pad_speed = 8;  // パッドの移動速度

// ステージマージン
float margin = 20;

void setup() {
  size(600, 400);
  noStroke();

  // パッドの初期位置
  pad_y = height / 2;

  // ボールの初期位置
  ball_x = width / 4;
  ball_y = height / 2;
}

void draw() {
  background(0);


  // プレイヤーのパッド操作
  if (keyPressed) {
    if (keyCode == UP) {
      pad_y -= pad_speed;
    }
    if (keyCode == DOWN) {
      pad_y += pad_speed;
    }
  }

  // パッドが画面外に出ないようにする
  // constrain(現在の数値, 最小値, 最大値);
  pad_y = constrain(pad_y, margin + pad_h/2, height - margin - pad_h/2);

  // パッドを描画
  fill(255); // 白
  noStroke();

  // パッド（プレイヤー）
  rectMode(CENTER);
  rect(pad_x, pad_y, pad_w, pad_h);


  // マウス座標でボールを制御
  ball_x = mouseX;
  ball_y = mouseY;
  // 矩形とボールの当たり判定
  // 当たり判定フラグをリセット
  collision = false;

  if (ball_x - ball_size < pad_x + pad_w/2 && ball_x + ball_size > pad_x - pad_w/2) {
    if (ball_y - ball_size < pad_y + pad_h/2 && ball_y + ball_size > pad_y - pad_h/2 ) {
      // ボールがパッドと接触している
      collision = true;
    }
  }
  // ボールを描く
  // 当たっていたら色を変える
  if (collision) {
    fill(255, 0, 0);
  } else {
    fill(255);
  }
  ellipse(ball_x, ball_y, ball_size * 2, ball_size * 2);
}
