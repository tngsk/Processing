// ===== ミニゲームテンプレート =====

// --- ゲーム状態 ---
final int MODE_TITLE = 0;
final int MODE_GAME = 1;
final int MODE_GAMEOVER = 2;
int currentMode = MODE_TITLE;

// --- ワールド設定 ---
final int WORLD_WIDTH = 1280;
final int WORLD_HEIGHT = 720;

// --- ゲームオブジェクト ---
Player player;
Goal goal;
ArrayList<Wall> walls;
ArrayList<Enemy> enemies;
ArrayList<Item> items;

// --- ゲーム変数 ---
int score;
float cameraX, cameraY;

// --- 入力状態 ---
boolean isLeftKeyPressed = false;
boolean isRightKeyPressed = false;
boolean isUpKeyPressed = false;
boolean isDownKeyPressed = false;

// --- 初期化処理 ---
void setup() {
  size(1280, 720);
  frameRate(60);

  // 基本設定
  rectMode(CORNER);
  imageMode(CORNER);
  ellipseMode(CORNER);
  textAlign(CENTER, CENTER);
}

// --- メインループ ---
void draw() {
  if (currentMode == MODE_TITLE) {
    drawTitle();
    return;
  }

  if (currentMode == MODE_GAME) {
    updateGame();
    drawGame();
    return;
  }

  if (currentMode == MODE_GAMEOVER) {
    drawGameOver();
  }
}

// --- ゲーム初期化 ---
void initGame() {
  score = 0;
  cameraX = 0;
  cameraY = 0;

  // 入力状態クリア
  isLeftKeyPressed = false;
  isRightKeyPressed = false;
  isUpKeyPressed = false;
  isDownKeyPressed = false;

  // プレイヤー作成
  player = new Player(50, 50, 30, 30);

  // ゴール作成
  goal = new Goal(WORLD_WIDTH - 80, WORLD_HEIGHT - 80, 40, 40);

  // 壁作成
  createWalls();

  // 敵作成
  enemies = new ArrayList<Enemy>();
  enemies.add(new Enemy(WORLD_WIDTH/2, WORLD_HEIGHT/2, 30, 30));
  enemies.add(new Enemy(WORLD_WIDTH/3, WORLD_HEIGHT/3, 30, 30));
  enemies.add(new Enemy(WORLD_WIDTH*2/3, WORLD_HEIGHT*2/3, 30, 30));

  // アイテム作成
  createItems();
}

// --- ゲーム更新 ---
void updateGame() {
  // プレイヤー更新
  player.update();

  // 敵更新
  for (Enemy enemy : enemies) {
    enemy.update();
  }

  // ゴール更新
  goal.update();

  // 衝突処理
  handleCollisions();

  // カメラ更新
  updateCamera();

  // ゲーム状態チェック
  checkGameState();
}

// --- 衝突処理 ---
void handleCollisions() {
  // プレイヤーと壁
  for (Wall wall : walls) {
    if (isColliding(player, wall)) {
      resolveCollision(player, wall);
    }
  }

  // 敵と壁
  for (Enemy enemy : enemies) {
    if (enemy.isActive) {
      for (Wall wall : walls) {
        if (isColliding(enemy, wall)) {
          resolveCollision(enemy, wall);
        }
      }
    }
  }

  // プレイヤーと敵
  for (Enemy enemy : enemies) {
    if (enemy.isActive && isColliding(player, enemy)) {
      if (player.hasPowerUp) {
        enemy.getDefeated();
        score += 200;
      } else {
        player.takeDamage(20);
      }
    }
  }

  // プレイヤーとアイテム
  for (Item item : items) {
    if (!item.isCollected && isColliding(player, item)) {
      item.collect();
    }
  }

  // プレイヤーとゴール
  if (goal.isActive && isColliding(player, goal)) {
    goal.reachGoal();
  }
}

// --- カメラ更新 ---
void updateCamera() {
  cameraX = player.x - width/2;
  cameraY = player.y - height/2;

  // 境界制限
  cameraX = constrain(cameraX, 0, max(0, WORLD_WIDTH - width));
  cameraY = constrain(cameraY, 0, max(0, WORLD_HEIGHT - height));
}

// --- ゲーム状態チェック ---
void checkGameState() {
  // プレイヤー死亡
  if (player.health <= 0) {
    currentMode = MODE_GAMEOVER;
  }

  // 全ドット収集でゴールアクティブ
  if (allDotsCollected()) {
    goal.isActive = true;
  }

  // ゴール到達
  if (goal.isReached) {
    currentMode = MODE_GAMEOVER;
  }
}

// --- 描画処理 ---
void drawGame() {
  background(135, 206, 235); // 空色

  // カメラ変換開始
  pushMatrix();
  translate(-cameraX, -cameraY);

  // オブジェクト描画
  for (Wall wall : walls) {
    wall.draw();
  }

  for (Item item : items) {
    item.draw();
  }

  for (Enemy enemy : enemies) {
    enemy.draw();
  }

  goal.draw();
  player.draw();

  popMatrix();
  // カメラ変換終了

  // UI描画
  drawUI();
}

