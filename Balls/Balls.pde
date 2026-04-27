ArrayList<Ball> balls;
float gravity = 0.3;

void setup() {
  size(800, 600);
  balls = new ArrayList<Ball>();
  
  for (int i = 0; i < 10; i++) {
    float x = random(width);
    float y = random(height/4);
    float size = random(20, 50);
    color ballColor = color(random(255), random(255), random(255));
    balls.add(new Ball(x, y, size, ballColor));
  }
}

void draw() {
  background(240);
  
  // 全てのボールを更新して描画
  for (Ball ball : balls) {
    ball.update();
    ball.display();
    ball.checkEdges();
  }
  
  // 画面上部に説明テキストを表示
  fill(0);
  textSize(16);
  text("balls: " + balls.size(), 20, 50);
}

void mousePressed() {
  float size = random(20, 50);
  color ballColor = color(random(255), random(255), random(255));
  balls.add(new Ball(mouseX, mouseY, size, ballColor));
}


class Ball {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float size;
  color col;
  float bounce = 0.8;
  
  Ball(float x, float y, float s, color c) {
    position = new PVector(x, y);
    velocity = new PVector(random(-2, 2), random(-2, 2));
    acceleration = new PVector(0, 0);
    size = s;
    col = c;
  }
  
  void update() {

    PVector g = new PVector(0.0, gravity);
    applyForce(g);
    
    velocity.add(acceleration);
    position.add(velocity);
    
    acceleration.mult(0);
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  void checkEdges() {

    if (position.y > height - size/2) {
      position.y = height - size/2;
      velocity.y *= -bounce;
    }
    
    if (position.y < size/2) {
      position.y = size/2;
      velocity.y *= -bounce;
    }
    
    if (position.x > width - size/2) {
      position.x = width - size/2;
      velocity.x *= -bounce;
    }
    
    if (position.x < size/2) {
      position.x = size/2;
      velocity.x *= -bounce;
    }
    
    if (abs(velocity.y) < 0.1 && position.y > height - size/2 - 1) {
      velocity.y = 0;
    }
  }
  
  void display() {
    noStroke();
    fill(col);
    ellipse(position.x, position.y, size, size);
  }
}
