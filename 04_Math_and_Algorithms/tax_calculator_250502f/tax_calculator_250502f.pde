void setup() {
  size(600,400);
  background(0);
}

void draw() {
  background(0);
  //myFunction(mouseX);
  float price = tax(mouseX); 
  ellipse(mouseX, mouseY, price, price);
}

void myFunction(int x) {
  println(x + x * 0.1);
}

float tax(float x) {
  return x * 1.5;
}
