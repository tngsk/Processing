// すべてのオブジェクトの基礎（親）となるクラス
// クラスとは、モノの「設計図」のようなものです。
// この設計図をもとに、プレイヤーや敵、アイテムなどの実体（インスタンス）を作ります。

class BaseClass {

  // --- 変数（フィールド） ---
  // オブジェクトが持つ「データ」や「状態」を記録します。
  float x, y; // 画面上の位置 (X座標, Y座標)
  float vx = 0, vy = 0; // 速度 (Velocity: 1フレームにどれだけ移動するか)
  float w, h; // サイズ (Width:幅, Height:高さ)
  PImage img; // オブジェクトの見た目になる画像データ

  // --- コンストラクタ ---
  // オブジェクトが新しく作られるときに「最初に行う設定」です。

  // コンストラクタその1（画像を使わず、四角形として描画する場合）
  BaseClass(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.img = null; // 画像は設定しない (null = 何もない状態)
  }

  // コンストラクタその2（画像を一緒に設定する場合）
  // ※ 引数（カッコの中身）のパターンが違う同じ名前のコンストラクタを作ることを「オーバーロード」と呼びます。
  BaseClass(float x, float y, float w, float h, PImage img) {
    this(x, y, w, h); // 画像なしコンストラクタを呼び出す（コードの共通化）
    this.img = img;
  }

  // --- メソッド（関数） ---
  // オブジェクトの「振る舞い」や「機能」を定義します。

  // 位置を更新するメソッド（毎フレーム呼び出します）
  void update() {
    x += vx; // 現在の位置に速度を足して移動させる
    y += vy;
  }

  // 画面に描画するメソッド（毎フレーム呼び出します）
  void draw() {
    // もし画像が設定されていれば画像を表示する
    if (img != null) {
      image(img, x, y, w, h);
    } else {
      // 画像がないときは、白い四角形として表示する
      rect(x, y, w, h);
    }
  }

  // 後から画像を設定するためのメソッド
  void setImage(PImage img) {
    this.img = img;
  }

  // 衝突判定（別のオブジェクト other とぶつかっているかを調べます）
  // これは「AABB (Axis-Aligned Bounding Box)」と呼ばれる、四角形同士のシンプルな当たり判定です。
  boolean onCollision(BaseClass other) {
    return (x < other.x + other.w &&    // 自分の左端が、相手の右端より左にある
            x + w > other.x &&          // 自分の右端が、相手の左端より右にある
            y < other.y + other.h &&    // 自分の上端が、相手の下端より上にある
            y + h > other.y);           // 自分の下端が、相手の上端より下にある
  }

}
