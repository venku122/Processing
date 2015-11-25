class Human extends Vehicle
{
  //seeking target

  PVector target = null;

  //overall steering force for this Seeker accumulates the steering forces
  //  of which this will be applied to the vehicle's acceleration
  PVector steeringForce;

  //Target zombie
  Zombie z=null;

  //Array of animation PImages
  PImage[] animation;


  //---------------------------------------
  //Constructor
  //Human(x position, y position, radius, max speed, max force, animation array)
  //---------------------------------------
  Human(float x, float y, float r, float ms, float mf, PImage[] animation)
  {
    super(x, y, r, ms, mf);

    //instantiate steeringForce vector to (0, 0)
    steeringForce= new PVector(0, 0);
    this.animation=animation;
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
    if (debug)
    {
      println("position: " + position);
    }
    if (z!=null)
    {

      PVector force = evade(z, 10);

      force.limit(maxForce);
      //add the above seeking force to this overall steering force
      steeringForce.add(force.mult(0.4));
      for (int i=0; i<obstacles.size(); i++)
      {
        steeringForce.add(avoidObstacle(obstacles.get(i), safeDistance));
      }

      //limit this seeker's steering force to a maximum force
      steeringForce.limit(maxForce);

      //apply this steering force to the vehicle's acceleration
      applyForce(steeringForce);

      //reset the steering force to 0
      steeringForce.mult(0);
    } else
    {
      //wander if no target to evade
      applyForce(wander(10, (int)radius).mult(0.5));
    }
    applyForce(avoidBorder(150).limit(maxForce));
  }


  //Method: display()
  //Purpose: Finds the angle this seeker should be heading toward
  //         Draws this seeker as a triangle pointing toward 0 degreed
  //         All Vehicles must implement display
  void display() {

    //calculate the direction of the current velocity - this is done for you
    float angle = velocity.heading();  
    fill(255, 0, 0);

    //draw this vehicle's body PShape using proper translation and rotation
    pushMatrix();

    translate(position.x, position.y);
    rotate(angle);
    scale(.2);

    //Slows down the animation speed
    int frame = (frameCount%40)/2;
    imageMode(CENTER);
    image(animation[frame], 0, 0);
    popMatrix();

    if (debug)
    {
      ellipse(position.x, position.y, radius, radius);
      println(position);
    }
  }


  boolean checkCollision()
  {

    if (z!=null)
    {
      PVector distance = PVector.sub(z.position.copy(), position.copy());
      if (distance.mag()<radius+z.radius)
      {
        return true;
      }
    }
    return false;
  }

  void getClosest(ArrayList<Zombie> zm)
  {
    float distance =99999;
    Zombie closest=z;

    for (int i=0; i<zm.size(); i++)
    {
      if (distance>PVector.sub(zm.get(i).position, position.copy()).mag())
      {
        distance=PVector.sub(zm.get(i).position, position.copy()).mag();
        closest=zm.get(i);
      }
    }
    z=closest;
  }
}