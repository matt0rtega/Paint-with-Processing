//OSC Setup
import netP5.*;

NetAddress myRemoteLocation;

void setup() {
  size(400,400, P3D);

  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device,
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("momacbookpro.local",8001);

}


// Sending messages, if need. But the main thing we want to do is receive messages.
void mousePressed() {
  /* create a new osc message with address pattern /test */
  OscMessage myMessage = new OscMessage("/test");

  myMessage.add(123);

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}


void draw() {
  background(0);

  /* create a new osc message with address pattern /test */
  OscMessage xyMessage = new OscMessage("/xy");
  OscMessage toggleMessage = new OscMessage("/toggle");
  // Message 1
  myMessage.add(map(mouseX, 0, width, 1, 8)*12);
  // Message 2
  myMessage.add(map(sin(frameCount*0.01), -1, 1, 0, 127.0));

  toggleMessage.add((int)random(2));

  /* send the message */
  oscP5.send(toggleMessage, myRemoteLocation);
  oscP5.send(xyMessage, myRemoteLocation);
}
