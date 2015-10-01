//Represents the player in the game
class Ship extends GameObject
{
  int health; // player's health
  boolean keys[]; // local copy of key input
  
  Ship(int x, int y, float m) 
  {
    super(x, y, m);
    health=100;
    keys= new boolean[5];
    force = new PVector(0, 0);

  }

//Moves coordinate system to ship position then
//Creates ship at 0,0 relative to local coordinate system
//Allows for rotation of the ship and its bounding box
  void display()
  {
    noStroke();
    pushMatrix();
    
    translate(position.x+(size.x/2), position.y+(size.y/2));
    rotate(direction.heading());
    rectMode(CENTER);

    //Actual Ship Body
    fill(0, 255, 0);
    rect(10, 0, (size.x/2+10), (size.y/2)-15);
    fill(0, 0, 255);
    rect(-15, -10, size.x/4, size.y/2);
    rect(-15, 10, size.x/4, size.y/2);
    
    popMatrix();
  }

//Checks for user input and updates direction and applied forces
  void update(boolean[] keys)
  {
    super.update();
    if (keys[3])
    {
      direction.rotate(0.1);
    }
    if (keys[1])
    {
      direction.rotate(-0.1);
    }
    if (keys[0])
    {
      addForce(5, direction.heading());
    }
    if (keys[2])
    {
      addForce(5, direction.heading()+radians(180));
    }
  }

  
//Returns a bullet moving in the direction of the ship relative to the ship
  Bullet shoot()
  {
    Bullet b = new Bullet(position.copy(), direction.copy(), velocity.copy(), 3);
    b.addForce(100, direction.heading());
    return b;
  }
}