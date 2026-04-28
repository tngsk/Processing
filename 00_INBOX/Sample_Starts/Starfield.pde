

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
