PVector[][] terrainMap;
 
void setup()
{
  size(1000,1000);

  generateMap(.001,.001);
}

void draw()
{
 background(125); 
 noStroke();
 for(int i=0; i<width; i++)
 {
    for(int j=0; j<height; j++)
    {
      PVector colorNum = terrainMap[i][j];
      color c= color(colorNum.x,colorNum.y,colorNum.z);
      set(i,j,c);
    }
 }
}

void generateMap(float x, float y)
{
  terrainMap= new PVector[width][height];
  noiseSeed((long)random(1000));
  noiseDetail((int)random(7,10), random(0,0.8));
  float xOff=x;
  float yOff=y;
  
 for(int i=0; i<width; i++)
 {
    yOff=y;
    for(int j=0; j<height; j++)
    {
      float noiseVal=noise(xOff, yOff)*255;
      //print(noiseVal+" ");
      if(noiseVal>255) noiseVal=255;
      if(noiseVal<0) noiseVal=0;
      //terrainMap[i][j]=new PVector(noiseVal,100,100);
       terrainMap[i][j]=new PVector(noiseVal,noiseVal, noiseVal);
      yOff=yOff+0.01;
    }
    xOff=xOff+.01;
 }
 println("Map Generated");
 
  
}

void keyPressed()
{
 generateMap(.001,.001); 
}