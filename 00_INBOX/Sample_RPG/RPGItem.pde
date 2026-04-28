// シンプルなRPGアイテムクラス
class RPGItem extends BaseClass {

  String itemName;
  color itemColor;
  boolean isCollected;

  RPGItem(float x, float y, String name) {
    super(x, y, 20, 20);
    this.itemName = name;
    this.isCollected = false;

    // アイテムタイプに応じた色設定
    if (name.equals("Potion")) {
      this.itemColor = color(255, 100, 100); // 赤
    } else if (name.equals("Gold")) {
      this.itemColor = color(255, 255, 0); // 黄色
    } else {
      this.itemColor = color(150, 150, 255); // 青
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
