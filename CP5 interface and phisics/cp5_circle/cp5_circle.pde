import controlP5.*;
ControlP5 cp5;

PVector pos, vel, grav;
int r = 25;

void setup() {
  size(640, 480);
  frameRate(60);
  pos = new PVector(width/2, height/2);
  grav = new PVector(0, 0.5);
  vel = PVector.random2D();

  cp5 = new ControlP5(this);
  cp5.addSlider("speed")
    .setPosition(10, 10)
    .setSize(100, 20)
    .setRange(10, 100)
    ;
    
  cp5.addSlider("damp")
    .setPosition(10, 35)
    .setSize(100, 20)
    .setRange(0, 1)
    .setValue(1)
    ;

  cp5.addButton("reset")
    .setPosition(10, 70)
    .setSize(100, 20)
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
  circle(pos.x, pos.y, 2*r);
}
