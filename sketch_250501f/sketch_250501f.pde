void setup() {
  size(600, 600);
  background(240);
  
  int rows = 5;
  int cols = 5;
  
  float grid_w = width / cols;
  float grid_h = height / rows;
  
  for (int row = 0; row < rows; row++) {
    
    for (int col = 0; col < cols; col++) {
      
      float x = col * grid_w + (grid_w / 2);
      float y = row * grid_h + (grid_h / 2);
            
      drawShape(x, y);
    }
  }
}

// シンプルな図形を描画する関数
void drawShape(float x, float y) {
  pushMatrix();
  translate(x, y);
  ellipse(0, 0, 30, 30);
  popMatrix();
}
