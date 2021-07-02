import processing.sound.*;
SoundFile builtSound;
SoundFile humanSound;
SoundFile naturSound;

int x = 100;
int y = 100;
int triangleSide = 500;

// declare circle size variables
float circleX;
float circleY;
float circleDiameter;

float[] pointHuman = {triangleSide/2+x, 0+y};
float[] pointBuilt = {0+x, sqrt(pow(triangleSide,2) - pow(triangleSide/2,2))+y};
float[] pointNatur = {triangleSide+x,sqrt(pow(triangleSide,2) - pow(triangleSide/2,2))+y};

float gainHuman;
float gainBuilt;
float gainNatur;
      

// declare volume variables must be in range [0 1]
float builtAmp = 1;
float humanAmp = 1;
float naturAmp = 1;

// ..TO DO..
// x load sound loop
// x big triangle
// x draggable circle 
// x load all loops
// x percent loudness from circle position and size
// x centre point of triangle
// x percent towards each point
// x display percent
// x add labels to triangle

// slider to change circle diameter
// add instructions
// convert to p5.js
// https://p5js.org/reference/#/p5.SoundFile
// scale to screen size
// email result

// ..BUGS..
// only change fill colour of circle when dragging
// stop circle being dragged beyond triangle
// cursor can overtake circle and stop dragging

void setup() {
  size(1000, 1000);
  background(255);
  // Load soundfile from the data folder of the sketch and play it back in a loop
  builtSound = new SoundFile(this, "Build_CCtr_01.mp3");
  humanSound = new SoundFile(this, "HVoc_CCtr_01.mp3");
  naturSound = new SoundFile(this, "Nat_QSqr_01.mp3");
  
  // start the loops
  builtSound.loop(1,builtAmp); // (rate, amp)
  humanSound.loop(1,humanAmp);
  naturSound.loop(1,naturAmp);
  circleX = width/2;
  circleY = height/2;
  circleDiameter = 20;

  
}      

void draw() {

  background(64);
  //triangle(pointHuman[0], pointHuman[1], pointBuilt[0], pointBuilt[1], pointNatur[0], pointNatur[1]);
  
  noFill();
  ellipseMode(RADIUS);
  arc(pointHuman[0], pointHuman[1], triangleSide, triangleSide, radians(60), radians(120));
  arc(pointBuilt[0], pointBuilt[1], triangleSide, triangleSide, radians(300), radians(360));
  arc(pointNatur[0], pointNatur[1], triangleSide, triangleSide, radians(180), radians(240));
  
  circle(pointHuman[0], pointHuman[1], 5);
  circle(pointBuilt[0], pointBuilt[1], 5);
  circle(pointNatur[0], pointNatur[1], 5);
    
  textSize(32);
  text("Human", pointHuman[0]-50, pointHuman[1]-10); 
  text("Built", pointBuilt[0]-80, pointBuilt[1]); 
  text("Nature", pointNatur[0]+10, pointNatur[1]);

  if (dist(mouseX, mouseY, circleX, circleY) < circleDiameter/2) {
    //mouse is inside the circle

    if (mousePressed) {
      //mouse is inside the circle and clicked
      //color it bright green and move the circle
      fill(64, 256, 64);
      circleX = mouseX;
      circleY = mouseY;
      
      gainHuman = 1-sqrt(pow(pointHuman[0] - mouseX,2) + pow(pointHuman[1] - mouseY, 2)) / triangleSide;
      gainBuilt = 1-sqrt(pow(pointBuilt[0] - mouseX,2) + pow(pointBuilt[1] - mouseY, 2)) / triangleSide;
      gainNatur = 1-sqrt(pow(pointNatur[0] - mouseX,2) + pow(pointNatur[1] - mouseY, 2)) / triangleSide;
      humanSound.amp(gainHuman);
      builtSound.amp(gainBuilt);
      naturSound.amp(gainNatur);
      
      println("1");
      //print("human: ");
      //println(gainHuman);
      //print("Built: ");
      //println(gainBuilt);
      //print("Natur: "); 
      //println(gainNatur);
      // calculate percentage for each loop
    } else {
      //mouse is inside the circle but not clicked
      //highlight the circle light green but don't move it
      fill(128, 256, 128);
    }
  } else {
    //mouse is outside the circle, color it gray
    fill(128);
  }
  
  textSize(32);
  text("Human:  " + nf((gainHuman)*100,3,1) + "%", 10, 30); 
  textSize(32);
  text("Built:  " + nf((gainBuilt)*100,3,1) + "%", 10, 60); 
  textSize(32);
  text("Nature: " + nf((gainNatur)*100,3,1) + "%", 10, 90);

  ellipse(circleX, circleY, circleDiameter, circleDiameter);
}
