void setup(){
  size(600, 600);
  
  for (int i = 0; i < 8; i++){
    float x = i * 50;
    float y = i * 50;
    ellipse(100 + x, 100 + y, 50, 50);
  }
}
