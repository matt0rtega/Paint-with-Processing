//The Most Basic OSC Setup

import oscP5.*;

OscP5 oscP5;

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

  //Parse out the value using .get() method
  float val = theOscMessage.get(0).floatValue();

  if(frameCount % 2 == 0){
    println("fader1: "+val);
  }
  
}