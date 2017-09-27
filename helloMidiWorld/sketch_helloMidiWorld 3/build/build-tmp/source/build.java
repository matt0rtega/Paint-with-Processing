import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import themidibus.*; 
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

// Midi Setup




MidiBus myBus;
OscP5 oscP5;

float x, y;
float rotary;
float fade1, fade2;
float push, toggle;

public void setup() {
  
  background(0);

  //Midibus(this, INPUT, OUTPUT)
  // You need to run TouchOSC Bridge in order to get a connection
  myBus = new MidiBus(this, "TouchOSC Bridge", -1);

  // start oscP5, listening for incoming messages at port 8000
  //oscP5 = new OscP5(this,8000);

  x=0;
  y=0;

  push =0;
  toggle = 0;

  rotary = 30;
  fade1 = 25;
  fade2 = 255;
}

public void draw() {
  fill(0, fade1);
  rect(0, 0, width, height);

  // Since MIDI is currently sending numbers from 0 to 127
  // we need to use the map function.
  x = (int)map(x, 0, 127, 0, width);
  y = (int)map(y, 0, 127, height, 0);

  noStroke();

  // Switching colors
  if (toggle == 0){
    fill(255, fade2); 
  } else {
    fill(255, 0, 255, fade2);
  }
  
  ellipse(x, y, rotary, rotary);

}

public void controllerChange(int channel, int number, int value) {
  // // Receive a controllerChange
  // println();
  // println("Controller Change:");
  // println("--------");
  // println("Channel:"+channel);
  // println("Number:"+number);
  // println("Value:"+value);

  // Method 1: Using a switch to isolate and assign the values through the addrPattern
  switch(number){
    case 0: 
      fade1 = value;
      println("fade1: "+fade1);
      break;
    case 1:
      fade2 = value;
      println("fade2: "+fade2);
      break;
    case 2:
      push = value;
      println("push: "+push);
      break;
    case 3:
      toggle = value;
      println("toggle: "+toggle);
      break;
    case 4:
      rotary = value;
      println("rotary: "+rotary);
      break;
    case 5:
      y = value;
      println("x: "+y);
      break;
    case 6:
      x = value;
      println("y: "+x);
      break;
    default:
      println("No midi number for that assignment!");
      break;
  }

}
  public void settings() {  size(400,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "build" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
