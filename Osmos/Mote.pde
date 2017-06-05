class Mote{
  public PVector loc,vel;//loc:x,y,radius(?) | vel:xvel,yvel
  public float radius;
  
  public Mote(float xcor, float ycor, float xvel, float yvel, float rad){
    loc=new PVector (xcor,ycor);
    vel=new PVector (xvel,yvel);
    radius= rad;
  }
  
  public void move(){
    //if(vel.mag()!=0){
        loc.add(vel);
          //bound checking and bouncing, we need to decide window size
      if(loc.x-radius<0||loc.x+radius>width){
        vel.set(-1*vel.x,vel.y);
      }
      if(loc.y-radius<0||loc.y+radius>width){
        vel.set(vel.x,-1*vel.y);
      }
    //}
  }   
}