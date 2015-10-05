
//Beginning to code autonomous agents
//Will implement inheritance with a Vehicle class and a Seeker class


Seeker s;

void setup() {
  size(1000, 1000);
  s = new Seeker(500, 500, 6, 4, 0.1);
}

void draw() {
  background(255);
  
  // Draw an ellipse at the mouse location
  fill(0,255,0);
  ellipse(mouseX, mouseY, 50,50);
  
  //update the seeker - done for you
  s.update();
  s.display();
  
}