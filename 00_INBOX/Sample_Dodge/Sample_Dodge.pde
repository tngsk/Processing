 // ===== シンプル避けゲーム =====

 // --- ゲームオブジェクト ---
 Player player;
 ArrayList<Obstacle> obstacles;
 int score;
 int spawnTimer;
 boolean gameOver;

 // --- 入力状態 ---
 boolean isLeftKeyPressed = false;
 boolean isRightKeyPressed = false;
 boolean isUpKeyPressed = false;
 boolean isDownKeyPressed = false;

 // --- 初期化処理 ---
 void setup() {
   size(1280, 720);
   frameRate(60);

   // 基本設定
   rectMode(CORNER);
   imageMode(CORNER);
   ellipseMode(CORNER);
   textAlign(CENTER, CENTER);

   // ゲーム初期化
   initGame();
 }

 // --- ゲーム初期化 ---
 void initGame() {
   player = new Player(width/2 - 25, height/2 - 25, 50, 50);
   obstacles = new ArrayList<Obstacle>();
   score = 0;
   spawnTimer = 0;
   gameOver = false;
 }

 // --- メインループ ---
 void draw() {
   background(30, 30, 50);

   if (!gameOver) {
     updateGame();
   }

   drawGame();
   drawUI();
 }

 // --- ゲーム更新 ---
 void updateGame() {
   player.update();

   // 障害物生成
   spawnTimer++;
   if (spawnTimer > 60) {
     spawnObstacle();
     spawnTimer = 0;
   }

   // 障害物更新
   for (Obstacle obs : obstacles) {
     obs.update();
     if (!obs.isActive) {
       score += 10;
     }
   }

   // 衝突判定
   for (Obstacle obs : obstacles) {
     if (obs.isActive && isColliding(player, obs)) {
       player.takeDamage();
       obs.isActive = false;
     }
   }

   // 非アクティブな障害物を安全に削除（逆順ループ）
   for (int i = obstacles.size() - 1; i >= 0; i--) {
     if (!obstacles.get(i).isActive) {
       obstacles.remove(i);
     }
   }

   // ゲームオーバー判定
   if (player.lives <= 0) {
     gameOver = true;
   }
 }

 // --- 障害物生成 ---
 void spawnObstacle() {
   float x, y;

   // ランダムな場所から出現
   int side = int(random(4));
   switch (side) {
   case 0: // 上から
     x = random(50, width - 50);
     y = -50;
     break;
   case 1: // 下から
     x = random(50, width - 50);
     y = height + 50;
     break;
   case 2: // 左から
     x = -50;
     y = random(50, height - 50);
     break;
   case 3: // 右から
     x = width + 50;
     y = random(50, height - 50);
     break;
   default:
     x = random(50, width - 50);
     y = -50;
     break;
   }

   Obstacle obs = new Obstacle(x, y, 30, 30);
   obstacles.add(obs);
 }

 // --- 描画処理 ---
 void drawGame() {
   // 障害物描画
   for (Obstacle obs : obstacles) {
     obs.draw();
   }

   // プレイヤー描画
   player.draw();
 }

 // --- UI描画 ---
 void drawUI() {
   fill(255);
   textAlign(LEFT, TOP);
   textSize(18);
   text("Score: " + score, 20, 20);
   text("Lives: " + player.lives, 20, 50);

   textAlign(CENTER, CENTER);
   textSize(16);
   text("Arrow Keys: Move", width/2, height - 60);
   text("Avoid the obstacles!", width/2, height - 40);

   if (gameOver) {
     fill(255, 100, 100);
     textSize(36);
     text("GAME OVER", width/2, height/2);
     text("Final Score: " + score, width/2, height/2 + 40);
     text("Press R to Restart", width/2, height/2 + 80);
   }
 }

 // --- キー入力 ---
 void keyPressed() {
   if (gameOver && (key == 'r' || key == 'R')) {
     initGame();
   }

   if (keyCode == LEFT) {
     isLeftKeyPressed = true;
   } else if (keyCode == RIGHT) {
     isRightKeyPressed = true;
   } else if (keyCode == UP) {
     isUpKeyPressed = true;
   } else if (keyCode == DOWN) {
     isDownKeyPressed = true;
   }
 }

 void keyReleased() {
   if (keyCode == LEFT) {
     isLeftKeyPressed = false;
   } else if (keyCode == RIGHT) {
     isRightKeyPressed = false;
   } else if (keyCode == UP) {
     isUpKeyPressed = false;
   } else if (keyCode == DOWN) {
     isDownKeyPressed = false;
   }
 }
