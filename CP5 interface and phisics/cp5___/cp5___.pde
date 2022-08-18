import controlP5.*;
ControlP5 cp5;

Slider slider1;

void setup() {
  size(400, 600);
  cp5 = new ControlP5(this);
  cp5.setFont(createFont("Ubuntu", 15));
  
  slider1 = cp5.addSlider("slider")
    .setPosition(100, 50)
    .setSize(150, 30)
    .setRange(0, 255)
    ;
    
  cp5.addTextfield("input")
    .setPosition(100, 80)
    .setSize(150, 30)
    ;
}

void draw() {
  background(120);
  println(slider1.getValue());
}
