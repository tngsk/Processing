

int state = 0;

float bx, by, vy;
int item_count = 0;

PImage game_over_image, game_clear_image;


void setup() {
  size(600, 400);

  state = 0;

  //数字で状況を決める(自分がわかれば自由に決めて良い)
  //0 スタート画面
  //1 ゲーム中
  //2 ゲームオーバー画面
  //3 クリア画面
}

void draw() {

  if (state == 0) {
    //スタート画面を描く（画像を表示するなど）

    //ゲームをスタートさせる条件を書く
    //キーを押すなど
    if (keyPressed) {
      state = 1; //ゲームスタート
    }
  }


  if (state == 1) {
    //ゲーム中
    //コードが長くなるので、ファンクションにしてdraw()の外に追い出すと、構造が見やすい
    game();
  }

  if (state == 2) {
    game_over();
  }

  if (state == 3) {
    game_clear();
  }
}

//ゲーム中のコードを書くファンクション
//背景クリアして、オブジェクト移動して当たり判定して表示して、、などを書く
void game() {

  background(0);

  by += vy;
  ellipse(bx, by, 50, 50);
  
  if (by < height){
    // 落ちたらゲームオーバー
    state = 2; 
  }
  
  if (item_count >= 5){
    // アイテムを5個以上とったらクリア
    state = 3;
  }
}


// ゲームオーバー画面
void game_over() {
   image(game_over_image, 0, 0);
  if (keyPressed) {
    state = 0; //スタート画面へ
  }
}

void game_clear() {
   image(game_clear_image, 0, 0);
  if (keyPressed) {
    state = 0; //スタート画面へ
  }
}
