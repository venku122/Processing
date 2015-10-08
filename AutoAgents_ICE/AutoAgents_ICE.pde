
//Beginning to code autonomous agents
//Will implement inheritance with a Vehicle class and a Seeker class


Seeker s;
public ArrayList<Obstacle> obstacles;

void setup() {
  size(1000, 1000);
  s = new Seeker(500, 500, 6, 4, 0.1);
  obstacles= new ArrayList<Obstacle();
  for(int i=0; i<10; i++)
  {
    obstacles.add(new Obstacle((int)random(width), (int)random(height), 50));
  }
  
}

void draw() {
  background(255);
  
  // Draw an ellipse at the mouse location
  fill(0,255,0);
  ellipse(mouseX, mouseY, 50,50);
  
  //update the seeker - done for you
  s.update();
  s.display();
  println("position: "+s.position+" velocity: "+s.velocity+" acceleration: " +s.acceleration);
  for(int i=0; i<obstacles.length; i++)
  {
    obstacles[i].display();
  }
  
}