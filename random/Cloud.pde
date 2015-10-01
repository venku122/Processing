class Cloud
{
  //position of cloud pieces
  int xPos;
  int yPos;
  int xPos2;
  int yPos2;
  int xPos3;
  int yPos3;

  //speed at which clouds move up the screen
  int movementSpeed;
  
  //size of cloud
  int radius;
  
  //Creates a cloud of random radius with 3 circles of random but close relative position
  Cloud()
  {
    xPos=(int)random(0, width);
    yPos=height;
    radius=(int)random(5, 50);
    
    xPos2=(int)random(xPos, xPos+radius);
    xPos3=(int)random(xPos, xPos+radius);
    yPos2=(int)random(yPos, yPos+radius);
    yPos3=(int)random(yPos, yPos+radius);
    
    movementSpeed=1;
  }
//Displays the three ellipses that make up the cloud
  void display()
  {
    fill(200, 200, 200, 128);
    
    ellipse(xPos, yPos, radius, radius);
    ellipse(xPos2, yPos2, radius, radius);
    ellipse(xPos3, yPos3, radius, radius);

    yPos-=movementSpeed;
    yPos2-=movementSpeed;
    yPos3-=movementSpeed;

//if 'w' is pressed, clouds speed up to a maximum of 10 pixels per frame
    if (keyPressed)
    {
      if (key=='w'&&frameCount%30==0)
      {
        movementSpeed++;
        if (movementSpeed>10)
        { 
          movementSpeed=10;
        }
      }
      //if 's' is pressed, clouds slow down to a minimum of 1 pixel per frame
      if (key=='s'&&frameCount%30==0)
      {
        movementSpeed--;
        if (movementSpeed<1)
        { 
          movementSpeed=1;
        }
      }
    }
  }
}