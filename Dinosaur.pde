// Note: Class name must match file name.
class Dinosaur {

  // Global variables -- accessible to any function in this class
  //                 -- cannot be accessed from outside this class
  float x;     // tracks horizontal position of dino
  float y;     // tracks vertical position of dino
  float r;     // tracks radius of dinosaur sprite
  float s;     // tracks speed of dino
  float a;     // tracks acceleration of the dino
  PImage dino;     // Our "dino"

  // constructor
  //
  // Purpose: Run once, when class is instantiated and an object created
  //          Note that constructor name must match class name.
  Dinosaur(float x_, float y_, float r_, float a_, float s_) {

    // set dino initial horizontal position
    x = x_;

    // set dino initial vertical position
    y = y_;

    // set dino sprite's radius
    r = r_;

    // set dino's initial acceleration
    a = a_;

    // set dino's initial speed
    s = s_;

    // set image for the dino
    dino = loadImage("mushroom.png");
  }

  // update
  //
  // Purpose: Do anything needed to update appearance of an object.
  //          This will be called from the main program's draw() function.
  //
  // Parameters: 
  //              float gravity      - the gravity of the game's scene
  void update(float gravity) {

    // draw the image-based "dino"
    // Need to subtract dino's radius from x and y position
    // since images are displayed by Processing based on their top-left corner
    // whereas circles are displayed based on their centre point
    // (our previous "dino" was a circle centred on (dinoX, dinoY) )
    image(dino, x - r, y - r);

    // Change dino's acceleration based on gravity
    a = a + gravity;

    // Change dino's speed based on acceleration
    s = s + a;

    // Change dino's location based on speed
    y = y + s;

    // When the dino hits the ground, acceleration and speed stop
    // Subract radius of dino sprite from height of screen, so dino
    // stops when bottom edege of it's sprite touches bottom of screen
    if (y > height - r) {
      s = 0;
      a = 0;
      y = height - r;  // Sometimes dino goes a bit below "ground level", so reset to ground level
    }
  }

  // isTouching
  //
  // Purpose: Tell us whether a cactus is touching this dinosaur
  //
  // Parameters:
  //                Cactus c  - the cactus object to be checked
  //
  // Returns:  Whether the cactus is touching the dinosaur
  boolean isTouching(Cactus c) {

    // Find distance between the two character's boundary circles using the
    // the Pythagorean Theorem
    float verticalLegLength = y - c.getY();
    float horizontalLegLength = x - c.getX();
    float verticalLegLengthSquared = pow(verticalLegLength, 2);
    float horizontalLegLengthSquared = pow(horizontalLegLength, 2);
    float distanceBetweenCharacters = sqrt(horizontalLegLengthSquared + verticalLegLengthSquared);

    // When the sum of the radii of the boundary circles of the two characters
    // is less than that distance between the centre points of the two characters,
    // they are not touching.
    if ( r + c.getRadius() < distanceBetweenCharacters ) {
      return false;
    }

    // Default return value is true
    return true;
  }
  
  // jump
  //
  // Purpose: Make the dinosaur jump
  void jump() {
    
    // Make dino move "up" on the screen
    if (y >= height - r) {    // Only permit dino to jump when it is on the ground
      a = -0.6; // negative acceleration is required, given direction of Y axis
    }
    
  }
  

}