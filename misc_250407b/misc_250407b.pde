// ユークリッド互除法計算のための変数
int a = 1105;
int b = 663;
a = 1005;
b = 399;
//int c;
//int d = b;

// グラフィック描画に使用する変数
int wd = b; // 正方形のサイズ
int x_pos = 0; // 描画位置（横）
int y_pos = 0; // 描画位置（縦）
int repeat = 0; //繰り返しの数

// キャンパス設定
size(1005, 399);
background(255);

// Color
color col;
colorMode(HSB, 1);
noStroke();

// 描画
while (wd > 0) {
  repeat++;

  if (repeat % 2 == 1) { // 繰り返し回数が奇数のとき、横方向に正方形を増やす
    while (x_pos + wd <= a) { // x位置に正方形を置いても、長方形の幅を超えないなら
      // 正方形を描く
      col = color(random(1), 0.25, 1.0);
      fill(col);
      rect(x_pos, y_pos, wd, wd);
      // x位置を更新する
      x_pos += wd;
    }
    // 正方形のサイズを更新
    wd = a - x_pos;
  } else { // 繰り返しの回数が偶数のとき、縦方向に正方形を増やす
    while (y_pos + wd <= b) { // y位置に正方形を置いても、長方形の高さを超えないなら
      // 正方形を描く
      col = color(random(1), 1, 1);
      fill(col);
      rect (x_pos, y_pos, wd, wd);
      // y位置を更新する
      y_pos += wd;
    }
    // 正方形のサイズを更新
    wd = b - y_pos;
  }
}
