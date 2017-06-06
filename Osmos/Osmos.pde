ArrayList<Mote> Motes = new ArrayList<Mote>();

void setup() {
  size(1200, 1200);
  Motes.add(new Player());
  for (int i=0; i<30; i++) {
    Motes.add(new Mote((float)Math.random()*width, (float)Math.random()*height, 0, 0, (float)Math.random()*20+40));
  }
}

void draw() {
  clear();
  for (Mote m : Motes) {
    if (m.radius > 1) {
      //ellipse(m.loc.x, m.loc.y, 2*m.radius, 2*m.radius);
      image(m.img, m.loc.x-m.radius, m.loc.y-m.radius);
      m.img.resize((int)m.radius*2, (int)m.radius*2);
      m.move();
      for (Mote m2 : Motes) {
        m.transfer(m2);
      }
    }
  }

  for (int i=Motes.size()-1; i>=0; i--) {
    if (Motes.get(i).kill()) {
      Motes.remove(i);
    }
    if (frameCount%(Motes.size()*1)==i) {
      Motes.get(i).refresh();
      System.out.println(i);
    }
  }
}