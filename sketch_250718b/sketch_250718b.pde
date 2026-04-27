import ddf.minim.*;

Minim minim;
AudioPlayer item_sound;
AudioPlayer item2_sound;

void setup(){
  size(800,600);
  
  minim = new Minim(this);
  item_sound = minim.loadFile("sound.mp3");
 
}

void draw(){

}

void mousePressed(){
  
  item_sound.rewind();
  item_sound.play();
}
