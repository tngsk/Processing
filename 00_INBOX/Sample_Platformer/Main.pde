// ===== シンプルプラットフォーマーゲーム with スクロール =====

// --- ワールド設定 ---
final int WORLD_WIDTH = 1280 * 3;
final int WORLD_HEIGHT = 720;

// --- ゲームオブジェクト ---
Player player;
ArrayList<Platform> platforms;
CameraClass camera;
float goalX;
boolean gameCleared;

// --- 入力状態 ---
boolean isLeftKeyPressed = false;
boolean isRightKeyPressed = false;

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
  player = new Player(100, 300, 50, 60);
  platforms = new ArrayList<Platform>();
  camera = new CameraClass(0, 0, WORLD_WIDTH, WORLD_HEIGHT);
  goalX = WORLD_WIDTH - 200;
  gameCleared = false;

  // 長いワールドのプラットフォーム配置
  // 地面
  platforms.add(new Platform(0, height - 60, WORLD_WIDTH, 60));

  // 飛び石プラットフォーム
  platforms.add(new Platform(400, height - 160, 120, 20));
  platforms.add(new Platform(600, height - 240, 120, 20));
  platforms.add(new Platform(800, height - 320, 120, 20));
  platforms.add(new Platform(1000, height - 240, 120, 20));
  platforms.add(new Platform(1200, height - 360, 120, 20));
  platforms.add(new Platform(1400, height - 280, 120, 20));
  platforms.add(new Platform(1600, height - 400, 120, 20));
  platforms.add(new Platform(1800, height - 320, 120, 20));
  platforms.add(new Platform(2000, height - 240, 120, 20));
  platforms.add(new Platform(2200, height - 360, 120, 20));
  platforms.add(new Platform(2400, height - 280, 120, 20));
  platforms.add(new Platform(2600, height - 200, 120, 20));
  platforms.add(new Platform(2800, height - 320, 120, 20));
  platforms.add(new Platform(3000, height - 240, 120, 20));

  // ゴールプラットフォーム
  platforms.add(new Platform(goalX - 100, height - 120, 200, 40));
}

// --- メインループ ---
void draw() {
  background(135, 206, 235); // 空色

  if (!gameCleared) {
    updateGame();
  }

  // カメラ更新
  camera.follow(player);

  // 描画
  drawGame();
  drawUI();
}

// --- ゲーム更新 ---
void updateGame() {
  player.update();

  // プラットフォーム衝突処理
  handlePlatforms(player, new ArrayList<BaseClass>(platforms));
  player.setGrounded(isOnGround(player, new ArrayList<BaseClass>(platforms)));

  // ゴール判定
  if (player.x > goalX) {
    gameCleared = true;
  }

  // 落下判定
  if (player.y > height + 100) {
    player.x = 100;
    player.y = 300;
    player.vx = 0;
    player.vy = 0;
  }
}

// --- 描画処理 ---
void drawGame() {
  camera.begin();

  // プラットフォーム描画
  for (Platform platform : platforms) {
    platform.draw();
  }

  // ゴール描画
  fill(255, 215, 0);
  rect(goalX, height - 180, 80, 80);

  // プレイヤー描画
  player.draw();

  camera.end();
}

// --- UI描画 ---
void drawUI() {
  fill(255);
  textAlign(LEFT, TOP);
  textSize(16);
  text("Arrow Keys: Move", 20, 20);
  text("Space: Jump", 20, 50);
  text("Reach the gold goal!", 20, 80);
  text("Camera follows player through long world!", 20, 110);

  if (gameCleared) {
    fill(255, 255, 0);
    textAlign(CENTER, CENTER);
    textSize(36);
    text("GOAL REACHED!", width/2, height/2);
    text("Press R to Restart", width/2, height/2 + 50);
  }
}

// --- キー入力 ---
void keyPressed() {
  if (key == 'r' || key == 'R') {
    initGame();
  } else if (keyCode == LEFT) {
    isLeftKeyPressed = true;
  } else if (keyCode == RIGHT) {
    isRightKeyPressed = true;
  } else if (key == ' ') {
    player.jump();
  }
}

void keyReleased() {
  if (keyCode == LEFT) {
    isLeftKeyPressed = false;
  } else if (keyCode == RIGHT) {
    isRightKeyPressed = false;
  }
}
