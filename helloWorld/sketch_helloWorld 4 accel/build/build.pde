import oscP5.*;

OscP5 osc;

float x, y, z = 0;

void setup() {
  size(500, 500, P3D);
  
  osc = new OscP5(this, 8000);
  
  // Make sure you go to Settings in TouchOSC and active the Accelerometer
  osc.plug(this, "accxyz", "/accxyz");

}
void draw() {

  translate(x, y, z);
  ellipse(0, 0, 30, 30);

}


void accxyz(float x_, float y_, float z_) {
  x = (int)map(x_, -1, 1, 0, width);
  y = (int)map(y_, -1, 1, 0, height);
  z = (int)map(z_, -1, 1, -width, width);
  
  
  // Only prints every 25 frames instead of every frame
  println("x: "+x+ " y: "+y+" z: "+z);
  
}