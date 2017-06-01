class Player extends Mote{
  Player(){
    radius = 5;
  }
  
  void move(){
    while(mousePressed){
      vel.set(1,1,1);
    }
  }  
}