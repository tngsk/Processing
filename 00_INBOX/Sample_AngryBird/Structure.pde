class Structure extends BaseClass {

  boolean is_destroyed;
  boolean is_static;

  Structure(float x, float y, float w, float h, int type) {
    super(x, y, w, h);
    this.is_destroyed = false;
    this.is_static = (type == 1);
  }

  void destroy() {
    if (!this.is_destroyed) {
      this.is_destroyed = true;
      score += 50;
    }
  }

  void update() {
    if (!this.is_destroyed && !this.is_static) {
      applyGravity(this, 0.25);
      super.update();

      if (this.y > 620) {
        this.y = 620;
        this.vy = 0;
        this.vx *= 0.7;
      }

      checkBounds(this, 0, 0, 1600, 720, 0.3);
    }
  }

  void draw() {
    if (!this.is_destroyed) {
      fill(139, 69, 19);
      rect(this.x, this.y, this.w, this.h);
    }
  }
}
