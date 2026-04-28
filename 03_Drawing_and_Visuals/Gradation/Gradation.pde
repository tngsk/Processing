// 淡いパステルカラーのグラデーション

void setup() {
  size(800, 600);
  colorMode(HSB, 360, 1.0, 1.0); // HSBカラーモード(色相:0-360, 彩度・明度:0.0-1.0)
  noLoop();  // 一度だけ描画する
}

void draw() {
  // 傾きのパラメータ: 0.0〜1.0の値
  // 0.0: 縦方向のグラデーション
  // 0.5: 45度の斜め
  // 1.0: 横方向のグラデーション
  float slopeRatio = 0.7; // この値を変更して傾きを調整
  
  for (int y = 0; y < height; y++) {
    float y_ratio = (float)y / height;
    
    for (int x = 0; x < width; x++) {
      float x_ratio = (float)x / width;
      
      // 傾きを考慮した混合比率
      float mixRatio = slopeRatio * x_ratio + (1.0 - slopeRatio) * y_ratio;
      
      // 色相を淡い紫(220)から淡いピンク(340)へ変化
      float hue = lerp(200, 320, mixRatio);
      
      // 彩度は低めに保ってパステル感を出す
      float saturation = lerp(0.2, 0.3, y_ratio);
      
      // 明度は高めに保つ
      float brightness = lerp(0.95, 1.0, x_ratio);
      
      stroke(hue, saturation, brightness);
      point(x, y);
    }
  }
}

void keyPressed(){
  save("image.png");
}
