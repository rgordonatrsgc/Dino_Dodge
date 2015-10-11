// global variables (can be used everywhere below)

// CACTUS INTIALIZATION
Cactus cactus1;
Cactus cactus2;

// DINO VARIABLES
Dinosaur dino;

// GAMEPLAY VARIABLES
float gravity;   // gravity
int score;       // Track score for the game

// this function runs once only
void setup() {

  // draw the canvas
  size(800, 200);

  // CACTUS INITIALIZATION
  //                    r  a  s  value scale
  cactus1 = new Cactus(25, 0, -8, 25, 1);
  cactus2 = new Cactus(12.5, 0, -12, 50, 0.5);

  // DINO INITIALIZATION
  //           x    y    r  a  s
  dino = new Dinosaur(50, 170, 30, 0, 0);

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
  score = cactus1.update(score);
  score = cactus2.update(score);

  // animate the dino
  dino.update(gravity);

  // Check for collision
  if ( dino.isTouching(cactus1) == true || dino.isTouching(cactus2) == true) {
    noLoop();
  }
}

// respond to keypress 
void keyPressed() {

  // Make dino jump when spacebar is pressed
  if (key == ' ') {
    dino.jump();
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