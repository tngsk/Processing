//meiro
int i, j;
//改訂版
int map[][] = {{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  {0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1},
  {1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1 },
  {1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1},
  {1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},

  {1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1},
  {1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1},
  {1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1},
  {1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1},
  {1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},

  {1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1},
  {1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1},
  {1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1},
  {1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},
  {1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1},

  {1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1},
  {1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1},
  {1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
  {1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};

//{{0,0,1,1,1, 1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1},
//{0,0,0,1,0, 0,0,0,1,0, 0,0,0,1,0, 0,0,1,1,1},
//{1,0,0,1,0, 1,1,0,1,0, 1,0,0,1,1, 1,0,1,0,1},
//{1,0,1,0,0, 0,1,0,1,0, 1,1,0,1,0, 0,0,0,0,1},
//{1,0,0,0,1, 0,1,0,1,0, 0,1,0,1,0, 1,0,1,0,1},
//{1,0,1,0,1, 0,1,0,0,0, 1,1,1,1,0, 1,1,1,0,1},
//{1,0,1,0,1, 0,0,0,1,0, 0,1,0,0,0, 1,0,1,0,1},
//{1,1,1,0,1 ,1,0,1,0,0, 0,1,0,1,0 ,1,0,0,0,1},
//{1,0,0,0,0, 1,0,1,0,1, 0,1,0,1,0, 1,1,1,0,1},
//{1,0,0,1,0, 0,0,1,0,1, 0,0,0,1,0, 0,0,0,0,1},
//{1,0,0,1,0, 0,0,0,1,0, 0,0,0,1,0, 0,0,1,1,1},
//{1,0,0,1,0, 1,1,0,1,0, 1,1,0,1,1, 1,0,1,0,1},
//{1,0,1,0,0, 0,1,0,1,0, 0,1,0,1,0, 0,0,0,0,1},
//{1,0,0,0,1, 0,1,0,1,0, 0,1,0,1,0, 1,0,1,0,1},
//{1,0,1,0,1, 0,1,0,0,0, 1,1,1,1,0, 1,1,1,0,1},
//{1,0,1,0,1, 0,0,0,1,0, 0,1,0,0,0, 0,0,1,0,0},
//{1,1,1,0,1, 1,0,1,0,0, 0,1,0,1,0, 0,0,1,0,0},
//{1,0,0,0,0, 1,0,1,0,1, 0,1,0,1,0 ,1,1,1,0,1},
//{1,0,0,1,0, 0,0,1,0,1, 0,0,0,1,0, 0,0,0,0,1},
//{1,1,1,1,1 ,1,1,1,1,1, 1,1,1,1,1, 1,1,1,1,1}};

PImage A;
PImage B;

String resultMessage = "You Lose";
String resultMessage2 = "You Win";
String start="Start";
String goal="Goal";
//自分
float ball_x;
float ball_y ;
float ball_w ;
float ball_h ;
float ball_speed;

float vx, vy;

float start_x;
float start_y;

float ball_size;

//鬼
float oni_x;
float oni_y ;
float oni_w ;
float oni_h ;
float oni_speed;

float onistart_y;

//itukaraugoku
float oikake_x;
float oikake_y;


void setup() {
  size(1280, 720);

  //だるま
  A = loadImage("thumbnail_image1.png");

  //実は私
  B = loadImage("thumbnail_image0.png");

  //だるま


  ball_x = 50;
  ball_y = 40;
  ball_w = 40;
  ball_h = 40;
  ball_speed=2;

  //oniではなく私

  oni_x=20;
  oni_y=40;
  oni_w=40 ;
  oni_h=40;

  oni_speed=0.5;
}

void draw() {
  background(#FAE8F7);
  oikake_x=0;

  textSize(15);//size
  fill(#E000FF);//iro
  text(start, 45, 15);

  textSize(15);//size
  fill(#E000FF);//iro
  text(goal, width-45, 80);

  //meiro
  for (int i=0; i<20; i++) {
    for (int j=0; j<20; j++) {
      if (map[i][j]==1) {
        fill(#9503FF);
        rect(i*width/20, j*height/20, width/20, height/20);
      }
    }
  }

  imageMode(CENTER);
  image(A, ball_x, ball_y, ball_w, ball_h);
  image(B, oni_x, oni_y, oni_w, oni_h);

  //key操作
  if (keyPressed) {
    if (keyCode == UP) {
      ball_y -=ball_speed;
    }
    if (keyCode == DOWN) {
      ball_y  += ball_speed;
    }
    if (keyCode == RIGHT) {
      
      
      
      int i = int((ball_x + (ball_w / 2)) / (width/20));
      int j = int((ball_y + (ball_h / 2)) / (height/20));
      
      println(i, j, map[i][j]);
      
      if (map[i][j]==0) {
        ball_x +=ball_speed;
      }
      
      
      
    }
    if (keyCode == LEFT) {
      ball_x  -= ball_speed;
    }
  }

  //やり方不明なのでこれは手計算でやる

  if ((ball_x)>1216 && (ball_y-ball_h/2)>36&&(ball_y+ball_h/2)<108) {
    background(#F205E7);
    textAlign(CENTER, CENTER);
    textSize(64);
    fill(#D4FF48);
    text(resultMessage2, width/2, height/2-40);
    noLoop();
  }

  //oniと自分の当たり判定
  float d = dist(ball_x, ball_y, oni_x, oni_y);
  if ( d < 0 ) {
    background(#F205E7);

    textAlign(CENTER, CENTER);//ichi
    textSize(64);//size
    fill(#D4FF48);//iro
    text(resultMessage, width / 2, height / 2 - 40);
  }





  // oniボールの位置制限
  oni_x = constrain(oni_x, 0, width-oni_w);
  oni_y = constrain(oni_y, 0, height-oni_h);
  ball_x = constrain(ball_x, 10, width-ball_w);
  ball_y = constrain(ball_y, 0, height-ball_h);


  // ボール
  //ellipse(ball_x, ball_y, ball_w, ball_h);

  //oniボール
  //ellipse(oni_x, oni_y, oni_w, oni_h);

  // 鬼の追跡
  //if (  oikake_x<=abs( ball_x-(oni_x+oni_w) )) {
  if (oni_x+oni_w/2< ball_x-ball_w/2) {
    oni_x += oni_speed;
  } else if (ball_x+ball_w/2<oni_x-oni_w/2) {
    oni_x -= oni_speed;
  }
  if (oni_y+oni_h/2 < ball_y-ball_h/2) {
    oni_y += oni_speed;
  } else if (oni_y-oni_h/2> ball_y+ball_h/2) {
    oni_y -= oni_speed;
  }



  //if(abs(ball_x-oikake_x)>=50){
  //   oni_x += oni_speed;
  // }
  // else if (50<= abs(ball_y-oikake_y)) {
  // oni_y += oni_speed;
  // }
}
