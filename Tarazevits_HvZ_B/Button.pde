class Button
{
  PVector position, size, rightBound;
  String buttonText;
  color buttonColor;
  Button(int x, int y, int w, int h, color c, String text)
  {
    position= new PVector(x, y);
    size=new PVector(w, h);
    rightBound= new PVector(position.x+size.x, position.y+size.y);
    buttonText=text;
    buttonColor=c;
  }

  void display()
  {
    fill(buttonColor);
    rect(position.x, position.y, size.x, size.y);
    textSize(24);
    fill(0,0,0);
    if (buttonText!=null)
    {
      text(buttonText, position.x+5, position.y+size.y/2);
    }
  }

  boolean isClicked()
  {
    if (mouseX>position.x&&mouseX<rightBound.x&&mouseY>position.y &&mouseY<rightBound.y)
    {
      return true;
    } else
    {
      return false;
    }
  }
}