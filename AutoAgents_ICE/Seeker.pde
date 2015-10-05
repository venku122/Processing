//Seeker class
//Creates an inherited Seeker object from the Vehicle class
//Due to the abstract nature of the vehicle class, the Seeker
//  must implement the following methods:  
//  calcSteeringForces() and display()

class Seeker extends Vehicle {

  //---------------------------------------
  //Class fields
  //---------------------------------------

  //seeking target
  //set to null for now
  PVector target = null;
  
  //PShape to draw this seeker object
  PShape body;

  //overall steering force for this Seeker accumulates the steering forces
  //  of which this will be applied to the vehicle's acceleration
  PVector steeringForce;


  //---------------------------------------
  //Constructor
  //Seeker(x position, y position, radius, max speed, max force)
  //---------------------------------------
  Seeker(float x, float y, float r, float ms, float mf) {
      
    //call the super class' constructor and pass in necessary arguments


    //instantiate steeringForce vector to (0, 0)


    //PShape initialization
    //draw the seeker "pointing" toward 0 degrees
    
  }


  //--------------------------------
  //Abstract class methods
  //--------------------------------
  
  //Method: calcSteeringForces()
  //Purpose: Based upon the specific steering behaviors this Seeker uses
  //         Calculates all of the resulting steering forces
  //         Applies each steering force to the acceleration
  //         Resets the steering force
  void calcSteeringForces() {
      
    //get the steering force returned from calling seek
    //This seeker's target (for now) is the mouse
    

    //add the above seeking force to this overall steering force


    //limit this seeker's steering force to a maximum force


    //apply this steering force to the vehicle's acceleration


    //reset the steering force to 0

  }
  

  //Method: display()
  //Purpose: Finds the angle this seeker should be heading toward
  //         Draws this seeker as a triangle pointing toward 0 degreed
  //         All Vehicles must implement display
  void display() {
      
    //calculate the direction of the current velocity - this is done for you
    float angle = velocity.heading();   

    //draw this vehicle's body PShape using proper translation and rotation
    pushMatrix();

    popMatrix();
  }
  
  //--------------------------------
  //Class methods
  //--------------------------------
  
  
  
}