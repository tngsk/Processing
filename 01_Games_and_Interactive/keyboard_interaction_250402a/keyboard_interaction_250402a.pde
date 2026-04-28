void setup() {
  size(800, 400);
  colorMode(HSB, 360, 100, 100);
  noStroke();
  
  // Display different color combinations
  drawColorPair(0, "Harmonious Combination", createHarmoniousColors());
  drawColorPair(100, "Contrasting Combination", createContrastingColors());
  drawColorPair(200, "Fresh Combination", createFreshColors());
  drawColorPair(300, "Retro Combination", createRetroColors());
}

void drawColorPair(float y, String title, color[] colors) {
  // Left color
  fill(colors[0]);
  rect(0, y, width/2, 100);
  
  // Right color
  fill(colors[1]);
  rect(width/2, y, width/2, 100);
  
  // Display title
  fill(0);
  textAlign(CENTER);
  text(title, width/2, y + 50);
  
  // Display HSB values
  textAlign(CENTER);
  fill(0);
  String color1Info = "H:" + int(hue(colors[0])) + " S:" + int(saturation(colors[0])) + " B:" + int(brightness(colors[0]));
  String color2Info = "H:" + int(hue(colors[1])) + " S:" + int(saturation(colors[1])) + " B:" + int(brightness(colors[1]));
  text(color1Info, width/4, y + 70);
  text(color2Info, 3*width/4, y + 70);
}

// Harmonious color combination (similar hues)
color[] createHarmoniousColors() {
  color[] colors = new color[2];
  float baseHue = random(360);
  colors[0] = color(baseHue, 80, 90);
  colors[1] = color((baseHue + 30) % 360, 75, 85);
  return colors;
}

// Contrasting color combination (complementary colors)
color[] createContrastingColors() {
  color[] colors = new color[2];
  float baseHue = random(360);
  colors[0] = color(baseHue, 90, 90);
  colors[1] = color((baseHue + 180) % 360, 90, 90);
  return colors;
}

// Fresh combination (high-saturation accent with pastel)
color[] createFreshColors() {
  color[] colors = new color[2];
  
  // Pastel color (high brightness, low-medium saturation)
  float pastelHue = random(360);
  float pastelSat = random(20, 40);
  float pastelBri = random(85, 95);
  
  // Vivid color (medium-high brightness, high saturation)
  float vividHue = (pastelHue + random(90, 270)) % 360; // Hue distant from pastel
  float vividSat = random(80, 100);
  float vividBri = random(75, 95);
  
  // Randomly swap order
  if (random(1) > 0.5) {
    colors[0] = color(pastelHue, pastelSat, pastelBri);
    colors[1] = color(vividHue, vividSat, vividBri);
  } else {
    colors[0] = color(vividHue, vividSat, vividBri);
    colors[1] = color(pastelHue, pastelSat, pastelBri);
  }
  
  return colors;
}

// Retro combination (muted saturation, characteristic hue pairings)
color[] createRetroColors() {
  color[] colors = new color[2];
  
  // Define several hue ranges suitable for retro colors
  float[][] retroHueRanges = {
    {30, 60},   // Yellow to orange
    {0, 20},    // Red
    {200, 220}, // Teal
    {280, 320}, // Purple
    {90, 140}   // Yellowish-green to green
  };
  
  // Randomly select two different hue ranges
  int index1 = int(random(retroHueRanges.length));
  int index2 = int(random(retroHueRanges.length));
  while (index2 == index1) {
    index2 = int(random(retroHueRanges.length));
  }
  
  float hue1 = random(retroHueRanges[index1][0], retroHueRanges[index1][1]);
  float hue2 = random(retroHueRanges[index2][0], retroHueRanges[index2][1]);
  
  // Create retro feel with moderate saturation and brightness
  float sat1 = random(50, 85);
  float sat2 = random(50, 85);
  float bri1 = random(65, 85);
  float bri2 = random(65, 85);
  
  colors[0] = color(hue1, sat1, bri1);
  colors[1] = color(hue2, sat2, bri2);
  
  return colors;
}

void draw() {
  // Drawing happens once in this program
}

// Press space key to generate new color combinations
void keyPressed() {
  if (key == ' ') {
    background(360);
    drawColorPair(0, "Harmonious Combination", createHarmoniousColors());
    drawColorPair(100, "Contrasting Combination", createContrastingColors());
    drawColorPair(200, "Fresh Combination", createFreshColors());
    drawColorPair(300, "Retro Combination", createRetroColors());
  }
}
