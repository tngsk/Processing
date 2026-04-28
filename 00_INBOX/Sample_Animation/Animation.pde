// 単一アニメーション配列のシンプルなアニメーションクラス
class Animation extends BaseClass {

  PImage[] frames;        // アニメーションフレーム配列
  int currentFrame;       // 現在のフレーム番号
  int frameTimer;         // フレームタイマー
  int frameDelay;         // フレーム切り替えの遅延

  Animation(float x, float y, float w, float h, PImage[] frames) {
    super(x, y, w, h);
    this.frames = frames;
    this.currentFrame = 0;
    this.frameTimer = 0;
    this.frameDelay = 8;
  }

  void update() {
    super.update();

    if (frames.length > 0) {
      frameTimer++;
      if (frameTimer >= frameDelay) {
        frameTimer = 0;
        currentFrame = (currentFrame + 1) % frames.length;
      }
    }
  }

  void draw() {
    if (frames.length > 0 && frames[currentFrame] != null) {
      image(frames[currentFrame], x, y, w, h);
    } else {
      fill(100, 150, 255);
      super.draw();
    }
  }

  void setSpeed(int delay) {
    frameDelay = delay;
  }

  void reset() {
    currentFrame = 0;
    frameTimer = 0;
  }
}
