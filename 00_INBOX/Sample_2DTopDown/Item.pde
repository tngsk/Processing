class Item extends BaseClass {

  String itemType;
  boolean isCollected;
  int value;

  Item(float x, float y, float w, float h, String itemType) {
    super(x, y, w, h);
    this.itemType = itemType;
    this.isCollected = false;

    // アイテムタイプに応じた値設定
    if (itemType.equals("dot")) {
      this.value = 10;
    } else if (itemType.equals("power_pellet")) {
      this.value = 50;
    } else if (itemType.equals("bonus_fruit")) {
      this.value = 100;
    } else {
      this.value = 10;
    }
  }

  void collect() {
    this.isCollected = true;
    score += this.value;

    // パワーペレットの場合、プレイヤーをパワーアップ
    if (this.itemType.equals("power_pellet")) {
      player.powerUp();
    }
  }

  void draw() {
    if (this.isCollected) return;

    // アイテムタイプに応じた色設定
    if (this.itemType.equals("dot")) {
      fill(255, 255, 0); // 黄色（ドット）
    } else if (this.itemType.equals("power_pellet")) {
      fill(255, 255, 0); // 黄色（パワーペレット）
      // パワーペレットは点滅効果
      if (frameCount % 30 < 15) {
        fill(255, 255, 255); // 白色で点滅
      }
    } else if (this.itemType.equals("bonus_fruit")) {
      fill(255, 0, 255); // マゼンタ（ボーナス）
    } else {
      fill(255, 255, 0); // デフォルト黄色
    }

    super.draw();
  }
}
