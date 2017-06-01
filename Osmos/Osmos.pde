class Osmos{
  ArrayList<Mote> Motes = new ArrayList<Mote>();
  
  void setup(){
    Motes.add(new Player());
  }

  void draw(){
    for(Mote m: Motes){
      ellipse(m.loc.x, m.loc.y, m.radius, m.radius);
    }
  }
}