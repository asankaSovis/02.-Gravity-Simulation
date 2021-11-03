/* GRAVITY SIMULATION ----------------------------------------------------------

In this example, we wil create a simulation of gravity. We will generate some ball
which will bounce from the floor and the walls to create a natural looking gravity simulation.
Gravity is a force. So we need to create this force mathematically within the computer
memory.
Check out my blog post: https://asanka-sovis.blogspot.com/2021/11/02-gravity-simulation-making-bouncing.html
Coded by Asanka Akash Sovis

-----------------------------------------------------------------------------*/

// Defining global variables
color backColour = #22556E; // Colour of the background
color ballColours[] = { #D2E5E8, #DBEDD4, #F7F0D3, #ECD7DA, #E1E4FD }; // Some random colours for the balls

float gravity = 0.5; // Value of gravity
float energyLoss = 0.05; // Energy loss when hitting a surface

ball[] balls = new ball[40]; // Creating a fixed amount of balls (A ball is defined as a class)

void setup() {
  size(800, 600); // Defining the size of the canvas
  background(backColour); // Setting the colour of the background
  for (int i = 0; i < balls.length; i++) {
      balls[i] = new ball(); // Creating balls and adding them to the array
  }
  strokeWeight(5); // Setting the stroke weight of the balls
}

void draw() {
  // We first set the background colour and some text
  background(backColour);
  textAlign(CENTER);
  textSize(70);
  text("GRAVITY SIMULATION", width / 2, 200);
  textSize(20);
  text("BY ASANKA SOVIS", width / 2, 230);
  
  // For each ball in the balls array, we draw them on screen
  for (int i = 0; i < balls.length; i++) {
      balls[i].draw();
  }
  //saveFrame("Output\\Gravity-" + frameCount + ".png"); // Saves the current frame. Comment if you don't need
}

class ball {
  // This class defines what a ball is. A ball should have a size, position on the screen, velocity,
  // fill colour and stroke colour. These parameters are set as variables to the ball class.
  // Here, they're determined at random, but you can uncomment the fixed sizes instead if you want.
  // The position and velocity must have two axis, X and Y because we work in the 2D plane.
  // So we use the PVector class to define a vector with X and Y to easily create them.
  //
  //int size = 100;
  //PVector position = new PVector(400, 100);
  //PVector velocity = new PVector(9, 0);
  int size = int(random(50, 100));
  PVector position = new PVector(random(100, width - 100), random(-400, -100));
  PVector velocity = new PVector(random(0, 10), random(0, 10));
  color fillColour = ballColours[int(random(ballColours.length - 1))];
  color strokeColour =  ballColours[int(random(ballColours.length - 1))];
  
  // The ball should also have a draw function which will draw itself on the screen.
  // It will also update its parameters in this function.
  void draw() {
    // Setting up colours
    fill(fillColour);
    stroke(strokeColour);
    
    // WORKING ON THE Y AXIS -----
    // Y axis is where gravity takes place. When an object is let go from a certain x, y coordinate,
    // it will start to accelerate towards the ground (Y). Once it hits the ground, it will lose some
    // energy and bounce back.
    // We can define the X, Y as the location of the ball on the screen. X, Y velocity will define the
    // rate in which it changes.
    // Force = mass x acceleration. Thus we see that the Gravitational force excerts an acceleration
    // on our particle in the Y direction. We'll assume Force, mass of our particles as constant. Thus
    // acceleration is also constant, as we have defined as a global variable.
    // Let's take each frame as a one unit of time. We know that v = u + at, and
    // s = s0 + vt. Thus for each iteration, we add acceleration to velocity and velocity to Y
    // We also need to make the ball bounce. In this case, we constantly check if Y + (size / 2) is greater
    // than the height, which means that the ball has hit the bottom. If this is the case, velocity opposes
    // which means v = v * -1 instead of adding gravity. We also add a small energy loss to it to emulate
    // a real world energy loss, so that the height the ball reaches slowly decline.
    if (position.y + (size / 2)  + velocity.y > height) {
      velocity.y *= -1 + energyLoss;
    } else {
      velocity.y += gravity; 
    }
    position.y += velocity.y;
    
    // Same is done for the X axis. But no force exist in the X direction. So there is no acceleration,
    // And velocity stay constant. However we check for bounces of the walls in the same manner, and
    // does the same transformation to emulate a real world bounce.
    if ((position.x + (size / 2) + velocity.x >= width)  || (position.x - (size / 2) + velocity.x <= 0)){
      velocity.x *= -1 + energyLoss;
    }
    position.x += velocity.x;
    //println(velocity); // Just print the velocity vector. Comment if not needed.
    
    circle(position.x, position.y, size); // Drawing the ball as a circle
    
    // When both X and Y direction behaviour is combined, we get these realistic bouncing balls,
    // slowly losing their chaotic nature.
  }
  
}
