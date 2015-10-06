// global variables (can be used everywhere below)
int x;    // tracks horizontal position of first cactus

// this function runs once only
void setup() {
  // draw the canvas
  size(800, 200);
  
  // set the initial position of the cactus
  x = 900; // position it off-screen on the right
}

// this function runs repeatedly
void draw() {
  // background clears each time the program loops
  background(255);
  
  // draw a circle at bottom right corner of the screen
  //       x    y    w   h
  ellipse(x, 175, 50, 50);
  
  // create the appearance of moving by changing the x position
  x = x - 1;
}