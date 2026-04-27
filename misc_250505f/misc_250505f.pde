// シンプルなワープエフェクト
float x1, y1, z1;  // 1本目の線の始点の座標と奥行き
float x2, y2, z2;  // 2本目の線の始点の座標と奥行き
float x3, y3, z3;  // 3本目の線の始点の座標と奥行き
float x4, y4, z4;  // 4本目の線の始点の座標と奥行き
float x5, y5, z5;  // 5本目の線の始点の座標と奥行き
float x6, y6, z6;  // 6本目の線の始点の座標と奥行き
float speed = 5;   // 移動速度

void setup() {
  size(600, 400);
  
  // 線の始点をランダムに初期化
  resetLine(1);
  resetLine(2);
  resetLine(3);
  resetLine(4);
  resetLine(5);
  resetLine(6);
}

void draw() {
  background(0);  // 黒背景
  
  // 線を描画
  drawLine(1);
  drawLine(2);
  drawLine(3);
  drawLine(4);
  drawLine(5);
  drawLine(6);
  
  // 奥行きを更新
  updateLine(1);
  updateLine(2);
  updateLine(3);
  updateLine(4);
  updateLine(5);
  updateLine(6);
}

// 指定した番号の線を初期化
void resetLine(int lineNum) {
  float centerX = width / 2;
  float centerY = height / 2;
  float randomAngle = random(TWO_PI);
  float randomDist = random(50, 150);
  
  // 画面中心から少し離れた位置に点を配置
  if (lineNum == 1) {
    x1 = centerX + cos(randomAngle) * randomDist;
    y1 = centerY + sin(randomAngle) * randomDist;
    z1 = 500;  // 奥の奥行き
  } else if (lineNum == 2) {
    x2 = centerX + cos(randomAngle) * randomDist;
    y2 = centerY + sin(randomAngle) * randomDist;
    z2 = 500;
  } else if (lineNum == 3) {
    x3 = centerX + cos(randomAngle) * randomDist;
    y3 = centerY + sin(randomAngle) * randomDist;
    z3 = 500;
  } else if (lineNum == 4) {
    x4 = centerX + cos(randomAngle) * randomDist;
    y4 = centerY + sin(randomAngle) * randomDist;
    z4 = 500;
  } else if (lineNum == 5) {
    x5 = centerX + cos(randomAngle) * randomDist;
    y5 = centerY + sin(randomAngle) * randomDist;
    z5 = 500;
  } else if (lineNum == 6) {
    x6 = centerX + cos(randomAngle) * randomDist;
    y6 = centerY + sin(randomAngle) * randomDist;
    z6 = 500;
  }
}

// 指定した番号の線を描画
void drawLine(int lineNum) {
  float centerX = width / 2;
  float centerY = height / 2;
  float x, y, z;
  
  // 線の座標と奥行きを取得
  if (lineNum == 1) {
    x = x1;
    y = y1;
    z = z1;
  } else if (lineNum == 2) {
    x = x2;
    y = y2;
    z = z2;
  } else if (lineNum == 3) {
    x = x3;
    y = y3;
    z = z3;
  } else if (lineNum == 4) {
    x = x4;
    y = y4;
    z = z4;
  } else if (lineNum == 5) {
    x = x5;
    y = y5;
    z = z5;
  } else {
    x = x6;
    y = y6;
    z = z6;
  }
  
  // 奥行きに基づいて投影された座標を計算
  float projectionFactor = z / 500.0;
  float projectedX = map(x, 0, width, centerX - (centerX - x) * projectionFactor, centerX + (x - centerX) * projectionFactor);
  float projectedY = map(y, 0, height, centerY - (centerY - y) * projectionFactor, centerY + (y - centerY) * projectionFactor);
  
  // 奥行きに基づいて線の太さと透明度を設定
  float lineWeight = map(z, 0, 500, 3, 1);
  float alpha = map(z, 0, 500, 255, 50);
  
  stroke(255, alpha);
  strokeWeight(lineWeight);
  
  // 線を描画（始点から中心へ）
  line(projectedX, projectedY, centerX, centerY);
}

// 指定した番号の線の奥行きを更新
void updateLine(int lineNum) {
  if (lineNum == 1) {
    z1 -= speed;
    if (z1 < 10) resetLine(1);
  } else if (lineNum == 2) {
    z2 -= speed;
    if (z2 < 10) resetLine(2);
  } else if (lineNum == 3) {
    z3 -= speed;
    if (z3 < 10) resetLine(3);
  } else if (lineNum == 4) {
    z4 -= speed;
    if (z4 < 10) resetLine(4);
  } else if (lineNum == 5) {
    z5 -= speed;
    if (z5 < 10) resetLine(5);
  } else if (lineNum == 6) {
    z6 -= speed;
    if (z6 < 10) resetLine(6);
  }
}
