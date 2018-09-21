public class Bubblo{
final int SLOWDOWNTHRESHOLD =40;
final int PERCEPTIONFIELD = 200;
final float MAXFORCE = 15;
final float MAXSPEED = 2;
final int MAXSATIETY = 400;
final int MINSATIETY = 50;
final int STARVINGTAX = 10;
final int MAXMASS = 400;
final int MINMASS = 20;
final int MAXDIMENSION=40;
final int MINDIMENSION=10;
float impulsivity=1;
int dimension;
int mass;
int satiety;
String name;
PVector position = new PVector();
PVector velocity = new PVector();
PVector accelleration = new PVector();
boolean alive = true;
int starvationCounter = 0;
float angle = 0;




centredTriangle nose = new centredTriangle();




public Bubblo(int mass, int x, int y, String name){
  
  
  this.dimension = (int)map(mass,MINMASS,MAXMASS,MINDIMENSION,MAXDIMENSION);
  this.mass = mass;
  position.x = x;
  position.y = y;
  this.name = name;
  satiety = mass;
}

void update(ArrayList<RectFood> targets){
  
  
  
  if(alive()){
    velocity.x += accelleration.x;
    velocity.y += accelleration.y;
    position.x += velocity.x;
    position.y += velocity.y;
    angle = velocity.heading()+ PI/2;
    fill(255,250,12,map(satiety,0,MAXSATIETY,0,255));
    ellipse(position.x, position.y, dimension, dimension);
    seekAndSteer(targets);
    nose.update(position.x, position.y,dimension/10,angle);
    fill(map(satiety,MINSATIETY,MAXSATIETY,0,255));
    eat(targets);
    starv();
    ellipse(position.x, position.y, dimension/5, dimension /5);
    
  }
}


void applyForce(PVector force){
  force.div(mass/3);
  accelleration.x = force.x;
  accelleration.y = force.y;
}

void seekAndSteer(ArrayList<RectFood> targets){
  
  
  
  ArrayList<RectFood> perceivedTargets  = new ArrayList();
    
  for(RectFood t: targets){
    
      
    if(PVector.dist(t.position,position)<PERCEPTIONFIELD){
            
      perceivedTargets.add(t);
      
      }
          
    }
  
    RectFood near = checkNearest(perceivedTargets);
  
    
    impulsiveSteering(near);  
    
  
  
  
  
  
  
  
}

public void starv(){
  starvationCounter++;
  
  
  if(starvationCounter >=STARVINGTAX){
    starvationCounter = 0;
    satiety -= (satiety/MINSATIETY);
  }
  
  if (satiety > MAXSATIETY){
    satiety=MAXSATIETY;
  }
  
  if(satiety > 2* MAXSATIETY/3){
    fill(0,0,255);
  }else if(satiety > MAXSATIETY/2){
    fill(0,255,0);
  }else if(satiety > MAXSATIETY/3){
    fill(255,0,0);
  }else{
    fill(0);
  }
  
}

public void strategicSteering(ArrayList<RectFood> perceivedTargets){
  PVector desire = new PVector(0,0);
  for(RectFood pt: perceivedTargets){
      
      desire.add((PVector.sub(pt.position,position)));
    
    }
    
  
    desire.setMag(MAXSPEED);
  
   
    
  
  PVector action = PVector.sub(desire,velocity);
  action.limit(MAXFORCE);
  
  applyForce(action.mult(1-impulsivity));
  
  
}


public void impulsiveSteering(RectFood near){
  PVector desire = PVector.sub(near.position, position);
  
  if(desire.mag()<SLOWDOWNTHRESHOLD){
    desire.setMag(map(desire.mag(),0,SLOWDOWNTHRESHOLD,0, MAXSPEED));
    fill(0,0,255,255);
  }else{
    desire.setMag(MAXSPEED);
    fill(255,0,0,255);
  }
  
  PVector action = PVector.sub(desire,velocity);
  action.limit(MAXFORCE);
  
  applyForce(action.mult(impulsivity));
  

}


public void eat(ArrayList<RectFood> targets){
  RectFood target=checkNearest(targets);
  PVector distance = PVector.sub(target.position,position);
  if(distance.mag() < dimension/2 && target.name == "generic"){
    target.eat();
    satiety+=10;
   }
}

public boolean alive(){
  alive = satiety >=MINSATIETY;
  
  return alive;

}

public void printStatus(){
  System.out.println(name+" : "+satiety);

}


public RectFood checkNearest(ArrayList<RectFood> targets){
    RectFood min = new RectFood(position,"default");
    if(!targets.isEmpty()){
      min = targets.get(0);
    }
    for( RectFood target : targets){
    
      if((PVector.sub(target.position,position)).mag()<PVector.sub(min.position,position).mag()){
        min = target;
      }
    }
    
    return min;


}




private class centredTriangle{

  
  
  public centredTriangle(){
    
    
  }
  
  public void update(float x, float y, int radius, float alpha){
    
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(x,y);
    rotate(alpha);
    beginShape();
    vertex(0, -radius*3);
    vertex(-radius, radius*3);
    vertex(radius, radius*3);
    endShape(CLOSE);
    popMatrix();
   
  
  }
}


}
