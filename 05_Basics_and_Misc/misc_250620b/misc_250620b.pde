// Enemyクラスの定義
class Enemy {
  float x; // X座標
  float y; // Y座標
  int hp; // 体力
  int speed; // 移動速度
  color clr; // 色
  PImage img;
  
  Enemy(float _x, float _y, int _hp, int _s, color _c) {
    x = _x;
    y = _y;
    hp = _hp;
    speed = _s;
    clr = _c;
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
// メインプログラム

Enemy enemy1;
Enemy enemy2;
Enemy enemy3;


void setup() {
  size(800, 600);
  enemy1 = new Enemy(50, 100, 100, 10, color(255, 0, 0));
  enemy2 = new Enemy(150, 300, 80, 8, color(0, 255, 0));
  enemy3 = new Enemy(150, 340, 10, 9, color(0, 255, 255));
}
void draw() {
  background(220);
  
  enemy1.update();
  enemy1.draw();
  
  enemy2.update();
  enemy2.draw();
  
  enemy3.update();
  enemy3.draw();
  
}
