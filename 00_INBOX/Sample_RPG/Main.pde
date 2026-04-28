 // ===== シンプルRPGデモ =====

 // --- ゲームオブジェクト ---
 RPGPlayer player;
 ArrayList<RPGItem> items;
 boolean gameWon;

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
   player = new RPGPlayer(width/2 - 30, height/2 - 30, 60, 60);
   items = new ArrayList<RPGItem>();
   gameWon = false;

   // アイテム配置
   spawnItems();
 }

 // --- アイテム生成 ---
 void spawnItems() {
   // ポーション
   items.add(new RPGItem(200, 200, "Potion"));
   items.add(new RPGItem(400, 150, "Potion"));
   items.add(new RPGItem(600, 300, "Potion"));

   // ゴールド
   items.add(new RPGItem(300, 400, "Gold"));
   items.add(new RPGItem(800, 250, "Gold"));
   items.add(new RPGItem(500, 500, "Gold"));
   items.add(new RPGItem(700, 400, "Gold"));
   items.add(new RPGItem(900, 300, "Gold"));
 }

 // --- メインループ ---
 void draw() {
   background(60, 80, 60);

   if (!gameWon) {
     updateGame();
   }

   drawGame();
   drawUI();
 }

 // --- ゲーム更新 ---
 void updateGame() {
   player.update();

   // アイテムとの衝突判定
   for (RPGItem item : items) {
     if (!item.isCollected && isColliding(player, item)) {
       item.collect();
       player.collectItem(item.itemName);
     }
   }

   // 収集されたアイテムを削除（安全な逆順ループ）
   for (int i = items.size() - 1; i >= 0; i--) {
     if (items.get(i).isCollected) {
       items.remove(i);
     }
   }

   // 全アイテム収集でクリア
   if (items.size() == 0) {
     gameWon = true;
   }
 }

 // --- 描画処理 ---
 void drawGame() {
   // アイテム描画
   for (RPGItem item : items) {
     item.draw();
   }

   // プレイヤー描画
   player.draw();
 }

 // --- UI描画 ---
 void drawUI() {
   fill(255);
   textAlign(LEFT, TOP);
   textSize(18);
   text("Health: " + player.health + "/" + player.maxHealth, 20, 20);
   text("Gold: " + player.gold, 20, 50);
   text("Items: " + player.inventory.size(), 20, 80);
   text("Items Left: " + items.size(), 20, 110);

   textAlign(CENTER, CENTER);
   textSize(16);
   text("Arrow Keys: Move", width/2, height - 60);
   text("Collect all items!", width/2, height - 40);

   if (gameWon) {
     fill(255, 255, 0);
     textSize(36);
     text("ALL ITEMS COLLECTED!", width/2, height/2);
     text("Total Gold: " + player.gold, width/2, height/2 + 40);
     text("Press R to Restart", width/2, height/2 + 80);
   }
 }

 // --- キー入力 ---
 void keyPressed() {
   if (gameWon && (key == 'r' || key == 'R')) {
     initGame();
   }

   if (keyCode == UP) {
     isUpKeyPressed = true;
   } else if (keyCode == DOWN) {
     isDownKeyPressed = true;
   } else if (keyCode == LEFT) {
     isLeftKeyPressed = true;
   } else if (keyCode == RIGHT) {
     isRightKeyPressed = true;
   }
 }

 void keyReleased() {
   if (keyCode == UP) {
     isUpKeyPressed = false;
   } else if (keyCode == DOWN) {
     isDownKeyPressed = false;
   } else if (keyCode == LEFT) {
     isLeftKeyPressed = false;
   } else if (keyCode == RIGHT) {
     isRightKeyPressed = false;
   }
 }

 // --- マウス入力 ---
 void mousePressed() {
   // クリック位置にアイテムを追加
   if (items.size() < 15) {
     String[] itemNames = {"Potion", "Gold"};
     String itemName = itemNames[int(random(2))];
     RPGItem newItem = new RPGItem(mouseX - 10, mouseY - 10, itemName);
     items.add(newItem);
   }
 }
