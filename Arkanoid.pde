// true wenn the game must be displayed
// false when the instruction window must be displayed
boolean window = false;

// contains copy of the blocks
ArrayList<ArrayList<Block>> tempBlocks;

// instance of the game
Game game = new Game();

// whether the ball ist still or not
boolean ballStill = true;

// whether it's time to restart the game
boolean restart = false;

// number of destroyed
int blocks_destroyed=0;

// score of the game
// when a block is hit after leaving the paddle, it gives 1 point
// the more blocks are hit before the ball's return to the paddle, the more points are scored after hitting a block
int score=0;

// how many times the ball hits the paddle
int paddle_hit_num=0;

void setup(){
  size(800,600);
  background(50);
  fill(180);
  frameRate(100);
  smooth();
  noStroke();
  
  if(game.ball.lost)
    setupLoss();
  else if(!window)
    setupMainMenu();
}

void setup(ArrayList<ArrayList<Block>>blocks_){
  size(800,600);
  background(50);
  fill(180);
  stroke(255);
  if(!game.ball.lost)
    if(!window)
      setupMainMenu();
    else
      game.setupGame(blocks_);
}

void draw(){
  if(blocks_destroyed==177){
    setup();
    drawWin();
  }
  else if(!game.ball.lost){
    setup(game.blocks);
    if(!window)
      drawMainMenu();
    else
      game.draw(ballStill);
  }
  else{
    setup();
    drawLoss();
  }
}

void keyPressed(){
  if(blocks_destroyed==177 && key=='r'){
    restart = false;
    ballStill = true;
    window = false;
    blocks_destroyed=0;
    score=0;
    paddle_hit_num=0;
    game = new Game();
    restart();
  }
  else if(!game.ball.lost){
    if(!window){
        window=true;
        restart();
      }
      else if(key=='p'){
        window=false;
        tempBlocks=new ArrayList<ArrayList<Block>>();
        for(int i=0;i<game.blocks.size();i++){
          tempBlocks.add(new ArrayList<Block>());
          for(int j=0;j<game.blocks.get(i).size();j++)
            tempBlocks.get(i).add(game.blocks.get(i).get(j));
        }
        restart();
      }
      else if(key=='c'){
        window=true;
        restart(tempBlocks);
      }
      else if(key==CODED && keyCode==LEFT && game.paddle.location.x>=10){
        game.paddle.move_left();
        if(game.ball.still)
          game.ball.move_still((-1)*game.paddle.speed);
        restart(game.blocks);
      }
      else if(key==CODED && keyCode==RIGHT && game.paddle.location.x<=689){
        game.paddle.move_right();
        if(game.ball.still)
          game.ball.move_still(game.paddle.speed);
        restart(game.blocks);
      }
  }
  else if(key=='r'){
        restart = false;
        ballStill = true;
        window = false;
        blocks_destroyed=0;
        score=0;
        paddle_hit_num=0;
        game = new Game();
        restart();
  }
}

void mouseMoved(){
  if(window && game.ball.still)
    restart(game.blocks);
}

void mousePressed(){
  if(game.ball.still){
    ballStill=false;
    game.ball.still=false;
    //game.ball.still=false;
    game.ball.startAngle=atan2(game.ball.location.y-mouseY,game.ball.location.x-mouseX);
    println(degrees(game.ball.startAngle));
  }
  restart(game.blocks);
}

// reload the game
void restart(){
  setup();
  draw();
}

// reload the game with the old status of the blocks
void restart(ArrayList<ArrayList<Block>>blocks_){
  setup(blocks_);
  game.draw(ballStill);
}
