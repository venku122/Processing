class Box
{
  int xPos;
  int yPos;
  int xLength;
  int yWidth;
  color boxColor;
  Box(int w, int h )
  {
    xPos=0;
    yPos=0;
    xLength=w;
    yWidth=h;
    boxColor=color(255);
  }

  void setPos(int x, int y)
  {
    xPos=x;
    yPos=y;
  }

  boolean intersects(Box b)
  {
    if (b.xPos < (xPos+xLength))
    {
      if ((b.xPos+b.xLength)>xPos)
      {
        if ( b.yPos<(yPos+yWidth))
        {
          if ((b.yPos+b.yWidth)>yPos)
          {
            return true;
          }
        }
      }
    }
    return false;
  }
  
  void display()
  {
   fill(boxColor);
   rect(xPos, yPos, xLength, yWidth);
  }
  
}