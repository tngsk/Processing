// プラットフォームクラス
class Platform extends BaseClass {

  Platform(float x, float y, float w, float h) {
    super(x, y, w, h);
  }

  void draw() {
    fill(150, 100, 50); // 茶色
    super.draw();
  }
}
