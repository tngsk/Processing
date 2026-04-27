void setup() {
  size(600, 600);
  background(240);

 
  stroke(30, 100, 200);
  strokeWeight(2);

  for (int i = 1; i < 10; i++) {
    // 左端の点のy座標
    float y1 = 60 * i;

    // 右下の点のx座標
    float x2 = 60 * i;

    // 左端の点から下端の点へ線を引く
    line(60, y1, x2, height - 60);
  }
}
