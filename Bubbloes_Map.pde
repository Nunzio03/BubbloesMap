

int counter = 0;
float scale = 1;
int xPan=1550;
int yPan=900;
PVector origin = new PVector(0,0);
ArrayList<Bubblo> bubbloes = new ArrayList();
ArrayList<Bubblo> cemetery = new ArrayList();
ArrayList<RectFood> trash = new ArrayList();
ArrayList<RectFood> food = new ArrayList();
RectBiome biome1= new RectBiome(new PVector(50,50),700,1400,food);
RectBiome biome2= new RectBiome(new PVector(1500,500),3000,1280,food);
RectBiome biome3= new RectBiome(new PVector(2000,1400),3000,1700,food);



void setup(){
  
  
  
  frameRate(60);
  size(3100,1800);
 
 

}

void draw(){
  
  
  background(50,100,255);
  translate(width/2,height/2);
  scale(scale);
  translate(-xPan,-yPan);
  stroke(255);
  fill(0,0,0,0);
  rect(origin.x,origin.y,width,height);
  stroke(0);

  biome1.update();
  biome2.update();
  biome3.update();
  updateBubbloes(bubbloes,food);
  
  updateFoods(food);
    
  execute();
  
  
  fill(0,255,255);
  ellipse(mouseX,mouseY,10,10);
  randomBirth();
  
  System.out.println("amici: "+counter);

}


/////////////////////////////CONTROLLS

void keyPressed(){
  switch(keyCode){
    case UP:
      scale*=1.1;
      break;
    case DOWN:
      scale/=1.1;
      break;
  }
  if(scale<1){
    scale=1;
  
  }
  
  switch(key){
    case 'w':
      yPan-=40;
      break;
    case 's':
      yPan+=40;
      break;
    case 'a':
      xPan-=40;
      break;
    case 'd':
      xPan+=40;
      break;
    case 'c':
      xPan=1550;
      yPan=900;
      break;
    case 'x':
      xPan=1550;
      yPan=900;
      scale=1;
      break;
    case 'f':
      food.add(new RectFood(new PVector(mouseX, mouseY)));
      break;
   
  }
}

void mousePressed() {
    
    if(scale==1&&xPan==1550&&yPan==900){
      String name = "amico"+counter;
      counter++;
  
      bubbloes.add(new Bubblo((int)random(20,400),mouseX,mouseY,name));
      }
    
}


void randomBirth(){
  float r =random(1);
  
  if(r<0.02){

    if(scale==1&&xPan==1550&&yPan==900){
      String name = "amico"+counter;
      counter++;
  
      bubbloes.add(new Bubblo((int)random(20,400),(int)random(width),(int) random(height),name));
      }
  }

}


/////////////////////////////////////////////////////////////ARTIFICIAL DAEMONS



//////////////////////////////////////////////////////////UPDATE ROUTINES

void updateBubbloes(ArrayList<Bubblo> list, ArrayList<RectFood> target){

    for(Bubblo b : list){
    b.update(target);
    if(!b.alive()){
      deathCollector(b);
    }
  }
}

void updateFoods(ArrayList<RectFood> list){

    for(RectFood f : list){
    f.update();
    if(!f.isAlive()){
      trashCollector(f);
    }
  } 
}

///////////////////////////REMOVERS


void deathCollector(Bubblo bDead){
  cemetery.add(bDead);
}

void trashCollector(RectFood fDead){
  trash.add(fDead);
}


void execute(){
  
  for(Bubblo d:cemetery){
    bubbloes.remove(d);
    System.out.println(d.name+" is dead");
    counter--;
  }
  
  for(RectFood d : trash){
    food.remove(d);
  }
 
  cemetery = new ArrayList();
  trash = new ArrayList();
}
