void setup() {
  size(600, 600);
  noStroke();
  fill(0);

  float x = 200;
  float y = 400;

  MMouse(100, 200);
  MMouse(300, 200);
  MMouse(500, 200);

  MMouse(100, 400);
  MMouse(300, 400);
  MMouse(500, 400);
}

void MMouse(float x, float y) {
  
  pushMatrix();
  translate(x,y);
  scale(0.75);
  rotate(radians(15));
  
  fill(80,80,80);
  ellipse(0, 0, 100, 100);
  ellipse(-50, -50, 60, 60);
  ellipse(+50, -50, 60, 60);
  
  popMatrix();
}
