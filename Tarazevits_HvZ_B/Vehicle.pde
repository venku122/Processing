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
    maxVelocity, //Limit of the object's velocity
    safeDistance;

  boolean debug;


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
    safeDistance=100;
    acceleration=new PVector(0, 0);
    velocity = new PVector(0, 0);
    force = new PVector(0, 0);
    forward= new PVector(0, 0);
    right = new PVector(0, 0);
    debug=false;
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
    forward = velocity.copy().normalize();
    right = forward.copy().rotate(radians(90));

    //println("forward: "+forward+" right: "+right);
    //reset acceleration

    if (debug)
    {
      stroke(255, 0, 0);
      line(position.x, position.y, position.x+(forward.x*100), position.y+(forward.y*100));
      stroke(0, 255, 0);
      line(position.x, position.y, position.x+(right.x*100), position.y+(right.y*100));
    }
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
    desiredVelocity.normalize();
    desiredVelocity.mult(maxVelocity);
    PVector steeringForce = desiredVelocity.sub(velocity);
    steeringForce.limit(maxForce);
    return steeringForce;
  }
  
  PVector pursue(Vehicle v, int frames)
  {
    PVector target = v.position.copy().add(velocity.copy().mult(frames));
    return seek(target);
  }
  
  PVector evade(Vehicle v, int frames)
  {
    PVector target = v.position.copy().add(velocity.copy().mult(frames));
    return flee(target);
  }
  
  PVector wander(int frames, int radius)
  {
    PVector center = position.copy().add(velocity.copy().mult(frames));
    int direction = (int)random(0, 360);
    PVector vectToTarget = PVector.fromAngle(radians(direction));
    vectToTarget.setMag(radius);
    PVector target = center.copy().add(vectToTarget);
    return seek(target);
    
  }

  PVector flee(PVector target)
  {
    //write the code to seek a target!
    if (PVector.sub(target.copy(), position.copy()).mag()<radius*15);
    {
      if (debug)
      {
        noFill();
        stroke(4);
        ellipse(position.x, position.y, radius*15, radius*15);
      }
      PVector desiredVelocity= target.sub(position);
      desiredVelocity.setMag(maxVelocity);
      PVector steeringForce = desiredVelocity.sub(velocity);
      steeringForce.limit(maxForce);
      steeringForce.mult(-1);
      return steeringForce;
    }
  }
  void avoidBorder(int distance)
  {
    if (position.x > width-distance)
    {
      applyForce(seek(new PVector(width-distance, position.y)).mult(2));
    } else if (position.x < distance)
    {
      applyForce(seek(new PVector(distance, position.y)).mult(2));
    } else if (position.y > height-distance)
    {
      applyForce(seek(new PVector(position.x, height-distance)).mult(2));
    } else if (position.y < distance)
    {
      applyForce(seek(new PVector(position.x, distance)).mult(2));
    }
  }

  PVector avoidObstacle (Obstacle obst, float safeDistance)
  {
    PVector steer = new PVector(0, 0);
    // Create vecToCenter - a vector from the character
    //to the center of the obstacle
    PVector vectToCenter = position.copy();
    //vectToCenter.sub(obst.position);
    vectToCenter=obst.position.copy().sub(vectToCenter);
    // Find the distance to the obstacle
    float distance= vectToCenter.mag();
    // Return a zero vector if the obstacle is too far
    //to concern us Use safe distance to determine how large
    //the “safe zone” is 
    if (distance-(obst.size.x+radius)>safeDistance)
    {
      return new PVector(0, 0);
    }

    // Return a zero vector if the obstacle is behind us
    // (dot product of vecToCenter and forward is negative)
    if (vectToCenter.copy().dot(forward)<0)
    {
      return new PVector(0, 0);
    }
    // Use the dot product of the vector to obstacle center
    //(vecToCenter) and the unit vector
    // to the right (right) of the vehicle to find the distance 
    //between the centers of the vehicle and the obstacle 
    distance=vectToCenter.copy().dot(right);

    // Compare this to the sum of the radii and return a zero vector
    //if we can pass safely
    if (distance>radius+obst.size.x)
    {
      return new PVector(0, 0);
    }

    // If we get this far we are on a collision course and must steer away! 
    // Use the sign of the dot product between the vector to center 
    //(vecToCenter) and the      //   vector to the right (right) to
    //determine whether to steer left or right
    PVector desiredVelocity = new PVector(0, 0);
    if (distance>0)
    {
      desiredVelocity = right.mult(-maxVelocity);
    } else if (distance<0)
    {
      desiredVelocity = right.mult(maxVelocity);
    }
    steer=PVector.sub(desiredVelocity, velocity);
    //steer.mult(distance);
    // For each case calculate desired velocity using the right vector
    //and maxSpeed Compute the force required to change current velocity
    //to desired velocity Consider multiplying this force by
    //safeDistance/dist to increase the relative weight // 
    //of the steering force when obstacles are closer.
    stroke(0, 0, 255);
    line(position.x, position.y, position.x+vectToCenter.x, position.y+vectToCenter.y);
    return steer;
  }
}