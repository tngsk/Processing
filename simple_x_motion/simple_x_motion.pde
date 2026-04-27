// 等加速度直線運動シミュレーション（X軸のみ）
// x = x0 + v0 * t + 0.5 * a * t^2 の公式を使用

float x0 = 50;      // 初期位置 (画面左端からの距離) [ピクセル]
float v0 = 100;     // 初速度 [ピクセル/秒]
float a = 50;       // 加速度 [ピクセル/秒^2]

float x;            // ボールの現在位置
float t = 0;        // 経過時間 [秒]
float dt = 0.02;    // 時間ステップ [秒]
float ballRadius = 20; // ボールの半径
float trackHeight = 300; // トラックの高さ

// グラフ表示用の変数
ArrayList<PVector> positionHistory = new ArrayList<PVector>();
int maxHistoryPoints = 300;
float graphHeight = 200;
float graphTop = 400;

void setup() {
  size(800, 650);
  frameRate(60);
  x = x0;
  textSize(16);
}

void draw() {
  background(240);
  
  // 時間の更新
  t += dt;
  
  // 等加速度直線運動の公式を使ってx座標を計算
  x = x0 + v0 * t + 0.5 * a * t * t;
  
  // 位置の履歴を記録
  if (frameCount % 3 == 0) { // フレームレートを下げて記録
    positionHistory.add(new PVector(t, x));
    if (positionHistory.size() > maxHistoryPoints) {
      positionHistory.remove(0);
    }
  }
  
  // ボールが画面の左右に到達したら反射する
  if (x < ballRadius || x > width - ballRadius) {
    if (x < ballRadius) {
      x = ballRadius;
    } else {
      x = width - ballRadius;
    }
    t = 0;  // 時間をリセット
    x0 = x; // 新しい初期位置
    v0 = -v0 * 0.8; // 反発係数0.8で跳ね返る
  }
  
  // トラック（レール）を描画
  fill(200);
  noStroke();
  rect(0, trackHeight - 5, width, 10);
  
  // ボールを描画
  fill(255, 0, 0);
  noStroke();
  ellipse(x, trackHeight, ballRadius * 2, ballRadius * 2);
  
  // 現在の速度を計算
  float v = v0 + a * t;
  
  // 情報表示
  fill(0);
  text("時間: " + nf(t, 0, 2) + " 秒", 20, 30);
  text("位置: " + nf(x, 0, 1) + " px", 20, 50);
  text("速度: " + nf(v, 0, 1) + " px/秒", 20, 70);
  text("加速度: " + nf(a, 0, 1) + " px/秒²", 20, 90);
  
  // 公式の表示
  text("位置の公式: x = x₀ + v₀t + ½at²", 20, 120);
  text("計算例: " + nf(x, 0, 1) + " = " + nf(x0, 0, 1) + " + " + nf(v0, 0, 1) + " × " + nf(t, 0, 2) + " + 0.5 × " + nf(a, 0, 1) + " × " + nf(t, 0, 2) + "²", 20, 140);
  
  // 位置-時間グラフを描画
  drawPositionTimeGraph();
  
  // 速度-時間グラフを描画
  drawVelocityTimeGraph();
}

void drawPositionTimeGraph() {
  // グラフの背景と枠
  fill(250);
  stroke(0);
  rect(50, graphTop, width - 100, graphHeight);
  
  // グラフのタイトルと軸ラベル
  fill(0);
  text("位置-時間グラフ", width/2 - 60, graphTop - 10);
  text("時間 (秒)", width/2, graphTop + graphHeight + 30);
  pushMatrix();
  translate(20, graphTop + graphHeight/2);
  rotate(-HALF_PI);
  text("位置 (px)", 0, 0);
  popMatrix();
  
  // 軸の目盛り
  stroke(200);
  for (int i = 0; i <= 10; i++) {
    float y = graphTop + graphHeight * (1 - i/10.0);
    line(50, y, width - 50, y);
    fill(0);
    text(nf(i * 80, 0, 0), 30, y + 5);
  }
  
  for (int i = 0; i <= 10; i++) {
    float x = 50 + (width - 100) * (i/10.0);
    line(x, graphTop, x, graphTop + graphHeight);
    fill(0);
    text(nf(i * 0.5, 0, 1), x - 10, graphTop + graphHeight + 15);
  }
  
  // データ点をプロット
  if (positionHistory.size() > 1) {
    stroke(255, 0, 0);
    strokeWeight(2);
    for (int i = 0; i < positionHistory.size() - 1; i++) {
      PVector p1 = positionHistory.get(i);
      PVector p2 = positionHistory.get(i+1);
      
      float x1 = map(p1.x, 0, 5, 50, width - 50);
      float y1 = map(p1.y, 0, 800, graphTop + graphHeight, graphTop);
      float x2 = map(p2.x, 0, 5, 50, width - 50);
      float y2 = map(p2.y, 0, 800, graphTop + graphHeight, graphTop);
      
      line(x1, y1, x2, y2);
    }
    strokeWeight(1);
  }
}

void drawVelocityTimeGraph() {
  // 速度-時間グラフは描画しない（シンプルに保つため）
}

void mousePressed() {
  // マウスクリックでボールをリセット
  t = 0;
  x0 = mouseX;
  x = x0;
  v0 = random(-100, 300); // ランダムな初速度
  a = random(-100, 100);  // ランダムな加速度
  positionHistory.clear();
}

void keyPressed() {
  // スペースキーで時間を一時停止
  if (key == ' ') {
    if (dt > 0) {
      dt = 0;
    } else {
      dt = 0.02;
    }
  }
  
  // 'r'キーでパラメータをリセット
  if (key == 'r' || key == 'R') {
    t = 0;
    x0 = 50;
    x = x0;
    v0 = 100;
    a = 50;
    positionHistory.clear();
  }
  
  // 'a'キーで加速度を変更
  if (key == 'a') a -= 10;
  if (key == 'A') a += 10;
  
  // 'v'キーで初速度を変更
  if (key == 'v') v0 -= 10;
  if (key == 'V') v0 += 10;
}