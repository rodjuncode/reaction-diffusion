RD rd;
// http://mrob.com/pub/comp/xmorphia/glossary.html#soliton
// http://mrob.com/pub/comp/xmorphia/pearson-classes.html
// http://mrob.com/pub/comp/xmorphia/ogl/index.html

int count = 0;
PGraphics mask;

void setup() {
  size(1000,1000);
  rd = new RD(width,0.09242969,0.05636812); 
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
