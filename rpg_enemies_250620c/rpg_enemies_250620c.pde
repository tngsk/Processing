Enemy e1;
Slime s1;
Slime s2;
Dragon d1;

void setup() {
  size(800, 600);
  e1 = new Enemy(100, 0, 100, 5, color(255, 255, 255));
  s1 = new Slime(350,450);
  s2 = new Slime(300,400);
  d1 = new Dragon(400,300);
}

void draw() {
  background(0);
  e1.update();
  e1.draw();
  
  s1.update();
  s1.draw();
  
  d1.update();
  d1.draw();

}

// マウスが押されたら
void mousePressed(){
  e1.damage(18);
  d1.fire();
}

// キーボードが押されたら
void keyPressed(){
  e1.heal(100);
}
