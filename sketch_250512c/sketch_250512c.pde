
// ボールの位置（マウス座標で制御）
float ball_x;
float ball_y;
float ball_size = 20; // ボールの半径

// パッドの情報
float pad_x;         // パッドのX座標（固定）
float pad_y;         // パッドのY座標（固定）
float pad_w = 20;    // パッドの幅
float pad_h = 120;   // パッドの高さ

// 当たり判定のフラグ
boolean collision = false;


void setup() {
  size(600, 400);
  noStroke();

  // パッドの位置を固定
  pad_x = 100;  // 右側に固定
  pad_y = height / 2;   // 中央に固定

  // ボールの初期位置
  ball_x = width / 4;
  ball_y = height / 2;
}

void draw() {
  background(0);

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

  //パッドを描く
  rectMode(CENTER);
  fill(255);
  rect(pad_x, pad_y, pad_w, pad_h);

  // ボールを描く
  // 当たっていたら色を変える
  if (collision) {
    fill(255, 0, 0);
  } else {
    fill(255);
  }
  ellipse(ball_x, ball_y, ball_size * 2, ball_size * 2);
}
