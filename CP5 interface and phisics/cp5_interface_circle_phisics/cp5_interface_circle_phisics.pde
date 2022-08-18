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
  cp5.addSlider("speed")
    .setPosition(10, 10)
    .setSize(100, 20)
    .setRange(10, 100)
    .getCaptionLabel().setPaddingX(-30);
    ;
    
  cp5.addSlider("damp")
    .setPosition(10, 35)
    .setSize(100, 20)
    .setRange(0, 1)
    .setValue(1)
    .getCaptionLabel().setPaddingX(-30);
    ;
    
  cp5.addSlider("drag")
    .setPosition(10, 60)
    .setSize(100, 20)
    .setRange(0, 0.001)
    .setValue(0)
    .getCaptionLabel().setPaddingX(-30);
    ;
    
  cp5.addSlider("vent")
    .setPosition(10, 85)
    .setSize(100, 20)
    .setRange(0, 1)
    .setValue(0)
    .getCaptionLabel().setPaddingX(-30);
    ;
    
  cp5.addSlider("water")
    .setPosition(10, 110)
    .setSize(100, 20)
    .setRange(0, 1)
    .setValue(1)
    .getCaptionLabel().setPaddingX(-30);
    ;



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
  float damp = cp5.get(Slider.class, "damp").getValue();
  vel.add(grav);
  
  drag = vel.copy();
  drag.mult(vel.mag() * cp5.get(Slider.class, "drag").getValue());
  
  vel.add(drag);
  
  vent.set(-1, 0);
  vent.mult( cp5.get(Slider.class, "vent").getValue());
  vel.add(vent);
  
  if (pos.y > height*2/3) {
    vel.mult(0.8);
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

float getSlider(String str) {
  return cp5.get(Slider.class, str).getValue();
}
