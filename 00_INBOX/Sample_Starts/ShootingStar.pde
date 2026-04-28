class ShootingStar {
  float x, y, vx, vy, tail;
  boolean active;

  ShootingStar() {
    x = random(width * 0.8, width * 1.2);
    y = random(-height * 0.2, height * 0.3);
    vx = random(-8, -3);
    vy = random(2, 6);
    tail = random(30, 80);
    active = true;
  }

  void update() {
    if (!active) return;
    x += vx;
    y += vy;
    if (x < -100 || y > height + 100) active = false;
  }

  void draw() {
    if (!active) return;
    stroke(255, 255, 200);
    line(x, y, x + tail * (-vx/8), y + tail * (-vy/8));
    stroke(255);
    point(x, y);
  }
}
