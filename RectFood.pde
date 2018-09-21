public class RectFood{
  PVector position;
  int dimension = 2;
  boolean alive = true;
  String name;
  public RectFood(PVector position){
    
    this.position = position;
    name = "generic";
  }
  
  public RectFood(PVector position , String name){
    this.position = position;
    this.name = name;
  }
  
  public void update(){
    if(alive){
      fill(0,125,0);
      rect(position.x-dimension/2, position.y - dimension/2,
      dimension, dimension);
    }
  
  }
  
  public void eat(){
    
    alive = false;
  
  }
  
  public boolean isAlive(){
    
    return alive;
  
  }

}