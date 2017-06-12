ArrayList<Mote> Motes = new ArrayList<Mote>();
Player player;
PImage biggerEnemy;
PImage smallerEnemy;
int mapWidth, mapHeight;
float radTemp;

void setup() {
  size(1200, 1200);
  mapWidth=2400;
  mapHeight=2400;
  biggerEnemy = loadImage("biggerEnemy.png");
  smallerEnemy = loadImage("smallerEnemy.png");
  player = new Player(loadImage("player.png"));
  Motes.add(player);

  for (int i = 1; i < 20; i++) {
    //add random motes
    Motes.add(new Mote((float)Math.random()*mapWidth, (float)Math.random()*mapHeight, 0, 0, (float)Math.random()*25+40, biggerEnemy));
    //delete motes touching other motes
    for (int n = 0; n < i; n++) {
      if (Motes.get(n).shouldAbsorb(Motes.get(i)) || Motes.get(i).shouldAbsorb(Motes.get(n))) {
        Motes.remove(i);
        i--;
      }
    }
  }
}

void draw() {
  clear();
  background(100);
  fill(0, 255);
  rect(width/2-player.loc.x, height/2-player.loc.y, mapWidth, mapHeight);

  for (int i = 0; i < Motes.size(); i++) {
    Mote m = Motes.get(i);
    if (m.radius > 1) {
      image(m.img, m.loc.x-m.radius-player.loc.x+height/2, m.loc.y-m.radius-player.loc.y+height/2, m.radius*2, m.radius*2);
      if (m.move()) {
        if (frameCount%10 == 0) {
          float newRadius = (float)Math.sqrt(2*player.radius*radTemp - radTemp*radTemp);
          PVector dir = new PVector(mouseX-width/2, mouseY-height/2).normalize().mult(player.radius*1.5);
          PVector newVel = new PVector(mouseX-width/2, mouseY-height/2).normalize().mult(player.radius*player.radius/(newRadius*newRadius));
          Motes.add(new Mote(player.loc.x+dir.x, player.loc.y+dir.y, newVel.x, newVel.y, newRadius, smallerEnemy));
          radTemp = 0.5;
        } else {
          radTemp += 0.5;
        }
      }
      for (Mote m2 : Motes) {
        while (m.shouldAbsorb(m2)) {
          m.absorb(m2);
        }
      }

      if (!(m instanceof Player)) {
        if (m.radius >= player.radius && m.img != biggerEnemy) m.img = biggerEnemy;
        else if (m.radius < player.radius && m.img != smallerEnemy)m.img = smallerEnemy;
      }
    } else {
      Motes.remove(m);
      i--;
    }
  }
}