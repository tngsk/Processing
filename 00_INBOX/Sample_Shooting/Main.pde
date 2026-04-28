// ===== シンプルシューティングゲーム =====
// 基本ルールに従った最小限のシューティングゲーム実装

// --- ゲームオブジェクト ---
Player player;
ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets;
int score;
int enemySpawnTimer;
boolean gameOver;

// --- 入力状態 ---
boolean isLeftKeyPressed = false;
boolean isRightKeyPressed = false;
boolean isUpKeyPressed = false;
boolean isDownKeyPressed = false;
boolean isShootKeyPressed = false;

// --- 初期化処理 ---
void setup() {
  size(1280, 720);
  frameRate(60);

  // 基本設定
  rectMode(CORNER);
  imageMode(CORNER);
  ellipseMode(CORNER);
  textAlign(CENTER, CENTER);

  // ゲーム初期化
  initGame();
}

// --- ゲーム初期化 ---
void initGame() {
  player = new Player(width/2 - 30, height - 80, 60, 60);
  enemies = new ArrayList<Enemy>();
  bullets = new ArrayList<Bullet>();
  score = 0;
  enemySpawnTimer = 0;
  gameOver = false;
}

// --- メインループ ---
void draw() {
  background(20, 30, 60);

  if (!gameOver) {
    updateGame();
  }

  drawGame();
  drawUI();
}

// --- ゲーム更新 ---
void updateGame() {
  // プレイヤー更新
  player.update();

  // 敵生成
  enemySpawnTimer++;
  if (enemySpawnTimer > 90) {
    Enemy enemy = new Enemy(random(50, width - 50), -50, 40, 40);
    enemies.add(enemy);
    enemySpawnTimer = 0;
  }

  // 敵更新
  for (int i = enemies.size() - 1; i >= 0; i--) {
    Enemy enemy = enemies.get(i);
    enemy.update();
    if (enemy.x < -500) {
      enemies.remove(i);
    }
  }

  // 弾丸更新
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet bullet = bullets.get(i);
    bullet.update();
    if (bullet.x < -500) {
      bullets.remove(i);
    }
  }

  // 衝突判定
  checkCollisions();

  // ゲームオーバー判定
  if (player.lives <= 0) {
    gameOver = true;
  }
}

// --- 衝突判定 ---
void checkCollisions() {
  // プレイヤーの弾丸と敵
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet bullet = bullets.get(i);
    if (bullet.vy < 0) { // プレイヤーの弾丸（上向き）
      for (int j = enemies.size() - 1; j >= 0; j--) {
        Enemy enemy = enemies.get(j);
        if (isColliding(bullet, enemy)) {
          bullets.remove(i);
          enemies.remove(j);
          score += 100;
          break;
        }
      }
    }
  }

  // 敵の弾丸とプレイヤー
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet bullet = bullets.get(i);
    if (bullet.vy > 0) { // 敵の弾丸（下向き）
      if (isColliding(bullet, player)) {
        bullets.remove(i);
        player.takeDamage();
      }
    }
  }

  // 敵とプレイヤーの直接衝突
  for (int i = enemies.size() - 1; i >= 0; i--) {
    Enemy enemy = enemies.get(i);
    if (isColliding(player, enemy)) {
      enemies.remove(i);
      player.takeDamage();
    }
  }
}

// --- 描画処理 ---
void drawGame() {
  // 弾丸描画
  for (Bullet bullet : bullets) {
    bullet.draw();
  }

  // 敵描画
  for (Enemy enemy : enemies) {
    enemy.draw();
  }

  // プレイヤー描画
  player.draw();
}

// --- UI描画 ---
void drawUI() {
  fill(255);
  textAlign(LEFT, TOP);
  textSize(18);
  text("Score: " + score, 20, 20);
  text("Lives: " + player.lives, 20, 50);

  textAlign(CENTER, CENTER);
  textSize(16);
  text("Arrow Keys: Move, Space: Shoot", width/2, height - 30);

  if (gameOver) {
    fill(255, 100, 100);
    textSize(36);
    text("GAME OVER", width/2, height/2);
    text("Final Score: " + score, width/2, height/2 + 40);
    text("Press R to Restart", width/2, height/2 + 80);
  }
}

// --- キー入力 ---
void keyPressed() {
  if (gameOver && (key == 'r' || key == 'R')) {
    initGame();
  }

  // 移動キー
  if (keyCode == LEFT) {
    isLeftKeyPressed = true;
  } else if (keyCode == RIGHT) {
    isRightKeyPressed = true;
  } else if (keyCode == UP) {
    isUpKeyPressed = true;
  } else if (keyCode == DOWN) {
    isDownKeyPressed = true;
  } else if (key == ' ') {
    isShootKeyPressed = true;
  }
}

void keyReleased() {
  if (keyCode == LEFT) {
    isLeftKeyPressed = false;
  } else if (keyCode == RIGHT) {
    isRightKeyPressed = false;
  } else if (keyCode == UP) {
    isUpKeyPressed = false;
  } else if (keyCode == DOWN) {
    isDownKeyPressed = false;
  } else if (key == ' ') {
    isShootKeyPressed = false;
  }
}
