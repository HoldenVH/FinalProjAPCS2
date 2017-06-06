ArrayList<Mote> Motes = new ArrayList<Mote>();
int i;
void setup(){
  size(1200,1200);
  Motes.add(new Player());
}

void draw(){
  clear();
  i++;
  for(Mote m: Motes){
     ellipse(m.loc.x, m.loc.y, 2*m.radius, 2*m.radius);
     m.move();
  }
}