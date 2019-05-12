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
  float axis1; //width
  float axis2; //height
  

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  abstract void display();
  //this should be false, it's modified in rock and livign rock but for balls, they should never be touching something
  //like how in the example code on the website, only when a rock is touching a ball is the ball affected
  
  boolean isTouching(Thing other){
    
    if (abs(x - other.x) < axis1 / 2 + other.axis1 / 2 && abs(y - other.y) < axis2 / 2 + other.axis2 / 2) {
      return true;
    }
    
    return false;
  }
  
}

class Rock extends Thing {
  PImage img1;
  
  Rock(float x, float y) {
    super(x, y);
    if (random(2) > 1) {
      img1 = loadImage("Rock.png");
    } else {
      img1 = loadImage("Rock2.png");
    }
    axis1 = 200;
    axis2 = 100;
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
  PImage eyes;
  PImage surprisedEyes;
  boolean surprised;
  
  LivingRock(float x, float y) {
    super(x, y);
    xinc = random(-3, 3);
    yinc = random(-3, 3);
    angle = random(360);
    ogX = random(800);
    ogY = random(1000);
    eyes = loadImage("normalEyes.png");
    surprisedEyes = loadImage("eyes.png");
    surprised = false;
  }
  
  void display() {
    super.display();
    if (surprised) {
      image(surprisedEyes, x + 80, y + 10, 50, 25);
    } else {
      image(eyes, x + 80, y + 10, 50, 25);
    }
    /* Old eyes
    fill(0);
    ellipse(x + 50, y+10, 10, 10);
    ellipse(x + 80, y+10, 10, 10);
    */
  }
  
  void surprised() {
    surprised = true;
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
  float xspeed = random(-5,5);
  float yspeed = random(-5,5);
  float[] colors = new float[3];
  //boolean complex = false; removed this because i want all the ball1s to be complex
  boolean crazy = false; 
  int acceleration = 2;
  //float axis1, axis2;
  Ball(float x, float y) {
    super(x, y);
    //random color
    for (int i = 0; i<3; i++){
     colors[i] = random(0, 256); 
    }
    //boolean to decide
    //if (random(2) <= 1.5) {
    // complex = true;
    //}
    //making sizes
    axis1 = random(30, 55);
    axis2 = random(30, 55);
  }
  //if istouching, set crazy true
  //
  //remember isTouching is only for rocks. for balls it's always false

  void display() {}
  //if touching
  void crazy(){
    crazy = true;
  }

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
    yspeed = random(.5);
    xspeed = 5 * (sin(y / 5) + cos(y / 5));
   }
   boolean checker = true;
   int counter = 0;
   float oldx = .5;
   float oldy = 5 * sin(x / 5);
   //
   //
   //isTouching only relevant for rocks
  //
  //
  //
  //
  //NO IMAGE FOR BALL1
   void display() { //will set crazy false at the end so that if ball is no longer touching, won't be stuck in infinite loop
    /* ONE PERSON WRITE THIS  --Alma */
      //spikes on the ball
      float r, g, b;
      if (crazy) {
        r = 255;
        g = 0;
        b = 0;
      }else{
        r = colors[0];
        g = colors[1];
        b = colors[2];
      }
      fill(r, b, g);
      triangle((x+axis1/2), y, (x-axis1/2), y, x, (y+(axis2/2) + (axis2/6))); //up
      triangle((x+axis1/2), y, (x-axis1/2), y, x, (y-(axis2/2) - (axis2/6))); //down
      triangle(x, (y+axis2/2), x, (y-axis2/2), (x+(axis1/2) + (axis1/6)), y); //left
      triangle(x, (y+axis2/2), x, (y-axis2/2), (x-(axis1/2) - (axis1/6)), y); //right
      //the ball
      fill(r, g, b);
      ellipse(x, y, axis1, axis2);
      //if (complex){
       //make the colors blend
      for (int i = 0; i<3; i++){
        colors[i] = colors[i] + 2;
        if (colors[i] > 255){
         colors[i] = 0;
         }
       }
       //not sure how to make change to colors affect rgb only when not crazy so j rewrite the if statemetn
       if (crazy) {
        r = 255;
        g = 0;
        b = 0;
      }else{
        r = colors[0];
        g = colors[1];
        b = colors[2];
      }
      //
       fill(g, b, r);
       ellipse(x, y, axis1*.75, axis2*.75); //first inner circle
       fill(g, r, b);
       ellipse(x, y, axis1/2, axis2/2); //inner most circle
       rectMode(CENTER);
       fill(r, g, b);
       rect(x, y, axis1/3, axis2/3); //a rectangle
       rectMode(CORNER);
       //triangle outside
      //}
      crazy = false; //this way you don't need to check if no longer touching
      //if they're still touching crazy will be set to true next frame
  }
  //
  //
  void move() {
    /* ONE PERSON WRITE THIS  Alex */
     //random movement
    if (x + axis1 / 2 >= width - 20 && y  + axis2 / 2 >= height - 10 || x - axis1 / 2 <= 20 && y - axis2 / 2 <= 10){
        //x += 10 * (sin(y / 5) + cos(y / 5));
        xspeed *= -1;
       yspeed *= - (1);
       counter++;
    } else 
    if (y  + axis2 / 2 >= height - 10 || y - axis2 / 2 <= 10){
       yspeed *= -(1); 
     //  xspeed *= - 1;
    } else
    if (x + axis1 / 2 >= width - 20 || x - axis1 / 2 <= 20){
      xspeed *= -1;
      counter++;
     //yspeed *= - 1;
     //x += 10 * (sin(y / 5) + cos(y / 5));
    } 
    if (counter >= 2){
      float holderx = xspeed;
      float holdery = yspeed;
      xspeed = oldx;
      yspeed = oldy;
      oldx = holderx;
      oldy = holdery;
      counter = 0;
      checker = !checker;
    }
    if (checker == true){
    y += yspeed;
    x += xspeed;
    } else {
      x += xspeed;
      y += yspeed;
    }
}
 }
 
