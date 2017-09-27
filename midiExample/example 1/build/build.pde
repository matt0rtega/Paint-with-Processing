// Midi Setup

import themidibus.*;

import oscP5.*;

OscP5 oscP5;

MidiBus myBus;

float x, y = 0;
float diameter = 30;
int numCircles = 40;
float red = 255;

void setup() {
  size(400,400);

  //Midibus(this, INPUT, OUTPUT)
  // You need to run TouchOSC Bridge in order to get a connection
  myBus = new MidiBus(this, "TouchOSC Bridge", -1);

  // start oscP5, listening for incoming messages at port 12000
  oscP5 = new OscP5(this,8000);
}


void draw() {
  //background(0);

  fill(red, 0, 0);

  for (int i=0; i<numCircles; i++){
    ellipse(x * i, y * i, diameter, diameter);
  }
  
  x += 0.1;
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);


  // Midi setup is the same
  //if (number == 0) {
  //  println("Fader 1");
  //} else if (number == 1){
  //  println("Fader 2");
  //}
  
  switch(number){
    case 0:
        x = value;
        break;
    case 1:
        y = value;
        break;
    case 2: 
        diameter = value;
        break;
    case 3:
        numCircles = value;
        break;
    case 4:
        red = map(value, 0.0, 127.0, 0.0, 255.0);
        break;
  }
}