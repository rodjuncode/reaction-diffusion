RD rd;

int count = 0;
PGraphics mask;

void setup() {
  size(200,200);
  rd = new RD(width,0.058,0.065); 
  rd.generateMask();
  rd.loadMask();
}

void draw() {
  background(255);

  loadPixels();
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < width; j++) {
      pixels[i + j * width] = color(constrain((int) Math.floor((rd.grid[i][j].a - rd.grid[i][j].b) * 255),0,255));
    }
  }
  updatePixels();
  
  if (!mousePressed) {
    rd.next();
    rd.swap();
    
    count++;
    println(count);    
  }

}
