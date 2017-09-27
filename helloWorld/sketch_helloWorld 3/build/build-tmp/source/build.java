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

float x;

public void setup() {
  

  // start oscP5, listening for incoming messages at port 12000
  oscP5 = new OscP5(this,8000);

  oscP5.plug(this, "fader1", "/page1/fader1");
}

public void draw() {
  background(0);

}

public void fader1(float value) {
  println("### plug event method. received a message /fader1.");
  println(" 1 ints received: "+value);  

  x = value;

  println(x);
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
