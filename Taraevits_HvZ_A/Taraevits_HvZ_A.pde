
//Beginning to code autonomous agents
//Will implement inheritance with a Vehicle class and a Seeker class


Zombie z;
Human h;
public ArrayList<Obstacle> obstacles;

ArrayList<Zombie> zombies;
ArrayList<Human> humans;

void setup() {
  size(1000, 1000);

  obstacles= new ArrayList<Obstacle>();
  zombies = new ArrayList<Zombie>();
  humans = new ArrayList<Human>();
  /*
    zombies.add(z);
   humans.add(h);
   
   h.z=z;
   z.h=h;
   */

  for (int i=0; i<10; i++)
  {
    h = new Human((int)random(width), (int)random(height), 10, 4, 0.2);
    humans.add(h);
  }

  for (int i = 0; i<1; i++)
  {
    z = new Zombie(500, 500, 20, 6, 0.1);
    zombies.add(z);
  }

  for (int i=0; i<10; i++)
  {
    obstacles.add(new Obstacle((int)random(width), (int)random(height), 50));
  }
}

void draw() {
  background(255);
  rect(50, 30, 100, 60);
  if (mousePressed && mouseX>50&&mouseX<150&&mouseY>30&&mouseY<90&&frameCount%10==0)
  {
    for (int i=0; i<zombies.size(); i++)
    {
      zombies.get(i).debug=!zombies.get(i).debug;
    }
    for (int i=0; i<humans.size(); i++)
    {
      humans.get(i).debug=!humans.get(i).debug;
    }
  }


  for (int i =0; i<zombies.size(); i++)
  {
    zombies.get(i).getClosest(humans);
    zombies.get(i).update(); 
    zombies.get(i).display();
  }

  for (int i =0; i<humans.size(); i++)
  {
    humans.get(i).getClosest(zombies);
    humans.get(i).update(); 
    humans.get(i).display();
    if (humans.get(i).checkCollision())
    {
      Zombie x = new Zombie(humans.get(i).position.x, humans.get(i).position.y, 20, 4, 0.2);
      zombies.add(x);
      humans.remove(i);
    }
  }


  //println("position: "+s.position+" velocity: "+s.velocity+" acceleration: " +s.acceleration);
  for (int i=0; i<obstacles.size(); i++)
  {
    obstacles.get(i).display();
  }
}