import themidibus.*;

public class MidiInterface implements SimpleMidiListener {
  
  MidiBus bus;
  PApplet p;
  Metronome m;
  Flock f;
  
  public MidiInterface(PApplet p, Metronome m, Flock f, int midiIn, int midiOut) {
    this.p = p;
    this.m = m;
    this.f = f;
    MidiBus.list();
    bus = new MidiBus(this, midiIn, midiOut);
  }
  
  public void noteOn(int channel, int pitch, int velocity) {
    
    println();
    println("Note On:");
    println("--------");
    println("Channel: " + channel);
    println("Pitch: " + pitch);
    println("Velocity: " + velocity);
    
    if (velocity != 0)
      m.parseMidi(f, pitch, velocity);
    
  }
  
  public void noteOff(int channel, int pitch, int velocity) {
    
    println();
    println("Note Off:");
    println("--------");
    println("Channel: " + channel);
    println("Pitch: " + pitch);

  }
  
  public void controllerChange(int channel, int number, int value) {
    
    println();
    println("Controller Change:");
    println("--------");
    println("Channel: " + channel);
    println("Number: " + number);
    println("Value: " + value);
    
  }
  
}
