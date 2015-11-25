class Menu
{
  public ArrayList<Obstacle> obstacles;
  ArrayList<Zombie> zombies;
  ArrayList<Human> humans;
  ArrayList<Button> buttons;
  boolean debugNumber=false;

  Menu(ArrayList<Obstacle>obs, ArrayList<Zombie> zom, ArrayList<Human> hum)
  {
    obstacles=obs;
    zombies=zom;
    humans=hum;
    buttons=new ArrayList<Button>();


    Button debug= new Button(50, 30, 100, 60, color(125, 125, 125), "Debug");
    buttons.add(debug);

    Button spawnZombie= new Button(160, 30, 200, 60, color(125, 125, 125), "Spawn Zombie");
    buttons.add(spawnZombie);

    Button spawnHuman = new Button(160, 100, 200, 60, color(125, 125, 125), "Spawn Human");
    buttons.add(spawnHuman);

    Button increaseVelocityHuman = new Button(370, 30, 350, 60, color(125, 125, 125), "Increase Human MaxVelocity");
    buttons.add(increaseVelocityHuman);

    Button decreaseVelocityHuman = new Button(370, 100, 350, 60, color(125, 125, 125), "Decrease Human MaxVelocity");
    buttons.add(decreaseVelocityHuman);

    Button fastSim = new Button( 730, 30, 100, 60, color(125, 125, 125), "Sim++");
    buttons.add(fastSim);

    Button slowSim = new Button(730, 100, 100, 60, color(125, 125, 125), "Sim--");
    buttons.add(slowSim);
  }

  void update()
  {

    if (mousePressed&&frameCount%15==0)
    {

      if (buttons.get(0).isClicked())
      {
        debugNumber=!debugNumber;

        for (int i=0; i<zombies.size(); i++)
        {
          zombies.get(i).debug=!zombies.get(i).debug;
        }
        for (int i=0; i<humans.size(); i++)
        {
          humans.get(i).debug=!humans.get(i).debug;
        }
        for (int i=0; i<obstacles.size(); i++)
        {
          obstacles.get(i).debug=!obstacles.get(i).debug;
        }
      }
      if (buttons.get(1).isClicked())
      {
        boolean debug=false;
        if (zombies.size()>0)
        {
          debug=zombies.get(0).debug;
        }

        Zombie z = new Zombie((int)random(200, width-200), (int)random(200, height-200), 40, 6, 0.1);
        z.debug=debug;
        zombies.add(z);
      }
      if (buttons.get(2).isClicked())
      {
        boolean debug=false;
        if (humans.size()>0)
        {
          debug=humans.get(0).debug;
        }
        Human h = new Human((int)random(200, width-200), (int)random(200, height-200), 30, 4, 0.2, humanAnimation);
        h.debug=debug;
        humans.add(h);
      }
      if (buttons.get(3).isClicked())
      {
        for (int i=0; i<humans.size(); i++)
        {
          humans.get(i).maxVelocity+=0.1;
        }
      }
      if (buttons.get(4).isClicked())
      {
        for (int i=0; i<humans.size(); i++)
        {
          humans.get(i).maxVelocity-=0.1;
        }
      }

      if (buttons.get(5).isClicked())
      {
        frameRate(frameRate+=5);
      }

      if (buttons.get(6).isClicked())
      {
        frameRate(frameRate-=5);
        if (frameRate<=1) frameRate=1;
      }
    }
  }
  void display()
  {
    for (int i=0; i<buttons.size(); i++)
    {
      buttons.get(i).display();
    }
    if (debugNumber)
    {
      text("Humans: "+humans.size()+" Zombies: "+zombies.size(), width/2, 200);
    }
  }
}