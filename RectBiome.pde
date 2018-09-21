public class RectBiome{
  PVector topLeftCorner;
  int extensionX;
  int extensionY;
  ArrayList<RectLand> ground = new ArrayList();
  ArrayList<RectFood> commonCanteen;
  final int dimY=100;
  
  
public RectBiome(PVector topLeftCorner, int extX, int extY, ArrayList<RectFood> commonCanteen){
  this.commonCanteen=commonCanteen;
  PVector cursor = new PVector(topLeftCorner.x,topLeftCorner.y);
  
  this.topLeftCorner = topLeftCorner;
  this.extensionX=extX;
  this.extensionY=extY;
  while(cursor.y+100<extY){
    while(cursor.x+150<extX){
      int dimX=(int)random(100,150);
      
      ground.add(new RectLand(new PVector(cursor.x,cursor.y),dimX,dimY,(int) random(0,10),commonCanteen));
      cursor.x+=dimX;
    }
    cursor.y+=dimY;
    cursor.x = topLeftCorner.x;
    
  }

}  
  
  
public void update(){
  
  for(RectLand l : ground){
    
    l.update();
  }

}  
 
}