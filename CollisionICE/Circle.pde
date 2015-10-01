class Circle
{
  
  int radius;
  color circleColor;
  PVector position;  
  Circle(int r)
  {
    radius=r;
    position= new PVector(0,0);
    circleColor= color(255);
  }
  
  void setPos(int x, int y)
  {
    position.x=x;
    position.y=y;
  }
  
  boolean intersects(Circle b)
  {
    if(position.dist(b.position)<(b.radius+radius))
    {
      return true;
    }
    return false;
  }
  
  void display()
  {
    fill(circleColor);
    ellipseMode(RADIUS);
   ellipse(position.x, position.y, radius, radius); 
  }
 
}