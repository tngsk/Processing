// ===== Angry Bird ゲーム =====

ArrayList<BaseClass> gameObjects;
Slingshot slingshot;
ArrayList<Bird> birds;
ArrayList<Structure> structures;
ArrayList<Pig> pigs;

// ゲーム変数
int score;
int birds_remaining;
float camera_x;
boolean mouse_dragging;

// 初期化処理
void setup() {
  size(1280, 720);
  frameRate(60);

  // 基本設定
  rectMode(CORNER);
  ellipseMode(CORNER);
  textAlign(CENTER, CENTER);

  // リスト初期化
  gameObjects = new ArrayList<BaseClass>();
  birds = new ArrayList<Bird>();
  structures = new ArrayList<Structure>();
  pigs = new ArrayList<Pig>();

  init_game();
}

void draw() {
  background(135, 206, 235);

  // カメラ設定
  pushMatrix();
  translate(-camera_x, 0);

  // オブジェクト更新・描画
  for (BaseClass obj : gameObjects) {
    obj.update();
    obj.draw();
  }

  // カメラとゲーム処理
  update_camera();
  check_collisions();

  popMatrix();

  // UI表示
  drawUI();
  check_game_end();
}

// ゲーム初期化
void init_game() {
  score = 0;
  birds_remaining = 3;
  mouse_dragging = false;

  // リストクリア
  gameObjects.clear();
  birds.clear();
  structures.clear();
  pigs.clear();

  // オブジェクト作成
  slingshot = new Slingshot(100, 500);
  gameObjects.add(slingshot);

  // 地面
  Structure ground = new Structure(0, 650, 1600, 70, 1);
  ground.is_static = true;
  structures.add(ground);
  gameObjects.add(ground);

  // 構造物
  structures.add(new Structure(500, 550, 20, 100, 0));
  structures.add(new Structure(520, 530, 80, 20, 0));
  structures.add(new Structure(600, 550, 20, 100, 0));
  gameObjects.add(structures.get(1));
  gameObjects.add(structures.get(2));
  gameObjects.add(structures.get(3));

  // 豚
  Pig pig = new Pig(540, 510, 30, 30);
  pigs.add(pig);
  gameObjects.add(pig);
}

// カメラ更新
void update_camera() {
  Bird flying_bird = null;
  for (Bird bird : birds) {
    if (bird.is_launched && !bird.is_exploded) {
      flying_bird = bird;
      break;
    }
  }

  if (flying_bird != null) {
    camera_x = flying_bird.x - width / 4;
  } else {
    camera_x = slingshot.x - width / 4;
  }
  camera_x = constrain(camera_x, 0, 1000);
}

// 衝突判定
void check_collisions() {
  for (Bird bird : birds) {
    if (bird.is_launched && !bird.is_exploded) {
      // 鳥と構造物
      for (Structure structure : structures) {
        if (isColliding(bird, structure)) {
          structure.destroy();
          resolveCollision(bird, structure);
        }
      }

      // 鳥と豚
      for (Pig pig : pigs) {
        if (isColliding(bird, pig)) {
          pig.destroy();
          resolveCollision(bird, pig);
        }
      }
    }
  }
}

// ゲーム終了判定
void check_game_end() {
  boolean all_dead = true;
  for (Pig pig : pigs) {
    if (pig.is_alive) {
      all_dead = false;
      break;
    }
  }

  if (all_dead) {
    fill(0, 255, 0);
    textSize(48);
    text("CLEAR!", width/2, height/2);
    textSize(32);
    text("Score: " + score, width/2, height/2 + 50);
  }

  if (birds_remaining <= 0 && birds.size() == 0 && !all_dead) {
    fill(255, 0, 0);
    textSize(48);
    text("GAME OVER", width/2, height/2);
  }
}

// UI表示
void drawUI() {
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(20);
  text("Score: " + score, 20, 30);
  text("Birds: " + birds_remaining, 20, 60);

  int alive_pigs = 0;
  for (Pig pig : pigs) {
    if (pig.is_alive) alive_pigs++;
  }
  text("Pigs: " + alive_pigs, 20, 90);
  textAlign(CENTER, CENTER);
}

// キーボード入力
void keyPressed() {
  if (key == 'r' || key == 'R') {
    init_game();
  }
}

// マウス入力
void mousePressed() {
  if (!mouse_dragging && birds_remaining > 0) {
    float world_x = mouseX + camera_x;
    float world_y = mouseY;

    if (world_x > slingshot.x - 30 && world_x < slingshot.x + slingshot.w + 30 &&
        world_y > slingshot.y - 30 && world_y < slingshot.y + slingshot.h + 30) {
      mouse_dragging = true;
      slingshot.start_aiming(world_x, world_y);
    }
  }
}

