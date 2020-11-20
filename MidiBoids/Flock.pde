// The Flock (a list of Boid objects)

class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }

  public void createBassBoid(Metronome m, int note, float timing, float velocity) {
    Boid b = new Boid(m, random(width), random(height), timing);
    b.setValues(0, note, velocity);
    boids.add(b);
  }

  public void createChirpBoid(Metronome m, int oct, float timing, float velocity) {
    Boid b = new Boid(m, random(width), random(height), timing);
    b.setValues(1, (int)random(11 + oct*5), velocity);
    boids.add(b);
  }

  void run() {
    for (int i = 0; i < boids.size(); i++) { //Had to change this to avoid a ConcurrentModificationException
      if (boids.get(i) != null)
        boids.get(i).run(boids);  // Passing the entire list of boids to each boid individually
    }
  }

  /*void addBoid(Boid b) {
    boids.add(b);
  }*/

  void clearBoids() {
    boids.removeAll(boids); //Function to remove every boid
  }

  void removeRandBoid() {
    if (boids.size() > 0) {
      int index = (int) random(0, boids.size());
      boids.remove(index); //Removes a random boid
    }
  }
  
  void setBoidValues(int bType, int bDegree, float bVolume) {
    if (boids.size() > 0) {
      int index = (int) random(0, boids.size());
      (boids.get(index)).setValues(bType, bDegree, bVolume);
    }
  }
  
  void removeLastBoid() {
    boids.remove(boids.size() - 1);
  }

}
