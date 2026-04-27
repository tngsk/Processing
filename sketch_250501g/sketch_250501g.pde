
void setup() {
  size(600,600);
  colorMode(HSB, 360, 100, 100);
  
  MMouse(300,300);
}

void MMouse(float x, float y) {
  pushMatrix();
  translate(x,y);
  scale(1.0);
  noStroke();
  fill(0, 0, 0);
  ellipse(0,0,100,100);
  ellipse(-50,-50,60,60);
  ellipse(50,-50,60,60);
  popMatrix();
}
