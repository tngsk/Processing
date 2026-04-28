// キャッチゲーム用アイテムクラス
class Item extends BaseClass {

  String itemType;
  int value;
  color itemColor;
  boolean isCollected;

  Item(float x, float y, float w, float h, String type) {
    super(x, y, w, h);
    this.itemType = type;
    this.isCollected = false;

    // アイテムタイプに応じた設定
    if (type.equals("coin")) {
      this.value = 10;
      this.itemColor = color(255, 255, 0); // 黄色
    } else if (type.equals("gem")) {
      this.value = 50;
      this.itemColor = color(255, 100, 255); // マゼンタ
    } else {
      this.value = 100;
      this.itemColor = color(100, 255, 100); // 緑色
    }

    // 下向きに落下
    this.vy = 3.0;
  }

  void update() {
    super.update();

    // 画面外に出たら削除
    if (this.y > height + 50) {
      this.isCollected = true;
    }
  }

  void collect() {
    this.isCollected = true;
  }

  void draw() {
    if (!isCollected) {
      fill(itemColor);
      super.draw();
    }
  }
}
