class chaser
{
  //Position of the bird
 int xPos;
 int yPos;
 
 PShape box;
 
 float move;
 
 chaser(int x, int y)
 {
   xPos=x;
   yPos=y;
 }
 
 void display()
 {
   
   move=random(1);
   if(move>.6)
   {
   yPos++;
   }
   else if(move>.4)
   {
   xPos++;
   }
   else if(move>.2)
   {
   xPos--;
   }
   else if(move>0)
   {
     yPos++;
   }
   if(yPos<height)
   {
     fill(#f0efe6);
      rect(xPos, yPos, 10, 10);
   }

 }
 
}