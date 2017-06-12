ArrayList<Mote> Motes = new ArrayList<Mote>();
Player player;
PImage biggerEnemy;
PImage smallerEnemy;
int mapWidth, mapHeight;

void setup() {
  size(1200, 1200);
  mapWidth=3000;
  mapHeight=3000;
  biggerEnemy = loadImage("biggerEnemy.png");
  smallerEnemy = loadImage("smallerEnemy.png");
  player = new Player(loadImage("player.png"));
  Motes.add(player);

  for (int i = 1; i < 60; i++) {
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
  Mote p= Motes.get(0);
  fill(0,255);
  rect(width/2-p.loc.x,height/2-p.loc.y,mapWidth,mapHeight);
  /*
  for (Mote m: Motes) {
   if (m.radius > 1) {
   image(m.img, m.loc.x-m.radius, m.loc.y-m.radius, m.radius*2, m.radius*2);
   m.move();
   for (Mote m2 : Motes) {
   m.transfer(m2);
   }
   }
   }
   */

  for (int i = 0; i < Motes.size(); i++) {
    Mote m = Motes.get(i);
    if (m.radius > 1) {
      image(m.img, m.loc.x-m.radius-p.loc.x+height/2, m.loc.y-m.radius-p.loc.y+height/2, m.radius*2, m.radius*2);
      m.move();
      for (Mote m2 : Motes) {
        while (m.shouldAbsorb(m2)) {
          m.absorb(m2);
        }
      }
      
      if (!(m instanceof Player)) {
        if (m.radius >= player.radius && m.img != biggerEnemy) m.img = biggerEnemy;
        else if(m.radius < player.radius && m.img != smallerEnemy)m.img = smallerEnemy;
      }
      
    } else {
      Motes.remove(m);
      i--;
    }
  }
}