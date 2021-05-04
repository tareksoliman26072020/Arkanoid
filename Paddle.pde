class Paddle {
  private PVector location;
  private int speed;

  Paddle(int x) {
    this.location=new PVector(x,580);
    speed=20;
  }

  void draw() {
    fill(255);
    stroke(255);
    rect(location.x,location.y,100,10,170);
  }
  
  // move paddle to the right
  void move_right(){
    this.location.x=location.x+speed;
  }
  
  // move paddle to the left
  void move_left(){
    this.location.x=location.x-speed;
  }
}
