#define SWITCH 8
#define SWITCH_PRESSED LOW
#define SWITCH_RELEASED HIGH
#define BAUDRATE 9600

void setup() {
  Serial.begin(BAUDRATE);
  pinMode(SWITCH, INPUT_PULLUP);
}

void loop() {
  static char previousSwitchStatus = SWITCH_RELEASED;
  char switchStatus = digitalRead(SWITCH);
  if (switchStatus != previousSwitchStatus) { // status changed
    Serial.write(switchStatus);
    previousSwitchStatus = switchStatus;
    delay(100); // avoid chattering
  }
}
