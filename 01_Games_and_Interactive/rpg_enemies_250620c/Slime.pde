class Slime extends Enemy {

  Slime(float _x, float _y){
    super(_x, _y, 50, 1, color(0,255,0));
  }
  
  void draw(){
    fill(clr);
    ellipse(x, y, 40, 40);
  }
}
