# Into the Boid

by Ru Ferguson, Nikita Kulkarni, and Ayden Machajewski 

Note: all commits by @ruferguson were collaborations with @nikitakulkarni17

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

#### Run the Program

1. Open the BoidsPrototype.scd
2. Boot the server with ⌘ + B (Mac) or Ctrl + B (Windows)
3. Initialize the SynthDefs by placing your cursor where the // comment indicates and press ⌘ + return (Mac) or ctrl + enter (Windows)
4. Scroll about halfway down, and repeat the same action for the OSCdef.
5. Now navigate to the MidiBoids folder, and open any one of the .pde files. Do not close SuperCollider.
6. In the setup(), make sure the NetAddress information matches the SuperCollider NetAddress. You can check this, by running the line of code at the bottom of the BoidsPrototype.scd patch, "NetAddr.localAddr"
7. Now press ▶️ to run the sketch. Make sure your sound is on and enjoy!

#### Virtual Midi Controller Key

|    clear all boids    | remove last boid added | remove single random boid |
| :-------------------: | :--------------------: | :-----------------------: |
| **low octave chirp**  |         **C2**         |          **Eb2**          |
| **high octave chirp** |         **G1**         |          **Bb1**          |

### — Known Issues and Fixes —

#### SuperCollider

#### Processing
