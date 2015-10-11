// global variables (can be used everywhere below)

// CACTUS VARIABLES
float x1;    // tracks horizontal position of first cactus
float y1;    // tracks vertical position of first cactus
float r1;    // tracks radius of cactus sprite
float s1;    // speed for first cactus
float a1;    // acceleration for first cactus
PImage cactus;   // Our "cactus"

// DINO VARIABLES
float dinoX;     // tracks horizontal position of dino
float dinoY;     // tracks vertical position of dino
float dinoR;     // tracks radius of dinosaur sprite
float dinoS;     // tracks speed of dino
float dinoA;     // tracks acceleration of the dino
PImage dino;     // Our "dino"

// GAMEPLAY VARIABLES
float gravity;   // gravity
int score;       // Track score for the game

// this function runs once only
void setup() {
  // draw the canvas
  size(800, 200);

  // CACTUS INITIALIZATION
  // set the initial position of the cactus
  x1 = 900; // position it off-screen on the right
  
  // set cactus vertical position
  y1 = 175;

  // set cactus radius
  r1 = 25;

  // set the intial acceleration
  a1 = -0.1;

  // set the initial speed
  s1 = -1;

  // set image for the cactus
  cactus = loadImage("ghost.png");

  // DINO INITIALIZATION
  // set dino initial horizontal position
  dinoX = 50;

  // set dino initial vertical position
  dinoY = 170;

  // set dino sprite's radius
  dinoR = 30;

  // set dino's initial speed
  dinoS = 0;

  // set dino's initial acceleration
  dinoA = 0;

  // set image for the dino
  dino = loadImage("mushroom.png");

  // GAMEPLAY INITIALIZATION
  // set gravity
  gravity = 0.03;
  
  // set initial score
  score = 0;
}

// this function runs repeatedly
void draw() {
  
  // background clears each time the program loops
  background(255);
  
  // update the score
  updateScore();
  
  // draw the image-based "cactus"
  // Need to subtract cactus radius from x and y position
  // since images are displayed by Processing based on their top-left corner
  // whereas circles are displayed based on their centre point
  // (our previous "cactus" was a circle centred on (x1, y1) )
  image(cactus, x1 - r1, y1 - r1); 

  // change the speed
  s1 = s1 + a1;

  // create the appearance of moving by changing the x position
  x1 = x1 + s1;

  // put the cactus back on the right edge if it goes off the left edge
  if (x1 < -1*r1) {
    x1 = 900; // place off screen on right 
    s1 = -1;  // reset the speed (to avoid insanely fast movement)
    score = score + 25;  // dino dodged this one, so increase the score
  }

  // Change dino's acceleration based on gravity
  dinoA = dinoA + gravity;

  // Change dino's speed based on acceleration
  dinoS = dinoS + dinoA;

  // Change dino's location based on speed
  dinoY = dinoY + dinoS;

  // When the dino hits the ground, acceleration and speed stop
  // Subract radius of dino sprite from height of screen, so dino
  // stops when bottom edege of it's sprite touches bottom of screen
  if (dinoY > height - dinoR) {
    dinoS = 0;
    dinoA = 0;
    dinoY = 170;  // Sometimes dino goes a bit below "ground level", so reset to ground level
  }

  // draw the image-based "dino"
  // Need to subtract dino's radius from x and y position
  // since images are displayed by Processing based on their top-left corner
  // whereas circles are displayed based on their centre point
  // (our previous "dino" was a circle centred on (dinoX, dinoY) )
  image(dino, dinoX - dinoR, dinoY - dinoR);
  
  // Check for collision
  if ( isTouching(dinoX, dinoY, dinoR, x1, y1, r1) == true ) {
     noLoop();
  }
  
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

// updateScore
// Purpose: Update the on-screen score
void updateScore() {
  
  // display score in top-right corner of screen
  fill(0);
  textSize(24);
  textAlign(RIGHT);
  text(score, width - 15, 40);
  
}

// isTouching
// Purpose: Tell us whether two characters (with circular boundaries) are touching
// Parameters:
//                tX      - the x-position of the target's centre point
//                tY      - the y-position of the target's centre point
//                tR      - the radius of the target's boundary circle
//                oX      - the x-position of the other character's centre point
//                oY      - the y-position of the other character's centre point
//                oR      - the radius of the other character's boundary circle
boolean isTouching(float tX, float tY, float tR, float oX, float oY, float oR) {
  
  // Find distance between the two character's boundary circles using the
  // the Pythagorean Theorem
  float verticalLegLength = tY - oY;
  float horizontalLegLength = tX - oX;
  float verticalLegLengthSquared = pow(verticalLegLength, 2);
  float horizontalLegLengthSquared = pow(horizontalLegLength, 2);
  float distanceBetweenCharacters = sqrt(horizontalLegLengthSquared + verticalLegLengthSquared);
  
  // When the sum of the radii of the boundary circles of the two characters
  // is less than that distance between the centre points of the two characters,
  // they are not touching.
  if ( tR + oR < distanceBetweenCharacters ) {
    return false;
  }
  
  // Default return value is true
  return true;
}