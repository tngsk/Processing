float x, y;           // 円の位置
float diameter = 200;  // 円の直径
float hue = 0;        // 色相の初期値
float speed = 2;      // 移動速度
float amplitude = 150;  // 横方向の振幅
float frequency = 0.02; // 波の頻度

void setup() {
  size(800, 600);
  colorMode(HSB, 360, 100, 100, 100);  // HSBカラーモード（透明度含む）
  background(0);  // 背景を黒に
  noStroke();     // 輪郭線なし

  // 初期位置を画面上部中央に設定
  x = width / 2;
  y = -diameter;
}

void draw() {
  // 円を描画
  fill(hue, 80, 100, 30);  // 色相、彩度、明度、透明度を設定
  ellipse(x, y, diameter, diameter);

  // 位置を更新（サイン波で横に揺れながら下に移動）
  x = width/2 + sin(y * frequency) * amplitude;
  y += speed;

  // 色相を更新（0〜360の範囲で循環）
  hue = (hue + 1.0) % 360;

  // 画面の下に達したら上に戻る
  if (y - diameter > height) {
    y = -diameter;
  }
  // オプション：背景をフェードさせて古い軌跡を消す
  fill(0, 0, 0, 10);
  rect(0, 0, width, height);
}

// マウスクリックで画面をクリア
void mousePressed() {
  background(0);
}
