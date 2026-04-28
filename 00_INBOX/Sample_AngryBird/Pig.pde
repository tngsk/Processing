class Pig extends BaseClass {

  boolean is_alive;

  Pig(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.is_alive = true;
  }

  void destroy() {
    if (this.is_alive) {
      this.is_alive = false;
      score += 100;
    }
  }

  void update() {
    if (this.is_alive) {
      applyGravity(this, 0.25);
      super.update();

      if (this.y > 620) {
        this.y = 620;
        this.vy = 0;
        this.vx *= 0.8;
      }

      checkBounds(this, 0, 0, 1600, 720, 0.3);
    }
  }

  void draw() {
    if (this.is_alive) {
      fill(0, 255, 0);
      ellipse(this.x, this.y, this.w, this.h);
    }
  }
}
