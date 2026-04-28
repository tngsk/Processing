// 避けゲーム用プレイヤークラス
class Player extends BaseClass {

  float moveSpeed;
  int lives;

  Player(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.moveSpeed = 4.0;
    this.lives = 3;
  }

  void handleInput() {
    // 移動入力
    if (isLeftKeyPressed) {
      this.vx = -moveSpeed;
    } else if (isRightKeyPressed) {
      this.vx = moveSpeed;
    } else {
      this.vx = 0;
    }

    if (isUpKeyPressed) {
      this.vy = -moveSpeed;
    } else if (isDownKeyPressed) {
      this.vy = moveSpeed;
    } else {
      this.vy = 0;
    }
  }

  void takeDamage() {
    lives--;
  }

  void update() {
    handleInput();
    super.update();

    // 画面境界チェック（画面内で自由移動）
    this.x = constrain(this.x, 0, width - this.w);
    this.y = constrain(this.y, 0, height - this.h);
  }

  void draw() {
    fill(100, 255, 100); // 緑色
    super.draw();
  }
}
