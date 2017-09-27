//The Most Basic OSC Setup

import oscP5.*;

OscP5 oscP5;

float x;

void setup() {
  size(400,400, P3D);

  // start oscP5, listening for incoming messages at port 12000
  oscP5 = new OscP5(this,8000);

  // Image yourself as a telephone operate patching one output to another output
  oscP5.plug(this, "fader1", "/page1/fader1");
}

void draw() {
  background(0);

}

void fader1(float value) {
  println("### plug event method. received a message /fader1.");
  println(" 1 ints received: "+value);  

  x = value;

  println(x);
}