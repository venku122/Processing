int xPos;
int yPos;
float direction;
void setup()
{
  size(1000, 1000);
  background(255);
  xPos = 0;
  yPos = 0;
}

void draw()
{
  direction=random(1);
  if(direction<.4)
  {xPos+=1;}
  else if(direction<.8)
  {yPos+=1;}
  else if(direction<.9)
  {yPos-=1;}
  else if(direction<1)
  {xPos-=1;}
  
  if(xPos>1000) xPos=1000;
  if(yPos>1000)yPos=1000;
  if(xPos<0) xPos=0;
  if(yPos<0) yPos=0;
  strokeWeight(0);
  fill(255,0,0);
  //point(xPos, yPos);
  rect(xPos, yPos, 2, 2);
}