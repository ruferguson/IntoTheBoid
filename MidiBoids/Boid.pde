// The Boid class

class Boid {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  
  int type;
  int degree;
  float volume;
  float orientation = 0;
  
  float timing = 500;
  
  Metronome metro;

  public Boid(Metronome m, float x, float y, float pTime) {
    acceleration = new PVector(0, 0);

    position = new PVector(x, y);
    r = random(20, 25);
    maxspeed = 2;
    maxforce = 0.03;
    
    velocity = PVector.random2D().mult(maxspeed * 0.7);
    
    type = round(random(0, 1)); // should be random between 0 or 1
    degree = (int) random(30, 40);
    volume = random(0, 0.5);
   
    timing = pTime;
   
    println(timing);
   
    metro = m;
  }
  
  public void setValues(int bType, int bDegree, float bVolume) {
    type = bType;
    degree = bDegree;
    volume = bVolume;
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(0.2);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    
    orientation = atan(velocity.y / velocity.x);
    orientation /= (PI/2);
    
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    // Scale to maximum speed
    desired.setMag(maxspeed);

    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }

  void render() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading() + radians(90);
    
    if (type == 0) {
      pushMatrix();
      translate(position.x, position.y);
      rotate(theta);
      tint(255, 126);
      image(bird, 0, 0, r, r);
      popMatrix();
    } else {
      pushMatrix();
      translate(position.x, position.y);
      rotate(theta);
      tint(255, 255);
      image(bird, 0, 0, r, r);
      popMatrix();
    }
  }

  // Wraparound
  void borders() {
    if (!atEdge) {
      if (position.x < -r) {
        position.x = width+r;
        atEdge = true;
      } else if (position.y < -r) {
        position.y = height+r;
        atEdge = true;
      } else if (position.x > width+r) {
        position.x = -r;
        atEdge = true;
      } else if (position.y > height+r) {
        position.y = -r;
        atEdge = true;
      }
    }
    if (atEdge) {
        metro.queueBoid(this);
        atEdge = false;
    }
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Boid> boids) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (int i = 0; i < boids.size(); i++) {
      float d = 0;
      if (boids.get(i) != null)
        d = PVector.dist(position, boids.get(i).position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, boids.get(i).position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.setMag(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (int i = 0; i < boids.size(); i++) {
      float d = 0;
      if (boids.get(i) != null)
      d = PVector.dist(position, boids.get(i).position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(boids.get(i).velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      
      // Implement Reynolds: Steering = Desired - Velocity
      sum.setMag(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      return steer;
    } 
    else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (int i = 0; i < boids.size(); i++) {
      float d = 0;
      if (boids.get(i) != null)
      d = PVector.dist(position, boids.get(i).position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(boids.get(i).position); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } 
    else {
      return new PVector(0, 0);
    }
  }

}
