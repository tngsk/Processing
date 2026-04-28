
void setup(){

  size(800,600);
  rectMode(CENTER);
  
}

void draw() {
  
  background(200);
  
  float diff = width/2 - (width/2 - mouseX);
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(diff/5));
  rect(0, 0, 50,50);
  popMatrix();


}