void drawTitle() {
  background(20, 30, 80);
  fill(255, 255, 0);
  textSize(48);
  text("PAC-MAN GAME", width/2, height/2 - 100);
  textSize(24);
  text("Press SPACE to Start", width/2, height/2);
  textSize(16);
  text("WASD to Move", width/2, height/2 + 50);
}

void drawGameOver() {
  background(80, 20, 20);
  fill(255);
  textSize(48);
  if (goal.isReached) {
    text("GAME CLEAR!", width/2, height/2 - 100);
  } else {
    text("GAME OVER", width/2, height/2 - 100);
  }
  textSize(32);
  text("Score: " + score, width/2, height/2 - 30);
  textSize(24);
  text("Press SPACE to Restart", width/2, height/2 + 30);
}

void drawUI() {
  // ヘルス表示
  fill(100);
  rect(20, 20, 200, 20);
  fill(255, 0, 0);
  rect(20, 20, player.health * 2, 20);

  // スコア表示
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(24);
  text("SCORE: " + score, 20, 60);
  text("DOTS: " + countRemainingDots(), 20, 90);

  // パワーアップ表示
  if (player.hasPowerUp) {
    fill(255, 255, 0);
    text("POWER UP!", 20, 120);
  }

  textAlign(CENTER, CENTER);
}

// --- 入力処理 ---
void keyPressed() {
  if (currentMode == MODE_TITLE) {
    if (key == ' ') {
      initGame();
      currentMode = MODE_GAME;
    }
  } else if (currentMode == MODE_GAME) {
    if (key == 'a' || key == 'A' || keyCode == LEFT) {
      isLeftKeyPressed = true;
    } else if (key == 'd' || key == 'D' || keyCode == RIGHT) {
      isRightKeyPressed = true;
    } else if (key == 'w' || key == 'W' || keyCode == UP) {
      isUpKeyPressed = true;
    } else if (key == 's' || key == 'S' || keyCode == DOWN) {
      isDownKeyPressed = true;
    }
  } else if (currentMode == MODE_GAMEOVER) {
    if (key == ' ') {
      initGame();
      currentMode = MODE_GAME;
    }
  }
}

void keyReleased() {
  if (currentMode == MODE_GAME) {
    if (key == 'a' || key == 'A' || keyCode == LEFT) {
      isLeftKeyPressed = false;
    } else if (key == 'd' || key == 'D' || keyCode == RIGHT) {
      isRightKeyPressed = false;
    } else if (key == 'w' || key == 'W' || keyCode == UP) {
      isUpKeyPressed = false;
    } else if (key == 's' || key == 'S' || keyCode == DOWN) {
      isDownKeyPressed = false;
    }
  }
}

// --- レベル作成 ---
void createWalls() {
  walls = new ArrayList<Wall>();

  // 外壁
  walls.add(new Wall(0, 0, WORLD_WIDTH, 40));
  walls.add(new Wall(0, WORLD_HEIGHT - 40, WORLD_WIDTH, 40));
  walls.add(new Wall(0, 0, 40, WORLD_HEIGHT));
  walls.add(new Wall(WORLD_WIDTH - 40, 0, 40, WORLD_HEIGHT));

  // 内部の壁
  walls.add(new Wall(200, 200, 200, 40));
  walls.add(new Wall(600, 200, 200, 40));
  walls.add(new Wall(200, 400, 200, 40));
  walls.add(new Wall(600, 400, 200, 40));
  walls.add(new Wall(400, 100, 40, 200));
  walls.add(new Wall(400, 350, 40, 200));
}

void createItems() {
  items = new ArrayList<Item>();

  // ドット配置
  for (int x = 100; x < WORLD_WIDTH - 100; x += 80) {
    for (int y = 100; y < WORLD_HEIGHT - 100; y += 80) {
      if (!isPositionBlocked(x, y)) {
        items.add(new Item(x, y, 8, 8, "dot"));
      }
    }
  }

  // パワーペレット配置
  items.add(new Item(100, 100, 16, 16, "power_pellet"));
  items.add(new Item(WORLD_WIDTH - 150, 100, 16, 16, "power_pellet"));
  items.add(new Item(100, WORLD_HEIGHT - 150, 16, 16, "power_pellet"));
  items.add(new Item(WORLD_WIDTH - 150, WORLD_HEIGHT - 150, 16, 16, "power_pellet"));
}

// --- ヘルパー関数 ---
boolean isPositionBlocked(float x, float y) {
  for (Wall wall : walls) {
    if (x > wall.x - 20 && x < wall.x + wall.w + 20 &&
        y > wall.y - 20 && y < wall.y + wall.h + 20) {
      return true;
    }
  }
  return false;
}

boolean allDotsCollected() {
  for (Item item : items) {
    if (!item.isCollected && item.itemType.equals("dot")) {
      return false;
    }
  }
  return true;
}

int countRemainingDots() {
  int count = 0;
  for (Item item : items) {
    if (!item.isCollected && item.itemType.equals("dot")) {
      count++;
    }
  }
  return count;
}
