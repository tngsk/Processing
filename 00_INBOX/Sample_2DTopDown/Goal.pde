class Goal extends BaseClass {

  boolean isActive;
  boolean isReached;

  Goal(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.isActive = false;
    this.isReached = false;
  }

  void update() {
    // ゴールの更新処理（必要に応じて）
  }

  void reachGoal() {
    if (this.isActive && !this.isReached) {
      this.isReached = true;
      println("Goal reached! Score: " + score);
      // ゲームクリア処理はMain.pdeで行う
    }
  }

  void draw() {
    if (this.isActive) {
      fill(0, 255, 0); // 緑色（アクティブ）
      // 点滅効果
      if (frameCount % 60 < 30) {
        fill(0, 200, 0);
      }
    } else {
      fill(100, 100, 100); // 灰色（非アクティブ）
    }
    super.draw();
  }
}
