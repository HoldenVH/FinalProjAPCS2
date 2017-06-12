class Player extends Mote {
  Player(PImage img) {
    super(mapWidth/2-100, mapHeight/2, 0, 0, 100, img);
  }

  public void move() {
    if (mousePressed && radius > 10) {
      PVector change = new PVector(mouseX-width/2, mouseY-height/2);
      change.normalize();
      change.mult(-.1);
      vel.add(change);
      radius -= 0.5;
    }
    if (vel.mag()!=0) {
      loc.add(vel);
      if (vel.mag()>.05) {
        vel.mult(.99);//coefficient of "friction"
      } else {
        vel.mult(0);
      }
      //bound checking and bouncing, we need to decide window size
      if (loc.x-radius < 0|| loc.x+radius > mapWidth) {
        vel.set(-1*vel.x, vel.y);
      }
      if (loc.y-radius < 0 || loc.y+radius > mapWidth) {
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
    if (loc.x+radius > mapWidth) {
      loc.x = mapWidth-radius;
    }
    if (loc.y+radius > mapHeight) {
      loc.y = mapHeight-radius;
    }
  }
}