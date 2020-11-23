class MidiController extends PApplet {  
  MidiController() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }
  
  int buttonSize;
  boolean buttonOver; 
  color mouseColor;
  color pressedColor;
    
  void settings() {
    size(400, 400);
  }
  
  void setup() {
    surface.setLocation(displayWidth*7/20, displayHeight*11/20);
    buttonSize = 120;
        
    background(0);
    makeButtons();
  }

  void draw() {
    pressedColor = color(random(180, 200), random(100, 150), random(150, 200));
    mouseColor = get(mouseX, mouseY);
    if (!mousePressed) {
      makeButtons();
    }
  }
  
  void mouseReleased() {
    checkOverButton();
  }
  
  void makeButtons() { //makes the new button after pressed
    rectMode(CORNER);
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        fill(100, 150 + (20 * i), 150 + (20 * j));
        rect(20 + i*buttonSize, 20 + j*buttonSize, buttonSize, buttonSize);
      }
    }
  }
  
  void checkOverButton() { //changes button color after pressed
    if (mouseColor == color(100, 150, 150)) {
      b1();
    } else if (mouseColor == color(100, 170, 150)) {
      b2();
    } else if (mouseColor == color(100, 190, 150)) {
      b3();
    } else if (mouseColor == color(100, 150, 170)) {
      b4();
    } else if (mouseColor == color(100, 170, 170)) {
      b5();
    } else if (mouseColor == color(100, 190, 170)) {
      b6();
    } else if (mouseColor == color(100, 150, 190)) {
      b7();
    } else if (mouseColor == color(100, 170, 190)) {
      b8();
    } else if (mouseColor == color(100, 190, 190)) {
      b9();
    }
  }
  
  void b1() { //button 1
    fill(pressedColor);
    rect(20, 20, 120, 120);
    isB1 = true;
  }
  
  void b2() {   //button 2
    fill(pressedColor);
    rect(140, 20, 120, 120);
    isB2 = true;
  }
  
  void b3() {  //button 3
    fill(pressedColor);
    rect(260, 20, 120, 120);
    isB3 = true;
  }
  
  void b4() {  //button 4
    fill(pressedColor);
    rect(20, 140, 120, 120);
    isB4 = true;
  }
  
  void b5() {  //button 5
    fill(pressedColor);
    rect(140, 140, 120, 120);
    isB5 = true;
  }
    
  void b6() {  //button 6
    fill(pressedColor);
    rect(260, 140, 120, 120);
    isB6 = true;
  }
    
  void b7() {  //button 7
    fill(pressedColor);
    rect(20, 260, 120, 120);
    isB7 = true;
  }
    
  void b8() {  //button 8
    fill(pressedColor);
    rect(140, 260, 120, 120);
    isB8 = true;
  }
    
  void b9() {  //button 9
    fill(pressedColor);
    rect(260, 260, 120, 120);
    isB9 = true;
  }
}
