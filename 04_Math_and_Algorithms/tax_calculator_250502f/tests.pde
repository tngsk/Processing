void runTests() {
  println("--- Running Tests ---");

  testTax(100.0, 150.0);
  testTax(0.0, 0.0);
  testTax(1.0, 1.5);
  testTax(1000000.0, 1500000.0);
  testTax(-10.0, -15.0);

  println("--- Tests Completed ---");
}

void testTax(float input, float expected) {
  float actual = tax(input);
  if (abs(expected - actual) < 0.0001) {
    println("[PASS] tax(" + input + ") = " + actual);
  } else {
    println("[FAIL] tax(" + input + ") expected " + expected + " but got " + actual);
  }
}
