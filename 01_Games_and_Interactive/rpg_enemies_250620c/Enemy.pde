class Enemy {
  float x;
  float y;
  int hp;
  int speed;
  color clr;
  PImage img;

  Enemy(float _x, float _y, int _hp, int _s, color _c) {
    x = _x;
    y = _y;
    hp = _hp;
    speed = _s;
    clr = _c;
  }

  void update() {
    y += speed;
    if (y > height) {
      y = 0;
    }
  }

  void draw() {
    fill(clr);
    ellipse(x, y, 40, 40);
  }
  
  void damage(int d){  
    println(d + "のダメージ！");
    hp -= d;
    if (hp <= 0){
      println("Enemyを倒した！");
    }
  }
  
  void heal(int h) {
    hp += h;
    println("回復した！");
  }
  
}
