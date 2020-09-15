float angle = radians(HALF_PI* frameCount);
Table table;
PImage earth;
PShape globe;
float r = 200;
void setup(){
  size(600,600, P3D);
  earth = loadImage("worldmap.jpg");
  table = loadTable("covid.csv","header");
  noStroke();
  globe = createShape(SPHERE,r); 
  globe.setTexture(earth);
}
void draw(){
  background(51);
  translate(width*0.5, height*0.5);
  rotateY(angle);
  angle += 0.05;
  lights();
  fill(200);
  noStroke();
  shape(globe);
  for (TableRow row: table.rows()){
    float lat = row.getFloat("lat");
    float lon =row.getFloat("lon");
    float mag =row.getFloat("confirmed");
    float theta = radians(lat) ;
  float phi = radians(lon) + PI;
  float x = r*cos(theta)*cos(phi);
  float y = -r*sin(theta);
  float z = -r*cos(theta)*sin(phi);
  PVector pos = new PVector(x,y,z);
  float h = pow(10,mag);
  float maxh = pow(10,37);
  h = map(h, 0,maxh, 10, 100);
  PVector xaxis = new PVector(1,0,0);
  float angleb = PVector.angleBetween(xaxis, pos);
  PVector raxis = xaxis.cross(pos);
  pushMatrix();
  translate(x,y,z);
  rectMode(CENTER);
  rotate(angleb,raxis.x, raxis.y, raxis.z);
  fill(255,0,0);
  box(h,1,1);
  fill(255,0,0);
  popMatrix();
  }
  
}
