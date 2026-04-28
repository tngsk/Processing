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
