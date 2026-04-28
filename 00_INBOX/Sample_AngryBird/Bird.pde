class Bird extends BaseClass {

  boolean is_launched;
  boolean is_exploded;
  int still_timer;

  Bird(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.is_launched = false;
    this.is_exploded = false;
    this.still_timer = 0;
  }

  void launch(float vel_x, float vel_y) {
    this.vx = vel_x;
    this.vy = vel_y;
    this.is_launched = true;
  }

  void update() {
    if (this.is_launched && !this.is_exploded) {
      applyGravity(this, 0.25);
      super.update();

      // 地面跳ね返り
      if (this.y > 620) {
        this.y = 620;
        this.vy = -this.vy * 0.6;
        this.vx *= 0.9;
      }

      // 壁跳ね返り
      if (this.x < 0) {
        this.x = 0;
        this.vx = -this.vx * 0.6;
      }
      if (this.x > 1580) {
        this.x = 1580;
        this.vx = -this.vx * 0.6;
      }

      // 静止判定
      if (abs(this.vx) < 0.5 && abs(this.vy) < 0.5) {
        this.still_timer++;
        if (this.still_timer > 120) {
          this.is_exploded = true;
        }
      } else {
        this.still_timer = 0;
      }
    }
  }

  void draw() {
    if (!this.is_exploded) {
      fill(255, 0, 0);
      ellipse(this.x, this.y, this.w, this.h);
    }
  }
}
