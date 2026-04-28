// Sample Catch - Main.pde
// シンプルな「落ちてくるアイテムをキャッチ」デモ
// removeIf を使わず、逆順ループで安全に削除する実装例


// --- 入力状態 ---
boolean isLeftKeyPressed = false;
boolean isRightKeyPressed = false;

ArrayList<Item> items;
Player player;

int spawnTimer = 0;
int spawnInterval = 60; // フレーム単位（60fpsで1秒）
int score = 0;
int timeLimit = 60 * 60; // 60秒（frame単位）

void setup() {
  size(800, 600);
  frameRate(60);

  // 描画モードの明示（CODING_RULES に準拠）
  rectMode(CORNER);
  imageMode(CORNER);
  ellipseMode(CENTER);

  items = new ArrayList<Item>();
  player = new Player(width/2 - 40, height - 80, 80, 40);
}

void draw() {
  background(30, 30, 40);

  // タイマー処理：一定間隔でアイテムを生成
  spawnTimer++;
  if (spawnTimer >= spawnInterval) {
    spawnItem();
    spawnTimer = 0;
  }

  // プレイヤー更新・描画
  player.update();
  player.draw();

  // アイテムを順に更新・描画
  for (Item it : items) {
    it.update();
    it.draw();
  }

  // 当たり判定（プレイヤーとアイテム）
  for (Item it : items) {
    if (!it.isCollected && isColliding(player, it)) {
      it.collect();
      score += it.value;
    }
  }

  // 逆順ループで安全に削除する
  // [なぜ?] 前から削除するとインデックスがずれるため、後ろから削除する
  for (int i = items.size() - 1; i >= 0; i--) {
    Item it = items.get(i);
    if (it.isCollected || it.y > height + 50) {
      items.remove(i);
    }
  }

  // UI 表示
  drawUI();
}

void spawnItem() {
  float x = random(20, width - 20);
  Item it = new Item(x, -20, 20, 20, "coin");
  items.add(it);
}

void drawUI() {
  fill(255);
  textSize(18);
  textAlign(LEFT, TOP);
  text("Score: " + score, 10, 10);
  text("Items: " + items.size(), 10, 34);
}


// --- キー入力 ---
void keyPressed() {
  if (keyCode == LEFT) {
    isLeftKeyPressed = true;
  } else if (keyCode == RIGHT) {
    isRightKeyPressed = true;
  }
}

void keyReleased() {
  if (keyCode == LEFT) {
    isLeftKeyPressed = false;
  } else if (keyCode == RIGHT) {
    isRightKeyPressed = false;
  }
}

// --- Added from Item.pde ---
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

// --- Added from Player.pde ---
// キャッチゲーム用プレイヤークラス
class Player extends BaseClass {

  float moveSpeed;

  Player(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.moveSpeed = 5.0;
  }

  void handleInput() {
    // 左右移動のみ
    if (isLeftKeyPressed) {
      this.vx = -moveSpeed;
    } else if (isRightKeyPressed) {
      this.vx = moveSpeed;
    } else {
      this.vx = 0;
    }
  }

  void update() {
    handleInput();
    super.update();

    // 画面境界チェック（左右のみ）
    this.x = constrain(this.x, 0, width - this.w);
  }

  void draw() {
    fill(100, 150, 255); // 青色
    super.draw();
  }
}
