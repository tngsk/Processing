// ===== 方向キーでアニメーション切り替えデモ =====

/*
【使い方】
・方向キー: アニメーション切り替え + 移動
  - ↑ (UP): Idle アニメーション + 上移動
  - ↓ (DOWN): Run アニメーション + 下移動
  - ← (LEFT): Roll アニメーション + 左移動
  - → (RIGHT): Hit アニメーション + 右移動
・Space: アニメーション速度切り替え（8fps ↔ 4fps）

【v7などの自分のプログラムに組み込む手順】
1. Animation.pde を自分のプロジェクトフォルダにコピー
2. dataフォルダを作成し、連番画像を配置
   例: data/character/walk_0.png, walk_1.png, walk_2.png...
3. setup()で必要なアニメーションを作成:
   Animation walkAnim = new Animation(x, y, w, h, loadFrames("character/walk", 4));
4. draw()でアニメーションを更新・描画:
   walkAnim.update();
   walkAnim.draw();
5. 必要に応じてアニメーション切り替え:
   currentAnim = walkAnim;
   currentAnim.reset();

【連番画像の準備】
・ファイル名: "名前_番号.png" 形式（例: walk_0.png, walk_1.png）
・サイズ: 統一推奨
・フレーム数: loadFrames()の第2引数で指定

【カスタマイズ例】
・アニメーション速度: anim.setSpeed(遅延フレーム数)
・位置更新: anim.x = 新しいX座標; anim.y = 新しいY座標;
・リセット: anim.reset() でフレーム0から再開
*/

// --- 個別のアニメーションオブジェクト ---
Animation idleAnim;
Animation runAnim;
Animation rollAnim;
Animation hitAnim;
Animation currentAnim;

// --- キャラクター位置と速度 ---
float knightX, knightY;
float knightVX, knightVY;

// --- 初期化処理 ---
void setup() {
  size(1280, 720);
  frameRate(60);

  rectMode(CORNER);
  imageMode(CORNER);
  textAlign(CENTER, CENTER);

  // キャラクター初期位置
  knightX = width/2 - 40;
  knightY = height/2 - 40;
  knightVX = 0;
  knightVY = 0;

  // 各アニメーションを作成
  idleAnim = new Animation(knightX, knightY, 80, 80, loadFrames("knight/knight_idle_0", 4));
  runAnim = new Animation(knightX, knightY, 80, 80, loadFrames("knight/knight_run_2", 8));
  rollAnim = new Animation(knightX, knightY, 80, 80, loadFrames("knight/knight_roll_5", 8));
  hitAnim = new Animation(knightX, knightY, 80, 80, loadFrames("knight/knight_hit_6", 4));

  // 初期アニメーション設定
  currentAnim = idleAnim;
}

// --- 連番画像読み込み ---
PImage[] loadFrames(String path, int count) {
  PImage[] frames = new PImage[count];
  for (int i = 0; i < count; i++) {
    frames[i] = loadImage(path + "_" + i + ".png");
  }
  return frames;
}

// --- メインループ ---
void draw() {
  background(50);

  // 移動処理
  knightX += knightVX;
  knightY += knightVY;

  // 画面端で跳ね返る
  if (knightX < 0 || knightX > width-80) knightVX *= -0.8;
  if (knightY < 0 || knightY > height-80) knightVY *= -0.8;
  knightX = constrain(knightX, 0, width-80);
  knightY = constrain(knightY, 0, height-80);

  // 全アニメーションの位置を更新
  idleAnim.x = knightX;
  idleAnim.y = knightY;
  runAnim.x = knightX;
  runAnim.y = knightY;
  rollAnim.x = knightX;
  rollAnim.y = knightY;
  hitAnim.x = knightX;
  hitAnim.y = knightY;

  // アニメーション更新・描画
  currentAnim.update();
  currentAnim.draw();

  // UI
  fill(255);
  textSize(16);
  text("UP: Idle  DOWN: Run  LEFT: Roll  RIGHT: Hit", width/2, 30);
  text("Space: Speed", width/2, 60);
  text("Current: " + getAnimName(), width/2, 90);
}

// --- アニメーション名取得 ---
String getAnimName() {
  if (currentAnim == idleAnim) return "Idle";
  if (currentAnim == runAnim) return "Run";
  if (currentAnim == rollAnim) return "Roll";
  if (currentAnim == hitAnim) return "Hit";
  return "Unknown";
}

// --- キー入力 ---
void keyPressed() {
  if (keyCode == UP) {
    currentAnim = idleAnim;
    currentAnim.reset();
    knightVY = -3;
  }
  if (keyCode == DOWN) {
    currentAnim = runAnim;
    currentAnim.reset();
    knightVY = 3;
  }
  if (keyCode == LEFT) {
    currentAnim = rollAnim;
    currentAnim.reset();
    knightVX = -3;
  }
  if (keyCode == RIGHT) {
    currentAnim = hitAnim;
    currentAnim.reset();
    knightVX = 3;
  }

  if (key == ' ') {
    currentAnim.setSpeed(currentAnim.frameDelay == 8 ? 4 : 8);
  }
}

void keyReleased() {
  if (keyCode == UP || keyCode == DOWN) knightVY = 0;
  if (keyCode == LEFT || keyCode == RIGHT) knightVX = 0;
}

// --- Added from Animation.pde ---
// 単一アニメーション配列のシンプルなアニメーションクラス
class Animation extends BaseClass {

  PImage[] frames;        // アニメーションフレーム配列
  int currentFrame;       // 現在のフレーム番号
  int frameTimer;         // フレームタイマー
  int frameDelay;         // フレーム切り替えの遅延

  Animation(float x, float y, float w, float h, PImage[] frames) {
    super(x, y, w, h);
    this.frames = frames;
    this.currentFrame = 0;
    this.frameTimer = 0;
    this.frameDelay = 8;
  }

  void update() {
    super.update();

    if (frames.length > 0) {
      frameTimer++;
      if (frameTimer >= frameDelay) {
        frameTimer = 0;
        currentFrame = (currentFrame + 1) % frames.length;
      }
    }
  }

  void draw() {
    if (frames.length > 0 && frames[currentFrame] != null) {
      image(frames[currentFrame], x, y, w, h);
    } else {
      fill(100, 150, 255);
      super.draw();
    }
  }

  void setSpeed(int delay) {
    frameDelay = delay;
  }

  void reset() {
    currentFrame = 0;
    frameTimer = 0;
  }
}
