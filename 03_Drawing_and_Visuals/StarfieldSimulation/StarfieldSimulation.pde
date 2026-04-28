/*
  星空サンプル - Main.pde
  SharedResources/Sample_Starts/Main.pde
  removeIf を使わない安全な削除ループへ置換済み
*/

 // 星空の背景用クラス
GradientBackground bg;

// 星群
Starfield stars;

// 流れ星リスト
ArrayList<ShootingStar> shooting_stars;

// 次の流れ星発生時間（ミリ秒）
int nextTime;

void setup() {
  size(1280, 720);
  frameRate(60);
  rectMode(CORNER);
  imageMode(CORNER);
  ellipseMode(CORNER);
  textAlign(CENTER, CENTER);

  bg = new GradientBackground();

  stars = new Starfield(width, height, 150);

  shooting_stars = new ArrayList<ShootingStar>();
  nextTime = millis() + (int)random(3000, 8000);
}

void draw() {

  // グラデーション背景を描画
  bg.draw();

  // 星空を更新・描画
  stars.update();
  stars.draw();

  // 流れ星の発生
  if (millis() > nextTime) {
    // 新しい流れ星を追加
    shooting_stars.add(new ShootingStar());
    nextTime = millis() + (int)random(5000, 15000);
  }

  // 画面外の流れ星を配列から安全に削除する（逆順ループ）
  // [なぜ?] 前から削除するとインデックスがずれてループの飛びやConcurrentModificationの原因になるため
  for (int i = shooting_stars.size() - 1; i >= 0; i--) {
    ShootingStar s = shooting_stars.get(i);
    if (!s.active) {
      shooting_stars.remove(i);
    }
  }

  // 流れ星のアップデートと描画
  for (int i = 0; i < shooting_stars.size(); i++) {
    ShootingStar star = shooting_stars.get(i);
    star.update();
    star.draw();
  }
}

/* --- 補助クラス（参照のみ） ---
   GradientBackground, Starfield, ShootingStar は別ファイルで定義されている前提
   ここでは Main のフローだけを管理する
*/

// --- Added from GradientBackground.pde ---

//グラデーションの背景を作るクラス
//表示だけで当たり判定がないので、BaseClassを継承せずに作成

class GradientBackground {
  color top, bottom;

  GradientBackground() {
    top = color(5, 5, 20);
    bottom = color(30, 30, 50);
  }

  void draw() {

    //少しずつ色を変えた線を描画することでグラデーションにする
    //widthやheightを変更して、任意のサイズのグラデーションを作れる

    for (int i = 0; i <= height; i++) {
      stroke(lerpColor(top, bottom, map(i, 0, height, 0, 1)));
      line(0, i, width, i);
    }
    noStroke();
  }

  void set(color t, color b) {
    top = t;
    bottom = b;
  }
}

// --- Added from ShootingStar.pde ---
class ShootingStar {
  float x, y, vx, vy, tail;
  boolean active;

  ShootingStar() {
    x = random(width * 0.8, width * 1.2);
    y = random(-height * 0.2, height * 0.3);
    vx = random(-8, -3);
    vy = random(2, 6);
    tail = random(30, 80);
    active = true;
  }

  void update() {
    if (!active) return;
    x += vx;
    y += vy;
    if (x < -100 || y > height + 100) active = false;
  }

  void draw() {
    if (!active) return;
    stroke(255, 255, 200);
    line(x, y, x + tail * (-vx/8), y + tail * (-vy/8));
    stroke(255);
    point(x, y);
  }
}

// --- Added from Starfield.pde ---


//星空を作るクラス
//表示だけで移動や当たり判定がないので、BaseClassを継承せずに作成


// ------------------------------------------------------------
// 使い方
// このファイル(Starfield.pde)を自分のプロジェクトにコピーする

// メインプログラムに星空クラスを管理する変数を宣言する
// Starfield stars;

// setup() で クラスを初期化する
// stars = new Starfield(width, height, 150);
// stars = new Starfield(星空の範囲（横）, 星空の範囲（高さ）, 星の数);

// draw() で計算と描画する
// stars.update();
// stars.draw();
// ------------------------------------------------------------


//星を複数まとめて管理するクラス
//下にある Star クラスをたくさん保持する

class Starfield {

  //星クラスを入れておく配列
  ArrayList<Star> stars;

  //指定範囲に指定の数の星クラスを作成する
  Starfield(float w, float h, int count) {
    stars = new ArrayList<Star>();
    for (int i = 0; i < count; i++) {
      stars.add(new Star(w, h));
    }
  }

  void update() {
    for (Star s : stars) {
      s.update();
    }
  }

  void draw() {
    for (Star s : stars) {
      s.draw();
    }
  }
}


//星ひとつ分のクラス

class Star {

  float x, y, brightness, base, phase, freq, size;

  Star(float w, float h) {

    // 座標のランダム
    x = random(w);
    y = random(h);

    // 明るさの変化を作る変数
    // sin を使って周期的に変化させる
    base = random(100, 255);
    brightness = base; // 明るさの初期値
    phase = random(TWO_PI); // 星ごとに変化の開始点をランダムにする
    freq = random(0.5, 2.0); // 変化のスピード
    size = random(1, 3); // サイズをランダムにする
  }

  void update() {
    //明るさ変化の計算
    phase += 0.02 * freq;
    brightness = base * (sin(phase) * 0.3 + 0.7);
  }

  void draw() {
    //星を描く
    stroke(255, 255, 255, brightness);
    strokeWeight(size);
    point(x, y);
  }
}
