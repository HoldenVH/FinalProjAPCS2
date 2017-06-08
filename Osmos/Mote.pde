class Mote {
  public PVector loc, vel;//loc:x,y,radius(?) | vel:xvel,yvel
  public float radius;
  public PImage img;
  public boolean radChange;

  public Mote(float xcor, float ycor, float xvel, float yvel, float rad) {
    loc=new PVector (xcor, ycor);
    vel=new PVector (xvel, yvel);
    radius= rad;
    img = loadImage("enemy.png");
    radChange=false;
  }

  public void move() {
    /*if (mousePressed&&radius>10) {
     PVector change=new PVector(mouseX-loc.x, mouseY-loc.y);
     change.normalize();
     change.mult(-.1);
     vel.add(change);
     radius-=.1;
     }*/
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

    //move away from edges
    if (loc.x-radius<0) {
      loc.x=radius;
    }
    if (loc.y-radius<0) {
      loc.y=radius;
    }
    if (loc.x+radius>width) {
      loc.x=width-radius;
    }
    if (loc.y+radius>height) {
      loc.y=height-radius;
    }
  }

  //true if a<=b<=c
  public boolean between(float a, float b, float c) {
    return a<=b && b<=c;
  }

  public boolean transCheck(Mote m) {
    return m.radius<this.radius
      &&
      (between(this.loc.x-this.radius, m.loc.x-m.radius, this.loc.x+this.radius)
      ||between(this.loc.x-this.radius, m.loc.x+m.radius, this.loc.x+this.radius))
      &&
      (between(this.loc.y-this.radius, m.loc.y-m.radius, this.loc.y+this.radius)
      ||between(this.loc.y-this.radius, m.loc.y+m.radius, this.loc.y+this.radius))
      && this.loc.dist(m.loc)<this.radius+m.radius;
  }

  public void transfer(Mote m) {
    double change=.2;
    while(transCheck(m)) {
      //pi cancels out
      this.radius=(float)Math.sqrt(this.radius*this.radius + 2*m.radius*change - change*change);
      m.radius-=change;     
      this.radChange=true;
      m.radChange=true;
      if (m.vel.mag()==0) {
        //m.loc.add(this.vel);
      }
    }
  }

  public boolean kill() {
    return radius<1;
  }
}