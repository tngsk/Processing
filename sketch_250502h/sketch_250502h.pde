int score = 70;
boolean deathFlag = false;

if (score > 79) {
  println("Good!");
  deathFlag = false;
} else {
  println("Bad");
  deathFlag = true;
}

if (deathFlag == true){
  println("Death!");
}
