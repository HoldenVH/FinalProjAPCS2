class Mote {
  public PVector loc, vel;
  public float radius, score;
  public PImage img;
  public boolean radChange;

  public Mote(float x, float y, float xvel, float yvel, float rad, PImage sprite) {
    loc = new PVector(x, y);
    vel = new PVector(xvel, yvel);
    radius= rad;
    img = sprite;
    radChange=false;
  }


  public boolean move() {

    if (vel.mag()!=0) {
      loc.add(vel);
      if (vel.mag()>.05) {
        vel.mult(.99);//coefficient of "friction"
      } else {
        vel.mult(0);
      }

      //bound checking and bouncing, we need to decide window size
      if (loc.x-radius < 0 || loc.x+radius > mapSize) {
        vel.set(-1*vel.x, vel.y);
      }
      if (loc.y-radius < 0|| loc.y+radius > mapSize) {
        vel.set(vel.x, -1*vel.y);
      }
    }
    

    //prevent motes from going out of bounds
    if (loc.x-radius < 0) {
      loc.x = radius;
    }
    if (loc.y-radius < 0) {
      loc.y = radius;
    }
    if (loc.x+radius > mapSize) {
      loc.x = mapSize-radius;
    }
    if (loc.y+radius > mapSize) {
      loc.y = mapSize-radius;
    }
    
    return false;
  }


  //true if a<=b<=c
  public boolean between(float a, float b, float c) {
    return a <= b && b <= c;
  }

  public boolean shouldAbsorb(Mote m) {
    return m.radius < this.radius && this.loc.dist(m.loc) < this.radius+m.radius;
  }

  public void absorb(Mote m) {
    float change = 0.2;
    //calculates the new radius for every quantized absorption
    score+=(float)Math.sqrt(radius*radius + 2*m.radius*change - change*change)-radius;
    radius = (float)Math.sqrt(radius*radius + 2*m.radius*change - change*change);
    m.radius -= change;
    radChange = true;
    m.radChange = true;
  }
}