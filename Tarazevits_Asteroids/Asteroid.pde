//Asteroid is of base class GameObject
class Asteroid extends GameObject
{
  //Creates an asteroid at a specific position with a mass
  Asteroid( int x, int y, float m)
  {
    super(x, y, m);
    //Size dependant on mass, allows for smaller child asteroids
    size= new PVector(mass*7,mass*7);
    maxVelocity=5;
    c= color((int)random(25,256),(int) random(25,256),(int)random(25,256));
  }
  
  //Draws a rectangle at that position
  void display()
  {
    fill(c);
    rectMode(CORNER);
    rect(position.x, position.y, size.x, size.y);
  }
  
  //Creates three smaller asteroids in random directions
  ArrayList<Asteroid> splitAsteroid()
  {
    ArrayList<Asteroid> x = new ArrayList<Asteroid>();
    //Three levels of destruction
    if (mass>3)
    {
      for (int i=0; i<3; i++)
      {
        Asteroid temp = new Asteroid((int)position.x, (int)position.y, mass/2); 
        temp.addForce(10, random(360));
        x.add(temp);
      }
    }
    return x;
  }
}