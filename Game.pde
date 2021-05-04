class Game{
  
  // the blocks
  private ArrayList<ArrayList<Block>> blocks;
  
  // the paddle
  Paddle paddle=new Paddle(330);
  
  // the ball
  Ball ball=new Ball(380);
  
  // how many slowing block there is
  private int slowing_blocks_num;
  // how many explosive block there is
  private int explosive_blocks_num;
  
  // particles system
  ArrayList<Particle> Particles;
  int particle_begin_position;
  int particle_stop_position;
  
  float specific_moment;
  
  Game(){
    this.blocks = new ArrayList<ArrayList<Block>>();
    this.slowing_blocks_num = 10;
    this.explosive_blocks_num = 10;
    
    for(int i=0; i<7; i++){
      this.blocks.add(new ArrayList<Block>());
      //blocks.add(new Block(50+(i*63),50));
    }
    for(int i=0;i<7;i++)
      for(int j=0;j<11;j++){
        int coorX = 45+(j*65);
        int coorY = 50+(i*45);
        boolean isSpecial = int(random(3)) == 0 ? true : false;
        boolean whichSpecialBlock = int(random(2)) == 0 ? false : true;
        if(isSpecial && whichSpecialBlock && slowing_blocks_num-->0){
          blocks.get(i).add(new SlowingBlock(coorX,coorY));
        }
        else if(isSpecial && !whichSpecialBlock && explosive_blocks_num-->0){
          blocks.get(i).add(new ExplosiveBlock(coorX,coorY));
        }
        else
          blocks.get(i).add(new Block(coorX,coorY));
      }
    particle_begin_position = 0;
    particle_stop_position = height-30/2;
 
    Particles = new ArrayList();
  }
  
  void setupGame(ArrayList<ArrayList<Block>> blocks_){
    for(int i=0;i<blocks_.size();i++)
      for(int j=0;j<blocks_.get(i).size();j++)
        this.blocks.get(i).set(j,blocks_.get(i).get(j));
  }
  
  void draw(boolean still){
    textSize(15);
    text(String.format("score=%d",score),700,30);
    textSize(15);
    text(String.format("blocks destroyed=%d/177",blocks_destroyed),10,30);
    fill(255);
    for(int i=0; i<7; i++)
      for(int j=0; j<11; j++)
        blocks.get(i).get(j).draw();
    
    paddle.draw();
    ball.draw(still,reflect_direction(),paddle.location.x);
    
    for(int i = Particles.size()-1; i >= 0; i--) { 
        Particle particle = Particles.get(i);
        particle.moveThis(); 
        particle.display();
    } // for 
     
    // for-loop backward, because we are removing items from the list
    for(int i = Particles.size()-1; i >= 0; i--) { 
      Particle particle = Particles.get(i);
      if (!particle.alive) 
        Particles.remove(i);
    } // for 
  }
  
  /**
  * it tells which side of the block is hit
  * it destroy the hit block with an explosion
  * it minds special blocks too.
  * @return 0 hitting nothing
  * @return 1 hitting on the down side
  * @return 2 hitting on the left side
  * @return 3 hitting on the right side
  * @return 4 hitting on the upper side
  */
  int reflect_direction(){
    if(abs(millis()-specific_moment)>=10000f){
      ball.speed=3;
      
    }
    for(int i=0; i<blocks.size(); i++)
      for(int j=0; j<blocks.get(i).size(); j++)
        if(blocks.get(i).get(j).exists){
          if(ball.location.x>=blocks.get(i).get(j).x && ball.location.x<=blocks.get(i).get(j).x+60 &&
             ball.location.y-ball.r>=blocks.get(i).get(j).y && ball.location.y-ball.r<=blocks.get(i).get(j).y+40){ //down side of block
               destroyBlock(i,j);
               explosion(blocks.get(i).get(j).x,blocks.get(i).get(j).y);
               special_blocks(i,j);
               return 1;
          }
          if(ball.location.x+ball.r>=blocks.get(i).get(j).x && ball.location.x+ball.r<=blocks.get(i).get(j).x+60 &&
             ball.location.y>=blocks.get(i).get(j).y && ball.location.y<=blocks.get(i).get(j).y+40){               //left side of block
               destroyBlock(i,j);
               explosion(blocks.get(i).get(j).x,blocks.get(i).get(j).y);
               special_blocks(i,j);
               return 2;
          }
          if(ball.location.x-ball.r>=blocks.get(i).get(j).x && ball.location.x-ball.r<=blocks.get(i).get(j).x+60 &&
             ball.location.y>=blocks.get(i).get(j).y && ball.location.y<=blocks.get(i).get(j).y+40){               //right side of block
               destroyBlock(i,j);
               explosion(blocks.get(i).get(j).x,blocks.get(i).get(j).y);
               special_blocks(i,j);
               return 3;
          }
          if(ball.location.x>=blocks.get(i).get(j).x && ball.location.x<=blocks.get(i).get(j).x+60 &&
             ball.location.y+ball.r>=blocks.get(i).get(j).y && ball.location.y+ball.r<=blocks.get(i).get(j).y+40){ //upper side of block
               destroyBlock(i,j);
               explosion(blocks.get(i).get(j).x,blocks.get(i).get(j).y);
               special_blocks(i,j);
               return 4;
          }
        }
    return 0;
  }
  
  // destroy the block by changing the boolean value
  void destroyBlock(int i, int j){
    this.blocks.get(i).get(j).exists=false;
  }
  
  // explode the block in the given coordinates
  void explosion(float x, float y){
    color colorTemp = color(random(0, 255), random(0, 255), random(0, 255));
    for(int k=0; k<50; k++){
      Particles.add(new Particle(x+30, y+20,
                                 particle_begin_position, random(100, 200),colorTemp));
    }
  }
  
  // activates a special block in the position in the block's arraylist 
  void special_blocks(int i,int j){
    if(blocks.get(i).get(j) instanceof SlowingBlock){
      println("slowing block is hit");
      specific_moment = millis();
      ball.speed=1;
    }
    else if(blocks.get(i).get(j) instanceof ExplosiveBlock){
      println("explosive block is hit");
      destroy_neighbors(i,j);
    }
  }
  
  // destroy neighboring blocks when an explosive block is hit
  void destroy_neighbors(final int i,final int j){
    ArrayList<PVector> coors = new ArrayList<PVector>(){{
      add(new PVector(i-1,j-1));
      add(new PVector(i-1,j));
      add(new PVector(i-1,j+1));
      add(new PVector(i,j-1));
      add(new PVector(i,j+1));
      add(new PVector(i+1,j-1));
      add(new PVector(i+1,j));
      add(new PVector(i+1,j+1));
    }};
    for(PVector vector : coors){
      int x = (int)vector.x;
      int y = (int)vector.y;
      if(x<0 || y<0 || x>=7 || y>=11)
        continue;
      destroyBlock(x,y);
      explosion(blocks.get(i).get(j).x,blocks.get(i).get(j).y);
    }
  }
}
