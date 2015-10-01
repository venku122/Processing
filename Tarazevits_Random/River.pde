class River
{
  //perlin noise variables
  float time;
  float timeStep;

  //Holds river body
  ArrayList shr;

  //holds the birds
  ArrayList<Bird> birds;

  //hold the clouds
  ArrayList<Cloud> clouds;

  //Initializes the river with a given initial time and timestep
  River(int t, float f)
  {
    time=t;
    timeStep=f;
    noise(time);

    birds=new ArrayList<Bird>();
    shr= new ArrayList();
    clouds= new ArrayList<Cloud>();

    //Fills up queue with a screen of perlin noise
    for (int i=0; i<height; i++)
    {
      time+=timeStep;
      shr.add(noise(time)*300);
    }
  }
  //Displays birds, rivers, and clouds
  void display()
  {
    stroke(#4B5769);

    //removes topmost river part
    shr.remove(0);

    time+=timeStep;
    shr.add(noise(time)*500);

    //creates two lines with endpoints defined by perlin noise
    for (int h=0; h<height; h++)
    {
      line((float)shr.get(h), (float)h, (float)width/2, (float)h);
      line((float)width/2, (float)h, (float)(width/2 + (float)shr.get(h)), (float)h);
    }
    //creates flock of birds every 5 seconds with gaussian distribution
    if (frameCount%300==0)
    {
      for (int i=0; i<5; i++)
      {
        birds.add(new Bird((int)randomGaussian()*100+(width/2), 0));
      }
    }
    //displays birds
    for (Bird b : birds)
    {
      b.display();
    }
    //displays clouds
    for (Cloud r : clouds)
    {
      r.display();
    }
    //if 'c' is pressed, creates a new cloud every 0.5 second
    if (keyPressed)
    {
      if (key=='c'&&frameCount%30==0)
      {
        clouds.add(new Cloud());
      }
    }
  }
}