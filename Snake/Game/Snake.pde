class Snake {
  int x;
  int y;
  int xspeed = 1;
  int yspeed = 0;
  int len;
  
  int loop;
  int speed = 10;
  
  int[] tailx;
  int[] taily;
  
  int player;
  
  boolean boost = false;
  int boostCount = 0;
  int boostLen = 100;
  
  int cooldown = 0;
  int cooldownLen = 200;
  boolean cooldownStart = false;
  
  Snake(int a, int b, int c, int d) {
    tailx = new int[(600/size)*(600/size)];
    taily = new int[(600/size)*(600/size)];
    x = a;
    y = b;
    len = c-1;
    for (int i = 0; i < len; i++) {
      tailx[i] = x;
      taily[i] = y;
    }
    x += xspeed;
    y += yspeed;
    player = d;
  }
  
  // ---------------------------------------------------------------------------
  
  void update() {
    loop++;
    if (boost && !cooldownStart) {
      boostCount++;
      speed = 3;
      if (boostCount > boostLen) {
        boostCount = 0;
        speed = 10;
        boost = false;
        cooldownStart = true;
      }
    }
    if (cooldownStart) {
      cooldown++;
      if (cooldown > cooldownLen) {
        cooldownStart = false;
        cooldown = 0;
      }
    }
    if (loop > speed) {
      colWithFood();
      for (int i = len-1; i > 0; i--) {
        tailx[i] = tailx[i-1];
        taily[i] = taily[i-1];
      }
      
      tailx[0] = x;
      taily[0] = y;
      
      x += xspeed;
      y += yspeed;
      
      if (x < 0) {
        x = (600-size)/size;
      }
      if (y < 0) {
        y = (600-size)/size;
      }
      if (x > (600-size)/size) {
        x = 0;
      }
      if (y > (600-size)/size) {
        y = 0;
      }
      loop = 0;
      checkForDeath();
    }
  }
  
  // ---------------------------------------------------------------------------
  
  void colWithFood() {
    if (x == food1.x && y == food1.y) {
      addLen(food1);
      food1.newPos();
    }
    if (x == food2.x && y == food2.y) {
      addLen(food2);
      food2.newPos();
    }
    if (x == food3.x && y == food3.y) {
      addLen(food3);
      food3.newPos();
    }
  }
  
  // ---------------------------------------------------------------------------
  
  void addLen(Food food) {
    for (int i = 0; i < food.value; i++) {
      len++;
      tailx[len-1] = tailx[len-2];
      taily[len-1] = taily[len-2];
    }
  }
  
  // ---------------------------------------------------------------------------
  
  void checkForDeath() {
    for (int i = 0; i < len; i++) {
      if (x == tailx[i] && y == taily[i]) {
        if (player == 1) {
          gameOver = true;
          winner = 2;
        } else if (player == 2) {
          gameOver = true;
          winner = 1;
        }
      }
    }
  }
  
  // ---------------------------------------------------------------------------
  
  void dead() {
    if (player == 1) {
          gameOver = true;
          winner = 2;
        } else if (player == 2) {
          gameOver = true;
          winner = 1;
        }
  }
  
  // ---------------------------------------------------------------------------
  
  void render() {
    if (player == 1) {
      fill(255, 0, 150);
    }
    
    if (player == 2) {
      fill(150, 0, 255);
    }
    
    rect(x*size, y*size, size, size);
    
    for (int i = 0; i < len; i++) {
      rect(tailx[i]*size, taily[i]*size, size, size);
    }
  }
  
  // ---------------------------------------------------------------------------
  
  void renderShadow() {
    fill(50);
    stroke(50);
    rect((x*size)+2, (y*size)+2, size, size);
    rect((x*size)+1, (y*size)+1, size, size);
    
    for (int i = 0; i < len; i++) {
      rect((tailx[i]*size)+1, (taily[i]*size)+1, size, size);
      rect((tailx[i]*size)+2, (taily[i]*size)+2, size, size);
    }
    stroke(0);
  }
  
  // ---------------------------------------------------------------------------
  
  void up() {
    if (yspeed != 1  && y-1 != taily[0]) {
      xspeed = 0;
      yspeed = -1;
    }
  }
  
  // ---------------------------------------------------------------------------
  
  void down() {
    if (yspeed != -1 && y+1 != taily[0]) {
      xspeed = 0;
      yspeed = 1;
    }
  }
  
  // ---------------------------------------------------------------------------
  
  void left() {
    if (xspeed != 1  && x-1 != tailx[0]) {
      xspeed = -1;
      yspeed = 0;
    }
  }
  
  // ---------------------------------------------------------------------------
  
  void right() {
    if (xspeed != -1  && x+1 != tailx[0]) {
      xspeed = 1;
      yspeed = 0;
    }
  }
  
  // ---------------------------------------------------------------------------
  
  void boost() {
    if (!cooldownStart) {
      boost = true;
    }
  }
}
