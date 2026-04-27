


// フォントを管理する変数を宣言する
PFont font;

void setup(){
  size(1280, 720);
  
  // お好きなttfフォントをdataフォルダに追加する
  
  // dataフォルダにあるフォントを読み込む
  font = createFont("NotoSansJP-Regular.ttf", 128);
}


void draw(){
  background(200);
  
  textFont(font, 128);
  textAlign(CENTER);
  text("こんにちは", width/2, height/2);
  
}
