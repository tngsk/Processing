size(800, 800);
background(255);

//dra
strokeWeight(6);
fill(60, 170, 235);
arc(400, 400, 450, 440, radians(-250), radians(70));
fill(255);
arc(400, 425, 400, 390, radians(-250), radians(70));

//eye
ellipse(353, 245, 90, 100);
ellipse(447, 245, 90, 100);

//eye
fill(0);
ellipse(380, 245, 20, 25);
ellipse(420, 245, 20, 25);
fill(255);
ellipse(382, 245, 10, 10);
ellipse(418, 245, 10, 10);

//mouth
fill(255);
arc(400, 350, 320, 320, radians(30), radians(150));

//nose
fill(255, 30, 40);
ellipse(400, 300, 45, 45);
line(400, 325, 400, 510);

//hige
line(340, 340, 270, 320);
line(342, 370, 260, 370);
line(340, 400, 270, 420);
line(460, 340, 530, 320);
line(458, 370, 540, 370);
line(460, 400, 530, 420);

//neckless
fill(255, 30, 40);
rect(250, 578, 295, 30);
fill(255, 220, 10);
ellipse(400, 610, 70, 70);
rect(364, 595, 72, 10);
fill(0);
ellipse(400, 617, 12, 12);
line(400, 617, 400, 639);

save("dra.png");