void mouseDragged() {
  if (mouse_dragging) {
    slingshot.update_aim(mouseX + camera_x, mouseY);
  }
}

void mouseReleased() {
  if (mouse_dragging && birds_remaining > 0) {
    Bird bird = slingshot.launch_bird();
    if (bird != null) {
      birds.add(bird);
      gameObjects.add(bird);
      birds_remaining--;
    }
    mouse_dragging = false;
  }
}

// --- Added from Bird.pde ---
class Bird extends BaseClass {

  boolean is_launched;
  boolean is_exploded;
  int still_timer;

  Bird(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.is_launched = false;
    this.is_exploded = false;
    this.still_timer = 0;
  }

  void launch(float vel_x, float vel_y) {
    this.vx = vel_x;
    this.vy = vel_y;
    this.is_launched = true;
  }

  void update() {
    if (this.is_launched && !this.is_exploded) {
      applyGravity(this, 0.25);
      super.update();

      // 地面跳ね返り
      if (this.y > 620) {
        this.y = 620;
        this.vy = -this.vy * 0.6;
        this.vx *= 0.9;
      }

      // 壁跳ね返り
      if (this.x < 0) {
        this.x = 0;
        this.vx = -this.vx * 0.6;
      }
      if (this.x > 1580) {
        this.x = 1580;
        this.vx = -this.vx * 0.6;
      }

      // 静止判定
      if (abs(this.vx) < 0.5 && abs(this.vy) < 0.5) {
        this.still_timer++;
        if (this.still_timer > 120) {
          this.is_exploded = true;
        }
      } else {
        this.still_timer = 0;
      }
    }
  }

  void draw() {
    if (!this.is_exploded) {
      fill(255, 0, 0);
      ellipse(this.x, this.y, this.w, this.h);
    }
  }
}

// --- Added from Pig.pde ---
class Pig extends BaseClass {

  boolean is_alive;

  Pig(float x, float y, float w, float h) {
    super(x, y, w, h);
    this.is_alive = true;
  }

  void destroy() {
    if (this.is_alive) {
      this.is_alive = false;
      score += 100;
    }
  }

  void update() {
    if (this.is_alive) {
      applyGravity(this, 0.25);
      super.update();

      if (this.y > 620) {
        this.y = 620;
        this.vy = 0;
        this.vx *= 0.8;
      }

      checkBounds(this, 0, 0, 1600, 720, 0.3);
    }
  }

  void draw() {
    if (this.is_alive) {
      fill(0, 255, 0);
      ellipse(this.x, this.y, this.w, this.h);
    }
  }
}

// --- Added from Slingshot.pde ---
class Slingshot extends BaseClass {

  boolean is_aiming;
  float aim_x, aim_y;

  Slingshot(float x, float y) {
    super(x, y, 40, 60);
    this.is_aiming = false;
  }

  void start_aiming(float mouse_x, float mouse_y) {
    this.is_aiming = true;
    this.aim_x = mouse_x;
    this.aim_y = mouse_y;
  }

  void update_aim(float mouse_x, float mouse_y) {
    this.aim_x = mouse_x;
    this.aim_y = mouse_y;
  }

  Bird launch_bird() {
    if (!this.is_aiming) return null;

    float dx = (this.x + this.w/2) - this.aim_x;
    float dy = (this.y + this.h/2) - this.aim_y;

    Bird bird = new Bird(this.x + this.w/2, this.y + this.h/2, 20, 20);
    bird.launch(dx * 0.2, dy * 0.2);

    this.is_aiming = false;
    return bird;
  }

  void draw() {
    fill(139, 69, 19);
    rect(this.x, this.y, this.w, this.h);

    if (this.is_aiming) {
      stroke(255, 0, 0);
      line(this.x + this.w/2, this.y + this.h/2, this.aim_x, this.aim_y);
      noStroke();
    }
  }
}

// --- Added from Structure.pde ---
class Structure extends BaseClass {

  boolean is_destroyed;
  boolean is_static;

  Structure(float x, float y, float w, float h, int type) {
    super(x, y, w, h);
    this.is_destroyed = false;
    this.is_static = (type == 1);
  }

  void destroy() {
    if (!this.is_destroyed) {
      this.is_destroyed = true;
      score += 50;
    }
  }

  void update() {
    if (!this.is_destroyed && !this.is_static) {
      applyGravity(this, 0.25);
      super.update();

      if (this.y > 620) {
        this.y = 620;
        this.vy = 0;
        this.vx *= 0.7;
      }

      checkBounds(this, 0, 0, 1600, 720, 0.3);
    }
  }

  void draw() {
    if (!this.is_destroyed) {
      fill(139, 69, 19);
      rect(this.x, this.y, this.w, this.h);
    }
  }
}
