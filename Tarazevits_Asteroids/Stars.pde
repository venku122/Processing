//Creates moving star background
class Stars
{
  ArrayList str;///Holds star positions

  Stars()
  {
    str=new ArrayList();
    //Each column has a random star at a random height
    for (int i=0; i<width; i++)
    {
      str.add(random(height));
    }
  }

//Draws small rectangles at each point
  void display()
  {


    for (int i=0; i<width; i++)
    {
      rectMode(CORNER);
      fill(255);
      rect((float)str.get(i), (float)i, 3, 3);
    }
  }

//Removes the top row and creates a new row
  void update()
  {
    str.remove(0);
    str.add(random(height));
  }
}