// ===== シンプル物理演算デモ =====

// --- ゲームオブジェクト ---
ArrayList<Ball> balls;

// --- 初期化処理 ---
void setup() {
  size(1280, 720);
  frameRate(60);

  // 基本設定
  rectMode(CORNER);
  imageMode(CORNER);
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER);

  // ボール配列初期化
  balls = new ArrayList<Ball>();

  // 初期ボールを生成
  for (int i = 0; i < 3; i++) {
    Ball ball = new Ball(random(100, width-100), random(100, 200), random(30, 50));
    ball.vx = random(-4, 4);
    ball.vy = random(-2, 2);
    balls.add(ball);
  }
}

// --- メインループ ---
void draw() {
  background(50, 50, 80);

  // ボール更新
  for (Ball ball : balls) {
    ball.update();
  }

  // ボール同士の衝突処理
  for (Ball ball1 : balls) {
    for (Ball ball2 : balls) {
      if (ball1 != ball2 && isColliding(ball1, ball2)) {
        resolveDynamicCollision(ball1, ball2, 0.7);
      }
    }
  }

  // ボール描画
  for (Ball ball : balls) {
    ball.draw();
  }

  // UI描画
  drawUI();
}

// --- UI描画 ---
void drawUI() {
  fill(255);
  textAlign(LEFT, TOP);
  textSize(18);
  text("Click: Add Ball", 20, 20);
  text("Space: Clear All", 20, 50);
  text("Balls: " + balls.size(), 20, 80);

  textAlign(CENTER, CENTER);
  textSize(16);
  text("Watch the physics simulation!", width/2, height - 30);
}

// --- キー入力 ---
void keyPressed() {
  if (key == ' ') {
    balls.clear();
  }
}

// --- マウス入力 ---
void mousePressed() {
  Ball ball = new Ball(mouseX - 20, mouseY - 20, random(25, 45));
  ball.vx = random(-3, 3);
  ball.vy = random(-3, 1);
  balls.add(ball);
}

// --- Added from Ball.pde ---
// シンプルな物理演算ボールクラス
class Ball extends BaseClass {

  float radius;
  color ballColor;
  float bounciness;

  Ball(float x, float y, float size) {
    super(x, y, size, size);
    this.radius = size / 2;
    this.ballColor = color(random(100, 255), random(100, 255), random(100, 255));
    this.bounciness = 0.8;
  }

  void update() {
    // 重力適用
    applyGravity(this, 0.5);

    // 位置更新
    super.update();

    // 境界でのバウンド処理
    checkBounds(this, 0, 0, width, height, bounciness);
  }

  void draw() {
    fill(ballColor);
    ellipse(x + radius, y + radius, w, h);
  }
}
