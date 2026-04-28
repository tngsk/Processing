// キャッチゲーム用プレイヤークラス
class Player extends BaseClass {

  float moveSpeed;

  Player(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.moveSpeed = 5.0;
  }

  void handleInput() {
    // 左右移動のみ
    if (isLeftKeyPressed) {
      this.vx = -moveSpeed;
    } else if (isRightKeyPressed) {
      this.vx = moveSpeed;
    } else {
      this.vx = 0;
    }
  }

  void update() {
    handleInput();
    super.update();

    // 画面境界チェック（左右のみ）
    this.x = constrain(this.x, 0, width - this.w);
  }

  void draw() {
    fill(100, 150, 255); // 青色
    super.draw();
  }
}
