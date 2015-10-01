//Provides forces and vectors for moving objects
class GameObject
{
  
  PVector position, //Position of the object on the screen
  velocity, //rate of change of position 
  acceleration, //rate of change of velocity this frame
  direction, //direction that the object is facing
  force,  //net force acting on the object this frame
  size, //dimensions of the ship
  min, // minimum bounding of the ship
  max; //maximum bounding of the ship
  float mass, //Mass of the object, used for physics
  maxVelocity; //Limit of the object's velocity
  color c;

//Creates a new game object at the given x and y
  GameObject(int x, int y, float m)
  {
    position= new PVector(x, y);
    velocity= new PVector(0, 0);
    acceleration  = new PVector(0, 0);
    direction = PVector.fromAngle(radians(-90));
    size =new PVector(50, 50);
    force= new PVector(0, 0);

    //Defines bounding box
    min= new PVector();
    max= new PVector();
    min.x=position.x;
    min.y=position.y;
    max.x=position.x+size.x;
    max.y=position.y+size.y;


    mass=m;
    maxVelocity=7;
  }

//Overriden in child classes
  void display()
  {
  }

//Updates the state of the object
  void update()
  {
    acceleration=force.div(mass); //F=ma
    velocity.add(acceleration);//updates velocity
    velocity.limit(maxVelocity);//Limits velocity
    position.add(velocity);//Updates position

    //Updates bounding box
    min.x=position.x;
    min.y=position.y;
    max.x=position.x+size.x;
    max.y=position.y+size.y;
    edgeCheckWrap();

    //Resets per frame values
    acceleration.mult(0);
    force.mult(0);
  }

//Adds a force to the object in the given direction
  void addForce(float f, float d)
  {
    PVector temp = PVector.fromAngle(d);
    temp.mult(f);
    force.add(temp);
  }

//Causes the object to wrap around the screen
  void edgeCheckWrap()
  {
    if (position.x<-size.x)
    {
      position.x=width;
    }
    if (position.x>width)
    {
      position.x=0;
    }

    if (position.y<-size.y)
    {
      position.y=width;
    }
    if (position.y>height)
    {
      position.y=0;
    }
  }
  
  //Causes the object to bound around inside the screen
  //Unused
   void edgeCheckBounce()
  {
    if (position.x<0)
    {
      position.x=0;
      velocity.x=-velocity.x;
    }
    if (position.x>width-size.x)
    {
      position.x=width-size.x;
      velocity.x=-velocity.x;
    }

    if (position.y<0)
    {
      position.y=0;
      velocity.y=-velocity.y;
    }
    if (position.y>height-size.y)
    {
      position.y=height-size.y;
      velocity.y=-velocity.y;
    }
  }
  //Uses AABB to check for collisions
  boolean checkCollision(GameObject b)
  {
    if (b.min.x<max.x)
    {
      if (b.max.x>min.x)
      {
        if (b.min.y<max.y)
        {
          if (b.max.y>min.y)
          {
            return true;
          }
        }
      }
    }
    return false;
  }
}