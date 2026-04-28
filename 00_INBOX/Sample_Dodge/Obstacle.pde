// 障害物クラス
class Obstacle extends BaseClass {

  float moveSpeed;
  color obstacleColor;
  boolean isActive;

  Obstacle(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.moveSpeed = 2.0;
    this.obstacleColor = color(255, 100, 100);
    this.isActive = true;

    // 移動方向を設定
    if (y < 0) {
      this.vy = moveSpeed; // 上から下へ
    } else if (y > height) {
      this.vy = -moveSpeed; // 下から上へ
    } else if (x < 0) {
      this.vx = moveSpeed; // 左から右へ
    } else if (x > width) {
      this.vx = -moveSpeed; // 右から左へ
    }
  }

  void update() {
    super.update();

    // 画面外に出たら非アクティブ
    if (this.x < -50 || this.x > width + 50 || this.y < -50 || this.y > height + 50) {
      this.isActive = false;
    }
  }

  void draw() {
    if (isActive) {
      fill(obstacleColor);
      super.draw();
    }
  }
}
