import SimpleOpenNI.*;
SimpleOpenNI kinect;

ArrayList<Particle> particles;

int closestValue;
int closestX;
int closestY;

void setup(){
 size(640,360);
  kinect = new SimpleOpenNI(this);
   kinect.enableDepth(); 
     particles = new ArrayList<Particle>();
  
}

void draw(){
 closestValue = 4000;
  kinect.update();
   int[] depthValues = kinect.depthMap();
    for(int y = 0;y<360; y++){
     for(int x = 0;x<640; x++){
      int i = x + y*640;
       int currentDepthValue = depthValues[i];
      
        if(currentDepthValue>0 && currentDepthValue < closestValue){
         closestValue = currentDepthValue;
         closestX = x;
         closestY = y;
        } 
     }
    } 
    image(kinect.depthImage(),0,0);
    particles.add(new Particle(new PVector(closestX, closestY)));
    
      for(int i=0; i<particles.size(); i++){
       Particle p = particles.get(i);
        p.run();
         if(p.isDead()){
          particles.remove(i);
         } 
      }
  //image(kinect.depthImage(),0,0);
   // fill(155,150,200);
   // ellipse(closestX, closestY,25,25);
  
}
