PVector location, dimension, velocity, acceleration;
color rectColor;
float time, timeStep;
void setup()
{
  size(1000, 1000);
  location = new PVector(0, 0);
  dimension= new PVector(100, 100);
  velocity= new PVector(0.1, 0.1);
  acceleration= new PVector(0.05, 0.07);
  frameRate(120);
  time=0;
  timeStep=0.03;
}



void draw()
{

  velocity.add(acceleration);
  location.add(velocity);
  velocity.limit(10);
  /*
  if (location.x>width) location.x=0;
   if (location.y>height) location.y=0;
   */
  if (location.x>width)
  {
    velocity.x= (-velocity.x);
    acceleration.x=(-acceleration.x);
  }
  if (location.y>width)
  {
    velocity.y= (-velocity.y);
    acceleration.y=(-acceleration.y);
  }
  if (location.x<0)
  {
    velocity.x= (-velocity.x);
    acceleration.x=(-acceleration.x);
  }
  if (location.y<0)
  {
    velocity.y= (-velocity.y);
    acceleration.y=(-acceleration.y);
  }


  time+=timeStep;
  //rectColor=color(noise(time)*255, noise(time)*255, noise(time)*255);


  rectColor=color(random(0, 255), random(0, 255), random(0, 255));
  fill(rectColor, 30);
  noStroke();
  rect(location.x, location.y, dimension.x, dimension.y);
}