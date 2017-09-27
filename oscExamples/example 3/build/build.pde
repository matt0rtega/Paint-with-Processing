//OSC Setup

import oscP5.*;

OscP5 oscP5;

//Declare your variables in the global scope so you can access them between functions
float diameter = 30;
float val;
float rotation = 0;

float fade = 255.0;
float speed = 0.02;
int segments = 1;

color randomColor = color(255);

PVector location;

void setup() {
  size(400,400, P3D);
  background(0);

  // start oscP5, listening for incoming messages at port 12000
  oscP5 = new OscP5(this,8000);

  location = new PVector(width/2, height/2);
}

void draw() {
  //background(0);
  fill(0, fade);
  rect(0, 0, width, height);

  //int segments = (int)map(mouseX, 0, width, 1, 40);
  int inc = 360/segments;
  println(inc);

  //speed = map(mouseX, 0, width, 0.0, 0.2);

  for (int j=1; j<10; j++){
    for (int i=0; i<segments; i++){

      pushMatrix();
      translate(location.x, location.y);
      rotate(radians(i*inc));

      float x0 = map(sin(frameCount*speed*j), -1, 1, -200/j, 200/j);
      float y0 = map(cos(frameCount*speed*i), -1, 1, -200/j, 200/j);

      noStroke();
      fill(randomColor);
      ellipseMode(CENTER);
      ellipse(x0, y0, 5, 5);
      popMatrix();
    }
  }

}



/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {

  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());

  //Parse out the value using .get() method

  if (theOscMessage.checkAddrPattern("/page1/xy1")==true){
    float valX = theOscMessage.get(0).floatValue();
    float valY = theOscMessage.get(1).floatValue();

    // Using one value to control multiple inputs
    location.y = map(valX, 0, 127, height, 0);
    location.x = map(valY, 0, 127, 0, width);

    println(valX);
    println(valY);
  } else if (theOscMessage.checkAddrPattern("/page1/fader1")==true) {
    float val = theOscMessage.get(0).floatValue();
    println(val);

    segments = (int)map(val, 0.0, 127.0, 1, 40);
  } else if (theOscMessage.checkAddrPattern("/page1/fader2")==true) {
    float val = theOscMessage.get(0).floatValue();
    
    fade = map(val, 0.0, 127.0, 0, 255);
    
    println(fade);
  } else if (theOscMessage.checkAddrPattern("/page1/rotary1")==true) {
    float val = theOscMessage.get(0).floatValue();
    rotation = map(val, 0.0, 127.0, 0.0, PI*2);

    speed = map(val, 0.0, 127.0, 0.02, 0.05);
    println(val);
  } else if (theOscMessage.checkAddrPattern("/page1/push1")==true){

    randomColor = color(random(255), random(255), random(255));
  }

  
}