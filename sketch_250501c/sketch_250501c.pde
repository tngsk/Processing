
size(600, 600);
colorMode(HSB, 360, 100, 100);
background(0, 0, 100);


int days = 30;
int today = 15;

float spacing = width / (days+1);
float len = height / 2;

strokeWeight(2);

for (int i = 1; i <= days; i++) {
  float x = i * spacing;

  // 今日に該当する線だけ色を変える
  if (i == today) {
    stroke(0, 100, 100);
  } else {
    stroke(i * 12, 40, 100);
  }

  line(x, len - 50, x, len + 50);
}
