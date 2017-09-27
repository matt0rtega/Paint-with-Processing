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
OscMessage theMessage;

float val1, val2, val3;

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
