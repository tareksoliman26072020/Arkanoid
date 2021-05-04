class ExplosiveBlock extends Block{

  // variables for color change of the block
  private float timeInterval;
  private float timePast;
  private int textAlpha = 50;
  private int textFade = 2;

  ExplosiveBlock(int x, int y){
    super(x,y);
    this.timePast = millis();
    this.timeInterval = 1000.0f;
  }

  @Override
  void draw(){
    if(millis() > timeInterval + timePast){
      timePast = millis();
      textFade *= -1;
    }
    textAlpha += textFade;
    fill(textAlpha);
    if(super.exists){
      stroke(255);
      noStroke();
      fill(textAlpha,100,0);
      rect(super.x, super.y, super.w, super.h,20);
    }
  }
}
