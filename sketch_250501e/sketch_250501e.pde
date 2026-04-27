size(600, 600);
background(240);

int rows = 8;
int cols = 8;
float cellSize = width / cols;

//行方向(row)への繰り返し
for (int i = 0; i < rows; i++) {
  
  //列方向（col）への繰り返し
  for (int j = 0; j < cols; j++) {
  
    // 行と列の合計が偶数なら白、奇数なら黒
    if ((i + j) % 2 == 0) {
      
      fill(255); // 白
      
    } else {
      
      fill(0);   // 黒
      
    }

    float x = j * cellSize;
    float y = i * cellSize;

    noStroke();
    rect(x, y, cellSize, cellSize);
  }
}
