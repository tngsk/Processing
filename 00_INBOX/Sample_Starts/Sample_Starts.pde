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
