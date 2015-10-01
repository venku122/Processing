Raft raft;
River river;
Cloud c;
void setup()
{
  size(1000, 1000, P2D);
  raft=new Raft(width/2, height/2, 15, 0.002);
  river=new River(15, 0.002);
   c = new Cloud();
 
}
void draw()
{
  background(#526F35);
  river.display(); 
  raft.display();
  c.display();

}