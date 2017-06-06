ArrayList<Mote> Motes = new ArrayList<Mote>();

PImage imgP,imgM;

void setup() {
  size(1200, 1200);
  Motes.add(new Player());
  for (int i=1; i<50; i++) {
    //add random motes
    Motes.add(new Mote((float)Math.random()*width, (float)Math.random()*height, 0, 0, (float)Math.random()*20+40));
    //delete motes touching player
    if(Motes.get(0).transfer(Motes.get(i))||Motes.get(i).transfer(Motes.get(0))){
      Motes.remove(i);
      i--;
    }
  }
  imgP = loadImage("player.png");
  imgM = loadImage("enemy.png");
}

void draw() {
  clear();
  for (Mote m : Motes) {
    if (m.radius > 1) {
      //ellipse(m.loc.x, m.loc.y, 2*m.radius, 2*m.radius);
      m.img.resize((int)m.radius*2, (int)m.radius*2);
      image(m.img, m.loc.x-m.radius, m.loc.y-m.radius);
      
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
    if (frameCount%(Motes.size()*1)==i && Motes.get(i).radChange) {
      Motes.get(i).refresh();
      System.out.println(i);
    }
  }
}