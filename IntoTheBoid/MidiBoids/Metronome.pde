class Metronome {
  
  MidiBoids m;
  
  OscMessage msg;
  
  float deltaTime = 0; //The time elapsed since the last drawing frame. (ms)
  float worldTime = 0; //The global clock time as of the most recently drawn frame. (ms)
  float beatTime = 0; //The time elapsed since the last beat.
  
  float tempo = 500; // The amount of time that should elapse between each beat. (ms)
  
  ArrayList<Boid> boids = new ArrayList<Boid>(); //A list of boids that still need to send an OscMessage
  
  float tolerance = 5f; //in ms
  
  int bassCount = 0;
  int bassMax = 1;
  int chirpCount = 0;
  int chirpMax = 50;
  
  float subdivision = 8;
  
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
      if (boids.get(i) != null) {
        //boids.get(i).timing <= beatTime || (deltaTime >= beatTime && boids.get(i).timing <= deltaTime)
        if ((abs(boids.get(i).timing - beatTime) <= tolerance || abs(boids.get(i).timing - (beatTime - tempo)) <= tolerance)) {
          println(boids.get(i).timing);
          sendMessage(boids.get(i)); //Run through each queued boid and see if it is time to run its message.
        }
      }
    }
    
    if (beatTime > tempo)
      onBeat(); //Reset the beatTime every beat.
      
    for (int i = 1; i < subdivision; i++) {
      if ((tempo/(subdivision/i)) - beatTime <= tolerance && (tempo/(subdivision/i)) - beatTime >= -tolerance)
        formMessage(2, 24, 0.4, 0);
    }
    
  }
  
  void onBeat() {
    beatTime = 0;
    formMessage(2, 24, 0.7, 0);
  }
  
  void formMessage(int type, int degree, float volume, float orientation) { //sends to SuperCollider
    
    msg = new OscMessage("/listener");
    
    msg.add(type);
    msg.add(degree);
    msg.add(volume);
    msg.add(orientation);
    
    m.passOscMessage(msg);
    
  }
  
  void sendMessage(Boid boid) {
    
    formMessage(boid.type, boid.degree, boid.volume, boid.orientation);
    if (boid.type == 0) {
      bassCount--;
    } else if (boid.type == 1) {
      chirpCount--;
    }
    boids.remove(boid); //Remove the selected boid from the ArrayList.
    
  }
  
  void queueBoid(Boid boid) {
    if (!boids.contains(boid)) {
      if (boid.type == 0 && bassCount == bassMax) {
      bassCount++;
    } else if (boid.type == 1 && chirpCount < chirpMax) {
      chirpCount++;
    }
      boids.add(boid);
    }
  }
  
  void parseMidi(Flock f, int pitch, int velocity) {
    
    switch (pitch) {
      
      case 60: // clears all boids
      f.clearBoids();
      boids.removeAll(boids);
      break;
      
      case 61: // removes last boid
      f.removeLastBoid();
      break;
      
      case 62: // remove a random boid - temporary one
      f.removeRandBoid();
      break;
      
      case 63: // chirp lower octave
      f.createChirpBoid(this, 0, beatTime, ((float)velocity / 100f));
      formMessage(1, 5, (float)velocity / 100f, 0);
      break;
      
      case 64: // C2
      f.createBassBoid(this, 36, beatTime, ((float)velocity / 127f));
      formMessage(0, 36, (float)velocity / 127f, 0);
      break;
      
      case 65: // Eb2
      f.createBassBoid(this, 39, beatTime, ((float)velocity / 127f));
      formMessage(0, 39, (float)velocity / 127f, 0);
      break;
      
      case 66: // chirp higher octave
      f.createChirpBoid(this, 2, beatTime, ((float)velocity / 100f));
      formMessage(1, 10, (float)velocity / 100f, 0);
      break;
      
      case 67:  // G1
      f.createBassBoid(this, 31, beatTime, ((float)velocity / 127f));
      formMessage(0, 31, (float)velocity / 127f, 0);
      break;
      
      case 68: // Bb1
      f.createBassBoid(this, 34, beatTime, ((float)velocity / 127f));
      formMessage(0, 34, (float)velocity / 127f, 0);
      break;   
    }  
  }
  
}
