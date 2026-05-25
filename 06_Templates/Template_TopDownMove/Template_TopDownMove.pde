// ===== テンプレート：トップダウン(見下ろし型)の8方向移動 =====
//
// 用途: RPGやアクションゲームなど、上下左右斜めにキャラクターを移動させる処理です。

// --- キー入力状態フラグ ---
boolean isLeftKeyPressed = false;
boolean isRightKeyPressed = false;
boolean isUpKeyPressed = false;
boolean isDownKeyPressed = false;

Player player;

void setup() {
  size(800, 600);
  rectMode(CORNER);
  player = new Player(width/2, height/2, 40, 40);
}

void draw() {
  background(50, 150, 50); // 緑色の背景（草地風）

  player.update();
  player.draw();

  // UIの表示
  fill(255);
  textSize(20);
  textAlign(LEFT, TOP);
  text("WASD or Arrow Keys to Move", 10, 10);
}

// キーボードが押されたときの処理
void keyPressed() {
  if (key == 'a' || key == 'A' || keyCode == LEFT)  isLeftKeyPressed = true;
  if (key == 'd' || key == 'D' || keyCode == RIGHT) isRightKeyPressed = true;
  if (key == 'w' || key == 'W' || keyCode == UP)    isUpKeyPressed = true;
  if (key == 's' || key == 'S' || keyCode == DOWN)  isDownKeyPressed = true;
}

// キーボードが離されたときの処理
void keyReleased() {
  if (key == 'a' || key == 'A' || keyCode == LEFT)  isLeftKeyPressed = false;
  if (key == 'd' || key == 'D' || keyCode == RIGHT) isRightKeyPressed = false;
  if (key == 'w' || key == 'W' || keyCode == UP)    isUpKeyPressed = false;
  if (key == 's' || key == 'S' || keyCode == DOWN)  isDownKeyPressed = false;
}

// ==========================================
// コピー＆ペースト用：Playerクラス
// ==========================================
class Player extends BaseClass {
  float moveSpeed;

  Player(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.moveSpeed = 4.0f;
  }

  // キー入力に応じた速度の計算
  void handleInput() {
    // 左右の移動
    if (isLeftKeyPressed) {
      this.vx = -this.moveSpeed;
    } else if (isRightKeyPressed) {
      this.vx = this.moveSpeed;
    } else {
      this.vx *= 0.8; // 移動キーを押していないときは摩擦で減速
    }

    // 上下の移動
    if (isUpKeyPressed) {
      this.vy = -this.moveSpeed;
    } else if (isDownKeyPressed) {
      this.vy = this.moveSpeed;
    } else {
      this.vy *= 0.8; // 移動キーを押していないときは摩擦で減速
    }
  }

  void update() {
    handleInput();
    super.update(); // 位置の更新(BaseClassで定義)

    // 画面外に出ないように制限する
    this.x = constrain(this.x, 0, width - this.w);
    this.y = constrain(this.y, 0, height - this.h);
  }

  void draw() {
    fill(100, 150, 255); // 青色
    super.draw();
  }
}

// --- BaseClass ---
class BaseClass {
  float x, y, vx = 0, vy = 0, w, h;
  PImage img;

  BaseClass(float x, float y, float w, float h) {
    this.x = x; this.y = y; this.w = w; this.h = h; this.img = null;
  }

  void update() {
    this.x += this.vx;
    this.y += this.vy;
  }

  void draw() {
    if (this.img != null) image(this.img, this.x, this.y, this.w, this.h);
    else rect(this.x, this.y, this.w, this.h);
  }
}
