class RD {
  RDCell[][] grid;
  RDCell[][] next_grid;
  
  PGraphics mask;
  
  float feed;
  float kill;
  
  float dA = 1;
  float dB = .5;

  int size = 200;
    
  RD(int s, float f, float k) {
    size = s;
    feed = f;
    kill = k;
    grid = new RDCell[size][size];
    next_grid = new RDCell[size][size];
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        grid[i][j] = new RDCell(1,0);
        next_grid[i][j] = new RDCell(1,0);
      }
    }
    mask = createGraphics(size, size);
  }
  
  void swap() {
    RDCell[][] _swap = grid;
    grid = next_grid;
    next_grid = _swap;
  }
  
  void next() {
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid.length; j++) {
        float a = grid[i][j].a;
        float b = grid[i][j].b;
        RDCell la_place = laPlace(i,j);
        next_grid[i][j].a = constrain(a + 
                            (dA * la_place.a) -
                            (a * b * b) +
                            (feed * (1 - a)), 0, 1); 
                            
        next_grid[i][j].b = constrain(b +   
                            (dB * la_place.b) +
                            (a * b * b) -
                            ((kill + feed) * b), 0, 1);                          

      }
    }
  }
  
  void generateMask() {
    mask.beginDraw();
    for (int i = 0; i < width/20; i++) {
      RDBlob b = new RDBlob(new PVector(random(size),random(size)),size/15,36,mask); 
      b.display();
    }
    mask.endDraw();    
  }
  
  void loadMask() {
    for (int i = 0; i < mask.pixels.length; i++) {
      if (mask.pixels[i] == color(0)) {
        grid[i % size][(int) Math.floor(i/size)].b = 1; 
      }
    }  
  }
  
  RDCell laPlace(int i, int j) {
    RDCell la_place = new RDCell(0,0);
    
    int i_minus, i_plus, j_minus, j_plus;
    
    if (i == 0) {
      i_minus = grid.length-1;
    } else {
      i_minus = i - 1; 
    }
  
    if (i == grid.length-1) {
      i_plus = 0;
    } else {
      i_plus = i + 1; 
    }

    if (j == 0) {
      j_minus = grid[grid.length-1].length-1;
    } else {
      j_minus = j - 1; 
    }
  
    if (j == grid[grid.length-1].length-1) {
      j_plus = 0;
    } else {
      j_plus = j + 1; 
    }
    
    // a
    la_place.a += grid[i][j].a * -1;
    la_place.a += grid[i_minus][j].a * .2;
    la_place.a += grid[i_plus][j].a * .2;
    la_place.a += grid[i][j_minus].a * .2;
    la_place.a += grid[i][j_plus].a * .2;
    la_place.a += grid[i_minus][j_minus].a * .05;
    la_place.a += grid[i_minus][j_plus].a * .05;
    la_place.a += grid[i_plus][j_minus].a * .05;
    la_place.a += grid[i_plus][j_plus].a * .05;
    // b
    la_place.b += grid[i][j].b * -1;
    la_place.b += grid[i_minus][j].b * .2;
    la_place.b += grid[i_plus][j].b * .2;
    la_place.b += grid[i][j_minus].b * .2;
    la_place.b += grid[i][j_plus].b * .2;
    la_place.b += grid[i_minus][j_minus].b * .05;
    la_place.b += grid[i_minus][j_plus].b * .05;
    la_place.b += grid[i_plus][j_minus].b * .05;
    la_place.b += grid[i_plus][j_plus].b * .05;
    
    return la_place;
  }
  
  String info() {
    return "f" + feed + "k" + kill; 
  }
  
} 
