size(600,600);

pushMatrix();
translate(0,0);
rect(0,0,100,100);
ellipse(50,50, 80,80);
popMatrix();

pushMatrix();
translate(100,0);
scale(0.5);

rect(0,0,100,100);
ellipse(50,55, 80,80);
popMatrix();

pushMatrix();
translate(200,0);
rotate(45 * PI /180);

rect(0,0,100,100);
ellipse(50,45, 80,80);
popMatrix();
