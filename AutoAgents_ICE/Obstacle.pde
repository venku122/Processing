class Obstacle
{
  PVector position, size;
 
  Obstacle(int x, int y, float r)
  {
    position=new PVector(x, y);
    size = new PVector(r,r);
  }
  
  void display()
  {
    fill(255,0,0);
   ellipse(position.x, position.y, size.x, size.y); 
  }
}