
//Minimライブラリを使う準備
import ddf.minim.*;

//Minimの変数
Minim minim;
AudioPlayer item_sound;

void setup() {
  size(1280, 720);

  // Minimの初期化（必須）
  minim = new Minim(this);

  // サウンドファイルの読み込み
  item_sound = minim.loadFile("item.mp3");
}

void draw() {
}

void mousePressed() {

  //サウンド再生位置を最初に戻す
  item_sound.rewind();

  //再生（効果音など）
  item_sound.play();

  if (item_sound.isPlaying()) {
    // 再生中なら
  } else {
    // じゃなかったら
  }
}

void keyPressed() {

  if (key == 'l') {
    //ループ再生（BGMなど）
    item_sound.loop();
  }

  if (key == 's' || key == 'p') {
    //停止
    item_sound.pause();
  }
}
