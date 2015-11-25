//Creates clickable buttons for the UI handler
class Button
{
  PVector position, size, rightBound;
  String buttonText;
  color buttonColor;
  
  //Creates a button at the designated position with the defined dimensions, color,
  //and button text
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

//Checks if mouse is inside the button
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