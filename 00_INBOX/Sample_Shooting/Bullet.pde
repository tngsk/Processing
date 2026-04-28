// シンプルな弾丸クラス
class Bullet extends BaseClass {

  Bullet(float x, float y, float w, float h) {
    super(x, y, w, h);
  }

  void update() {
    super.update();

    // 画面外に出たら削除
    if (this.y < -50 || this.y > height + 50) {
      this.x = -1000; // 削除フラグとして使用
    }
  }

  void draw() {
    fill(255, 255, 0); // 黄色の弾丸
    super.draw();
  }
}
