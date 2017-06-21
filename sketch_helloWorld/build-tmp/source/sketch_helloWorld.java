import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import oscP5.*; 
import netP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_helloWorld extends PApplet {

//OSC Setup

/**
 * oscP5properities by andreas schlegel
 * example shows how to use osc properties.
 * if you need more specific settings for your osc session,
 * osc properties serves your needs.
 * oscP5 website at http://www.sojamo.de/oscP5
 */



OscP5 oscP5;
NetAddress myRemoteLocation;

public void setup() {
  

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
public void mousePressed() {
  /* create a new osc message with address pattern /test */
  OscMessage myMessage = new OscMessage("/test");
  myMessage.add(123);

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}


public void draw() {
  background(0);
}



/* incoming osc message are forwarded to the oscEvent method. */
public void oscEvent(OscMessage theOscMessage) {

  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());

  //Parse out the value using .get() method
  float val = theOscMessage.get(0).floatValue();

  println(" value: "+val);
  
}
  public void settings() {  size(400,400, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_helloWorld" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
