class Ball {

  float x;
  float y;
  float size;
  float vx;
  float vy;
  float clr;
  float bounce;
  float gravity;

  Ball(
    float _x, float _y, float _size, color _color) {

    x = _x;
    y = _y;
    size = _size;
    clr = _color;

    vx = random(3, 8);
    vy = random(3, 8);
    gravity = 0.98;
    bounce = random(0.8, 0.98);
  }

  void update() {
    vy += gravity;
    y += vy;
    if (y > height) {
      y = height;
      vy = -vy * bounce;
    }
  }

  void draw() {
    fill(clr);
    ellipse(x, y, size, size);
  }
}
