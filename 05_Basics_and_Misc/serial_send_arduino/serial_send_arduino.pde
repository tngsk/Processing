import processing.serial.*;

Serial arduino;
String serialPort = "/dev/cu.usbmodem101"; // change this
int baudRate = 9600;

final char MOUSE_PRESSED = '+';
final char MOUSE_RELEASED = '-';

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
  
}

void mousePressed() {
  if (arduino != null) {
    arduino.write(MOUSE_PRESSED);
    println("Sent: " + MOUSE_PRESSED);
  }
}

void mouseReleased() {
  if (arduino != null) {
    arduino.write(MOUSE_RELEASED);
    println("Sent: " + MOUSE_RELEASED);
  }
}
