
//グラデーションの背景を作るクラス
//表示だけで当たり判定がないので、BaseClassを継承せずに作成

class GradientBackground {
  color top, bottom;

  GradientBackground() {
    top = color(5, 5, 20);
    bottom = color(30, 30, 50);
  }

  void draw() {
    
    //少しずつ色を変えた線を描画することでグラデーションにする
    //widthやheightを変更して、任意のサイズのグラデーションを作れる
    
    for (int i = 0; i <= height; i++) {
      stroke(lerpColor(top, bottom, map(i, 0, height, 0, 1)));
      line(0, i, width, i);
    }
    noStroke();
  }

  void set(color t, color b) {
    top = t;
    bottom = b;
  }
}
