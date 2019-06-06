class Food {
  int x;
  int y;
  int value = floor(random(1.1, 3.9));
  
  int num;
  
  Food(int a) {
    num = a;
    
    x = floor(random(0, 600))/size;
    y = floor(random(0, 600))/size;
  }
  
  // ---------------------------------------------------------------------------
  
  void render() {
    fill(50);
    stroke(50);
    rect((x*size)+ 3, (y*size)+ 3, size-4, size-4);
    stroke(0);
    
    fill(0, 255, 125);
    rect((x*size)+ 2, (y*size)+ 2, size-4, size-4);
  }
  
  // ---------------------------------------------------------------------------
  
  void newPos() {
    x = floor(random(0, 600))/size;
    y = floor(random(0, 600))/size;
    if (x == snake1.x && y == snake1.y) {
      newPos();
    } else if (P2) {
      if (x == snake2.x && y == snake2.y) {
        newPos();
      }
    }
    for (int i = 0; i < snake1.len; i++) {
      if (snake1.tailx[i] == x && snake1.taily[i] == y) {
        newPos();
      }
    }
    if (P2) {
      for (int i = 0; i < snake1.len; i++) {
        if (snake2.tailx[i] == x && snake2.taily[i] == y) {
          newPos();
        }
      }
    }
    
    if (num == 1) {
      if (x == food2.x && y == food2.y) {
        newPos();
      }
      if (x == food3.x && y == food3.y) {
        newPos();
      }
    }
    if (num == 2) {
      if (x == food1.x && y == food1.y) {
        newPos();
      }
      if (x == food3.x && y == food3.y) {
        newPos();
      }
    }
    if (num == 3) {
      if (x == food2.x && y == food2.y) {
        newPos();
      }
      if (x == food1.x && y == food1.y) {
        newPos();
      }
    }
    value = floor(random(1.1, 3.9));
  }
}
