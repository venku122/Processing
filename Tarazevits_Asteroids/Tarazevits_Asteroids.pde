//Basis for a Finite State Machine for modes of the game //<>//
enum Game_State
{
    START, 
    GAME, 
    CONTROLS, 
    LOSE
}


Game_State gameState;  //Tracks the State of the game

//Player object and score
Ship p;
int score;


//Font required for onscreen text input
PFont f;

//Allows for multiple key presses
boolean keys[];

//Creates Star Background
Stars star;

//Holds the bullets and asteroids
ArrayList<Asteroid> asteroids;
ArrayList<Bullet> bullets;

//Initializes the game's objects and sets the state to START
void setup()
{
  //Initializes window and state
  gameState=Game_State.START;
  size(1000, 1000);
  keys= new boolean[10];
  star= new Stars();

  //Creates a list and quadtree that holds all GameObjects
  asteroids = new ArrayList<Asteroid>();
  bullets = new ArrayList<Bullet>();

  //Initalizes the Player and creates Asteroid
  p=new Ship(width/2, height/2, 10); 
  createAsteroid(5);
  score=0;

  //Initializes font support
  f = createFont("Arial", 16, true); 
  textFont(f, 36)
    ;
}
//Draws the objects depending on the game state
void draw()
{

  //finite state machine for game modes
  //Switch caused errors with enum so FSM is implemented with IF/else
  if (gameState== Game_State.GAME)
  {
    //Create StarBackground Background
    background(0);
    if (frameCount%3==0)star.update();
    star.display();

    //Creates HUD
    fill(255);
    text("health: "+p.health, 10, 100);
    text("score: "+score, 10, 130);

    //Asteroids spawn every 5 seconds
    if (frameCount%300==0) createAsteroid(1);

    //Updates and displays Player
    p.display();
    p.update(keys);


    //Updates and Displays all asteroids
    for (int i = 0; i<asteroids.size(); i++)
    {      
      asteroids.get(i).update();
      asteroids.get(i).display();
    }

    //Bullet Collision Detections
    if (bullets.size()>0)
    {
      for (int i = bullets.size()-1; i>=0; i--)
      {
        if (bullets.get(i).edgeCheckDestroy()) //Bullets are destroyed once they cross the edge
        {
          bullets.remove(i);
        } else
        {
          //Updates and Displays Bullets
          bullets.get(i).update();
          bullets.get(i).display();


          for (int j=asteroids.size()-1; j>=0; j--)
          {
            if (bullets.get(i).checkCollision(asteroids.get(j)))
            {
              //If a bullet hits an asteroid, score is incremented
              //asteroid is destroyed and 3 child asteroids are created
              bullets.remove(i);
              asteroids.addAll(asteroids.get(j).splitAsteroid());
              asteroids.remove(j);
              score+=10;
              break;
            }
          }
        }
      }
    }
    //Checks for Collision between player and the asteroid
    for (int i = asteroids.size()-1; i>=0; i--)
    {
      Asteroid temp=asteroids.get(i);
      
        if (p.checkCollision(temp))
        {
          p.health-=25;
          asteroids.remove(i);
        }
      
    }
    //Limits gun to every quarter second
    if (keys[4]&&frameCount%15==0)
    {
      bullets.add(p.shoot());
    }
    //If the Player dies, the game ends
    if (p.health<=0) gameState=Game_State.LOSE;
  }
  //Draws menu items 
  else if (gameState==Game_State.START)
  {
    textFont(f, 60);
    background(0);
    if (frameCount%3==0)star.update();
    star.display();

    text("Super Amazing Asteroids!", 50, height/3);
    textFont(f, 36);
    text("Press Enter or r to Start", 55, height/3+100);
    text("Press e to show Controls", 55, height/3+200);
    
    if (keys[5]||keys[8]) gameState=Game_State.GAME;
    if (keys[6]) gameState=Game_State.CONTROLS;
    
  } else if (gameState== Game_State.CONTROLS)
  {
    background(0);
    if (frameCount%3==0)star.update();
    star.display();
    
    text("Press w to accelerate and s to decelerate", width/4, height/3); 
    text("Press a and d to rotate your ship", width/4, height/3+50); 
    text("Press spacebar to fire", width/4, height/3+100);
    text("Press Enter to Start", width/4, height/3+150); 
    text("Press Backspace to return to Main Menu", width/4, height/3+200);
    
    if (keys[5]||keys[8]) gameState=Game_State.GAME;
    if (keys[7]) gameState=Game_State.START;
    
  } else if (gameState == Game_State.LOSE)
  {
    background(0);
    if (frameCount%3==0)star.update();
    star.display();
    
    fill(255);
    text("GAME OVER", width/2, height/2-150);
    text("You have died", width/2, height/2 -100);
    text("Your score: "+score, width/2, height/2);
    text("Press Enter to play Again", width/2, height/2+100);
    
    if (keys[8])
    {
      //Resets game for another round
      p=new Ship(width/2, height/2, 10);
      score=0;
      asteroids.clear();
      createAsteroid(5);
      gameState=Game_State.GAME;
    }
  }
}


//Keeps track of which keys are down
void keyPressed()
{
  if (key =='w') keys[0]=true;
  if (key =='a') keys[1]=true;
  if (key =='s') keys[2]=true;
  if (key =='d') keys[3]=true;
  if (key ==' ') keys[4]=true;
  if (key=='r') keys[5]=true;
  if (key=='e') keys[6]=true;
  if (keyCode==BACKSPACE) keys[7]=true;
  if (keyCode==ENTER) keys[8]=true;
  if (keyCode==ESC) keys[9]=true;
}

//Keeps track of which keys are up
void keyReleased()
{
  if (key =='w') keys[0]=false;
  if (key =='a') keys[1]=false;
  if (key =='s') keys[2]=false;
  if (key =='d') keys[3]=false;
  if (key ==' ') keys[4]=false;
  if (key=='r') keys[5]=false;
  if (key=='e') keys[6]=false;
  if (keyCode==BACKSPACE) keys[7]=false;
  if (keyCode==ENTER) keys[8]=false;
  if (keyCode==ESC) keys[9]=false;
}

//Creates asteroids randomly that are spaced a certain distance away from the player
//To avoid collisions
void createAsteroid(int x)
{
  for (int i=0; i<x; i++)
  {
    PVector minimum, maximum;
    minimum= new PVector(p.position.x-200, p.position.y+200);
    maximum= new PVector(p.position.x+p.size.x+200, p.position.y+p.size.y+200);
    
    int randX, randY, choice;
    
    randX=0; 
    randY=0;
    
    //Determines which quadrant
    choice=(int)random(0, 4);
    
    if (choice==0)
    {
      randX=(int)random(0, minimum.x);
      randY=(int)random(0, minimum.y);
    }
    if (choice==1)
    {
      randX=(int)random(maximum.x, width);
      randY= (int)random(0, minimum.y);
    }
    if (choice==2)
    {
      randX=(int)random(0, minimum.x);
      randY=(int)random(maximum.y, height);
    }
    if (choice==3)
    {
      randX=(int)random(maximum.x, width);
      randY=(int)random(maximum.y, height);
    }


    Asteroid a= new Asteroid(randX, randY, 10); 
    
    //Applies a force directed towards the player
    PVector dir = PVector.sub(p.position, a.position);
    dir.normalize();
    a.addForce(10, dir.heading());
    
    asteroids.add(a);
  }
}