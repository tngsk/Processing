

// 原点を画面中心に移動し、オブジェクトやキャラクターを制作します
// オブジェクトやキャラクターの中心、または足元を原点に合わせます

void setup(){
  size(600,600);
}

void draw(){
  pushMatrix();
  // 画面中央に原点を移動する
  translate(width/2, height/2);
  //オブジェクトここから
  background(255,255,255,0);
  
  
  
  
  
  
  
  //オブジェクトここまで
  popMatrix();
}

void keyPressed(){

  save("Image.png");

}
