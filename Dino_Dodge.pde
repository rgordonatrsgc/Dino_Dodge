// global variables (can be used everywhere below)

// CACTUS INTIALIZATION
Cactus c1;

// DINO VARIABLES
Dino d;

// GAMEPLAY VARIABLES
float gravity;   // gravity
int score;       // Track score for the game

// this function runs once only
void setup() {

  // draw the canvas
  size(800, 200);

  // CACTUS INITIALIZATION
  //               x    y    r     a    s
  c1 = new Cactus(900, 175, 25, -0.1, -1);

  // DINO INITIALIZATION
  //           x    y    r  a  s
  d = new Dino(50, 170, 30, 0, 0);

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

  // draw current score
  drawScore();

  // animate the cactus
  c1.update();

  // Reset cactus
  resetCactus();

  // animate the dino
  d.update(gravity);

  // Check for collision
  if ( isTouching(d.getX(), d.getY(), d.getRadius(), c1.getX(), c1.getY(), c1.getRadius()) == true ) {
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
    if (d.getY() >= height - d.getRadius()) {
      d.setAcceleration(-0.6);
    }
  }
}

// updateScore
// Purpose: Update the on-screen score
void drawScore() {

  // display score in top-right corner of screen
  fill(0);
  textSize(24);
  textAlign(RIGHT);
  text(score, width - 15, 40);
}


// resetCactus
// Purpose: Reset the position of the cactus, update score
void resetCactus() {

  // put the cactus back on the right edge if it goes off the left edge
  if (c1.getX() < -1*c1.getRadius()) {
    c1.setX(900);         // place off screen on right 
    c1.setSpeed(-1);      // reset the speed (to avoid insanely fast movement)
    score = score + 25;  // dino dodged this one, so increase the score
  }
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