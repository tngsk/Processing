void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100);
}

void draw() {
    
  
  if (mouseX < width/2) {
    background(180, 100, 100);
    
  } else {
    background(0, 100,100);
    
  }
  
  stroke(0, 0, 100);
  strokeWeight(2);
  line(width/2, 0, width/2, height);
  
  
  noStroke();
  fill(0, 0, 100);
  ellipse(mouseX, mouseY, 30, 30);
  
}
