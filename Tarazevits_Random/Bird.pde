class Bird
{
  //Position of the bird
  int xPos;
  int yPos;

  //Shape of the bird
  PShape box;

  //holds random movement value
  float move;

  //Creates bird at given x and y position
  Bird(int x, int y)
  {
    xPos=x;
    yPos=y;
  }

  //Displays the bird to the screen
  void display()
  {
    //gets a random value between 0 and 1
    move=random(1);

    //Directed random favoring downwards movement
    if (move>.6)
    {
      yPos++;
    } else if (move>.4)
    {
      xPos++;
    } else if (move>.2)
    {
      xPos--;
    } else if (move>0)
    {
      yPos++;
    }
    //Only draws object if visible onscreen
    if (yPos<height)
    {
      fill(#f0efe6);
      rect(xPos, yPos, 10, 10);
    }
  }
}