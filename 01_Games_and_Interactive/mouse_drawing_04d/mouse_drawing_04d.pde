void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  background(0,0,0);
  
  noStroke();
  fill(0, 0, 100);
  ellipse(mouseX, mouseY, 30, 30);
}
