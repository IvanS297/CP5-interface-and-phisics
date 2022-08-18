import controlP5.*;
ControlP5 cp5;
void setup() {
  size(800, 600, P3D);
  cp5 = new ControlP5(this);
  cp5.setFont(createFont("Ubuntu", 20));

  cp5.addButton("btn")
    .setPosition(10, 10)
    .setSize(100, 30)
    .setLabel("button");
  ;

  cp5.addSlider("slider")
    .setPosition(10, 50)
    .setSize(100, 30)
    .setLabel("size")
    .setRange(0, 100)
    .setNumberOfTickMarks(10+1);
  ;

  cp5.addColorWheel("col", 10, 100, 130);
  
  cp5.addKnob("knob")
    .setRange(0, 360)
    .setValue(0)
    .setPosition(10, 320)
    .setRadius(50)
    .setDragDirection(Knob.HORIZONTAL)
    ;

  String list[] = {"circle", "rect", "triangle"};
  cp5.addScrollableList("dropdown")
    .setPosition(10, 270)
    .setSize(150, 200)
    .setBarHeight(30)
    .setItemHeight(30)
    .addItems(list)
    .close()
    ;
    
}

void knob(int val) {
  rot = val;
}

void btn() {
  println("click");
}
void slider(int val) {
  d = val;
}
void dropdown(int num) {
  println(num);
  fig = num;
}

int x=500, y=250, d;
int fig = 0;
int rot = 0;
color col;
void draw() {
  background(255);
  
  fill(110);
  rect(0, 0, 200, height);
  fill(col);
  rotateZ(radians(rot));
  switch (fig) {
  case 0:
    circle(x, y, d);
    break;
  case 1:
    square(x, y, d);
    break;
  case 2:
    triangle(x, y, x+d, y+d, x+d, y-d);
    break;
  }
  rotateZ(-radians(rot));
}
