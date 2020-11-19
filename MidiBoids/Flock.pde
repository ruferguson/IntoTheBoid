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

  void removeLastBoid() {
    boids.remove(boids.size() - 1); //Removes the most recently created boid
  }
  
  void removeBoid() {
    if (boids.size() > 0)
      boids.remove(random(boids.size())); //Picks a random boid and removes it.
  }

}
