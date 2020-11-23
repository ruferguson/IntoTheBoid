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
    size(displayWidth, displayHeight / 2);
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
  
  mController = new MidiController();
  mListener = new MidiInterface(this, metro, flock, 0, 1);
  
  metro.setBPM(15);
}

void draw() {
  background(0);
  flock.run();
  metro.update();
  checkMidiController();
}

void passOscMessage(OscMessage message) {
  osc.send(message, supercollider);
}

void checkMidiController() {
    if (isB1) { // clear all boids
        metro.parseMidi(flock, 60, 100);
        isB1 = false;
    } else if (isB2) { // remove last boid
        metro.parseMidi(flock, 61, 100);
        isB2 = false;
    } else if (isB3) { // remove a random boid
        metro.parseMidi(flock, 62, 100);
        isB3 = false;
    } else if (isB4) { // chirp lower octave
        metro.parseMidi(flock, 63, 100);
        isB4 = false;
    } else if (isB5) { // C2
        metro.parseMidi(flock, 64, 100);
        isB5 = false;
    } else if (isB6) { // Eb2
        metro.parseMidi(flock, 65, 100);
        isB6 = false;
    } else if (isB7) { // chirp higher octave
        metro.parseMidi(flock, 66, 100);
        isB7 = false;
    } else if (isB8) { // G1
        metro.parseMidi(flock, 67, 100);  
        isB8 = false;
    } else if (isB9) { // Bb1
        metro.parseMidi(flock, 68, 100);
        isB9 = false;
    }
}
