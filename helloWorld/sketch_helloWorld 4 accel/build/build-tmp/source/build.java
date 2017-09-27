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



OscP5 osc;

float x, y, z = 0;

public void setup() {
  
  
  osc = new OscP5(this, 8000);
  
  // Make sure you go to Settings in TouchOSC and active the Accelerometer
  osc.plug(this, "accxyz", "/accxyz");

}
public void draw() {

  translate(x, y, z);
  ellipse(0, 0, 30, 30);

}


public void accxyz(float x_, float y_, float z_) {
  x = (int)map(x_, -1, 1, 0, width);
  y = (int)map(y_, -1, 1, 0, height);
  z = (int)map(z_, -1, 1, 0, -5000);
  
  
  // Only prints every 25 frames instead of every frame
  println("x: "+x+ " y: "+y+" z: "+z);
  
}
  public void settings() {  size(500, 500, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
