class Slingshot extends BaseClass {

  boolean is_aiming;
  float aim_x, aim_y;

  Slingshot(float x, float y) {
    super(x, y, 40, 60);
    this.is_aiming = false;
  }

  void start_aiming(float mouse_x, float mouse_y) {
    this.is_aiming = true;
    this.aim_x = mouse_x;
    this.aim_y = mouse_y;
  }

  void update_aim(float mouse_x, float mouse_y) {
    this.aim_x = mouse_x;
    this.aim_y = mouse_y;
  }

  Bird launch_bird() {
    if (!this.is_aiming) return null;

    float dx = (this.x + this.w/2) - this.aim_x;
    float dy = (this.y + this.h/2) - this.aim_y;

    Bird bird = new Bird(this.x + this.w/2, this.y + this.h/2, 20, 20);
    bird.launch(dx * 0.2, dy * 0.2);

    this.is_aiming = false;
    return bird;
  }

  void draw() {
    fill(139, 69, 19);
    rect(this.x, this.y, this.w, this.h);

    if (this.is_aiming) {
      stroke(255, 0, 0);
      line(this.x + this.w/2, this.y + this.h/2, this.aim_x, this.aim_y);
      noStroke();
    }
  }
}
