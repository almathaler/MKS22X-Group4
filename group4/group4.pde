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
  float xinc;
  float yinc;
  float angle;
  float ogX;
  float ogY;
  

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
  //this should be false, it's modified in rock and livign rock but for balls, they should never be touching something
  //like how in the example code on the website, only when a rock is touching a ball is the ball affected
  boolean isTouching(Thing other){
    return false;
  }
}

class Rock extends Thing {
  PImage img1;
  //PImage img2;
  int axis1 = 200; //width
  int axis2 = 100; //height
  
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
    /*
    if (abs(x - other.x) < axis1 / 2 + other.axis1 / 2 && abs(y - other.y) < axis2 / 2 + other.axis2 / 2) {
      return true;
    }
    */
    return false;
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
    xinc = random(-3, 3);
    yinc = random(-3, 3);
    angle = random(360);
    ogX = random(800);
    ogY = random(1000);

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
   ////////LINEAR///////
  /*x += xinc;
  y += yinc;*/
  
   ///////ELLIPSE//////
  /* angle += 0.05;
   x = 60 * cos(angle) + ogX;
   y = 80 * sin(angle) + ogY; */
    
   /////STAR/////
   angle += 0.05;
   x = 60* pow(cos(angle),3) + ogX;
   y = 80* pow(sin(angle),3) + ogY;
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
  float[] colors = new float[3];
  boolean complex = false;
  boolean crazy = false;
  float axis1, axis2;
  Ball(float x, float y) {
    super(x, y);
    //random color
    for (int i = 0; i<3; i++){
     colors[i] = random(0, 256); 
    }
    //boolean to decide
    if (random(2) <= 1.5) {
     complex = true;
    }
    //making sizes
    axis1 = random(30, 55);
    axis2 = random(30, 55);
  }
  //if istouching, set crazy true
  void setCrazy(boolean b){
   crazy = b; 
  }
  //
  //remember isTouching is only for rocks. for balls it's always false

  void display() {}
  //if touching
  void crazy(){}

  void move() {}
    
    /* movement in straight lines but random*/
    //if (direction == 0){
      // x 
    //}
  }
 // 
 // 
 //this will be j like original ball
 class Ball1 extends Ball{
   Ball1(float x, float y){
    super(x, y); 
   }
   //
   //
   //isTouching only relevant for rocks
  //
  //
   void crazy(){
     //will fill later
   }
  //
  //
  //NO IMAGE FOR BALL1
   void display() {
    /* ONE PERSON WRITE THIS  --Alma */
      //spikes on the ball
      fill(colors[0], colors[2], colors[1]);
      triangle((x+axis1/2), y, (x-axis1/2), y, x, (y+(axis2/2) + (axis2/6))); //up
      triangle((x+axis1/2), y, (x-axis1/2), y, x, (y-(axis2/2) - (axis2/6))); //down
      triangle(x, (y+axis2/2), x, (y-axis2/2), (x+(axis1/2) + (axis1/6)), y); //left
      triangle(x, (y+axis2/2), x, (y-axis2/2), (x-(axis1/2) - (axis1/6)), y); //right
      //the ball
      fill(colors[0], colors[1], colors[2]);
      ellipse(x, y, axis1, axis2);
      if (complex){
       //make the colors blend
      for (int i = 0; i<3; i++){
        colors[i] = colors[i] + 5;
        if (colors[i] > 255){
         colors[i] = 0;
         }
       }
       fill(colors[1], colors[2], colors[0]);
       ellipse(x, y, axis1*.75, axis2*.75); //first inner circle
       fill(colors[2], colors[0], colors[1]);
       ellipse(x, y, axis1/2, axis2/2); //inner most circle
       rectMode(CENTER);
       fill(colors[0], colors[2], colors[1]);
       rect(x, y, axis1/3, axis2/3); //a rectangle
       rectMode(CORNER);
       //triangle outside
      }
  }
  //
  //
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
 }
 
 class Ball2 extends Ball{
   PImage img;
   boolean picYes = true;
   Ball2(float x, float y, PImage img){
     super(x, y); 
     this.img = img;
     if (random(2)  <= 1){
      picYes = false; 
     }
   }
   //
   //
   void crazy(){
   
   }
   //
   //
   
   //isTouching only relevant for rocks
   void display(){
    if (picYes){
      image(img, x, y, 50, 50);
    }else{
     //make a new shape 
     fill(colors[0] + 25, colors[1] + 25, colors[2] + 25); //so they're diff shades from ball1
     ellipse(x, y, axis1, axis2);
    }
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
   
 }


/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> listOfCollideables;
void setup() {
  size(1000, 800);
  //balls image
  ballImg = loadImage("basketball.png");
  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  listOfCollideables = new ArrayList<Collideable>();
  
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball1(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Ball b2 = new Ball2(50+random(width-100), 50+random(height-100), ballImg);
    thingsToDisplay.add(b2);
    thingsToMove.add(b2);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
    listOfCollideables.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
    listOfCollideables.add(m);
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
