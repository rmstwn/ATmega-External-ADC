/***********************************
 First upload the Arduino code to the Arduino and then run this code.
 Make sure that the Port number and baudrate are the same.
 ***********************************/
import meter.*;
import processing.serial.*;
import controlp5.*;

Serial port;
String[] list;
float temp;
Meter m, m2;

void setup() {
  size(500, 400);
  background(0);

  port = new Serial(this, "COM5", 9600);

  fill(120, 50, 0);
  m = new Meter(this, 25, 100);
  // Adjust font color of meter value  
  m.setTitleFontSize(20);
  m.setTitleFontName("Arial bold");
  m.setTitle("Temperature (C)");
  m.setDisplayDigitalMeterValue(true);

  // Meter Scale
  String[] scaleLabelsT = {"0", "10", "20", "30", "40", "50", "60", "70", "80","90","100"};
  m.setScaleLabels(scaleLabelsT);
  m.setScaleFontSize(18);
  m.setScaleFontName("Times New Roman bold");
  m.setScaleFontColor(color(200, 30, 70));

  m.setArcColor(color(141, 113, 178));
  m.setArcThickness(10);
  m.setMaxScaleValue(100);

  m.setNeedleThickness(3);

  m.setMinInputSignal(0);
  m.setMaxInputSignal(100);

  // A second meter for reference
  int mx = m.getMeterX();
  int my = m.getMeterY();
  int mw = m.getMeterWidth();
}

public void draw() {

  textSize(30);
  fill(0, 255, 0);
  text("Temperature", 150, 50);

  //if (port.available() > 0) {
  //  String val = port.readString();
  //  //list = split(val, ',');
  //  float temp = float(val);

    println("Temperature: " + temp + " C  ");

    m.updateMeter(int(temp));
  //}
}

void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);
    temp = float(inString);
  }
}
