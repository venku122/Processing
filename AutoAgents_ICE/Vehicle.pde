//Vehicle class
//Specific autonomous agents will inherit from this class 
//Abstract since there is no need for an actual Vehicle object
//Implements the stuff that each auto agent needs: movement, steering force calculations, and display

abstract class Vehicle {

  //--------------------------------
  //Class fields
  //--------------------------------
  //vectors for moving a vehicle
  PVector position, //Position of the object on the screen
    velocity, //rate of change of position 
    acceleration, //rate of change of velocity this frame
    force, //net force acting on the object this frame
    min, // minimum bounding of the ship
    max; //maximum bounding of the ship

  //no longer need direction vector - will utilize forward and right
  //these orientation vectors provide a local point of view for the vehicle
  PVector forward, right;

  //floats to describe vehicle movement and size
  float mass, //Mass of the object, used for physics
    radius, 
    maxForce, 
    maxVelocity; //Limit of the object's velocity


  //--------------------------------
  //Constructor
  //Vehicle(x position, y position, radius, max speed, max force)
  //--------------------------------
  Vehicle(float x, float y, float r, float ms, float mf)
  {
    //Assign parameters to class fields
    position= new PVector(x, y);
    radius=r;
    maxVelocity=ms;
    maxForce=mf;
    mass=1;
    acceleration=new PVector(0,0);
    velocity = new PVector(0,0);
    force = new PVector(0,0);
    
    
  }

  //--------------------------------
  //Abstract methods
  //--------------------------------
  //every sub-class Vehicle must use these functions
  abstract void calcSteeringForces();
  abstract void display();

  //--------------------------------
  //Class methods
  //--------------------------------

  //Method: update()
  //Purpose: Calculates the overall steering force within calcSteeringForces()
  //         Applies movement "formula" to move the position of this vehicle
  //         Zeroes-out acceleration 
  void update() {
    //calculate steering forces by calling calcSteeringForces()
    calcSteeringForces();
    //add acceleration to velocity, limit the velocity, and add velocity to position
    velocity.add(acceleration);//updates velocity
    velocity.limit(maxVelocity);//Limits velocity
    position.add(velocity);//Updates position
    
    //calculate forward and right vectors
    forward= velocity.copy().normalize();
    right= forward.copy().rotate(radians(90));
    
    //reset acceleration
    acceleration.mult(0);
    force.mult(0);
  }


  //Method: applyForce(force vector)
  //Purpose: Divides the incoming force by the mass of this vehicle
  //         Adds the force to the acceleration vector
  void applyForce(PVector force) {
    acceleration.add(PVector.div(force, mass));
  }


  //--------------------------------
  //Steering Methods
  //--------------------------------

  //Method: seek(target's position vector)
  //Purpose: Calculates the steering force toward a target's position
  PVector seek(PVector target)
  {
    //write the code to seek a target!
    PVector desiredVelocity= target.sub(position);
    desiredVelocity.setMag(maxVelocity);
    PVector steeringForce = desiredVelocity.sub(velocity);
    return steeringForce;
  }
}