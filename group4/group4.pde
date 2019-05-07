import java.util.*;
import java.io.*;
interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing
  float xinc = random(-1, 1);
  float yinc = random(-1, 1);

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
}

class Rock extends Thing {
  PImage img1;
  //PImage img2;
  
  Rock(float x, float y) {
    super(x, y);
    if (random(2) > 1) {
      img1 = loadImage("Rock.png");
    } else {
      img1 = loadImage("Rock2.png");
    }
  }

  void display() {
    image(img1, x, y, 200, 100);
    /*
    fill(128, 128, 128); //Gray
    ellipse(x, y, 100, 70);
    fill(0);
    //Smiley face
    circle(x - 15, y - 15, 10);
    circle(x + 15, y - 15, 10);
    */
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  
  void display() {
    super.display();
    fill(0);
    circle(x - 15, y - 15, 10);
    circle(x + 15, y - 15, 10);
  }
  
  void move() { //change x, y by small increments
  /*  a) Random Movement to test it out
    b) A simple path (may need some instance variables from here onward)
    c) A more complex path
    d) Randomly choose between several paths.  (you may need a new constructor for this)
    ONE PERSON WRITE THIS */
   ////////LINEAR WITH BOUNCES///////
  /*x += xinc;
    y += yinc;
    */
    
    ///////SPIRAL AND REWIND//////
    x +=  10 * cos(xinc);
    y +=  10 * sin(yinc);
    
      
   ////////BOUNCING///////// 
     if (x >= 1000 || x <= 0){
      xinc *= -1;
    }
    if (y >= 800 || y <= 0){
      yinc *= -1;
    }
  }
}


class Ball extends Thing implements Moveable {
  PImage img;
  Ball(float x, float y) {

    super(x, y);
  }

  void display() {
    /* ONE PERSON WRITE THIS  --Alma */
    float r = random(0, 255);
    float g = random(0, 255);
    float b = random(0, 255);
    float axis1 = random(40, 51);
    float axis2 = random(40, 51);
    if (random(2) >= .5){
      fill(r, g, b);
      ellipse(x, y, axis1, axis2);
    }
    else{
      img = loadImage("ballBlue.jpeg");
      image(img, x, y, axis1, axis2);
    }
  }

  void move() {
    /* ONE PERSON WRITE THIS */
    if (x == 1000 && y == 800){
       x -= 1; 
       y -= 1;
    } else 
    if (y == 800){
       y -= 1; 
       x += random(3) - 1;
    } else
    if (x == 1000){
      x -= 1;
      y += random(3) - 1;
    } else {
    x += random(3) - 1;
    y += random(3) - 1;
    }
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
  }
}
void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
}
