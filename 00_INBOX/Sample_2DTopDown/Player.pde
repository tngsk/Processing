class Player extends BaseClass {

  float moveSpeed;
  int health;
  boolean hasPowerUp;
  int powerUpTimer;

  Player(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.moveSpeed = 3.0;
    this.health = 100;
    this.hasPowerUp = false;
    this.powerUpTimer = 0;
  }

  void update() {
    // パワーアップタイマー更新
    if (this.hasPowerUp) {
      this.powerUpTimer--;
      if (this.powerUpTimer <= 0) {
        this.hasPowerUp = false;
      }
    }

    // 入力処理
    handleInput();

    // 摩擦適用
    applyFriction(this, 0.85);

    // 位置更新
    super.update();

    // 境界チェック
    checkBounds(this, 0, 0, WORLD_WIDTH, WORLD_HEIGHT, 0);
  }

  void handleInput() {
    // 上下移動
    if (isUpKeyPressed) {
      this.vy = -this.moveSpeed;
    } else if (isDownKeyPressed) {
      this.vy = this.moveSpeed;
    } else {
      // 移動していない時に摩擦を適用する
      this.vy *= 0.8;
    }

    // 左右移動
    if (isLeftKeyPressed) {
      this.vx = -this.moveSpeed;
    } else if (isRightKeyPressed) {
      this.vx = this.moveSpeed;
    } else {
      // 移動していない時に摩擦を適用する
      this.vx *= 0.8;
    }
  }

  void powerUp() {
    this.hasPowerUp = true;
    this.powerUpTimer = 300; // 5秒間
  }

  void takeDamage(int damage) {
    this.health -= damage;
    if (this.health <= 0) {
      this.health = 0;
      respawn();
    }
  }

  void respawn() {
    this.x = 50;
    this.y = 50;
    this.vx = 0;
    this.vy = 0;
    this.health = 100;
    this.hasPowerUp = false;
    this.powerUpTimer = 0;
  }

  void draw() {
    if (this.hasPowerUp) {
      fill(255, 255, 0); // 黄色（パワーアップ中）
    } else {
      fill(0, 255, 0); // 緑色（通常時）
    }
    super.draw();
  }
}
