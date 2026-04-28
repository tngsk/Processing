size(600, 600);
colorMode(HSB, 360, 100, 100);

noStroke();
fill(90, 100, 100);

pushMatrix();
translate(100, 200);
scale(0.25);
rect(0, 0, 200, 100);
popMatrix();


pushMatrix();
translate(width/2, height/2);
rotate(radians(45));
rect(0, 0, 200, 100);
popMatrix();
