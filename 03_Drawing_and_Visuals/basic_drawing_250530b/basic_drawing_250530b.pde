
float ball_x, ball_y;
float vy;

float world_x, world_y;

PImage coin_img;
PImage world_img;

int point;

void setup() {
  size(1270, 720);

  ball_x = random(width);
  ball_y = 0;
  vy = 5;

  world_y = height - 80;

  coin_img = loadImage("coin.png");
  world_img = loadImage("world.png");


  imageMode(CENTER);
  
  point = 0;
  
  
}

void draw() {
  background(0, 200, 250);

  ball_y += vy;

  if (ball_y > height) {
    ball_x = random(width);
    ball_y = -random(height);
    vy = random(8);
    vy = constrain(vy, 3, 8);
    
    point -= 8;
  }

  // キャラクターの横座標
  world_x = mouseX;

  // キャラクターを表示
  image(world_img, world_x, world_y);


  ellipse(ball_x, ball_y, 60, 60);
  // コインを表示
  image(coin_img, ball_x, ball_y);

  strokeWeight(10);
  //line(ball_x, ball_y, world_x, world_y);

  float dx = ball_x - world_x;
  float dy = ball_y - world_y;
  if (dx * dx + dy * dy < 14400) {
    // 当たった！
    point += 10;
    
    ball_x = random(width);
    ball_y = -random(height);
    vy = random(point * 0.3);
    vy = constrain(vy, 3, 1000);
  }
  
  fill(255);
  textSize(48);
  text(point, 50, 50);
  
  if (point < 0){
    //ゲームオーバー
  
  }
  
}
