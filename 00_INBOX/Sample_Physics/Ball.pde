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
