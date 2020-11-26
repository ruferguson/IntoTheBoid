# Into the Boid

a collaboration between Ru Ferguson, Nikita Kulkarni, and Ayden Machajewski 

Note: all commits by @ruferguson were completed with @nikitakulkarni17

Video Demonstration: https://youtu.be/v2cxswKSgWA

#### Artists' Statement
This instrument, Into the Boid, generates sound in Supercollider using OSC data sent from a Boids flocking sketch in Processing. Additionally, the Boids’ behavior can be manipulated through user-interaction by either a physical or virtual MIDI controller. We designed and implemented the virtual MIDI controller so the project could be controlled directly from the device it was being run on, and we created two Processing windows so that the user can view both the virtual MIDI controller and the Boids flocking patterns simultaneously.

Through this project, we wanted to illustrate and engage the anthropogenic relationship between humans and the natural environment. The Boids represent elements and patterns within the natural world, such as bird migration, while the MIDI system demonstrates how humans interrupt those organic cycles. Our team was drawn to the beauty of the flocking behavior in the original Boids program, which was developed by Craig Reynolds in 1986, and we knew we wanted to explore how that pattern could be sonified.

On a conceptual level, the user-interaction illuminates the anthropogenic relationship between humans and the environment; however, this instrument is also intended for real-time performance use. For example, a musician may use this program to perform by playing various MIDI buttons to affect the sound produced by the flocking patterns. Further development and application could involve the use of motion capture data in lieu of the MIDI controller so that a dancer could affect the flocking and sounds produced by using gestures and movement. In addition to performative applications, this instrument also has potential as an installation in which the audience could manipulate the program on their own to explore and experience the outcomes of their actions.

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
