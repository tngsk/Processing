// ===== テンプレート：基本オブジェクトクラス (BaseObject) =====
//
// 用途: ゲーム内のキャラクターやアイテムなどの親クラスとして使用します。
// これを継承（extends）することで、座標や描画の基本機能を簡単に使い回せます。

// --- 使い方デモ ---
BaseClass obj1;
BaseClass obj2;

void setup() {
  size(800, 600);
  rectMode(CORNER);

  // X:100, Y:100 の位置に 幅:50, 高さ:50 のオブジェクトを生成
  obj1 = new BaseClass(100, 100, 50, 50);
  obj1.vx = 2; // 右へ移動する速度を設定

  obj2 = new BaseClass(400, 300, 80, 80);
}

void draw() {
  background(200);

  // 状態の更新と描画
  obj1.update();
  obj1.draw();

  obj2.update();
  obj2.draw();
}

// ==========================================
// コピー＆ペースト用：BaseClass の定義
// ==========================================
class BaseClass {

  // --- フィールド（状態） ---
  float x, y;           // 座標
  float vx = 0, vy = 0; // 速度
  float w, h;           // 幅・高さ
  PImage img;           // 表示する画像 (nullの場合は四角形を描画)

  // --- コンストラクタ（初期化処理） ---
  // 画像なしの場合
  BaseClass(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = null;
  }

  // 画像ありの場合
  BaseClass(float x, float y, float w, float h, PImage img) {
    this(x, y, w, h);
    this.img = img;
  }

  // --- メソッド（振る舞い） ---

  // 毎フレーム呼ばれる更新処理
  void update() {
    this.x += this.vx;
    this.y += this.vy;
  }

  // 画面への描画処理
  void draw() {
    if (this.img != null) {
      image(this.img, this.x, this.y, this.w, this.h);
    } else {
      fill(255); // デフォルトの色（白）
      rect(this.x, this.y, this.w, this.h);
    }
  }

  // 画像を後から設定するメソッド
  void setImage(PImage img) {
    this.img = img;
  }
}
