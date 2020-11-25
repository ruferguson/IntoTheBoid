# Into the Boid

by Ru Ferguson, Nikita Kulkarni, and Ayden Machajewski 

Note: all commits by @ruferguson were collaborations with @nikitakulkarni17

Video Demonstration: https://youtu.be/v2cxswKSgWA

### — Instructions —

#### Download the Files from GitHub

1. Click the green "Code" button

2. Select "Download ZIP" from the dropdown menu.

#### Required Software

- SuperCollider: https://supercollider.github.io/download

- Processing: https://processing.org/download/

- oscP5, netP5, and themidibus Processing libraries 

  - You can download these libraries from the menu bar

    Sketch > Import Library... > Add Library... 

    <img src ="https://i.stack.imgur.com/skXMV.png" alt="10%" style="zoom:50%;" />

### Using a Midi Controller

If you have a physical Midi controller, especially a drum pad like the Roland SPD-SX used in the demonstration, be sure to connect it to your computer before running the program. That will ensure that it is the default MIDI input and that Processing will properly connect with it. The program uses midi notes 60—68, which is from Middle C to the Ab above it on a Keyboard.

If you don't have a real MIDI controller, no worries. A 9-button GUI is included that functions identically to real MIDI input. See the **Midi Controller Key.

#### Run the Program

1. Open the BoidsPrototype.scd
2. Boot the server with ⌘ + B (Mac) or Ctrl + B (Windows)
3. Initialize the SynthDefs by placing your cursor where the // comment indicates and press ⌘ + return (Mac) or ctrl + enter (Windows)
4. Scroll about halfway down, and repeat the same action for the OSCdef.
5. Now navigate to the MidiBoids folder, and open any one of the .pde files. Do not close SuperCollider.
6. In the setup(), make sure the NetAddress information matches the SuperCollider NetAddress. You can check this, by running the line of code at the bottom of the BoidsPrototype.scd patch, "NetAddr.localAddr"
7. Now press ▶️ to run the sketch. Make sure your sound is on and enjoy!

#### Midi Controller Key

|     clear all boids (60)    | remove last boid added (61) | remove single random boid (62) |
| :-------------------------: | :------------------------: | :------------------------: |
| **low octave chirp (63)** |      **C2 Bass  (64)**     |       **Eb2 Bass  (65)**      |
| **high octave chirp (66)** |      **G1 Bass   (67)**    |       **Bb1 Bass  (68)**      |

### — Known Issues and Fixes —

Simultaneous removal and creation of a boid (in particular when using the "clear all boids" function) carries a risk of freezing the program. While you can create any number of boids at the same time, avoid using the top three functions at the same time as the boid creation functions.
