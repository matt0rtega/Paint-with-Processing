import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import oscP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class build extends PApplet {

//The Most Basic OSC Setup



OscP5 oscP5;

public void setup() {
  

  // start oscP5, listening for incoming messages at port 8000
  oscP5 = new OscP5(this,8000);
}

public void draw() {
  background(0);

}



/* incoming osc message are forwarded to the oscEvent method. */
public void oscEvent(OscMessage theOscMessage) {

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
  public void settings() {  size(400,400, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
