class Enemy {
  float x; // X座標
  float y; // Y座標
  int hp; // 体力
  int speed; // 移動速度
  color clr; // 色

  Enemy(float _x, float _y, int _hp, int _s, color _c) {
    x = _x;
    y = _y;
    hp = _hp;
    speed = _s;
    clr = _c;
  }
  
  void damage(int d) {
    hp -= d;
    if (hp <= 0) {
      println("Enemyを倒した！");
    }
  }

  void update() {
    x += speed;
    if (x > width) {
      x = 0;
    }
  }

  void draw() {
    fill(clr);
    rect(x, y, 40, 40);
  }
}

// 子クラス
class Slime extends Enemy {
  
  Slime(float _x, float _y) {
    super(_x, _y, 50, 1, color(0, 200, 0));
  }
  
  void draw() {
    fill(clr);
    ellipse(x + 20, y + 20, 40, 40);
  }
}

// メインプログラム
Enemy enemy;
Slime slime;

void setup() {
  size(800, 600);
  enemy = new Enemy(50, 50, 100, 2, color(200, 0, 0));
  slime = new Slime(50, 200);
}

void draw() {
  background(220);

  enemy.update();
  enemy.draw();

  slime.update();
  slime.draw();
}

void mousePressed(){
  // 敵にダメージを与える
  enemy.damage(5);
  slime.damage(5);
}
