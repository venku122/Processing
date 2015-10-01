class Raft
{
  //position of the boat
  int xPos;
  int yPos;

  //PShapes making up the oars
  PShape oar2;
  PShape body;
  PShape oar1;
  PShape oar3;
  PShape oar4;
  PShape oar5;
  PShape oar6;

  //variables for perlin noise movement
  float time;
  float timeStep;

  //boat dimensions
  int boatWidth;
  int boatLength;

  //initaial oar position
  int oarPositionX;
  int oarPositionY;

  //animation variables
  float rotation;
  float rowSpeed;
  boolean animation;


  ///Creates a raft at a given x and y position and initializes the perlin noise function
  Raft(int x, int y, float t, float f)
  {
    xPos=x;
    yPos=y;

    boatWidth=50;
    boatLength=70;

    oarPositionX=boatWidth;
    oarPositionY=boatLength;

    time=t;
    timeStep=f;

    rotation=0;
    rowSpeed=0.1;
    animation=true;


    body=createShape(RECT, 0, 0, boatWidth, boatLength);
    body.setFill(color(#663300));

    oar1=createShape(RECT, 0, 0, 10, 15);
    oar2=createShape(RECT, 0, 0, 10, 15);
    oar3=createShape(RECT, 0, 0, 10, 15);
    oar4=createShape(RECT, 0, 0, 10, 15);
    oar5=createShape(RECT, 0, 0, 10, 15);
    oar6=createShape(RECT, 0, 0, 10, 15);



    noise(time);
    time+=timeStep*height;
  }

  void display()
  {//comments
    time+=timeStep;


    pushMatrix();
    translate(noise(time)*600+200, height/2);
    shape(body);
    popMatrix();

    //Right Side Oars
    rotateOar(oar1, 0, 0, 270);
    rotateOar(oar2, 0, -30, 270);
    rotateOar(oar3, 0, -60, 270);

    //Left Side Oars
    rotateOar(oar4, -boatWidth, 0, 90);
    rotateOar(oar5, -boatWidth, -30, 90);
    rotateOar(oar6, -boatWidth, -60, 90);
  }

  ///animates the oars on the boat
  void rotateOar(PShape shape, int x, int y, int r)
  {
    shape.setFill(color(#F4A460));
    pushMatrix();
    translate(noise(time)*600+200, height/2);
    translate(oarPositionX +x, oarPositionY+y);
    rotate(radians(r));
    
    //provides cyclic motion
    if (animation)
    {
      rotate(rotation/12);
      rotation+=rowSpeed;
      if (rotation>15)
      {
        animation=false;
      }
    }

    if (!animation)
    {
      rotate(rotation/12);
      rotation-=rowSpeed;
      if (rotation<-15)
      {
        animation=true;
      }
    }

    shape(shape);
    popMatrix();
  }
}