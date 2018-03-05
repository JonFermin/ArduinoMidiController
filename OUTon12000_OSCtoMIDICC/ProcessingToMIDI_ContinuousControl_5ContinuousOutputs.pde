//Receives 5 continuous outputs from Wekinator: continuous control value messages for control numbers 0-4, on channel 1
//Sends these on as MIDI messages
//Please edit the "TODO" message in the code below to change your MIDI output device selection.

import themidibus.*;
import oscP5.*;
import netP5.*;
import controlP5.*;

int whichSending = 0;
int numLeft = 0;
int maxNum = 1;

ControlP5 cp5;

int channel = 1; //You may want to change this!

OscP5 oscP5;
NetAddress dest;

PFont f, f2;

float alpha = 255;


MidiBus myBus; 
float[] myVals = new float[5];

void setup() {
  oscP5 = new OscP5(this,12000); //listen for OSC messages on port 12000 (Wekinator default)
  dest = new NetAddress("127.0.0.1",6448); //send messages back to Wekinator on port 6448, localhost (this machine) (default)
  
  //Create the font
  f2 = createFont("Arial", 10);
  f = createFont("Courier", 16);
  textFont(f);
  textAlign(LEFT, TOP);
  
  size(300, 200);
  background(0);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  //TODO: Make sure that the 3rd parameter below matches your desired midi output.
  myBus = new MidiBus(this, -1, "Output to Audio Software"); // Create a new MidiBus with no input device and output device #1
  
   frameRate(10);
   
   cp5 = new ControlP5(this);
   for (int i = 0; i < 5; i++) {
      cp5.addButton("cc" + i )
     .setValue(0)
     .setPosition(10+30*i+68, 153)
     .setSize(20,20)
     ;
   }
   
}

void draw() {
  background(0);  
  drawText();
  drawCircle();
  
  if (numLeft > 0) {
   alpha = 255;
    sendValue(whichSending, (int)random(0, 127));
    numLeft--;
  }
}

void drawText() {
  fill(255);
  textFont(f2);
  text("Receiving 5 continuous OSC values:", 10, 10);
  text("Control values for control# 0-5, channel 1", 10, 22);
  text("Listening for /wek/outputs on 12000", 10, 34);
  text("Click buttons CC0 to CC4 to send single MIDI message", 10, 46);

  text("Sending control chg to default MIDI device:", 10, 140);
  text("Control: ", 10, 160);
  text("Value:", 10, 175);
  for (int i= 0; i < myVals.length; i++) {
     text("" + i + ":", 10+30*i+70, 160);
     text(myVals[i], 10+30*i+70, 175); 
  }

  textFont(f);
  text("Sending MIDI:", 10, 110);
}

//Send continuous control change message 
void sendValue(int number, int value) {
  myBus.sendControllerChange(0, number, value);
  println("Sent continuous controller change: " + number + ", " + value);
} 

//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
 if (theOscMessage.checkAddrPattern("/wek/outputs")==true) {
     if(theOscMessage.checkTypetag("fffff")) { //Now looking for 5 parameters
       println("Received OSC message");
        myVals[0] = (float)theOscMessage.get(0).floatValue(); //get this parameter
        myVals[1] = (float)theOscMessage.get(1).floatValue(); //get this parameter
        myVals[2] = (float)theOscMessage.get(2).floatValue(); //get this parameter
        myVals[3] = (float)theOscMessage.get(3).floatValue(); //get this parameter
        myVals[4] = (float)theOscMessage.get(4).floatValue(); //get this parameter

        for (int i= 0; i < myVals.length; i++)  {
           if (myVals[i] < 0) {
             myVals[i] = 0;
           } else if (myVals[i] > 1) {
             myVals[i] = 1;
           }
           sendValue(i, (int)(myVals[i]*127));
        }

        alpha = 255;
        
      } else {
        println("Error: unexpected params type tag received by Processing");
      }
    }
}

void cc0() {
  alpha = 255;
   sendValue(0, (int)random(0, 127));
   whichSending = 0;
   numLeft = maxNum;
}

void cc1() {
  alpha = 255;
  sendValue(1, (int)random(0, 127));
  whichSending = 1;
  numLeft = maxNum;
}
void cc2() {
  alpha = 255;
  sendValue(2, (int)random(0, 127));
  whichSending = 2;
  numLeft = maxNum;
}
void cc3() {
  alpha = 255;
  sendValue(3, (int)random(0, 127));
  whichSending = 3;
  numLeft = maxNum;
}

void cc4() {
  alpha = 255;
  sendValue(4, (int)random(0, 127));
   whichSending = 4;
   numLeft = maxNum;
}
/*
void keyPressed() {
  if (keyCode == 49) {
    cc0();
  } else if (keyCode == 50) {
    cc1();
  } else if (keyCode == 51) {
    cc2();
  } else if (keyCode == 52) {
    cc3();
  } else if (keyCode == 53) {
    cc4();
  }
} */

void drawCircle() {
    alpha = 0.9 * alpha;
     fill(0, 255, 0, alpha);
    ellipse(150, 120, 25, 25); 
}