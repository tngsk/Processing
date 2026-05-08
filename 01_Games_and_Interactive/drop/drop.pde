
//落ちものテンプレート

// プレイヤー
float player_x;
float player_y;
boolean player_flag;
PImage player_img_1; //2コマのアニメ画像にする
PImage player_img_2;
float player_speed;

// フルーツ1
float fruit1_x;
float fruit1_y;
float fruit1_speed;
boolean fruit1_flag;
PImage fruit1_img;


// フルーツ2
float fruit2_x;
float fruit2_y;
boolean fruit2_flag;

// フルーツ3
float fruit3_x;
float fruit3_y;
boolean fruit3_flag;

// コイン
float coin_x;
float coin_y;
boolean coin_flag;

// ワールド
float world_x;
float world_y;


void setup() {
  size(1280, 720);

  imageMode(CENTER);


  // プレイヤー関連
  player_img_1 = loadImage("knight_idle_0_0.png");
  player_img_2 = loadImage("knight_idle_0_2.png");
  player_x = width / 2;
  player_y = height - (player_img_1.height / 2);
  player_speed = 10;

  // アイテムの初期位置

  fruit1_img = loadImage("fruit1_0.png");

  //xは画面内のどこかだけど、左右100pxの余白内に収める
  fruit1_x = constrain(random(width), 100, width - 100);

  //yは画面上よりもさらに上にする（落ちてくる時間差を利用する）
  fruit1_y = -random(500);

  fruit1_speed = random(5, 12);
  fruit1_flag = true;
}


void draw() {
  background(#00DBFF);

  if (keyPressed) {
    if (keyCode == LEFT) {
      player_x -= player_speed;
    }

    if (keyCode == RIGHT) {
      player_x += player_speed;
    }
  }

  // アイテム1の処理
  fruit1_y += fruit1_speed;


  // 当たり判定 とりあえず円の方式（距離）を使う
  float dx = fruit1_x - player_x;
  float dy = fruit1_y - player_y;
  if ( (dx * dx + dy * dy) < 2500 ) {
    // 距離が短いので当たった
    fruit1_flag = false; // フルーツ1フラグを false にする
    // アイテム取った時の処理などをここに書いても良い
  }


  // フルーツ1の表示
  if ( fruit1_flag == true) {
    image(fruit1_img, fruit1_x, fruit1_y);
  }


  //
  if ((frameCount / 30) % 2 == 0) {
    // 30フレームごとに切り替え
    image(player_img_1, player_x, player_y);
  } else {
    image(player_img_2, player_x, player_y);
  }


  // フルーツ1が画面下まで落ちたら、また上から降ってくる
  if ( height < fruit1_y ) {
    //xは画面内のどこかだけど、左右100pxの余白内に収める
    fruit1_x = constrain(random(width), 100, width - 100);
    //yは画面上よりもさらに上にする（落ちてくる時間差を利用する）
    fruit1_y = -random(500);
    fruit1_speed = random(5, 12);
    fruit1_flag = true;
  }

}

void keyPressed() {
}
