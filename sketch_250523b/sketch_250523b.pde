

// プレイヤーの座標
float player_x;
float player_y;



// アイテム1の座標
float item1_x;
float item1_y;
// アイテム1フラグ
boolean item1_flag;


int score;



// アイテム2の座標
float item2_x;
float item2_y;
// アイテム2フラグ
boolean item2_flag;


// 経過秒数を計算する（フレームカウント）

int item1_counter;


void setup() {
  size(1280, 720);
  noStroke();


  // アイテムを画面のどこかに配置する
  item1_x = random(width);
  item1_y = random(height);
  // アイテム1状態（初期状態では見えている）
  item1_flag = true;

  // アイテムを画面のどこかに配置する
  item2_x = random(width);
  item2_y = random(height);
  
  // スコア
  score = 0;
  
  
}


void draw() {
  background(0);
  noStroke();

  player_x = mouseX;
  player_y = mouseY;

  // プレイヤーとアイテムの座標の距離を計算して、変数distanceに代入する
  float distance1 = dist(player_x, player_y, item1_x, item1_y);
  // 距離が一定以下だっら
  if (distance1 < 25) {
    // アイテムを消す
    item1_flag = false;
    
    // 得点を足す
    score = score + 10;
  }


  // item1復活のカウント
  if (item1_flag == false) {
    item1_counter = item1_counter + 1;
    if (item1_counter > 60 * 5) {

      // アイテムを画面のどこかに配置する
      item1_x = random(width);
      item1_y = random(height);
      // アイテム1を出現させる
      item1_flag = true;
      
      // 次の出現にむけてカウンタをリセットする
      item1_counter = 0;
    }
  }





  // アイテム2の場合
  float distance2 = dist(player_x, player_y, item2_x, item2_y);
  if (distance2 < 25) {
    // アイテムを画面のどこかに配置する
    item2_x = random(width);
    item2_y = random(height);
    
    // スコアを減らす
    score = score - 5;
  }
  

  // プレイヤーとアイテムを描く

  // player
  fill(255);
  ellipse(player_x, player_y, 50, 50);



  // item1
  if (item1_flag == true) {
    fill(#FFF300);
    ellipse(item1_x, item1_y, 50, 50);
  } else {
    //消す時に画面の外に出す
    item1_x = -999;
    item1_y = -999;
  }


  // item2
  fill(#00FFE8);
  ellipse(item2_x, item2_y, 50, 50);
  
  
  // スコア
  fill(255);
  textSize(100);
  text("Score: " + score, 100, 100);
  
}
