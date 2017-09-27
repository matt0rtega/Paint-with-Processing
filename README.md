# Paint with Processing & TouchOSC

# Info

---

 _Note to self: Show screen with QuickTime, New Movie Recording, and a Connected iOS Device._ 

In this workshop we will be learning how to connect your Processing sketches to TouchOSC iPad app, create custom TouchOSC interfaces, so that you can control multiple parameters in your Processing sketches. Familiarity with Processing will definitely help, but isn’t necessary.

We will spend 2 hours reviewing setup, and the 3rd hour will be dedicated to working on your sketches and answering questions.

# Stay connected

---

To get notified about future workshops and events feel free to sign up for my mailing list here: 

 [Subscribe to mailing list](http://matthewortega.us3.list-manage.com/subscribe/post?u=091c42b01b08c554d401b7930&id=49ed1dca8d) 

 [Follow on Twitter](https://twitter.com/matt0rtega) 

 [Follow on Facebook](https://www.facebook.com/matthewortegastudio/) 

 [Follow on Instragram](https://www.instagram.com/timesareweird/) 

# **Before the workshop**

---

- [Download TouchOSC](https://itunes.apple.com/app/touchosc/id288120394)
- [Download TouchOSC Editor](https://hexler.net/software/touchosc#downloads)
- [Download TouchOSC Bridge](https://hexler.net/software/touchosc#downloads)
- [Download Processing](https://processing.org/download/)
- [Download OSCulator](https://osculator.net) (Mac only)
- Install oscP5 Processing Library
- Get inspired or have a Processing sketch you would like to connect

# Schedule

---

- 0:00pm: Introductions, look at a selection of examples and applications
- 0:15pm: Show some of my work and the Quill project (maybe opportunity to improve)
- 0:15pm: What is OSC and what are its benefits
- 0:45pm: Reviewing TouchOSC
  - Touch OSC Editor
  - Creating an OSC Interface
  - Working with Labels, Faders, Rotary, Push Buttons, Toggles, and XY
- 1:15: Getting OSC connected: Hello Word!
  - Getting the first message
  - Method 1, Method 2, Method 3 - Examples 1, 2, 3
  - Working with the accelerometer - Example 4
  - Adding easing to the accelerometer - Example 5
  - Sending message - Example 6 (LED)
- 1:45: Getting MIDI connected: Hello Midi World!
  - Touch OSC Bridge
  - Getting Midi Connectivity - Example 1
  - Troubleshooting - Disconnecting with Midi
  - Method 1, Method 2 - Example 2
  - Method 2
  - Connecting to elements - Example 3
- 2:15: Applying what we have learned and extras
  - Principals for painting
  - Multitouch
  - Osculator
- 2:30: Assignment: create your own interface
  - 

# Introductions

---

- Who am I?
- Who are you?
- What does it mean to paint with code?

# Inspiration

---

Here we can see a quick video that will allow us to get an idea of the type of interaction we can add by connecting controllers beyond the mouse. Once we go beyond the mouse, interacting with the computer becomes almost like a musical experience.

- [Example link 1](https://vimeo.com/59984923)
- [Example link 2](https://vimeo.com/2388650)
- [Example link 3](https://vimeo.com/37936808)
- Ryoji Ikeda

# What is OSC?

---

Open Sound Control is a protocol similar to MIDI that allows us to connect disparate programs. Works with what the call UDP(User Datagram Protocol) packets.

The OSC Message

- an _address u_ sed as an identifier for the message.
- a list of _arguments e_ ach argument can be of different kind: numbers, strings, etc.

 **Examples** :

![](https://static.notion-static.com/5077ef63397a4da0a5ecdc5023984c03/Untitled)

Because many OSC messages have only one argument, novice users often make the confusion between the message itself and its arguments.

# **What is TouchOSC?**

---

TouchOSC is an app designed for iOS that gives us the ability to communicate between platforms using Open Sound Control(OSC) protocol and Midi. It also gives us the ability to connect to our computer remotely so that it is not the main center of focus.

![](https://static.notion-static.com/9756c0f07bf146928d70e89ef8d74a33/img1.png)

## **TouchOSC Editor**

In the TouchOSC Editor, we can create a customized interface with multiple pages and input types that gives us multiple ways to control behaviors in our sketches.

## **Demo:**

- Create a Touch OSC Interface
- Working with Labels, Faders, Rotary, Push Buttons, Toggles, and XY

 _!! Important: IP Does need to be set if it doesn't connect automatically. You can do this manually or through Osculator._ 

# **Getting started**

---

TouchOSC communicates via Midi and OSC. OSC requires a Wifi connection and Port setup in order to receive a signal. We are going to review the two ways to get TouchOSC connected to your sketches.

- Import Libraries oscP5 and The MidiBus.

  ![](https://static.notion-static.com/11e0e585a03342f59705f63829704c4d/img2.png)

# **Getting OSC Connected**

---

In order to get connected to your computer from TouchOSC we will need to know your IP Address. In terminal, run the command below. But if you run the sketch helloWorld.pde, it should also output the IP Address.

    // In terminal type this command
    ipconfig getifaddr en0

Keep that number on hand. You will need it for setting up the TouchOSC app.

Our main setup and functions for OSC:

```java
import oscP5.*;
OscP5 oscP5;` 

void setup(){
  size(400, 400);

  oscP5 = new OscP5(this,8000);
}

}
```


Our main function for getting OSC events:

```java 
/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {

 //print the address pattern and the typetag of the received OscMessage
 print("### received an osc message.");
 print(" addrpattern: "+theOscMessage.addrPattern());
 //Integer, float, etc.
 println(" typetag: "+theOscMessage.typetag());

 //Parse out the value using .get() method
 float val = theOscMessage.get(0).floatValue();

}
```

We can also isolate the value by using the addrPatter in a number of ways. _See examples in helloWorld/sketch_helloWorld 1-3_ 

This examples uses an if statement to check the Addr pattern.

```java
if (theOscMessage.checkAddrPattern("/fader1")==true){ 
  float val = theOscMessage.get(0).floatValue(); x = = val;
}
```

# **Getting MIDI Connected**

---

Midi is a bit easier of a setup in your Processing sketch. But you will also need to include the same OSC setup so that you can remotely connect without a cable. Don't forget to install TouchOSC Bridge and have it running when you execute your program.

```java
import oscP5.*;
import themidibus.*;
OscP5 oscP5;
MidiBus myBus;` 

 `void setup(){ 
  oscP5 = new OscP5(this,8000);
  //Midibus(this, INPUT, OUTPUT)  
  myBus = new MidiBus(this, "TouchOSC Bridge", -1);
}```

Our main function for getting midi input via Midibus:

```java
void controllerChange(int channel, int number, int value) { 
  // Receive a controllerChange println(); 
  println("Controller Change:"); 
  println("--------"); 
  println("Channel:"+channel); 
  println("Number:"+number); 
  println("Value:"+value);
}
```

Once you are receiving Midi events in your console, you can use if or switch statements to assign the number to a variable.

```java
if(number == 0){ 
  x = value;
} else if (number == 1){ 
  y = value;
}
```

# Tips, tricks & challenges

---

- Connected OSC to a program you use (Madmapper, Abelton, MaxMSP, Pure Data)
- Create your own custom interface and connect it with a Processing Sketch you created
- Reroute signals with OSCulator to control a MIDI Synth
- Control something in your TouchOSC Interface by sending it messages

# Resources

---

- [OSC Documentation](https://www.notion.so/Paint-with-Processing-TouchOSC-6dff7cb2cc4b4cd199fc4dcd71f715f8#06e314abe6e347fc966750b98b4083ad)
- [OSC based sequencer](http://oscseq.com)
- [LiveGrabber - Send OSC Messages from Abelton](http://showsync.info/tools/livegrabber/)
- [Routing OSC Messages in Max Tutorial](https://www.notion.so/Paint-with-Processing-TouchOSC-6dff7cb2cc4b4cd199fc4dcd71f715f8#96ff2d41921c49a281577880b5463012)

# Stay in touch

---

 [Subscribe to mailing list](http://matthewortega.us3.list-manage.com/subscribe/post?u=091c42b01b08c554d401b7930&id=49ed1dca8d) 

twitter: [@matt0rtega](https://www.notion.so/Paint-with-Processing-TouchOSC-6dff7cb2cc4b4cd199fc4dcd71f715f8#51b21b73cb464979b66169d3d1964c6d) 

facebook: [Follow on Facebook](https://www.facebook.com/matthewortegastudio/) 

instagram: [@timesareweird](https://www.instagram.com/timesareweird/) 

website: [matthewortega.studio](http://matthewortega.studio) 

studio: [formvoid.co](http://formvoid.co)
