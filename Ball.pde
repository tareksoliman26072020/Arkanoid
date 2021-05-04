class Ball{
  
  // location of the ball
  PVector location;
  
  // speed of the ball
  float speed;
  
  // radius of the ball
  float r=6.5;
  
  // whether the ball is still on the paddle or not
  boolean still;
  
  // the angle with which the ball is moving
  float startAngle;
  
  // whether the game is lost
  boolean lost=false;
  
  // current streak
  int streak=0;
  
  /**
  * whether the ball is moving to the left or to the right
  * true=left
  * false=right
  */
  boolean direction;
  
  /**
  * whether the ball is moving upwards or downwards
  * true=up
  * false=down
  */
  boolean direction2=true;
  
  Ball(int x) {
    location=new PVector(x, 572);
    speed=3;
    still=true;
  }
  
  // it deals with different angles of the moving ball
  void draw(boolean still, int reflect_direction, float paddleX){
    this.still=still;
    //setup();
    noStroke();
    fill(170);
    ellipse(location.x, location.y, r*2, r*2);
    point(location.x, location.y);
    if(still){
      prepareToLunch();
    }
    else if(reflect_direction==0){
      if(degrees(startAngle)>0 && degrees(startAngle)<=90)
        direction=true;
      else if(degrees(startAngle)>90 && degrees(startAngle)<=180)
        direction=false;
      else if(degrees(startAngle)>180 && degrees(startAngle)<=270)
        direction=false;
      else if(degrees(startAngle)>270 && degrees(startAngle)<=360)
        direction=true;
      /*else if(startAngle>=2*PI){
        while(startAngle>=2*PI) startAngle -= 2*PI;
      }
      else if(startAngle<=(-1)*2*PI){
        while(startAngle<=(-1)*2*PI) startAngle += 2*PI;
      }*/
      if(location.x>=8 && location.x<=792 && location.y>=8 && location.y<=572){
        if(degrees(startAngle)>=0 && degrees(startAngle)<90 && direction2){
          location.x -= speed*cos(startAngle);
          location.y -= speed*sin(startAngle);
        }
        else if(degrees(startAngle)==90 && direction2){
          location.x -= speed;
        }
        else if(degrees(startAngle)>90 && degrees(startAngle)<=180 && direction2){
          location.x -= speed*cos(startAngle);
          location.y -= speed*sin(startAngle);
        }
        else if(degrees(startAngle)<=0 && degrees(startAngle)>=-90 && !direction2){
          location.x += speed*cos(startAngle);
          location.y += (-1)*speed*sin(startAngle);
        }
        else if(degrees(startAngle)>=270 && !direction2){
          location.x += (-1)*speed*cos(startAngle);
          location.y -= speed*sin(startAngle);
        }
        else if(degrees(startAngle)>=180 && degrees(startAngle)<270 && !direction2){
          location.x += (-1)*speed*cos(startAngle);
          location.y += (-1)*speed*sin(startAngle);
        }
        else println(String.format("MyException: degree: %f\tdirection:",degrees(startAngle))+direction+"\tdirection2:"+direction2);
      }
      else
        if(location.x<8 && direction2){ //hitting the left wall
          startAngle = PI - startAngle;
          location.x += (-1)*speed*cos(startAngle);
          location.y -= speed*sin(startAngle);
          direction=true;
        }
        else if(location.x>792 && direction2){ //hitting the right wall
          startAngle = PI-startAngle;
          location.x -= speed*cos(startAngle);
          location.y -= speed*sin(startAngle);
          direction=false;
        }
        else if(location.y<8 && !direction){ //hitting the ceiling
          startAngle = 2*PI-startAngle;
          location.x += speed*cos(startAngle);
          location.y += (-1)*speed*sin(startAngle);
          direction2=false;
        }
        else if(location.y<8 && direction){ //hitting the ceiling
          startAngle = 2*PI-startAngle;
          location.x += (-1)*speed*cos(startAngle);
          location.y += (-1)*speed*sin(startAngle);
          //direction=false;
          direction2=false;
        }
        else if(location.x<8 && direction){
          startAngle = PI + 2*PI - startAngle;
          location.x += (-1)*speed*cos(startAngle);
          location.y += (-1)*speed*sin(startAngle);
          direction = false;
        }
        else if(location.x>792 && !direction2 && !direction){
          startAngle = PI/2 + startAngle;
          location.x += (-1)*speed*cos(startAngle);
          location.y -= (-1)*speed*sin(startAngle);
          direction = true;
        }
        else if(location.y>572 &&
                location.x>=paddleX && location.x<=paddleX+100){
          paddle_hit_num++;
          streak=0;
          if(direction && !direction2){
            startAngle = PI - (startAngle - PI);
            location.y -= 7;
            location.x -= speed*cos(startAngle);
            location.y -= speed*sin(startAngle);
            direction2=true;
          }
          else if(!direction && !direction2){
            startAngle = PI - (startAngle - PI);
            location.y -= 7;
            location.x -= (-1)*speed*cos(startAngle);
            location.y += speed*sin(startAngle);
            direction2=true;
          }
        }
        else if((location.x<paddleX || location.x>paddleX+100) &&
                (location.y>572)){
          lost=true;
        }
    }
    
    else if(reflect_direction==1 || reflect_direction==2 || reflect_direction==3 || reflect_direction==4){
      blocks_destroyed++;
      streak++;
      score += streak;
      if(reflect_direction==1){ //hitting the down side of the block
          if(direction){ //going left
            startAngle = 2*PI-startAngle;
            location.x += (-1)*speed*cos(startAngle);
            location.y += (-1)*speed*sin(startAngle);
            direction2=false;
          }
          else{ //going right
            startAngle = 2*PI-startAngle;
            location.x += speed*cos(startAngle);
            location.y += (-1)*speed*sin(startAngle);
            direction2=false;
          }
      }
      else if(reflect_direction==2){ //hitting the left side of block
        if(!direction && direction2){
          startAngle = PI - startAngle;
          location.x -= speed*cos(startAngle);
          location.y -= speed*sin(startAngle);
          direction = true;
        }
        else if(!direction && !direction2){
          startAngle = PI/2 + startAngle;
          location.x += (-1)*speed*cos(startAngle);
          location.y -= (-1)*speed*sin(startAngle);
          direction = true;
        }
      }
      else if(reflect_direction==3){ //hitting the right side of block
        if(direction && direction2){ //going up
          startAngle = radians(180-degrees(startAngle));
          location.x += (-1)*speed*cos(startAngle);
          location.y -= speed*sin(startAngle);
          direction=true;
        }
        else if(direction && !direction2){ //going down
          startAngle = PI + 2*PI - startAngle;
          location.x += (-1)*speed*cos(startAngle);
          location.y += (-1)*speed*sin(startAngle);
          direction = false;
        }
      }
      else if(reflect_direction==4){
        if(!direction){
          startAngle = PI - (startAngle - PI);
          location.x -= (-1)*speed*cos(startAngle);
          location.y += speed*sin(startAngle);
          direction2 = true;
        }
        else{
          startAngle = PI - (startAngle - PI);
          location.x -= speed*cos(startAngle);
          location.y -= speed*sin(startAngle);
          direction2 = true;
        }
      }
    }
    else{
    }
  }

  // moves the ball alongside the paddle when the ball lays still
  void move_still(int i){
    this.location.x += i;
  }
  
  // draw a line ending with a triangle to choose the direction of the ball.
  // the chosen direction will determine the value of the variable: startAngle
  void prepareToLunch(){
    stroke(126);
    line(location.x,572,mouseX,mouseY);
    stroke(126);
    
    pushMatrix();
    translate(mouseX, mouseY);
    float a = atan2(location.x-mouseX, mouseY-572);
    rotate(a);
    line(0, 0, -10, -20);
    line(0, 0, 10, -20);
    popMatrix();
  }
}
