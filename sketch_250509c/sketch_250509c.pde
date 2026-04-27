
void setup(){
  size(600, 600);
  colorMode(HSB, 360, 100, 100);
}


void draw(){
  background(0);
  noStroke();
  
  if (mouseX > width / 2){
    background(40, 80, 100);
    fill(80, 80, 100);
  } 
  
  if (mouseX < width / 2){
    background(80, 80, 100);
    fill(40, 80, 100);
  }
  
  stroke(0,0,100);
  strokeWeight(10);
  line(width/2, 0, width/2, height);
  ellipse(mouseX, mouseY, 100, 100);

}
