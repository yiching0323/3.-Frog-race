int [] frogX; 
int [] frogY; 
int lineX, lineY;
int playerX, playerY;
final int FINAL_LINE = 840;
float [] frogXSpeed;
float player_pace_cnt = 0;
float playerXSpeed = 17;

int life = 3;
boolean alive = true;
final int GAME_START = 1;
final int GAME_WIN = 2;
final int GAME_LOSE = 3;
final int GAME_RUN = 4;
final int DIE = 5;
int gameState;

PImage bg, frog, line;

float [] frog_pace_cnt ;
float frog_down = 60;
float frog_jump = 42;

void setup() {
  size(960, 720, P2D);
  frameRate(60);
  bg = loadImage("img/bg.png");
  frog = loadImage("img/frog.png");
  line = loadImage("img/line.png");

  //player position
  playerX = 30;
  playerY = 385;

  //frog position  
  frogX = new int[3] ;
  frogY = new int[3] ;
  frogXSpeed = new float[3];

  for (int i=0; i<3; i++) {
    frogX[i] = 30;
  }

  for (int i=0; i<3; i++) {
    if (i < 2) {
      frogY[i] = 25 + i *180;
    } else {
      frogY[i] = 25 + (i+1)*180;
    }
  }

  int index = floor(random(1)*3);
  for (int i=0; i<3; i++) {
    if (i == index) {
      frogXSpeed[i] = random(2, 2);
    } else {
      frogXSpeed[i] = random(1, 2);
    }
  }

  //frog jump
  frog_pace_cnt = new float[3];
  for (int i=0; i<3; i++) {
    frog_pace_cnt[i]=0;
  }

  //final line
  lineX = 835;
  lineY = 0;
}


void draw() {
  background(bg);
  image(line, lineX, lineY);
  
  //player jump
  if (player_pace_cnt <= frog_down) {
    image(frog, playerX, playerY);
  } 
  else if (player_pace_cnt > frog_down && player_pace_cnt <= frog_jump + frog_down && playerX < FINAL_LINE) {
    pushMatrix();
    translate(playerX, playerY);
    scale(1.2, 1.2);
    image(frog, 0, 0);
    popMatrix();
  } 
  else {
    image(frog, playerX, playerY); 
    player_pace_cnt = 0;
  }

  //frog jump
  for (int i=0; i<3; i++) {

    frog_pace_cnt[i] += frogXSpeed[i];
    frogX[i] += frogXSpeed[i];

    if (frog_pace_cnt[i] <= frog_down) {
      image(frog, frogX[i], frogY[i]);
    } else if (frog_pace_cnt[i] > frog_down && frog_pace_cnt[i] <= frog_jump + frog_down && frogX[i] < FINAL_LINE) {
      pushMatrix();
      translate(frogX[i], frogY[i]);
      scale(1.15, 1.15);
      image(frog, 0, 0);
      popMatrix();
    } else {
      image(frog, frogX[i], frogY[i]); 
      frog_pace_cnt[i] = 0;
    }

    if (frogX[i]>=FINAL_LINE) {
      frogX[i] = FINAL_LINE;
    }
  }
}

void mouseClicked() {
  playerX += playerXSpeed;
  player_pace_cnt += playerXSpeed;
  if (playerX>=FINAL_LINE) {
    playerX = FINAL_LINE;
  }
}
