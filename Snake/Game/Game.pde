Snake snake1;
Snake snake2;
Food food1;
Food food2;
Food food3;
int size = 20;
float progress;

boolean gameOver;
int winner;

boolean menu;
boolean P2 = true;

void setup() {
  size(600, 670);
  snake1 = new Snake(0, 2, 3, 1);
  if (P2) {
    snake2 = new Snake(0, 600/size-3, 3, 2);
  }
  food1 = new Food(1);
  food2 = new Food(2);
  food3 = new Food(3);
  
  gameOver = false;

  menu = true;
}

// ---------------------------------------------------------------------------    

void draw() {
  if (menu) {
    background(255);
    
    fill(0);
    textSize(60);
    textAlign(CENTER);
    text("2 Player Snake", 300, 180);
    
    // single player button
    stroke(150, 0, 0);
    strokeWeight(3);
    textAlign(LEFT);
    fill(200, 0, 0);
    textSize(24);
    rect(160, 280, 110, 40);
    stroke(0);
    fill(255);
    text("1 Player", 168, 308);
    
    // 2 player button
    stroke(0, 150, 0);
    fill(0, 200, 0);
    rect(330, 280, 110, 40);
    stroke(0);
    fill(255);
    text("2 Player", 338, 308);
  } else if (!gameOver && !menu) {
    background(255);

    snake1.update();
    if (P2) {
      snake2.update();
    }
    
    checkForAttack();
    
    snake1.renderShadow();
    if (P2) {
      snake2.renderShadow();
    }
    
    food1.render();
    food2.render();
    food3.render();
    
    if (!gameOver) {
      snake1.render();
      if (P2) {
        snake2.render();
      }
    }
    
    renderFooter();
  } else {
    background(0);
    
    if (P2) {
      fill(255);
      textSize(40);
      textAlign(CENTER);
      text("Player " + winner + " wins", width/2, height/2); 
      textAlign(LEFT);
    } else {
      fill(255);
      textSize(40);
      textAlign(CENTER);
      text("You Died", width/2, height/2); 
      textAlign(LEFT);
    }
    
    rect(200, 380, 200, 50);
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text("Replay", 300, 415); 
  }
}

// ---------------------------------------------------------------------------

void checkForAttack() {
  if (P2) {
    // Snake 1 crashes into snake 2
    for (int i = 0; i < snake2.len; i++) {
      if (snake1.x == snake2.tailx[i] && snake1.y == snake2.taily[i]) {
        snake1.dead();
      }
    }
    
    // Snake 2 crashes into snake 1
    for (int i = 0; i < snake1.len; i++) {
      if (snake2.x == snake1.tailx[i] && snake2.y == snake1.taily[i]) {
        snake2.dead();
      }
    }
  }
}

// ---------------------------------------------------------------------------

void renderFooter() {
  stroke(0);
  fill(0);
  rect(0, 600, 600, 2);
  textSize(15);
  text("Player 1", 7, 618);
  if (P2) {
    text("Player 2", 536, 618);
  }
  textSize(13);
  
  text(snake1.len + 1, 7, 633);
  if (P2) {
    if (snake2.len+1 < 10) {
      text(snake2.len + 1, 585, 633);
    } else if (snake2.len+1 < 100) {
      text(snake2.len + 1, 577, 633);
    } else {
      text(snake2.len + 1, 569, 633);
    }
  }
  
  stroke(0);
  fill(255);
  rect(7, 640, 220, 20);
  
  strokeWeight(0);
  fill(255, 150, 0);
  if (snake1.cooldownStart) {
    progress = map(snake1.cooldown, 0, snake1.cooldownLen, 0, 219);
  } else if (snake1.boost) {
    progress = map(snake1.boostCount, 0, snake1.boostLen, 219, 0);
  } else {
    progress = 219;
  }
  rect(8, 641, progress, 19);
  strokeWeight(1);
  
  if (P2) {
    stroke(0);
    fill(255);
    rect(593, 640, -220, 20);
   
    strokeWeight(0);
    fill(255, 150, 0);
    if (snake2.cooldownStart) {
      progress = map(snake2.cooldown, 0, snake2.cooldownLen, 0, 219);
    } else if (snake2.boost) {
      progress = map(snake2.boostCount, 0, snake2.boostLen, 219, 0);
    } else {
      progress = 219;
    }
    rect(374, 641, progress, 19);
    strokeWeight(1);
  }
}

// ---------------------------------------------------------------------------

void keyPressed() {
  if (!menu && !gameOver) {
    if (key == CODED) {
      if (keyCode == UP) {
        snake1.up();
      }
      if (keyCode == DOWN) {
        snake1.down();
      }
      if (keyCode == LEFT) {
        snake1.left();
      }
      if (keyCode == RIGHT) {
        snake1.right();
      }
    }
    if (key == '/') {
      snake1.boost();
    }
    if (key == ' ') {
      if (!P2) {
        snake1.boost();
      }
    }
    if (key == 'w') {
      if (P2) {
        snake2.up();
      } else {
        snake1.up();
      }
    }
    if (key == 'a') {
      if (P2) {
        snake2.left();
      } else {
        snake1.left();
      }
    }
    if (key == 's') {
      if (P2) {
        snake2.down();
      } else {
        snake1.down();
      }
    }
    if (key == 'd') {
      if (P2) {
        snake2.right();
      } else {
        snake1.right();
      }
    }
    if (key == 'q') {
      if (P2) {
        snake2.boost();
      } else {
        snake1.boost();
      }
    }
  }
}

// ---------------------------------------------------------------------------

void mousePressed() {
  if (menu) {
    if (mouseX > 160 && mouseX < 270 && mouseY > 280 && mouseY < 320) {
      menu = false;
      P2 = false;
    }
    if (mouseX > 330 && mouseX < 440 && mouseY > 280 && mouseY < 320) {
      menu = false;
      P2 = true;
    }
  }
  if (gameOver) {
    if (mouseX > 200 && mouseX < 400 && mouseY < 430 && mouseY > 380) {
      setup();
    }
  }
}
