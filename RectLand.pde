public class RectLand{
  
final int MAXFOOD = 150;
int extensionX;
int extensionY;
PVector topLeftCorner;
int fertility;
int food;
ArrayList<RectFood> canteen = new ArrayList();
ArrayList<RectFood> commonCanteen;
ArrayList<RectFood> trash = new ArrayList();


public RectLand(PVector topLeft, int dimX,int dimY, int fertility, ArrayList<RectFood> commonCanteen){
  
  this.topLeftCorner = topLeft;
  extensionX = dimX;
  extensionY = dimY;
  this.fertility=fertility;
  this.commonCanteen=commonCanteen;
  food=0; 
}



public void update(){
  
  if(fertility==0){
    fill(50,100,255);
    stroke(50,100,255);
  }else if(fertility<3){
    fill(125);
    stroke(125);
  }else if(fertility<6){
    fill(0,170,0);
    stroke(0,170,0);
  }else{
    stroke(0,200,0);
    fill(0,200,0);
  }
  
  
  rect(topLeftCorner.x, topLeftCorner.y, extensionX,extensionY);
  randomFeed((fertility+0.5)/200.0);
  
  stroke(0);
  collectTrash(canteen);
  burnTrash(canteen);
  
  
}

public void randomFeed(float dropProbability){
  
  
  
  if(random(1)<dropProbability&&food<MAXFOOD){
    
    RectFood newFood =new RectFood(new PVector(
    random(topLeftCorner.x +1,topLeftCorner.x-1+extensionX),
    random(topLeftCorner.y +1,topLeftCorner.y-1+extensionY)));
    food++;
    canteen.add(newFood);
    commonCanteen.add(newFood);
    
    
  }

}

public void collectTrash(ArrayList<RectFood> canteen){
  for(RectFood f : canteen){
    if(!f.isAlive()){
      trash.add(f);
      food--;
    }
  }
}

public void burnTrash(ArrayList<RectFood> canteen){
  
  for(RectFood d : trash){
    canteen.remove(d);
    
  }
 
  
  trash = new ArrayList();

}


}
