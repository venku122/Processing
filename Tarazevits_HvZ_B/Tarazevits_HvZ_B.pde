//Holds all objects in class specific arrayLists
public ArrayList<Obstacle> obstacles;
ArrayList<Zombie> zombies;
ArrayList<Human> humans;

//Array holding animation frames
PImage[] humanAnimation = new PImage[20];

//Generates UI elements and monitors interactions
Menu ui;

//Background image
PImage bg;

void setup() {
  //Sets renderer to JAVA2D
  size(1000, 1000, JAVA2D);

//itialization of Object lists
  obstacles= new ArrayList<Obstacle>();
  zombies = new ArrayList<Zombie>();
  humans = new ArrayList<Human>();

//initialization of ui handler
  ui = new Menu(obstacles, zombies, humans);
  
  //Loads animation frames to array
  for (int i=0; i<20; i++)
  {
    PImage x = loadImage("human/survivor-move_knife_"+i+".png");
    humanAnimation[i]=x;
  }
  
  //Loads background image
  bg = loadImage("grass.jpg");

  //Creates humans in the scene
  for (int i=0; i<10; i++)
  {
    
    Human h = new Human((int)random(200,width-200), (int)random(200, height-200), 30, 4, 0.1, humanAnimation);
    humans.add(h);
  }

  //Creates zombies in the scene,
  for (int i = 0; i<1; i++)
  {
    Zombie z = new Zombie(500, 500, 40, 3, 0.2);
    zombies.add(z);
    
    z= new Zombie(200,200, 40, 3, 0.2);
    zombies.add(z);
    
    z= new Zombie(width-200, height-200, 40,3,0.2);
    zombies.add(z);
  }

  //Creates randomly located obstacles
  for (int i=0; i<10; i++)
  {
    obstacles.add(new Obstacle((int)random(200,width-200), (int)random(200, height-200), 50));
  }
}

void draw() {
  //Draws background image
  background(bg);


//Updates and displays zombies 
  for (int i =0; i<zombies.size(); i++)
  {
    Zombie z= zombies.get(i);
    z.getClosest(humans);
    z.update(); 
    z.display();
    if (humans.size()==0)
    {
      z.h=null;
    }
  }

//Updates and displays zombies
  for (int i =0; i<humans.size(); i++)
  {
    Human h = humans.get(i);
    h.getClosest(zombies);
    h.update(); 
    h.display();
    //Handles collisions between humans and zombies
    if (h.checkCollision())
    {
      Zombie x = new Zombie(h.position.x, h.position.y, 40, 3, 0.2);
      x.debug=h.debug;
      zombies.add(x);
      humans.remove(i);
    }
  }

  //displays obstacles
  for (int i=0; i<obstacles.size(); i++)
  {
    obstacles.get(i).display();
  }

//Updates and displays the UI
  ui.update();
  ui.display();
}