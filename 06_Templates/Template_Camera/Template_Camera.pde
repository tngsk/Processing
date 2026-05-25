// ===== テンプレート：カメラ(画面スクロール)機能 =====
//
// 用途: 画面よりも広いワールドを歩き回るゲームで、プレイヤーを中心に画面をスクロールさせます。

Player player;
CameraClass camera;
ArrayList<BaseClass> trees; // 背景の目印用

// 画面サイズは 800x600 だが、ワールドサイズは 2000x2000 とする
int WORLD_WIDTH = 2000;
int WORLD_HEIGHT = 2000;

void setup() {
  size(800, 600);
  rectMode(CORNER);

  // プレイヤーをワールドの中央付近に配置
  player = new Player(1000, 1000, 40, 40);

  // カメラの作成（ワールドの端から端までを移動範囲とする）
  camera = new CameraClass(0, 0, WORLD_WIDTH, WORLD_HEIGHT);

  // 背景の目印（木など）をランダムに配置
  trees = new ArrayList<BaseClass>();
  for (int i = 0; i < 100; i++) {
    trees.add(new BaseClass(random(WORLD_WIDTH), random(WORLD_HEIGHT), 30, 50));
  }
}

void draw() {
  background(100, 200, 100); // 地面の緑色

  // --- 1. 状態の更新 ---
  player.update();

  // カメラをプレイヤーに追従させる
  camera.follow(player);

  // --- 2. ワールド座標での描画 ---
  camera.begin(); // ここから先はカメラの位置に合わせて描画がズレる

  // 背景の木を描画
  fill(34, 139, 34); // 深緑
  for (BaseClass tree : trees) {
    tree.draw();
  }

  // プレイヤーの描画
  player.draw();

  // ワールドの境界線を描画
  noFill();
  stroke(255, 0, 0);
  strokeWeight(4);
  rect(0, 0, WORLD_WIDTH, WORLD_HEIGHT);
  noStroke();

  camera.end(); // カメラの影響範囲ここまで

  // --- 3. 画面座標での描画（UIなど） ---
  // ここでの描画はカメラの影響を受けず、常に画面の同じ位置に表示される
  fill(255);
  textSize(20);
  textAlign(LEFT, TOP);
  text("Arrow Keys to move", 10, 10);
  text("Camera X: " + (int)(camera.x) + " Y: " + (int)(camera.y), 10, 40);
}

// 簡単な移動処理
void keyPressed() {
  if (keyCode == LEFT)  player.vx = -5;
  if (keyCode == RIGHT) player.vx = 5;
  if (keyCode == UP)    player.vy = -5;
  if (keyCode == DOWN)  player.vy = 5;
}

void keyReleased() {
  if (keyCode == LEFT || keyCode == RIGHT) player.vx = 0;
  if (keyCode == UP || keyCode == DOWN)    player.vy = 0;
}

// ==========================================
// コピー＆ペースト用：カメラクラス
// ==========================================
class CameraClass {
  float x, y;

  // カメラが移動できる境界
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

  // 対象オブジェクト（プレイヤーなど）を追従する
  void follow(BaseClass target) {
    if (target != null) {
      // 画面の中央に対象が来るようにカメラの左上座標を計算する
      x = target.x + target.w/2 - width/2;
      y = target.y + target.h/2 - height/2;

      // カメラがワールドの境界を越えないように制限する
      if (useBounds) {
        x = constrain(x, minX, maxX - width);
        y = constrain(y, minY, maxY - height);
      }
    }
  }

  // カメラ変換を開始（この後に描画したものはスクロールする）
  void begin() {
    pushMatrix();
    translate(-x, -y);
  }

  // カメラ変換を終了（この後に描画したものはスクロールせず画面に固定される）
  void end() {
    popMatrix();
  }
}

// ==========================================
// 以下はテスト動作用の簡略化クラス
// ==========================================
class Player extends BaseClass {
  Player(float x, float y, float w, float h) { super(x, y, w, h); }
  void update() {
    super.update();
    // プレイヤーがワールド境界を越えないようにする
    this.x = constrain(this.x, 0, WORLD_WIDTH - this.w);
    this.y = constrain(this.y, 0, WORLD_HEIGHT - this.h);
  }
  void draw() {
    fill(255, 0, 0); // 赤色
    super.draw();
  }
}

class BaseClass {
  float x, y, vx = 0, vy = 0, w, h;
  PImage img;

  BaseClass(float x, float y, float w, float h) {
    this.x = x; this.y = y; this.w = w; this.h = h; this.img = null;
  }
  void update() { this.x += this.vx; this.y += this.vy; }
  void draw() { if (this.img != null) image(this.img, this.x, this.y, this.w, this.h); else rect(this.x, this.y, this.w, this.h); }
}
