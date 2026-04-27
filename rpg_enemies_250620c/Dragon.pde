class Dragon extends Enemy {

  Dragon(float _x, float _y){
    super(_x, _y, 50, 1, color(0,80,0));
  }

  void draw(){
    fill(clr);
    rect(x, y, 100,100);
  }
  
  void fire(){
    println("火を吹いた！");
  }

}
