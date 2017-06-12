ArrayList<Mote> Motes = new ArrayList<Mote>();
Player player;
PImage biggerEnemy, smallerEnemy, gameOver;
int mapWidth, mapHeight;
boolean started;
int resetCounter;

void setup() {
  size(1200, 1200);
  biggerEnemy = loadImage("biggerEnemy.png");
  smallerEnemy = loadImage("smallerEnemy.png");
  gameOver= loadImage("gameOver.png");
}

void draw() {
  clear();
  if (!started) {//menu screen
    fill(150);
    if (mouseOver(width/2-100, height/2-50, 200, 100)) fill(100);
    rect(width/2-100, height/2-50, 200, 100);
    fill(255);
    textSize(50);
    textAlign(CENTER,CENTER);
    text("START",width/2,height/2);
    
    if (mouseOver(width/2-100, height/2-50, 200, 100) && mousePressed) {
      //start game
      started=true;
      //set map size
      mapWidth=3000;
      mapHeight=3000;
      //make player
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
  } else {//game playing

    if (!(Motes.get(0) instanceof Player)) {
      image(gameOver, 0, 0, width, height);
      resetCounter++;
      if(resetCounter>30){
        started=false;
        Motes=new ArrayList<Mote>();
      }
    } else {
      background(100);
      fill(0, 255);
      rect(width/2-player.loc.x, height/2-player.loc.y, mapWidth, mapHeight);
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
          image(m.img, m.loc.x-m.radius-player.loc.x+height/2, m.loc.y-m.radius-player.loc.y+height/2, m.radius*2, m.radius*2);
          m.move();
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
  }
}

boolean mouseOver(float x, float y, float w, float h) {
  return x<mouseX && mouseX <x+w && y<mouseY && mouseY<y+h;
}