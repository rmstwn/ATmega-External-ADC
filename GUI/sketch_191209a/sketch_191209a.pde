import processing.serial.*;

Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph

float fValue;
boolean newVal = false;

void setup () {
   size(800, 630);
   println(Serial.list());
   myPort = new Serial(this, Serial.list()[0], 9600);
   myPort.bufferUntil('\n');
   background(2);
   stroke(127, 34, 255);
}

void draw () {
    if (newVal) {
       line(xPos, height, xPos, height - fValue);

       // clear the screen
       if (++xPos >= width) {
         xPos = 0;
         background(2);
       }
       newVal = false;
    }
}

void serialEvent (Serial myPort) {
   String inString = myPort.readStringUntil('\n');
   if (inString != null) {
       inString = trim(inString);
       fValue = float(inString);
       fValue = map(fValue, 0, 1023, 0, height);
       println(fValue);
       newVal = true;
     }
}
