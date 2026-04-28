// シンプルなシューティングゲーム用プレイヤークラス
class Player extends BaseClass {

  float moveSpeed;
  int shootCooldown;
  int lives;

  Player(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.moveSpeed = 4.0;
    this.shootCooldown = 0;
    this.lives = 3;
  }

  void handleInput() {
    // 左右移動
    if (isLeftKeyPressed) {
      this.vx = -this.moveSpeed;
    } else if (isRightKeyPressed) {
      this.vx = this.moveSpeed;
    } else {
      this.vx = 0;
    }

    // 上下移動
    if (isUpKeyPressed) {
      this.vy = -this.moveSpeed;
    } else if (isDownKeyPressed) {
      this.vy = this.moveSpeed;
    } else {
      this.vy = 0;
    }

    // 射撃
    if (isShootKeyPressed && shootCooldown <= 0) {
      shoot();
      shootCooldown = 15; // クールダウン
    }
  }

  void shoot() {
    Bullet bullet = new Bullet(this.x + this.w/2 - 2, this.y, 4, 8);
    bullet.vy = -6; // 上向きに射撃
    bullets.add(bullet);
  }

  void takeDamage() {
    lives--;
  }

  void update() {
    handleInput();

    // クールダウン処理
    if (shootCooldown > 0) {
      shootCooldown--;
    }

    // 位置更新
    super.update();

    // 左右の境界チェックのみ
    this.x = constrain(this.x, 0, width - this.w);
  }

  void draw() {
    fill(100, 150, 255); // 青色
    super.draw();
  }
}
