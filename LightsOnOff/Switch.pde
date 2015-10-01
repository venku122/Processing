class Switch
{
  int xPos;
  int yPos;
  int size;
  int finalX;
  int finalY;
  color switchColor;
  
  Switch(int x, int y, color c)
  {
    xPos =x;
    yPos=y;
    switchColor=c;
    size=100;
    finalX=xPos+size;
    finalY=yPos+size;
  }
  
  void display()
  {
    fill(switchColor);
    rect(xPos, yPos, size, size);
  }
}