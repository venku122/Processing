class Obstacle
{
  PVector position, size;
  PImage sprite;
  float radius;
  boolean debug;

  Obstacle(int x, int y, float r)
  {
    
    sprite = loadImage("treeSmall.png");
    size = new PVector(sprite.width+10, sprite.height+10);
    radius=size.x;
    position=new PVector(x,y);
    debug=false;
  
  }

  void display()
  {
    //fill(255, 0, 0);
    //ellipse(position.x, position.y, size.x, size.y); 
    imageMode(CENTER);
    image(sprite, position.x, position.y);
    if(debug)
    {
    ellipse(position.x, position.y, size.x, size.y);
    }
  }
}