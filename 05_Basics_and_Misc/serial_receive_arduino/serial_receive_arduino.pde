import processing.serial.*;

Serial arduino;
String serialPort = "/dev/cu.usbmodem101"; // <-- change this
int baudRate = 9600;

final char SWITCH_PRESSED = 0;  // LOW
final char SWITCH_RELEASED = 1; // HIGH

void setup() {
  size(800, 600);

  try {
    arduino = new Serial(this, serialPort, baudRate);
    println("[o] Serial connected to: " + serialPort);
  } catch (Exception e) {
    println("[x] Failed to connect to serial port: " + serialPort);
  }
}

void draw() {
  if (arduino != null && arduino.available() > 0) {
    char switchStatus = (char)arduino.read();

    if (switchStatus == SWITCH_PRESSED) {
      println("Switch pressed");
    } else if (switchStatus == SWITCH_RELEASED) {
      println("Switch released");
    } else {
      println("Unknown message: " + (int)switchStatus);
    }
  }
}
