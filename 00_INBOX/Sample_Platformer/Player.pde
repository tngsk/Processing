// プラットフォーマー用プレイヤークラス
class Player extends BaseClass {

  float moveSpeed;
  float jumpPower;
  boolean isGrounded;

  Player(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.moveSpeed = 3.0;
    this.jumpPower = 10.0;
    this.isGrounded = false;
  }

  void handleInput() {
    // 左右移動
    if (isLeftKeyPressed) {
      this.vx = -moveSpeed;
    } else if (isRightKeyPressed) {
      this.vx = moveSpeed;
    } else {
      this.vx *= 0.8; // 摩擦
    }
  }

  void jump() {
    if (isGrounded) {
      this.vy = -jumpPower;
      this.isGrounded = false;
    }
  }

  void update() {
    handleInput();

    // 重力適用
    applyGravity(this, 0.5);

    // 速度制限
    limitVelocity(this, 8);

    // 位置更新
    super.update();

    // 左右の境界チェックのみ
    this.x = constrain(this.x, 0, WORLD_WIDTH - this.w);

    // 画面下に落ちたらリスポーン
    if (this.y > WORLD_HEIGHT + 50) {
      this.x = 100;
      this.y = 300;
      this.vx = 0;
      this.vy = 0;
    }
  }

  void setGrounded(boolean grounded) {
    this.isGrounded = grounded;
  }

  void draw() {
    fill(100, 150, 255); // 青色
    super.draw();
  }
}
