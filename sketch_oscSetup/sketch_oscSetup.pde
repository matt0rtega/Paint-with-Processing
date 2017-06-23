//OSC Setup

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

//Declare your variables in the global scope so you can access them between functions
float diameter = 30;
float val;
float rotation = 0;

float r, g, b = 0;
float x, y;
float rand = 4;

void setup() {
  size(400,400, P3D);

  // start oscP5, listening for incoming messages at port 12000
  oscP5 = new OscP5(this,12000);

  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device,
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1",12000);

}


// Sending messages, if need. But the main thing we want to do is receive messages.
void mousePressed() {
  /* create a new osc message with address pattern /test */
  OscMessage myMessage = new OscMessage("/test");
  myMessage.add(123);

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}


void draw() {
  //background(0);
  if(mousePressed){
    x = mouseX;
    y = mouseY;  
  }
  
  noStroke();
  fill(r, g, b);
  translate(x, y);

  rotateX(rotation);
  ellipse(0, 0, diameter, diameter);

  x += random(-rand, rand);
  y += random(-4, 4);
}



/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {

  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());

  //Parse out the value using .get() method

  if (theOscMessage.checkAddrPattern("/xy1")==true){
    float valX = theOscMessage.get(0).floatValue();
    float valY = theOscMessage.get(1).floatValue();

    r = valX;
    diameter = valY;
    g = valY;

    println(x);
    println(y);
  } else if (theOscMessage.checkAddrPattern("/fader1")==true) {
    float val = theOscMessage.get(0).floatValue();
    b = val;
    println(val);
  } else if (theOscMessage.checkAddrPattern("/fader2")==true) {
    float val = theOscMessage.get(0).floatValue();
    
    rand = map(val, 0.0, 127.0, 4, 10);
    
    println(rand);
  } else if (theOscMessage.checkAddrPattern("/rotary1")==true) {
    float val = theOscMessage.get(0).floatValue();
    rotation = map(val, 0.0, 127.0, 0.0, PI);
    println(val);
  }

  
}