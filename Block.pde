class Block{
  
  // width of block
  private float w=60;
  
  // depth of block
  private float h=40;
  
  // x-coordinates of block
  private float x;
  // y-coordinates of block
  private float y;
  
  // whether the block is hit or not
  private boolean exists;
  
  Block(float x, float y){
    this.x=x;
    this.y=y;
    this.exists=true;
  }
  
  void draw(){
    if(exists){
      stroke(255);
      noStroke();
      fill(255);
    
      fill(255);
      rect(x,y,w,h,20);
    }
  }
  
  void setNotExists(){
    this.exists=false;
  }
  
  void setExists(){
    this.exists=true;
  }
}

// particle for when a block is hit
class Particle {
  // position of particle
  float x;
  float y;
 
  // size of particle
  final float w = 30;
  final float h = 30;
 
  // movement of particle
  float beginPos;
  float stopPos;
  float speedX = random(-9, 9);
  float speedY = random(-9, 9);
 
  // color of particle
  color cBall;
 
  // whether particle still exists
  boolean alive = true; 
 
  // age of particle
  float k=0;
 
  // constructor
  Particle(float tempX, float tempY,
           float tempBegin, float tempStop, 
           color tempcBall) {
    x = tempX;
    y = tempY;
    stopPos = tempStop+y; 
    cBall=tempcBall;
 
    // make slow particle faster
    if (abs(speedX) < .9) 
      speedX = random(1, 6);
    if (abs(speedY) < .9) 
      speedY = random(1, 6);
  }
 
  // moving the particle
  void moveThis() {
    x = x + speedX; 
    y = y + speedY;
    if (y > stopPos) {
      y = stopPos;
      alive = false;
    }
    // particle is now older
    k+=1.5;
  }
 
  // drawing the particle
  void display() {
    fill(cBall, 100-k);
    if (k>=100) 
      alive=false; 
    ellipse (x, y, w, h);
  }
}
