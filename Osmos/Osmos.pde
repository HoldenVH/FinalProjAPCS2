ArrayList<Mote> Motes = new ArrayList<Mote>();
int i;
void setup(){
  size(1000,1000);
  Motes.add(new Player());
}

void draw(){
  clear();
  i++;
  for(Mote m: Motes){
    System.out.println(m.vel.y);
    m.move();
    ellipse(m.loc.x, m.loc.y, m.radius, m.radius);
  }
}