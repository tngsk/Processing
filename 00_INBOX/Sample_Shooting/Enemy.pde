// シンプルな敵クラス
class Enemy extends BaseClass {

  float moveSpeed;
  int shootTimer;
  int shootInterval;

  Enemy(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.moveSpeed = 2.0;
    this.shootTimer = 0;
    this.shootInterval = 120; // 2秒間隔
  }

  void update() {
    // 下に移動
    this.vy = moveSpeed;

    // 位置更新
    super.update();

    // 射撃処理
    shootTimer++;
    if (shootTimer >= shootInterval) {
      shoot();
      shootTimer = 0;
    }

    // 画面外に出たら削除
    if (this.y > height + 50) {
      this.x = -1000; // 削除フラグとして使用
    }
  }

  void shoot() {
    Bullet bullet = new Bullet(this.x + this.w/2 - 2, this.y + this.h, 4, 8);
    bullet.vy = 3; // 下向きに射撃
    bullets.add(bullet);
  }

  void takeDamage() {
    this.x = -1000; // 削除フラグとして使用
  }

  void draw() {
    fill(255, 100, 100); // 赤色
    super.draw();
  }
}
