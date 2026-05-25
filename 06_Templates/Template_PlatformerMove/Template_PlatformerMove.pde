// ===== テンプレート：横スクロールアクション(プラットフォーマー)の移動 =====
//
// 用途: ジャンプ、重力、足場の判定を必要とするゲームの実装に使用します。

// --- キー入力状態フラグ ---
boolean isLeftKeyPressed = false;
boolean isRightKeyPressed = false;

Player player;
ArrayList<Platform> platforms;

void setup() {
  size(800, 600);
  rectMode(CORNER);

  player = new Player(100, 300, 40, 60);

  // 足場の準備
  platforms = new ArrayList<Platform>();
  platforms.add(new Platform(0, height - 40, width, 40));   // 床
  platforms.add(new Platform(200, 4.0f, 150, 20));           // 浮島1
  platforms.add(new Platform(500, 350, 150, 20));           // 浮島2
}

void draw() {
  background(135, 206, 235); // 空色

  // 足場との衝突判定と接地フラグの更新
  handlePlatforms(player, platforms);
  player.setGrounded(isOnGround(player, platforms));

  player.update();

  // 足場の描画
  for (Platform p : platforms) {
    p.draw();
  }

  player.draw();

  // UIの表示
  fill(0);
  textSize(20);
  textAlign(LEFT, TOP);
  text("Left/Right to Move, Space to Jump", 10, 10);
}

// キーボード入力
void keyPressed() {
  if (keyCode == LEFT)  isLeftKeyPressed = true;
  if (keyCode == RIGHT) isRightKeyPressed = true;
  if (key == ' ')       player.jump(); // ジャンプ
}

void keyReleased() {
  if (keyCode == LEFT)  isLeftKeyPressed = false;
  if (keyCode == RIGHT) isRightKeyPressed = false;
}

// ==========================================
// コピー＆ペースト用：物理・衝突判定関数
// ==========================================

// オブジェクト同士が重なっているか（衝突しているか）を判定する
boolean isColliding(BaseClass obj1, BaseClass obj2) {
  return (obj1.x < obj2.x + obj2.w &&
          obj1.x + obj1.w > obj2.x &&
          obj1.y < obj2.y + obj2.h &&
          obj1.y + obj1.h > obj2.y);
}

// オブジェクトが足場の上に載っているか（接地しているか）を判定する
boolean isOnGround(BaseClass obj, ArrayList<Platform> platforms) {
  for (Platform platform : platforms) {
    if (obj.x < platform.x + platform.w &&
        obj.x + obj.w > platform.x &&
        obj.y + obj.h >= platform.y &&
        obj.y + obj.h <= platform.y + 5) { // 5ピクセル以内のめり込みを許容
      return true;
    }
  }
  return false;
}

// 足場との衝突を解決（めり込みを押し戻す）する処理
void resolveCollision(BaseClass moving, BaseClass staticObj) {
  if (!isColliding(moving, staticObj)) return;

  float overlapLeft = (moving.x + moving.w) - staticObj.x;
  float overlapRight = (staticObj.x + staticObj.w) - moving.x;
  float overlapTop = (moving.y + moving.h) - staticObj.y;
  float overlapBottom = (staticObj.y + staticObj.h) - moving.y;

  float minOverlap = min(min(overlapLeft, overlapRight), min(overlapTop, overlapBottom));

  if (minOverlap == overlapLeft) {
    moving.x = staticObj.x - moving.w; moving.vx = 0;
  } else if (minOverlap == overlapRight) {
    moving.x = staticObj.x + staticObj.w; moving.vx = 0;
  } else if (minOverlap == overlapTop) {
    moving.y = staticObj.y - moving.h; moving.vy = 0; // 足場に着地
  } else if (minOverlap == overlapBottom) {
    moving.y = staticObj.y + staticObj.h; moving.vy = 0; // 頭をぶつけた
  }
}

// 全ての足場に対して衝突解決を実行する
void handlePlatforms(BaseClass obj, ArrayList<Platform> platforms) {
  for (Platform platform : platforms) {
    resolveCollision(obj, platform);
  }
}

// ==========================================
// コピー＆ペースト用：Playerクラス (プラットフォーマー用)
// ==========================================
class Player extends BaseClass {
  float moveSpeed;
  float jumpPower;
  boolean isGrounded;

  Player(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.moveSpeed = 4.0f;
    this.jumpPower = 12.0f;
    this.isGrounded = false;
  }

  void handleInput() {
    if (isLeftKeyPressed) {
      this.vx = -moveSpeed;
    } else if (isRightKeyPressed) {
      this.vx = moveSpeed;
    } else {
      this.vx *= 0.8; // 摩擦で減速
    }
  }

  void jump() {
    // 地面にいるときだけジャンプできる
    if (isGrounded) {
      this.vy = -jumpPower;
      this.isGrounded = false;
    }
  }

  void update() {
    handleInput();

    // 重力をかける (毎フレーム下方向に加速)
    this.vy += 0.5;

    // 落下速度の制限 (早すぎると足場をすり抜けてしまうため)
    if (this.vy > 15) this.vy = 15;

    super.update(); // 位置の更新

    // 画面の左右の境界チェック
    this.x = constrain(this.x, 0, width - this.w);

    // 画面下に落ちたら上からリスポーン
    if (this.y > height + 50) {
      this.x = 100;
      this.y = 100;
      this.vx = 0;
      this.vy = 0;
    }
  }

  void setGrounded(boolean grounded) {
    this.isGrounded = grounded;
  }

  void draw() {
    fill(255, 100, 100); // 赤色
    super.draw();
  }
}

// 足場クラス
class Platform extends BaseClass {
  Platform(float x, float y, float w, float h) {
    super(x, y, w, h);
  }
  void draw() {
    fill(100, 150, 50); // 緑色
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
