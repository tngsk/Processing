// シンプルなRPGプレイヤークラス
class RPGPlayer extends BaseClass {

  int health;
  int maxHealth;
  int gold;
  float moveSpeed;
  ArrayList<String> inventory;

  RPGPlayer(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.maxHealth = 100;
    this.health = maxHealth;
    this.gold = 0;
    this.moveSpeed = 3.0;
    this.inventory = new ArrayList<String>();
  }

  void handleInput() {
    // 移動入力
    if (isLeftKeyPressed) {
      this.vx = -moveSpeed;
    } else if (isRightKeyPressed) {
      this.vx = moveSpeed;
    } else {
      this.vx = 0;
    }

    if (isUpKeyPressed) {
      this.vy = -moveSpeed;
    } else if (isDownKeyPressed) {
      this.vy = moveSpeed;
    } else {
      this.vy = 0;
    }
  }

  void collectItem(String item) {
    inventory.add(item);

    // アイテム効果
    if (item.equals("Potion")) {
      heal(20);
    } else if (item.equals("Gold")) {
      gold += 10;
    }
  }

  void heal(int amount) {
    health = min(health + amount, maxHealth);
  }

  void takeDamage(int damage) {
    health -= damage;
    health = max(0, health);
  }

  void update() {
    handleInput();
    super.update();

    // 画面境界チェック（画面内で自由移動）
    this.x = constrain(this.x, 0, width - this.w);
    this.y = constrain(this.y, 0, height - this.h);
  }

  void draw() {
    fill(100, 255, 100); // 緑色
    super.draw();

    // 体力バー
    fill(255, 0, 0);
    rect(x, y - 10, w * (float)health / maxHealth, 5);
  }
}
