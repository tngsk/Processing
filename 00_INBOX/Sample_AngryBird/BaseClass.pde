// すべてのオブジェクトの基礎となるクラス
//位置とサイズと移動速度を持ち、画像も設定できるオブジェクト

class BaseClass {

  float x, y; //位置
  float vx = 0, vy = 0; //速度
  float w, h; //サイズ
  PImage img; //画像

  //コンストラクタ（画像なし）
  BaseClass(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = null;
  }

  //コンストラクタ（画像も設定する）
  BaseClass(float x, float y, float w, float h, PImage img) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = img;
  }

  void update() {
    x += vx;
    y += vy;
  }

  void draw() {
    //もし画像が設定されていれば表示する
    if (img != null) {
      image(img, x, y, w, h);
    } else {
      //画像がないときはrectを表示する
      rect(x, y, w, h);
    }
  }

  //画像を設定する
  void setImage(PImage img) {
    this.img = img;
  }

  //衝突判定
  boolean onCollision(BaseClass other) {
    return (x < other.x + other.w &&
            x + w > other.x &&
            y < other.y + other.h &&
            y + h > other.y);
  }

}
