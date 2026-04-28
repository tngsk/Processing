
Ball b1;
Ball b2;

void setup(){
  size(800,600);
  b1 = new Ball(200, 20, 80, color(255, 0, 0));
  b2 = new Ball(600, 20, 80, color(255, 0, 0));
}

void draw(){
  background(255);
  b1.update();
  b1.draw();
  
  b2.update();
  b2.draw();
}
