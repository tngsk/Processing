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

// --- Added from CameraClass.pde ---
// カメラクラス
class CameraClass {
  float x, y;

  // カメラの境界
  float minX, maxX;
  float minY, maxY;
  boolean useBounds;

  // 境界付きコンストラクタ
  CameraClass(float minX, float minY, float maxX, float maxY) {
    this.x = 0;
    this.y = 0;
    this.minX = minX;
    this.minY = minY;
    this.maxX = maxX;
    this.maxY = maxY;
    this.useBounds = true;
  }

  // 対象オブジェクトを追従（プレイヤーを中心に配置）
  // 境界チェックも同時に実行
  void follow(BaseClass target) {
    if (target != null) {
      x = target.x + target.w/2 - width/2;
      y = target.y + target.h/2 - height/2;

      // 境界チェック
      if (useBounds) {
        x = constrain(x, minX, maxX - width);
        y = constrain(y, minY, maxY - height);
      }
    }
  }

  // カメラ変換を開始
  void begin() {
    pushMatrix();
    translate(-x, -y);
  }

  // カメラ変換を終了
  void end() {
    popMatrix();
  }
}

// --- Added from Platform.pde ---
// プラットフォームクラス
class Platform extends BaseClass {

  Platform(float x, float y, float w, float h) {
    super(x, y, w, h);
  }

  void draw() {
    fill(150, 100, 50); // 茶色
    super.draw();
  }
}

// --- Added from Player.pde ---
// プラットフォーマー用プレイヤークラス
class Player extends BaseClass {

  float moveSpeed;
  float jumpPower;
  boolean isGrounded;

  Player(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.moveSpeed = 3.0;
    this.jumpPower = 10.0;
    this.isGrounded = false;
  }

  void handleInput() {
    // 左右移動
    if (isLeftKeyPressed) {
      this.vx = -moveSpeed;
    } else if (isRightKeyPressed) {
      this.vx = moveSpeed;
    } else {
      this.vx *= 0.8; // 摩擦
    }
  }

  void jump() {
    if (isGrounded) {
      this.vy = -jumpPower;
      this.isGrounded = false;
    }
  }

  void update() {
    handleInput();

    // 重力適用
    applyGravity(this, 0.5);

    // 速度制限
    limitVelocity(this, 8);

    // 位置更新
    super.update();

    // 左右の境界チェックのみ
    this.x = constrain(this.x, 0, WORLD_WIDTH - this.w);

    // 画面下に落ちたらリスポーン
    if (this.y > WORLD_HEIGHT + 50) {
      this.x = 100;
      this.y = 300;
      this.vx = 0;
      this.vy = 0;
    }
  }

  void setGrounded(boolean grounded) {
    this.isGrounded = grounded;
  }

  void draw() {
    fill(100, 150, 255); // 青色
    super.draw();
  }
}
