// Midi Setup

import themidibus.*;
import oscP5.*;

MidiBus myBus;
OscP5 oscP5;

float x, y;
float rotary;
float fade1, fade2;

void setup() {
  size(400,400);

  //Midibus(this, INPUT, OUTPUT)
  // You need to run TouchOSC Bridge in order to get a connection
  myBus = new MidiBus(this, "TouchOSC Bridge", -1);

  // start oscP5, listening for incoming messages at port 8000
  oscP5 = new OscP5(this,8000);
}

void draw() {
  background(0);

}

void controllerChange(int channel, int number, int value) {
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
      rotary = value;
      println("rotary: "+rotary);
      break;
    case 3:
      x = value;
      println("x: "+x);
      break;
    case 4:
      y = value;
      println("y: "+y);
      break;
    default:
      println("No midi number for that assignment!");
      break;
  }

  // Method 2: Using if statements, etc.
  if (value = 0){
    fade1 = value;
  }
}