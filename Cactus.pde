// Note: Class name must match file name.
class Cactus {

  // Global variables -- accessible to any function in this class
  //                 -- cannot be accessed from outside this class
  float x;      // tracks horizontal position of cactus
  float y;      // tracks vertical position of cactus
  float r;      // tracks radius of cactus sprite
  float s;      // speed for first cactus
  float a;      // acceleration for cactus
  int value;  // score value for this cactus
  PImage cactus;   // Our "cactus"

  // constructor
  //
  // Purpose: Run once, when class is instantiated and an object created
  //          Note that constructor name must match class name.
  Cactus(float x_, float y_, float r_, float a_, float s_, int value_) {

    // set the initial position of the cactus
    x = x_;

    // set cactus vertical position
    y = y_;

    // set cactus radius
    r = r_;

    // set the intial acceleration
    a = a_;

    // set the initial speed
    s = s_;

    // set the score value
    value = value_;

    // set image for the cactus
    cactus = loadImage("ghost.png");
  }

  // update
  //
  // Purpose: Do anything needed to update appearance of an object.
  //          This will be called from the main program's draw() function.
  void update() {
    
    // draw the image-based "cactus"
    // Need to subtract cactus radius from x and y position
    // since images are displayed by Processing based on their top-left corner
    // whereas circles are displayed based on their centre point
    // (our previous "cactus" was a circle centred on (x, y) )
    image(cactus, x - r, y - r);

    // change the speed
    s = s + a;

    // create the appearance of moving by changing the x position
    x = x + s;
    
  }
  
  // getX
  // 
  // Purpose: Return the horizontal position of this cactus
  float getX() {
     return x; 
  }

  // setX
  //
  // Purpose: Set the horizontal position of this cactus
  void setX(float x_) {
    x = x_;  
  }

  // getY
  // 
  // Purpose: Return the vertical position of this cactus
  float getY() {
     return y; 
  }

  // getRadius
  // 
  // Purpose: Return the radius of this cactus sprite
  float getRadius() {
     return r; 
  }
  
  // setSpeed
  //
  // Purpose: Set the speed of this cactus
  void setSpeed(float s_) {
    s = s_;  
  }
  
  // getScoreValue
  // 
  // Purpose: Return the value of this cactus for scoring
  int getScoreValue() {
     return value; 
  }
  

}