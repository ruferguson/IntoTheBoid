class Metronome {
  
  MidiBoids m;
  
  OscMessage msg;
  
  float deltaTime = 0; //The time elapsed since the last drawing frame. (ms)
  float worldTime = 0; //The global clock time as of the most recently drawn frame. (ms)
  float beatTime = 0; //The time elapsed since the last beat.
  
  float tempo = 500; // The amount of time that should elapse between each beat. (ms)
  
  ArrayList<Boid> boids = new ArrayList<Boid>(); //A list of boids that still need to send an OscMessage
  
  public Metronome(MidiBoids pass) {
   m = pass; 
  }
  
  public void setBPM (float bpm) {
    
    if (bpm > 0) { //Reject invalid bpm
      tempo = 60000 / bpm; //Convert bpm to elapsed time in ms.
    }
  }
  
  void update() {
    
    deltaTime = millis() - worldTime; //Find the difference in ms between the global time this frame and last frame.
    worldTime = millis(); //Update the global time.
    beatTime += deltaTime; //Update the beat time.
    
    for(int i = 0; i < boids.size(); i++) {
      if (boids.get(i).timing >= beatTime || (deltaTime >= beatTime && boids.get(i).timing <= deltaTime)) {
        sendMessage(boids.get(i)); //Run through each queued boid and see if it is time to run its message.
      }
    }
    
    if (beatTime > tempo)
      beatTime = 0; //Reset the beatTime every beat.
    
  }
  
  void sendMessage(Boid boid) {
    
    msg = new OscMessage("/listener");
    msg.add(boid.type);
    msg.add(boid.degree);
    msg.add(boid.volume);
    msg.add(boid.orientation);
    
    msg.printData();
    
    //String s = "Size before: " + boids.size();
    
    boids.remove(boid); //Remove the selected boid from the ArrayList.
    
    //s += " Size after: " + boids.size();
    //println(s);
    
    m.passOscMessage(msg);
  }
  
  void queueBoid(Boid boid) {
    if (!boids.contains(boid)) {
      boids.add(boid);
      println("Boid of type " + boid.type + " and timing " + boid.timing + " queued for playback.");
    }
  }
  
}
