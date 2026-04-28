
//落ちものテンプレート

// プレイヤー
float player_x;
float player_y;
boolean player_flag;
PImage player_img_1; //2コマのアニメ画像にする
PImage player_img_2;
float player_speed;

void setup() {
  size(1280, 720);

  
  // 画像の座標計算を中央にする
  imageMode(CENTER);



  // アニメーションさせたい画像を読み込む（2コマ）
  player_img_1 = loadImage("knight_idle_0_0.png");
  player_img_2 = loadImage("knight_idle_0_2.png");

  // 位置やスピードの初期設定
  player_x = width / 2;
  player_y = height - (player_img_1.height / 2);
  player_speed = 10;
}


void draw() {
  background(#00DBFF);

  // プレイヤーの移動
  if (keyPressed) {
    if (keyCode == LEFT) {
      player_x -= player_speed;
    }

    if (keyCode == RIGHT) {
      player_x += player_speed;
    }
  }

  // 2コマアニメーション表示
  if ((frameCount / 30) % 2 == 0) {
    // 30フレーム(0.5秒)ごとに切り替え
    image(player_img_1, player_x, player_y);
  } else {
    image(player_img_2, player_x, player_y);
  }
  
  // frameCount は プログラム実行時からフレーム数を数えるシステム変数です。1秒間に60ずつ増えます
  // 30で割って速度を半分にし、% 2 == 0 は 2で割った余り、つまり偶数か奇数かを判定します
  // 偶数だったら画像1、奇数だった画像2を表示する、という判定を 0.5秒ごとに行っているため、秒間2コマのアニメーションに見えます
  
}
