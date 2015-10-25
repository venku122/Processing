class Menu
{
  public ArrayList<Obstacle> obstacles;
  ArrayList<Zombie> zombies;
  ArrayList<Human> humans;
  ArrayList<Button> buttons;
  Menu(ArrayList<Obstacle>obs, ArrayList<Zombie> zom, ArrayList<Human> hum)
  {
    obstacles=obs;
    zombies=zom;
    humans=hum;
    buttons=new ArrayList<Button>();
    Button debug= new Button(50, 30, 100, 60,color(125,125,125), "Debug");
    buttons.add(debug);
    
    Button spawnZombie= new Button(160, 30, 200, 60,color(125,125,125), "Spawn Zombie");
    buttons.add(spawnZombie);
  }

  void update()
  {


    if (mousePressed&&frameCount%15==0)
    {
      if (buttons.get(0).isClicked())
      {
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
    }
  }
  void display()
  {
    for (int i=0; i<buttons.size(); i++)
    {
      buttons.get(i).display();
    }
  }
}