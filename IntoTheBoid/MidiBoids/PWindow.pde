class PWindow extends PApplet {
  PWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    size(500, 200);
  }

  void setup() {
    background(150);
  }

  void draw() {
    //ellipse(random(width), random(height), random(50), random(50));
  }

  void mousePressed() {
    println("mousePressed in secondary window");
    msg = new OscMessage("/listener"); // remember to change slash for SC to match
    msg.add(type);
    msg.add(degree);
    msg.add(volume);
    msg.add(orientation);
    osc.send(msg, supercollider);
  }
}
