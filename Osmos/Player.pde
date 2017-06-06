class Player extends Mote{
  Player(){
    super(width/2-100,height/2,0,0,10);
    radius = 100;
  }
  
  /*void move1(){
    while(mousePressed){
      vel.set(10,10,1);
    }
  } */ 
  
  public void move() {
    if (mousePressed&&radius>10) {
      PVector change=new PVector(mouseX-loc.x, mouseY-loc.y);
      change.normalize();
      change.mult(-.1);
      vel.add(change);
      radius-=.1;
    }
    if (vel.mag()!=0) {
      loc.add(vel);
      if (vel.mag()>.05) {
        vel.mult(.99);//coefficient of "friction"
      } else {
        vel.mult(0);
      }
      //bound checking and bouncing, we need to decide window size
      if (loc.x-radius<0||loc.x+radius>width) {
        vel.set(-1*vel.x, vel.y);
      }
      if (loc.y-radius<0||loc.y+radius>width) {
        vel.set(vel.x, -1*vel.y);
      }
    }
  }
}