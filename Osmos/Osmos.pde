ArrayList<Mote> Motes = new ArrayList<Mote>();
Player player;
PImage biggerEnemy, smallerEnemy, gameOver;
float radTemp;

boolean started;
int resetCounter, mapBoxClicked, mapSize, enemiesBoxClicked, numEnemies;
//menu vars


void setup() {
  frameRate(20);
  size(1000, 1000);
  biggerEnemy = loadImage("biggerEnemy.png");
  smallerEnemy = loadImage("smallerEnemy.png"); 
  gameOver= loadImage("gameOver.png");
  mapBoxClicked=1;
  mapSize=3000;
  enemiesBoxClicked=1;
  numEnemies=180;
}

void draw() {

  clear();
  if (!started) {//menu screen
    textSize(50);
    textAlign(CENTER, CENTER);
    //text settings

    for (int box=0; box<3; box++) {
      fill(150);
      if (mouseOver(width/2-350+250*box, height/2, 200, 100)|| mapBoxClicked==box) {
        fill(100);
        if (mousePressed) {
          mapBoxClicked=box;
          mapSize=1500*(box+1);
        }
      }
      rect(width/2-350+250*box, height/2, 200, 100);
    }
    fill(255);
    text("Small", width/2-250, height/2+50);
    text("Medium", width/2, height/2+50);
    text("Large", width/2+250, height/2+50);
    text("Select your map size", width/2, height/2-50);
    //map size menu creation


    for (int box=0; box<3; box++) {
      fill(150);
      if (mouseOver(width/2-350+250*box, height/2-200, 200, 100)|| enemiesBoxClicked==box) {
        fill(100);
        if (mousePressed) {
          enemiesBoxClicked=box;
          numEnemies=Math.round(((mapSize/100*mapSize/100)/5)*(.5+.5*box));
        }
      }
      rect(width/2-350+250*box, height/2-200, 200, 100);
    }
    fill(255);
    text("Few", width/2-250, height/2-150);
    text("Normal", width/2, height/2-150);
    text("Many", width/2+250, height/2-150);
    text("How many enemies do you want?", width/2, height/2-250);
    //enemy num selection menu

    //start button
    fill(150);
    if (mouseOver(width/2-100, height/2+150, 200, 100)) fill(100);
    rect(width/2-100, height/2+150, 200, 100);
    fill(255);
    text("START", width/2, height/2+200);

    if (mouseOver(width/2-100, height/2+150, 200, 100) && mousePressed) {
      //start game
      started=true;
      //make player
      player = new Player(loadImage("player.png"));
      Motes.add(player);

      for (int i = 1; i < numEnemies; i++) {
        //add random motes
        Motes.add(new Mote((float)Math.random()*mapSize, (float)Math.random()*mapSize, 0, 0, (float)Math.random()*55+30, biggerEnemy));
        //delete motes touching other motes
        for (int n = 0; n < i; n++) {
          Motes.get(n+1).move();
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
      String s="SCORE: "+player.score;
      text(s,width/2,height/2+300);
      resetCounter++;
      if (resetCounter>30) {
        started=false;
        Motes=new ArrayList<Mote>();
        //=======
        background(100);
        fill(0, 255);
        rect(width/2-player.loc.x, height/2-player.loc.y, mapSize, mapSize);
      }
    } else {
      for (int i = 0; i < Motes.size(); i++) {
        Mote m = Motes.get(i);
        if (m.radius > 1) {
          image(m.img, m.loc.x-m.radius-player.loc.x+height/2, m.loc.y-m.radius-player.loc.y+height/2, m.radius*2, m.radius*2);
          if (m.move()) {
            if (frameCount%10 == 0) {
              float newRadius = (float)Math.sqrt(2*player.radius*radTemp - radTemp*radTemp);
              PVector dir = new PVector(mouseX-width/2, mouseY-height/2).normalize().mult(player.radius*1.5);
              PVector newVel = new PVector(mouseX-width/2, mouseY-height/2).normalize().mult(player.radius*player.radius/(newRadius*newRadius));
              Motes.add(new Mote(player.loc.x+dir.x, player.loc.y+dir.y, newVel.x, newVel.y, newRadius, smallerEnemy));
              radTemp = 0.1;
            } else {
              radTemp += player.vel.mag()*.1;
            }
          }
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