ArrayList<Mote> Motes = new ArrayList<Mote>();
Player player;
PImage biggerEnemy;
PImage smallerEnemy;

void setup() {
  size(1200, 1200);
  biggerEnemy = loadImage("biggerEnemy.png");
  smallerEnemy = loadImage("smallerEnemy.png");
  player = new Player(loadImage("player.png"));
  Motes.add(player);

  for (int i = 1; i < 30; i++) {
    //add random motes
    Motes.add(new Mote((float)Math.random()*width, (float)Math.random()*height, 0, 0, (float)Math.random()*25+40, biggerEnemy));
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
      image(m.img, m.loc.x-m.radius, m.loc.y-m.radius, m.radius*2, m.radius*2);
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