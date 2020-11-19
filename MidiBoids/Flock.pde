// The Flock (a list of Boid objects)

class Flock {
  ArrayList<Boid> boids; // An ArrayList for all the boids

  Flock() {
    boids = new ArrayList<Boid>(); // Initialize the ArrayList
  }

  void run() {
    for (Boid b : boids) {
      b.run(boids);  // Passing the entire list of boids to each boid individually
    }
  }

  void addBoid(Boid b) {
    boids.add(b);
  }

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
    int index = (int) random(0, boids.size());
    (boids.get(index)).setValues(bType, bDegree, bVolume);
  }
  
  void removeBoid() {
    if (boids.size() > 0)
      boids.remove(random(boids.size())); //Picks a random boid and removes it.
  }

}
