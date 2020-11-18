
// you must download the oscP5 library using Sketch > Import Library... > Add Library...
import oscP5.*;
import netP5.*;

int type; // 0 is bass, 1 is chirp
int degree; // For bass, represents a midi note (~30-40 or so).
            // For everything else, represents a scale degree (0-15 I’d say)
float volume; // 0-1 volume, 0 is silent and 1 is loud
float orientation; // -1 to 1 (we need to find a nice way to map
                   // orientation to this scale so I can plug it into pan)

PWindow win;
Flock flock;
OscP5 osc;
NetAddress supercollider; // where we want to send the messages
OscMessage msg;

void settings() {
    size(640, 360);
}

void setup() {
  win = new PWindow();
  
  osc = new OscP5(this, 12000); // any large number to fill the parameter because we are not receiving data from SuperCollider
  // Run 'NetAddr.localAddr' in SuperCollider to determine the input for NetAddress(string, int)
  supercollider = new NetAddress("127.0.0.1", 57120); 
    
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 150; i++) {
    flock.addBoid(new Boid(width/2,height/2));
  }
}

void draw() {
  background(50);
  flock.run();
  
  type = 0;
  degree = 32;
  volume = 0.5;
  orientation = 0;
  /*
  // send the data to SuperCollider
    OscMessage msg = new OscMessage("/colorhit");
    msg.add(type);
    msg.add(degree);
    msg.add(volume);
    msg.add(orientation);
    osc.send(msg, supercollider);*/
    msg = new OscMessage("/listener"); // remember to change slash for SC to match
    msg.add(type);
    println(type);
    msg.add(degree);
    msg.add(volume);
    msg.add(orientation);

}

// Add a new boid into the System
void mousePressed() {
  flock.addBoid(new Boid(mouseX,mouseY));
  println("mousePressed in primary window");

  osc.send(msg, supercollider);
}
