
// ボール

float ball_x;
float ball_y;
float ball_size;
float vx, vy;


// プレイヤーパッド

float pad_x;
float pad_y;
float pad_w;
float pad_h;
float pad_speed;

// AIパッド
float AI_x;
float AI_y;
float ai_pad_speed;

PImage dvd_logo;

void setup(){
  size(1200,400);
  noStroke();
  
  pad_x = 100;
  pad_y = height / 2;
  
  pad_w = 20;
  pad_h = 120;
  
  rectMode(CENTER);
  
  ball_size = 20;
  pad_speed = 8;
  
  AI_x = width - 100;
  AI_y = height / 2;
  ai_pad_speed = 9;
  
  
  ball_x = width/2;
  ball_y = height/2;
  vx = random(4,8);
  vy = random(4,8);
  
  dvd_logo = loadImage("dvd-white-100.png");
  
}


void draw(){
  background(0);
  
  
  // プレイヤーの操作
  if (keyPressed){
    if (keyCode == UP) {
      pad_y = pad_y - pad_speed;
    }
    if (keyCode == DOWN) {
      pad_y = pad_y + pad_speed;
    }
  }
  // プレイヤーが画面端にでないようにする
  pad_y = constrain(pad_y, pad_h/2, height-pad_h/2);
  
  
  // ボールの計算
  ball_x = ball_x + vx;
  ball_y = ball_y + vy;
  
  // ボールが上で跳ね返る
  if (ball_y < 0){
   vy = -vy;
   ball_y = 0;
  }
  
  // ボールが下で跳ね返る
  if (ball_y > height){
    vy = -vy;
    ball_y = height;
  }
  
  if (ball_x < 0){
    resetGame();
  }
  
  if (ball_x > width){
    resetGame();
  }
  

  // AIパッドがボールを追いかける
  // ボールがAIよりも上にあるとき
  if (ball_y < AI_y) {
    AI_y = AI_y - ai_pad_speed;
  }
  
  // ボールがAIよりも下にあるとき
  if (ball_y > AI_y) {
    AI_y = AI_y + ai_pad_speed;
  }
  
  // AIパッドの動きを制限する
  AI_y = constrain(AI_y, pad_h/2, height-pad_h/2);
  
  
  fill(255);
  
  // プレイヤーとボールの当たり判定
  if(ball_x - ball_size < pad_x + pad_w / 2 && ball_x + ball_size > pad_x - pad_w / 2){
    if (ball_y - ball_size < pad_y + pad_h / 2 && ball_y + ball_size > pad_y - pad_h / 2) {
        fill(255,0,0);
        vx = -vx;
        vy = vy + (ball_y - pad_y) / 10;
    }
  }
  // AIパッドとボールの当たり判定
  if(ball_x - ball_size < AI_x + pad_w / 2 && ball_x + ball_size > AI_x - pad_w / 2){
    if (ball_y - ball_size < AI_y + pad_h / 2 && ball_y + ball_size > AI_y - pad_h / 2) {
        fill(255,0,0);
        vx = vx * 1.2;
        vx = -vx;
        vy = vy + (ball_y - AI_y) / 10;
    }
  }
   
  //みんなまとめて描く
  rect(pad_x, pad_y, pad_w, pad_h);
  rect(AI_x, AI_y, pad_w, pad_h);
  
  ellipse(ball_x, ball_y, ball_size * 2, ball_size * 2);
  //imageMode(CENTER);
  //image(dvd_logo, ball_x, ball_y);

}

void resetGame(){
  ball_x = width/2;
  ball_y = height/2;
  
  if(random(1) > 0.5){
    vx = random(4,8);
  } else {
    vx = -random(4,8);
  }
  
  vy = random(-8,8);
}
