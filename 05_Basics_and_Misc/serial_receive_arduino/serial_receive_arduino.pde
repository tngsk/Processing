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
  // Validate port: alphanumeric, dots, underscores, forward slashes, and hyphens
  if (serialPort == null || !serialPort.matches("^[a-zA-Z0-9._/-]+$")) {
    if (serialPort != null) {
      println("[!] Invalid SERIAL_PORT format: " + serialPort + ". Using default.");
    }
    serialPort = "/dev/cu.usbmodem101"; // Default port
  }

  String envBaud = System.getenv("SERIAL_BAUD_RATE");
  if (envBaud != null) {
    try {
      int parsedBaud = Integer.parseInt(envBaud);
      // Validate baud rate: reasonable range for serial communication
      if (parsedBaud >= 300 && parsedBaud <= 1000000) {
        baudRate = parsedBaud;
      } else {
        println("[!] SERIAL_BAUD_RATE out of range (300-1000000): " + parsedBaud + ". Using default.");
        baudRate = 9600;
      }
    } catch (NumberFormatException e) {
      println("[!] Invalid SERIAL_BAUD_RATE format: " + envBaud + ". Using default.");
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
