class Wall extends BaseClass {

  Wall(float x, float y, float w, float h) {
    super(x, y, w, h);
  }

  void draw() {
    fill(100, 100, 100); // 灰色
    super.draw();
  }
}
