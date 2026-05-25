// ===== テンプレート：シーン(画面)切り替えとゲーム状態管理 =====
//
// 用途: タイトル画面 → ゲーム画面 → ゲームクリア/オーバー画面 のような
// 画面の切り替えを、シンプルなフラグ変数で行う設計パターンです。

// --- 状態を管理するフラグ（変数） ---
boolean isGameStarted = false; // タイトル画面か、ゲーム画面かを分ける
boolean isGameOver = false;    // 失敗した状態
boolean isGameCleared = false; // クリアした状態

// ゲーム用の変数
int score = 0;
int timer = 0;

void setup() {
  size(800, 600);
  textAlign(CENTER, CENTER);

  // 初期化関数を呼んで最初からスタート
  initGame();
}

// ゲームの初期化（リセット）処理
void initGame() {
  isGameStarted = false;
  isGameOver = false;
  isGameCleared = false;
  score = 0;
  timer = 300; // 5秒の制限時間（60fps × 5 = 300）
}

void draw() {
  // フラグの状態によって、実行する処理（画面）を切り替える

  if (!isGameStarted) {
    // -------------------------
    // タイトル画面
    // -------------------------
    drawTitleScreen();

  } else if (isGameOver) {
    // -------------------------
    // ゲームオーバー画面
    // -------------------------
    drawGameOverScreen();

  } else if (isGameCleared) {
    // -------------------------
    // ゲームクリア画面
    // -------------------------
    drawGameClearScreen();

  } else {
    // -------------------------
    // メインのゲーム画面
    // -------------------------
    updateGame();
    drawGameScreen();
  }
}

// ==========================================
// 各シーンの更新・描画処理
// ==========================================

void drawTitleScreen() {
  background(30, 30, 80);
  fill(255);
  textSize(48);
  text("SIMPLE GAME", width/2, height/2 - 50);

  textSize(24);
  // 点滅効果
  if (frameCount % 60 < 30) {
    fill(255, 255, 0);
    text("Press SPACE to Start", width/2, height/2 + 50);
  }
}

void updateGame() {
  // 時間を減らす
  timer--;

  // マウスが動いたらスコアアップ（仮のゲーム要素）
  score += abs(mouseX - pmouseX);

  // 条件を満たしたらフラグを切り替えて画面を移行する

  // 時間切れでゲームオーバー
  if (timer <= 0) {
    isGameOver = true;
  }

  // スコアが1000を超えたらゲームクリア
  if (score > 1000) {
    isGameCleared = true;
  }
}

void drawGameScreen() {
  background(50, 150, 50);

  fill(255);
  textSize(32);
  text("Move Mouse to earn score!", width/2, height/2);

  // UI表示
  textAlign(LEFT, TOP);
  textSize(24);
  text("Score: " + score + " / 1000", 20, 20);

  // 残り時間の表示（小数第一位まで）
  float seconds = timer / 60.0f;
  text("Time: " + nf(seconds, 0, 1), 20, 60);

  textAlign(CENTER, CENTER); // 戻しておく
}

void drawGameOverScreen() {
  background(100, 30, 30);
  fill(255);
  textSize(48);
  text("GAME OVER", width/2, height/2 - 50);

  textSize(24);
  text("Final Score: " + score, width/2, height/2 + 20);
  text("Press 'R' to Restart", width/2, height/2 + 80);
}

void drawGameClearScreen() {
  background(255, 200, 50);
  fill(0);
  textSize(48);
  text("GAME CLEAR!", width/2, height/2 - 50);

  textSize(24);
  text("Final Score: " + score, width/2, height/2 + 20);
  float secondsLeft = timer / 60.0f;
  text("Time Left: " + nf(secondsLeft, 0, 1) + "s", width/2, height/2 + 60);
  text("Press 'R' to Restart", width/2, height/2 + 120);
}

// ==========================================
// 入力処理（シーン間の移動）
// ==========================================
void keyPressed() {
  // タイトル画面でスペースキーを押したらゲーム開始
  if (!isGameStarted && key == ' ') {
    isGameStarted = true;
  }

  // 終了画面で 'R' を押したら最初から
  if ((isGameOver || isGameCleared) && (key == 'r' || key == 'R')) {
    initGame();
  }
}
