
void setup(){
  size(600,600);
}

void draw(){
  int days = 30;
  int today = 9;
  
  for (int day = 1; day <= days; day++){
    if (day == today) {
      strokeWeight(5);
      stroke(255, 0, 0);
    } else {
      strokeWeight(1);
      stroke(0, 0, 0);
    }
    float x = day * width / days;
    line(x, 0, x, height);
  }
    
}
