// global variables (can be used everywhere below)
float x1;    // tracks horizontal position of first cactus
float s1;    // speed for first cactus
float a1;    // acceleration for first cactus
float dinoY;     // tracks position of dino
float dinoS;     // tracks speed of dino
float dinoA;     // tracks acceleration of the dino
float gravity;   // gravity
PImage dino;     // Our "dino"
PImage cactus;     // Our "cactus"

// this function runs once only
void setup() {
  // draw the canvas
  size(800, 200);

  // set the initial position of the cactus
  x1 = 900; // position it off-screen on the right

  // set the intial acceleration
  a1 = -0.1;

  // set the initial speed
  s1 = -1;

  // set dino initial vertical position
  dinoY = 170;

  // set dino's initial speed
  dinoS = 0;

  // set dino's initial acceleration
  dinoA = 0;

  // set gravity
  gravity = 0.03;

  // set image for the dino
  dino = loadImage("mushroom.png");

  // set image for the cactus
  cactus = loadImage("ghost.png");
}

// this function runs repeatedly
void draw() {
  // background clears each time the program loops
  background(255);

  // draw the image-based "cactus"
  // Need to subtract 25 from x and y position
  // since images are displayed by Processing based on their top-left corner
  // whereas circles are displayed based on their centre point
  // (our previous "cactus" was a circle centred on x = x1, y = 175)
  image(cactus, x1 - 25, 175 - 25); 

  // change the speed
  s1 = s1 + a1;

  // create the appearance of moving by changing the x position
  x1 = x1 + s1;

  // put the cactus back on the right edge if it goes off the left edge
  if (x1 < -25) {
    x1 = 900; // place off screen on right 
    s1 = -1;  // reset the speed (to avoid insanely fast movement)
  }

  // Change dino's acceleration based on gravity
  dinoA = dinoA + gravity;

  // Change dino's speed based on acceleration
  dinoS = dinoS + dinoA;

  // Change dino's location based on speed
  dinoY = dinoY + dinoS;

  // When the dino hits the ground, acceleration and speed stop
  // I made the threshold 170, because 200 is the bottom of the screen,
  // and the radius of the "dino" is 30 pixels
  if (dinoY > 170) {
    dinoS = 0;
    dinoA = 0;
    dinoY = 170;  // Sometimes dino goes a bit below "ground level", so reset to ground level
  }

  // draw the image-based "dino"
  // Need to subtract 30 from x and y position
  // since images are displayed by Processing based on their top-left corner
  // whereas circles are displayed based on their centre point
  // (our previous "dino" was a circle centred on x = 50, y = dinoY)
  image(dino, 50 - 30, dinoY - 30);
}

// respond to keypress 
void keyPressed() {

  // Make dino move "up" on the screen
  // (negative acceleration is required, given direction of Y axis
  //  in Processing's co-ordinate system)
  // Only permit dino to jump when it is on the ground
  if (key == ' ') {
    if (dinoY >= 170) {
      dinoA = -0.6;
    }
  }
}

