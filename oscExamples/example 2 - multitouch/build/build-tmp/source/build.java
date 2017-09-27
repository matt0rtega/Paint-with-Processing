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

float x, y = 0;
float diameter = 10;

PVector position, position2, position3, position4, position5;

public void setup() {
  
  background(0);

  // start oscP5, listening for incoming messages at port 8000
  oscP5 = new OscP5(this,8000);

  position = new PVector(0, 0);
  position2 = new PVector(0, 0);
  position3 = new PVector(0, 0);
  position4 = new PVector(0, 0);
  position5 = new PVector(0, 0);
}

public void draw() {

  fill(0, 1);
  rect(0, 0, width, height);

  noStroke();
  fill(255);
  ellipse(position.x, position.y, 30, 30);
  ellipse(position2.x, position2.y, 30, 30);
  ellipse(position3.x, position3.y, 30, 30);
  ellipse(position4.x, position4.y, 30, 30);
  ellipse(position5.x, position5.y, 30, 30);
}

/* incoming osc message are forwarded to the oscEvent method. */
public void oscEvent(OscMessage theOscMessage) {

  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  // // Integer, float, etc.
  println(" typetag: "+theOscMessage.typetag());

  //Parse out the value using .get() method
  // float valx = theOscMessage.get(0).floatValue();
  // float valy = theOscMessage.get(1).floatValue();


  switch(theOscMessage.addrPattern()){
    case "/page3/multixy/1": 
      PVector location1 = new PVector(theOscMessage.get(0).floatValue(), theOscMessage.get(1).floatValue());
      position.y = map(location1.x, 0, 1, 0, width);
      position.x = map(location1.y, 0, 1, height, 0);
      println("position: "+position);
      break;
    case "/page3/multixy/2":
      PVector location2 = new PVector(theOscMessage.get(0).floatValue(), theOscMessage.get(1).floatValue());
      position2.y = map(location2.x, 0, 1, 0, width);
      position2.x = map(location2.y, 0, 1, height, 0);
      println("position: "+position2);
      break;
    case "/page3/multixy/3":
      PVector location3 = new PVector(theOscMessage.get(0).floatValue(), theOscMessage.get(1).floatValue());
      position3.y = map(location3.x, 0, 1, 0, width);
      position3.x = map(location3.y, 0, 1, height, 0);
      println("position: "+position3);
      break;
    case "/page3/multixy/4":
      PVector location4 = new PVector(theOscMessage.get(0).floatValue(), theOscMessage.get(1).floatValue());
      position4.y = map(location4.x, 0, 1, 0, width);
      position4.x = map(location4.y, 0, 1, height, 0);
      println("position: "+position4);
      break;
    case "/page3/multixy/5":
      PVector location5 = new PVector(theOscMessage.get(0).floatValue(), theOscMessage.get(1).floatValue());
      position5.y = map(location5.x, 0, 1, 0, width);
      position5.x = map(location5.y, 0, 1, height, 0);
      println("position: "+position5);
      break;
    default:
      println("No type tags!");
      break;
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
