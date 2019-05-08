import java.util.*;
import java.io.*;
PImage ballImg;


interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

interface Collideable{
 boolean isTouching(Thing other); 
}

abstract class Thing implements Displayable, Collideable {
  float x, y;//Position of the Thing
  float xinc = random(-3, 3);
  float yinc = random(-3, 3);

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
  abstract boolean isTouching(Thing other);
}

class Rock extends Thing {
  PImage img1;
  //PImage img2;
  int width = 200;
  int height = 100;
  
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
  
  boolean isTouching(Thing other) {
    return true;
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  
  void display() {
    super.display();
    fill(0);

    ellipse(x + 50, y+10, 10, 10);
    ellipse(x + 80, y+10, 10, 10);
  }
  
  void move() { //change x, y by small increments

  /*  a) Random Movement to test it out
    b) A simple path (may need some instance variables from here onward)
    c) A more complex path
    d) Randomly choose between several paths.  (you may need a new constructor for this)
    ONE PERSON WRITE THIS */
   ////////LINEAR WITH BOUNCES///////
  x += xinc;
  y += yinc;
    
    
    ///////SPIRAL AND REWIND//////
   // x +=  10 * cos(xinc);
   // y +=  10 * sin(yinc);
    
      
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
  float xspeed = random(-1,1);
  float yspeed = random(-1,1);
  PImage img;
  float[] colors = new float[3];
  boolean picYes = false;
  boolean complex = false;
  float axis1, axis2;
  Ball(float x, float y, PImage img) {
    super(x, y);
    //save the image
    this.img = img;
    //random color
    for (int i = 0; i<3; i++){
     colors[i] = random(0, 256); 
    }
    //boolean to decide
    if (random(2) <= .75) {
     if (random(2) <= .65){
      complex = true;
     }else {
      picYes = true; 
     }
    }
    //making sizes
    axis1 = random(30, 55);
    axis2 = random(30, 55);
  }
  
  boolean isTouching(Thing other){
   if (other.x <= (this.x+20) && other.x >= (this.x-20) 
       && other.y <= (this.y+20) && other.y >= (this.y-20)){
        return true; 
   }
   return false;
  }

  void display() {
    /* ONE PERSON WRITE THIS  --Alma */

    //deciding between pic, simple and complex
    if (!picYes){
      fill(colors[0], colors[1], colors[2]);

      ellipse(x, y, axis1, axis2);
      if (complex){
       fill(colors[1], colors[2], colors[0]);
       ellipse(x, y, axis1*.75, axis2*.75);
       fill(colors[2], colors[0], colors[1]);
       ellipse(x, y, axis1/2, axis2/2);
       rectMode(CENTER);
       fill(colors[0], colors[2], colors[1]);
       rect(x, y, axis1/3, axis2/3);
       rectMode(CORNER);
      }
    }
    else{
      image(img, x, y, axis1, axis2);
    }

  }
  //if touching
  void crazy(){
    
  }

  void move() {
    /* ONE PERSON WRITE THIS  Alex */
     //random movement
    if (x + axis1 / 2 >= width && y  + axis2 / 2 >= height || x - axis1 / 2 <= 0 && y - axis2 / 2 <= 0){
       xspeed *= -1; 
       yspeed *= -1;
    } else 
    if (y  + axis2 / 2 >= height || y - axis2 / 2 <= 0){
       yspeed *= -1; 
     //  xspeed *= - 1;
    } else
    if (x + axis1 / 2 >= width || x - axis1 / 2 <= 0){
      xspeed *= -1;
     // yspeed *= - 1;
    }
    x += xspeed;
    y += yspeed;
    }
    
    /* movement in straight lines but random*/
    //if (direction == 0){
      // x 
    //}
  }


/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);
  //balls image
  ballImg = loadImage("ballBlue.jpeg");
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100), ballImg);
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
  } //this might be bad practice to change display of ball when processing is doing rock
  for (Moveable thing : thingsToMove) {
    thing.move();
  }

  
}