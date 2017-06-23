import oscP5.*;

OscP5 osc;

float x, y, z = 0;

void setup() {
  size(500, 500);
  
  osc = new OscP5(this, 8000);
  
  osc.plug(this, "accxyz", "/accxyz");
}
void draw() {

  // This creates a fade effect
  fill(255, 255, 255, 25);
  rect(0, 0, width, height);
  
  translate(x, y, z);
  ellipse(x, y, 30, 30);
}


void accxyz(float x_, float y_, float z_) {
  x = map(x_, -1, 1, 0, width);
  y = map(y_, -1, 1, 0, height);
  z = map(z_, -1, 1, 0, width);
  
  
  // Only prints every 25 frames instead of every frame
  if (frameCount % 25 == 1){
    println("x is " + x);
    println(x);
  }
  
}