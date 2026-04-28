
void setup(){
  
size(800, 800);

}

void draw() {
background(255);


strokeWeight(80);
stroke(0,255,0);
point(400 - 160, 320);

stroke(0,0,255);
point(400 + 160, 320);

strokeWeight(60);

stroke(0,0,255);
//arc(400, 400 + 50, 300, 300, radians(0+30), radians(180-30));
//arc(400, 400 + 300, 300, 300, radians(180+30), radians(360-30));

strokeWeight(50);
stroke(0);
fill(255,0,0);
ellipse(400, 400 + 150, 100, 150);


}

void keyPressed(){
  save("image.png");
}
