import processing.serial.*;

Serial arduino;
String serialPort;
int baudRate;

final char SWITCH_PRESSED = 0;  // LOW
final char SWITCH_RELEASED = 1; // HIGH

void setup() {
  size(800, 600);

  // Configuration via environment variables with defaults
  serialPort = System.getenv("SERIAL_PORT");
  if (serialPort == null) {
    serialPort = "/dev/cu.usbmodem101"; // Default port
  }

  String envBaud = System.getenv("SERIAL_BAUD_RATE");
  if (envBaud != null) {
    try {
      baudRate = Integer.parseInt(envBaud);
    } catch (NumberFormatException e) {
      baudRate = 9600;
    }
  } else {
    baudRate = 9600;
  }

  println("Available serial ports:");
  printArray(Serial.list());

  try {
    arduino = new Serial(this, serialPort, baudRate);
    println("[o] Serial connected to: " + serialPort + " at " + baudRate + " baud");
  } catch (Exception e) {
    println("[x] Failed to connect to serial port: " + serialPort);
    println("    Check if the port is correct and not in use.");
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
