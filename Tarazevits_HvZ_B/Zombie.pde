class Zombie extends Vehicle
{
  //seeking target
  //set to null for now
  PVector target = null;

  //PShape to draw this seeker object
  PShape body;

  PShape z;

  //overall steering force for this Seeker accumulates the steering forces
  //  of which this will be applied to the vehicle's acceleration
  PVector steeringForce;

  Human h;

  PImage sprite;


  //---------------------------------------
  //Constructor
  //Seeker(x position, y position, radius, max speed, max force)
  //---------------------------------------
  Zombie(float x, float y, float r, float ms, float mf)
  {
    super(x, y, r, ms, mf);
    //call the super class' constructor and pass in necessary arguments


    //instantiate steeringForce vector to (0, 0)
    steeringForce= new PVector(0, 0);


    z=loadShape("zombie1.svg");
    sprite=loadImage("zombie3.png");
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

    if (h!=null)
    {
      PVector force = pursue(h, 10);

      //add the above seeking force to this overall steering force
      force.limit(maxForce);
      steeringForce.add(force.mult(0.4));
      for (int i=0; i<obstacles.size(); i++)
      {
        steeringForce.add(avoidObstacle(obstacles.get(i), safeDistance).mult(1.2));
      }

      //limit this seeker's steering force to a maximum force
      steeringForce.limit(maxForce);

      //apply this steering force to the vehicle's acceleration
      applyForce(steeringForce);
      //reset the steering force to 0
      steeringForce.mult(0);
    } else
    {
      applyForce((wander(10, (int)radius).mult(.5)));
      if (debug)
      {
        println("wander");
      }
    }

    applyForce(avoidBorder(150).limit(maxForce));
  }
  PVector seek(PVector target)
  {
    if (debug)
    {
      line(position.x, position.y, target.x, target.y);
    }
    return super.seek(target);
  }

  //Method: display()
  //Purpose: Finds the angle this seeker should be heading toward
  //         Draws this seeker as a triangle pointing toward 0 degreed
  //         All Vehicles must implement display
  void display() {

    //calculate the direction of the current velocity - this is done for you
    float angle = velocity.heading()+radians(90);  
    fill(255, 0, 0);

    //draw this vehicle's body PShape using proper translation and rotation
    shapeMode(CENTER);
    pushMatrix();
    translate(position.x, position.y);

    rotate(angle);
    /*
    noStroke();
     smooth();
     scale(.3);
     shape(z, 0, 0);
     */
    image(sprite, 0, 0);
    popMatrix();

    if (debug)
    {
      ellipse(position.x, position.y, radius, radius);
    }
  }

  void getClosest(ArrayList<Human> hs)
  {
    float distance =99999;
    int indexOfClosest= -1;
    for (int i=0; i<hs.size(); i++)
    {
      if (distance>PVector.sub(hs.get(i).position.copy(), position).mag())
      {
        distance=PVector.sub(hs.get(i).position.copy(), position).mag();
        indexOfClosest=i;
      }
    }
    if (indexOfClosest!= -1)
    {
      h=hs.get(indexOfClosest);
    }
  }
}