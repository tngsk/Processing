// face 3 color
size(800, 800);
background(255);

strokeWeight(80);
stroke(0,255,0);
point(400 - 160, 320);

stroke(0,0,255);
point(400 + 160, 320);

strokeWeight(60);
stroke(255,0,0);
arc(400, 400 + 50, 300, 300, radians(0+30), radians(180-30));
