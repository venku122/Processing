int xPos;
int yPos;
void setup()
{
  size(1000, 1000);
  xPos=(int)random(0, 800);
  yPos=(int)random(0,800);
}
void draw()
{
  background(150);
  fill(color(255,0,0));
  if(frameCount%30==0)
  {
      xPos=(int)random(0, 800);
      yPos=(int)random(0,800);
  }
  rect(xPos, yPos, 200, 200);
}