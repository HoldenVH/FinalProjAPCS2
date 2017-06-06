ArrayList<Mote> Motes = new ArrayList<Mote>();

void setup() {
  size(1200, 1200);
  Motes.add(new Player());
  for(int i=0;i<30;i++){
    Motes.add(new Mote((float)Math.random()*width,(float)Math.random()*height,0,0,(float)Math.random()*20+40));
  }
}

void draw() {
  clear();
  for (Mote m : Motes) {
    ellipse(m.loc.x, m.loc.y, 2*m.radius, 2*m.radius);
    m.move();
    for(Mote m2 : Motes){
      m.transfer(m2);
    }
  }
  for(int i=Motes.size()-1;i>=0;i--){
    if(Motes.get(i).kill()){
      Motes.remove(i);
    }
  }
}