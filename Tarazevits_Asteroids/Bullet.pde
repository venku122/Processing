//Bullets that are fired by the player
class Bullet extends GameObject
{

   //Vectors passed directly from Ship so the bullet inherits the Ship's velocity and direction
  Bullet(PVector p, PVector d, PVector v, float m)
  {
    //creates a default game object
    super(0, 0, 0);
    mass=m;
    position=p;
    position.x+=25;
    direction=d;
    velocity=v;
    size= new PVector(10, 10);
    maxVelocity=15;
    c=color(#FF6FFF);
  }

//Displays a rectangular bullet
  void display()
  {
    fill(c);
    rect(position.x, position.y, size.x, size.y);
  }

 
//Returns true if bullet is not on screen
  boolean edgeCheckDestroy()
  {
   // println("position is: " + position);
    if (position.x<(0))
    {
      return true;
    } else if (position.x>width-size.x)
    {
      return true;
    } else if (position.y<(0))
    {
      return true;
    } else if (position.y>height-size.y)
    {
      return true;
    } else
    {
      return false;
    }
  }
  
  //Overrides edgeCheckWrap to prevent the bullet from looping
  void edgeCheckWrap()
  {return;}
}