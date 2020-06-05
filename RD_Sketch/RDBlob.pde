class RDBlob { //<>//
 
    PVector location;
    float size;
    int vertex_qty;
    ArrayList<PVector> vertexes;
    PGraphics canvas;
  
    RDBlob(PVector l, float s, int v, PGraphics c) {
      location = l;
      size = s;      
      vertex_qty = v;
      vertexes = new ArrayList<PVector>();
      canvas = c;
      init();
    }

    void init() {
      for (float a = 0; a < TWO_PI; a += TWO_PI/vertex_qty) {
        float r_min = size*.8;
        float r_max = size*1.2;
        vertexes.add(new PVector(random(r_min,r_max) * cos(a), random(r_min,r_max) * sin(a)));
      }
    }
  
    void display() {
      canvas.push();
      canvas.noStroke();
      canvas.fill(0);
      canvas.translate(location.x, location.y);
      canvas.beginShape();
      for (int i = 0; i < vertexes.size(); i++) {
        canvas.vertex(vertexes.get(i).x,vertexes.get(i).y);
      }
      canvas.endShape();
      canvas.pop();
    }
  
}