 class Ball2 extends Ball{
   PImage img;
   //boolean picYes = true; --> commented this out bc i want all Ball2 to be image
   //g and n represent max bounce height for each ball
   float g = random(height);
   float n = random(width);
   Ball2(float x, float y, PImage img){
     super(x, y); 
     this.img = img;
     xspeed = .7 * y / 100;
     yspeed = 2;
     //if (random(2)  <= 1){
     // picYes = false; 
     //} else {
     axis1 = 50;
     axis2 = 50;
     //}
   }
   int counter = 0;
   float oldx = 2;
   float oldy = .7 * x / 100;
   boolean checker = true;
   
   //
   //
   //
   //
   
   //isTouching only relevant for rocks
   void display(){
    //if (picYes){
      fill(colors[0] + 25, colors[1] + 25, colors[2] + 25); //so they're diff shades from ball1
      if (crazy) {
        fill(255, 0, 0);
      }
      ellipse(x, y, 50, 50);
      image(img, x-25, y-25, 50, 50);
    //}else{
     //make a new shape 
       crazy = false;
    //}
   }
   
   void move() {
    /* ONE PERSON WRITE THIS  Alex */
     //random movement with boundaries of height of each bounce
     
    if (x + axis1 / 2 >= width && y  + axis2 / 2 >= height || x - axis1 / 2 <= 0 && y - axis2 / 2 <= 0){
       xspeed *= - 1;
        yspeed *= - 1;
        counter++;
    } else 
    if (y  + axis2 / 2 >= height || y - axis2 / 2 <= 0){
      //xspeed *= - random(1);
      yspeed *= - 1;
      counter++;
    } else
    if (x + axis1 / 2 >= width || x - axis1 / 2 <= 0){
     xspeed *= - 1;
     counter++;
     // yspeed *= - random(1);
    }
    if (counter >= 3){
      float holderx = xspeed;
      float holdery = yspeed;
      xspeed = oldx;
      yspeed = oldy;
      oldx = holderx;
      oldy = holdery;
      counter = 0;
      checker = !checker;
    }
    if (checker){
    x += xspeed;
    y += yspeed;
    } else {
      y += yspeed;
      x += xspeed;
  }
   }
   
 }


/*DO NOT EDIT THE REST OF THIS */
//edited for collideable
ArrayList<Rock> rocksToDisplay;
ArrayList<Ball> ballsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> listOfCollideables;

void setup() {
  size(1000, 800);
  //balls image
  ballImg = loadImage("basketball.png");
  rocksToDisplay = new ArrayList<Rock>();
  ballsToDisplay = new ArrayList<Ball>(); //made this seperation bc needs to be distinction between balls and other rocks 
  thingsToMove = new ArrayList<Moveable>();
  listOfCollideables = new ArrayList<Collideable>();
  
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball1(50+random(width-100), 50+random(height-100));
    ballsToDisplay.add(b);
    thingsToMove.add(b);
    Ball b2 = new Ball2(50+random(width-100), 50+random(height-100), ballImg);
    ballsToDisplay.add(b2);
    thingsToMove.add(b2);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    rocksToDisplay.add(r);
    listOfCollideables.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    rocksToDisplay.add(m);
    thingsToMove.add(m);
    listOfCollideables.add(m);
  }
}
void draw() {
  background(255);
  for (Rock thing : rocksToDisplay) {
    thing.display();
  }
  for (Ball b : ballsToDisplay) {
     b.display();
     for( Collideable c : listOfCollideables) {
       if ( c.isTouching(b)){
        b.crazy();
       }
     }
  } 
  for (Moveable thing : thingsToMove) {
    thing.move();
  }

  
}
