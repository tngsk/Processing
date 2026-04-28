// Sample Catch - Main.pde
// シンプルな「落ちてくるアイテムをキャッチ」デモ
// removeIf を使わず、逆順ループで安全に削除する実装例

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
  player.display();

  // アイテムを順に更新・描画
  for (Item it : items) {
    it.update();
    it.display();
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
  Item it = new Item(x, -20, 20, 20);
  items.add(it);
}

void drawUI() {
  fill(255);
  textSize(18);
  textAlign(LEFT, TOP);
  text("Score: " + score, 10, 10);
  text("Items: " + items.size(), 10, 34);
}

// 矩形同士の当たり判定（簡易版）
boolean isColliding(Player p, Item it) {
  return (p.x < it.x + it.w &&
          p.x + p.w > it.x &&
          p.y < it.y + it.h &&
          p.y + p.h > it.y);
}

// --------------------
// Player クラス
// --------------------
class Player {
  float x, y;
  float w, h;
  float speed = 6;

  Player(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }

  void update() {
    // キー入力で左右移動
    if (keyPressed) {
      if (keyCode == LEFT)  x -= speed;
      if (keyCode == RIGHT) x += speed;
    }
    // マウスを使って操作する場合はこちら（コメントアウト）
    // x = constrain(mouseX - w/2, 0, width - w);

    // 画面内に収める
    x = constrain(x, 0, width - w);
  }

  void display() {
    fill(200, 200, 255);
    noStroke();
    rect(x, y, w, h);
  }
}

// --------------------
// Item クラス
// --------------------
class Item {
  float x, y;
  float w, h;
  float vy = 0;
  float gravity = 0.4;
  boolean isCollected = false;
  int value = 10; // 得点

  Item(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    vy = random(1, 3);
  }

  void update() {
    if (!isCollected) {
      vy += gravity;
      y += vy;
    } else {
      // 収集されたらゆっくり上にフェードアウトする挙動（任意）
      y -= 2;
    }
  }

  void display() {
    if (!isCollected) {
      fill(255, 200, 50);
    } else {
      fill(150, 255, 150, 200);
    }
    noStroke();
    ellipse(x + w/2, y + h/2, w, h);
  }

  void collect() {
    isCollected = true;
    // ここで効果音を鳴らすなど（データフォルダに音を用意してから実装）
    // e.g. playSound(hitSound);
  }
}
