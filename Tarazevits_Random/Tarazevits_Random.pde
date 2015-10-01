//Object handling raft drawing and animation
Raft raft;

//Object handling river drawing and bird/cloud animation
River river;

//Sets window size and initalizes boat and river scene
void setup()
{
  size(1000, 1000, P2D);
  raft=new Raft(width/2, height/2, 15, 0.002);
  river=new River(15, 0.002);
}
//draws all parts of the scene
void draw()
{
  background(#526F35);
  river.display(); 
  raft.display();
}