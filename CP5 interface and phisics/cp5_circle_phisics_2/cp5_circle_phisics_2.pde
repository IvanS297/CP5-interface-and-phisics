import controlP5.*;
ControlP5 cp5;

PVector pos, vel, grav, drag, vent;
int r = 25;

void setup() {
  size(640, 480);
  frameRate(60);
  pos = new PVector(width/2, height/2);
  drag = new PVector(0, 0);
  grav = new PVector(0, 0.5);
  vent = new PVector(0.5, 0);
  vel = PVector.random2D();

  cp5 = new ControlP5(this);
  addSld("speed", 10, 100, 10);
  addSld("damp", 0, 1, 1);
  addSld("drag", 0, 0.001, 0);
  addSld("vent", 0, 1, 0);
  addSld("water", 0,1, 1);
  addSld("size", 5, 50, 5);
  
  cp5.addButton("reset")
    .setPosition(200, 10)
    .setSize(100, 20)
    .getCaptionLabel().setPaddingX(-30);
    ;
}

void reset() {
  vel = PVector.random2D();
  pos = new PVector(width/2, height/2);
  vel.normalize();
  vel.mult(cp5.get(Slider.class, "speed").getValue());
}

void draw() {
  background(255);
  fill(0);
  float r = getSlider("size");
  float damp = getSlider("damp");
  vel.add(grav);
  
  drag = vel.copy();
  drag.mult(vel.mag() * getSlider("drag") * r*r*0.005);
  
  vel.sub(drag);
  
  vent.set(-1, 0);
  vent.mult(getSlider("vent") * r*r*0.005);
  vel.add(vent);
  
  if (pos.y > height*2/3) {
    PVector waterDrag = new PVector();
    waterDrag = vel.copy();
    vel.mult(getSlider("water") * r*r*0.005);
  }
    
  pos.add(vel);
  
  if (pos.x < r) {
    vel.x = -vel.x;
    vel.mult(damp);
    pos.x = r;
  }
  if (pos.x > width-r) {
    vel.x = -vel.x;
    vel.mult(damp);
    pos.x = width-r;
  }
  if (pos.y < r) {
    vel.y = -vel.y;
    vel.mult(damp);
    pos.y = r;
  }
  if (pos.y > height-r) {
    vel.y = -vel.y;
    vel.mult(damp);
    pos.y = height-r;
  }
  noStroke();
  fill(#83DDFF);
  rect(0, height*2/3, width, height/3);
  fill(0);
  circle(pos.x, pos.y, 2*r);
}

//===============================================================

int offset = 10;
void addSld(String str, float min, float max, float init) {
  cp5.addSlider(str)
    .setPosition(10, offset)
    .setSize(100, 20)
    .setRange(min, max)
    .setValue(init)
    .getCaptionLabel().setPaddingX(-30);
  ;
  offset += 25;
}

float getSlider(String str) {
  return cp5.get(Slider.class, str).getValue();
}
