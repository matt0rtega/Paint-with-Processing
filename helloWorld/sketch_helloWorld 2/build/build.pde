//The Most Basic OSC Setup

import oscP5.*;

OscP5 oscP5;
OscMessage theMessage;

float val1, val2, val3;

void setup() {
  size(400,400, P3D);

  // start oscP5, listening for incoming messages at port 8000
  oscP5 = new OscP5(this,8000);
}

void draw() {
  background(0);

}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {

  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  // // Integer, float, etc.
  println(" typetag: "+theOscMessage.typetag());

  // Method 1: Using a switch to isolate and assign the values through the addrPattern
  switch(theOscMessage.addrPattern()){
    case "/page1/fader1": 
      val1 = theOscMessage.get(0).floatValue();
      println(val1);
      break;
    case "/page1/fader2":
      val2 = theOscMessage.get(0).floatValue();
      println(val2);
      break;
    default:
      println("No type tags!");
      break;
  }

  // Method 2: Using if statements // checkAddrPattern returns a boolean
  if(theOscMessage.checkAddrPattern("/page1/fader1") == true){
    val1 = theOscMessage.get(0).floatValue();
    println("If statement fader1 value is " + val1);
  }
}