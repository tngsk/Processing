
size(600, 600);
colorMode(HSB, 360, 100, 100);
background(0,0,100);
noStroke();

// 円の直径
int r = 60;

// 7つの円を横に並べる
for (int i = 1; i < 8; i++) {
  float x = width / 8 * i;
  float y = height / 2;
  
  fill(200,50,90);
  ellipse(x, y, r, r); 
}
