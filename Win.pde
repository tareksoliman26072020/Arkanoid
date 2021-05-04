void setupWin(){

}

void drawWin(){
  textSize(60);
  text("you won",width/2-120,height/2-20);
  textSize(30);
  text(String.format("score:%d",score),width/2-70,height/2+100);
  text("press 'r' to restart",width/2-130,height/2+200);
}
