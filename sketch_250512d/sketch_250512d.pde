
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

}
