
size(600, 600);
colorMode(HSB, 360, 100, 100); // HSBカラーモードを使用
background(0, 0, 95);

for (int i = 0; i < 10; i++) {
  // X座標
  float x = 60 * i;
  // 高さ
  float rectHeight = 60 * i;
  // 彩度
  float sat = 100 - (i * 9.5);
  // 描画設定
  fill(190, sat, 255);
  noStroke();
  // 矩形を描画
  float y = 600 - rectHeight;
  rect(x, y, 50, rectHeight);
}
