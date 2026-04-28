class Enemy extends BaseClass {

  boolean isActive;
  float moveSpeed;
  float directionX, directionY;
  int directionTimer;

  Enemy(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.isActive = true;
    this.moveSpeed = 1.5;
    this.directionX = random(-1, 1);
    this.directionY = random(-1, 1);
    this.directionTimer = 0;
  }

  void update() {
    if (!this.isActive) return;

    // 方向変更タイマー
    this.directionTimer--;
    if (this.directionTimer <= 0) {
      this.directionX = random(-1, 1);
      this.directionY = random(-1, 1);
      this.directionTimer = int(random(60, 180)); // 1-3秒
    }

    // 移動
    this.vx = this.directionX * this.moveSpeed;
    this.vy = this.directionY * this.moveSpeed;

    // 位置更新
    super.update();

    // 境界チェック
    checkBounds(this, 0, 0, WORLD_WIDTH, WORLD_HEIGHT, 0);
  }

  void getDefeated() {
    this.isActive = false;
  }

  void draw() {
    if (!this.isActive) return;

    fill(255, 0, 0); // 赤色
    super.draw();
  }
}
