class Player extends Mote {
  Player(PImage img) {
    super(mapSize/2-100, mapSize/2, 0, 0, 100, img);
  }


  public boolean move() {
    boolean moved = false;
    if (mousePressed) {
      PVector change = new PVector(mouseX-width/2, mouseY-height/2);
      change.normalize();
      change.mult(-.3);
      vel.add(change);
      //radius -= 0.5;
      radius -= vel.mag()*.1;
      moved = true;
    }
    if (vel.mag()!=0) {
      loc.add(vel);
      if (vel.mag()>.05) {
        vel.mult(.999);//coefficient of "friction"
      } else {
        vel.mult(0);
      }
      //bound checking and bouncing, we need to decide window size
      if (loc.x-radius < 0|| loc.x+radius > mapSize) {
        vel.set(-1*vel.x, vel.y);
      }
      if (loc.y-radius < 0 || loc.y+radius > mapSize) {
        vel.set(vel.x, -1*vel.y);
      }
    }

    //move away from edges
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
    
    return moved;
  }
}