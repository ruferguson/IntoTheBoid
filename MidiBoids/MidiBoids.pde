// you must download the oscP5 library using Sketch > Import Library... > Add Library...
import oscP5.*;
import netP5.*;
import themidibus.*;

int type; // 0 is bass, 1 is chirp
int degree; // For bass, represents a midi note (~30-40 or so).
            // For everything else, represents a scale degree (0-15 I’d say)
float volume; // 0-1 volume, 0 is silent and 1 is loud
float orientation; // -1 to 1 (we need to find a nice way to map
                   // orientation to this scale so I can plug it into pan)
PImage bird;

boolean isB1, isB2, isB3, isB4, isB5, isB6, isB7, isB8, isB9;
boolean atEdge;

MidiController mController;
Flock flock;
OscP5 osc;
NetAddress supercollider; // where we want to send the messages
OscMessage msg;

MidiInterface mListener;

Metronome metro = new Metronome(this);

void settings() {
    size(displayWidth, displayHeight/2);
}

void setup() {
  surface.setLocation(0, 0);
  frameRate(120);
  
  imageMode(CENTER);
  bird = loadImage("bird.png");
  
  osc = new OscP5(this, 12000); // any large number to fill the parameter because we are not receiving data from SuperCollider
  // Run 'NetAddr.localAddr' in SuperCollider to determine the input for NetAddress(string, int)
  supercollider = new NetAddress("127.0.0.1", 57120); 
    
  flock = new Flock();
  // Add an initial set of boids into the system
  /*for (int i = 0; i < 4; i++) {
    flock.createBassBoid(metro, 36, 0, random(1));
  }
  for (int i = 0; i < 2; i++) {
    flock.createBassBoid(metro, 39, 0, random(1));
  }
  for (int i = 0; i < 8; i++) {
    flock.createChirpBoid(metro, 0, 0, random(1));
  }
  for (int i = 0; i < 4; i++) {
    flock.createChirpBoid(metro, 0, 150, random(1));
  }*/
  
  mController = new MidiController();
  mListener = new MidiInterface(this, metro, flock, 0, 1);
  
  metro.setBPM(30);
  
}

void draw() {
  background(0);
  flock.run();
  metro.update();
  checkMidiController();
}

// Add a new boid into the System
void mousePressed() {
  //flock.addBoid(new Boid(metro, mouseX,mouseY, 1.0));
  println("mousePressed in primary window");
}

int test = 0;

void passOscMessage(OscMessage message) {
  osc.send(message, supercollider);
  println("Sent Message: " + (test++));
}

void checkMidiController() {
  if (isB1) { //Create a C2
      flock.createBassBoid(metro, 36, 0, random(1));
      //flock.setBoidValues(1, (int) random(0, 15), random(0, 0.5));
  } else if (isB2) { // Create an Eb2
      flock.createBassBoid(metro, 39, 0, random(1));
      //flock.setBoidValues(0, (int) random(30, 40), random(0, 0.5));
  } else if (isB3) {
    
  } else if (isB4) {
    
  } else if (isB5) {
    
  } else if (isB6) {
    
  } else if (isB7) { // Create a chirp
    flock.createChirpBoid(metro, 0, 0, random(1));
  } else if (isB8) { // destroy one random boid 
    flock.removeRandBoid();
  } else if (isB9) { // clear all boids
    flock.clearBoids();
  }
}
