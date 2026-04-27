
size(600, 600);
colorMode(HSB, 360, 100, 100);
background(0,0,100);

float num = 20;
float rect_width = width / num;

noStroke();

for (int i = 0; i < num; i++) {
  float hue = 0 + (i/num) * 60;

  fill(hue, 100, 100);  
  rect(i * rect_width, 0, rect_width, height);
}
