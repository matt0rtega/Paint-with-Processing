//OSC Setup

import oscP5.*;

OscP5 oscP5;

//Declare your variables in the global scope so you can access them between functions
float diameter = 30;
float val;
float rotation = 0;

float r, g, b = 0;
float x, y;
float rand = 4;

PVector location = new PVector(width/2, height/2);

void setup() {
  size(400,400, P3D);

  // start oscP5, listening for incoming messages at port 12000
  oscP5 = new OscP5(this,8000);
}

void draw() {
  //background(0);
  if(mousePressed){
    x = mouseX;
    y = mouseY;  
  }
  
  noStroke();
  fill(r, g, b);
  translate(location.x, location.y);

  rotateX(rotation);
  ellipse(0, 0, diameter, diameter);

  location.x = location.x + random(-rand, rand);
  location.y = location.y + random(-4, 4);
}



/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {

  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());

  //Parse out the value using .get() method

  if (theOscMessage.checkAddrPattern("/page1/xy1")==true){
    float valX = theOscMessage.get(0).floatValue();
    float valY = theOscMessage.get(1).floatValue();

    r = valX;
    diameter = valY;
    g = valY;

    // Using one value to control multiple inputs
    location.y = map(valX, 0, 127, height, 0);
    location.x = map(valY, 0, 127, 0, width);

    println(valX);
    println(valY);
  } else if (theOscMessage.checkAddrPattern("/page1/fader1")==true) {
    float val = theOscMessage.get(0).floatValue();
    b = val;
    println(val);
  } else if (theOscMessage.checkAddrPattern("/page1/fader2")==true) {
    float val = theOscMessage.get(0).floatValue();
    
    rand = map(val, 0.0, 127.0, 4, 50);
    
    println(rand);
  } else if (theOscMessage.checkAddrPattern("/page1/rotary1")==true) {
    float val = theOscMessage.get(0).floatValue();
    rotation = map(val, 0.0, 127.0, 0.0, PI*2);
    println(val);
  }

  
}