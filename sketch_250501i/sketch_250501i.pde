
void setup() {
  
  int price = 980;
  float tax = tax(price);
  float amount = price + tax;
 
  println("合計金額は " + amount + " 円です");
  
}

float tax(float x) {
  // 金額xに対する消費税（10%）を計算して返す
  return x * 0.1;
}
