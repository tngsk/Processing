#define MOUSE_PRESSED '+'
#define MOUSE_RELEASED '-'
#define BAUDRATE 9600

void setup()
{
  Serial.begin(BAUDRATE);
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop()
{
  static char mouseStatus = MOUSE_RELEASED;
  if (Serial.available()) {
    mouseStatus = Serial.read();
  }
  if (mouseStatus == MOUSE_PRESSED) {
    digitalWrite(LED_BUILTIN, HIGH);
  } else if (mouseStatus == MOUSE_RELEASED) {
    digitalWrite(LED_BUILTIN, LOW);
  }
}
