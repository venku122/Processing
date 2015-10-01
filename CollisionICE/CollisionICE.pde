//true is circle, false is rectangular
boolean collision;
Box mouseBox;
Box centerBox;
Circle mouseCircle;
Circle centerCircle;

void setup()
{
  mouseBox= new Box(50, 50);
  centerBox= new Box(200, 200);
  centerBox.setPos(width/2, height/2);

  mouseCircle = new Circle(50);
  centerCircle = new Circle(200);
  centerCircle.setPos(width/2, height/2);

  size(1000, 1000);
  collision=true;
}
void draw()
{
  
  background(0);
  
  if(keyPressed)
  {
   collision=!collision; 
  }
  if (!collision)
  {
    mouseBox.setPos(mouseX, mouseY);
    centerBox.display();
    mouseBox.display();

    if (mouseBox.intersects(centerBox))
    {
      mouseBox.boxColor=color(255, 0, 0);
    } else
    {
      mouseBox.boxColor=color(255);
    }
  }
  if (collision)
  {
    mouseCircle.setPos(mouseX, mouseY);
    centerCircle.display();
    mouseCircle.display();

    if (mouseCircle.intersects(centerCircle))
    {
      mouseCircle.circleColor=color(255, 0, 0);
    } else
    {
      mouseCircle.circleColor=color(255);
    }
  }
 
 
}