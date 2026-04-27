float ball_x = 0;
float ball_y = 0;
float vx = 0;
float vy = 0;
float ball_size = 0;

void setup() {
  size(600, 400);
  ball_x = width/2;
  ball_y = height/2;
  vx = 5;
  vy = 0;
  ball_size = 80;
}

void draw() {
  background(0, 0, 0);
  noStroke();

  if (ball_x + ball_size/2 > width) {
    vx = -vx;
  }

  if (ball_x - ball_size/2 < 0) {
    vx = -vx;
  }

  ball_x = ball_x + vx;
  ball_y = ball_y + vy;
  ellipse(ball_x, ball_y, ball_size, ball_size);
}
