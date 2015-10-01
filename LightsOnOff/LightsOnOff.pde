Switch mySwitch;
int backgroundColor;
void setup()
{
  size(1000, 1000);
  mySwitch = new Switch(width/2, height/2, color(255,0,0));
  backgroundColor=0;
}

void draw()
{
  background(backgroundColor);
  mySwitch.display();
}
void mousePressed()
{
  if((mouseX>mySwitch.xPos)&&(mouseX<mySwitch.finalX)&&(mouseY>mySwitch.yPos)&&(mouseY<mySwitch.finalY))
  {
  backgroundColor+=255;
  if(backgroundColor>255)
  {
    backgroundColor=0;
  }
  }
}