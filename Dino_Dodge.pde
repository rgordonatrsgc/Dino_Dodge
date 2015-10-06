// this function runs once only
void setup() {
  // draw the canvas
  size(800, 200);
}

// this function runs repeatedly
void draw() {
  // background clears each time the program loops
  background(255);
  
  // draw a circle at bottom right corner of the screen
  //       x    y    w   h
  ellipse(775, 175, 50, 50);
}