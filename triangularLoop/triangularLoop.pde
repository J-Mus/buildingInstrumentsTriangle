// interesting - another solution using PVector: https://gist.github.com/apclarity/cd1ed66bb79862191f7ad7ec50dd8314

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


// constraint variables (to keep in the arcs)
 int arcConstrain1;
 
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
// scale to screen size
// email result

// ..BUGS..
// only change fill colour of circle when dragging < optional
// stop circle being dragged beyond triangle < done
// cursor can overtake circle and stop dragging    << fixed
// ***** follow this example: https://processing.org/examples/constrain.html *****

void setup() {
  size(1000, 1000);
  background(255);
  // Load soundfile from the data folder of the sketch and play it back in a loop
  builtSound = new SoundFile(this, "Built_CCtr_00.mp3");
  humanSound = new SoundFile(this, "HVoc_CCtr_00.mp3");
  naturSound = new SoundFile(this, "Nat_CCtr_00.mp3");
  
  // start the loops
  builtSound.loop(1,builtAmp); // (rate, amp)
  humanSound.loop(1,humanAmp);
  naturSound.loop(1,naturAmp);
  circleX = width/2;
  circleY = height/2;
  circleDiameter = 60;

  
}      

void draw() {

  background(64);
  //triangle(pointHuman[0], pointHuman[1], pointBuilt[0], pointBuilt[1], pointNatur[0], pointNatur[1]);
  
   // arcConstrain1 = arc(pointHuman[0], pointHuman[1], triangleSide, triangleSide, radians(60), radians(120));

//float constra = constrain(mouseX, 0, 500);
  
  noFill();
  ellipseMode(RADIUS);
  arc(pointHuman[0], pointHuman[1], triangleSide, triangleSide, radians(60), radians(120));
  arc(pointBuilt[0], pointBuilt[1], triangleSide, triangleSide, radians(300), radians(360));
  arc(pointNatur[0], pointNatur[1], triangleSide, triangleSide, radians(180), radians(240));
  
  //println(pointHuman);
  
  circle(pointHuman[0], pointHuman[1], 5);
  circle(pointBuilt[0], pointBuilt[1], 5);
  circle(pointNatur[0], pointNatur[1], 5);
    
  textSize(32);
  text("Human", pointHuman[0]-50, pointHuman[1]-10); 
  text("Built", pointBuilt[0]-80, pointBuilt[1]); 
  text("Nature", pointNatur[0]+10, pointNatur[1]);
  
      float thetaHuman = 60;     // angle to iterate through to get co-ordinates the arc
      float [][] humanBuiltArcCart = new float [60][60];
  //  humanBuiltArcCart = {{pointBuilt[0] + triangleSide*cos(thetaHuman) ,  pointBuilt[1] + triangleSide*sin(thetaHuman)}};// new float[60][2]; // =  {{pointBuilt[0] + triangleSide*cos(thetaHuman), pointBuilt[1] + triangleSide*sin(thetaHuman)}};
      
     // humanBuiltArcCart [0][0] = {{pointBuilt[0] + triangleSide*cos(thetaHuman) ,  pointBuilt[1] + triangleSide*sin(thetaHuman)}};
      //println(humanBuiltArcCart);
      
      float thetaBuilt = 300;     // angle to iterate through to get co-ordinates the arc
      float [][] builtNaturArcCart = new float [60][60];  //=  {{pointBuilt[0] + triangleSide*cos(thetaBuilt)}, {pointBuilt[1] + triangleSide*sin(thetaBuilt)}};
      
      float thetaNatur = 180;     // angle to iterate through to get co-ordinates the arc
      float [][] naturHumanArcCart = new float [60][60];  //=  {{pointNatur[0] + triangleSide*cos(thetaNatur)}, {pointNatur[1] + triangleSide*sin(thetaNatur)}};
      
  for(int i = 0; i <= 59; i++){
    
    //for(int j = 0; j <=2; j++){
  

    naturHumanArcCart[i][0] = pointBuilt[0] + triangleSide*cos(radians(thetaBuilt));
    naturHumanArcCart[i][1] = pointBuilt[1] + triangleSide*sin(radians(thetaBuilt));
    thetaBuilt = thetaBuilt + 1;
    stroke(255);   // naturHuman =  white
    ellipse(naturHumanArcCart[i][0], naturHumanArcCart[i][1], 20, 20);
    
    humanBuiltArcCart[i][0] = pointNatur[0] + triangleSide*cos(radians(thetaNatur));
    humanBuiltArcCart[i][1] = pointNatur[1] + triangleSide*sin(radians(thetaNatur)); 
    thetaNatur = thetaNatur + 1;
    stroke(0, 255, 0);  //humanBuilt = green
    ellipse(humanBuiltArcCart[i][0], humanBuiltArcCart[i][1], 20, 20);
    
    builtNaturArcCart[i][0] = pointHuman[0] + triangleSide*cos(radians(thetaHuman));    //theta human is measured from the human point.
    builtNaturArcCart[i][1] = pointHuman[1] + triangleSide*sin(radians(thetaHuman));
    thetaHuman = thetaHuman + 1;
    stroke(0, 0, 255);    // builtNatur = blue
    ellipse(builtNaturArcCart[i][0], builtNaturArcCart[i][1], 20, 20);
    
    //println(i, "i");
    //println(builtNaturArcCart[i][0], builtNaturArcCart[i][1], "arc cartesians");
    //println(thetaHuman,"thetaHuman");
    
   
  /*       circleX = constrain(circleX,  humanBuiltArcCart[0][0] +200, naturHumanArcCart[i][0] + triangleSide);// constrain corcle in the arcs

     circleY = constrain(circleY, humanBuiltArcCart[0][0] +200, height - naturHumanArcCart[0][i]);
     
     circleY = constrain(circleY, naturHumanArcCart[0][0] -200, height - builtNaturArcCart[0][i]);
   
    */
   
    }   
  //}



  //  if (mousePressed) {
      
      
      
      //mouse is inside the circle and clicked
      //color it bright green and move the circle
      fill(64, 256, 64);
      circleX = mouseX;
      circleY = mouseY;
      
      float easing = 100;
   if (abs(mouseX - circleX) > 10) {
    circleX = circleX + (mouseX - circleX) * easing;
  }
  if (abs(mouseY - circleY) > 10) {
    circleY =circleY + (mouseY- circleY) * easing;
  }
  
  println(circleX, circleY, "location of mouse");    // doing - to hard code the x to the y... create constraints blocks, as many as possible see midori pad sunday_xxx-mr_22
                                                     // todo - try to make as smooth as possible, is it possible to itereate through circleY and then create constraints from arc and radians specifically?
  println(triangleSide, "triangleSide");             // todo - use a for loop to iterate through the if's....
  
  // ----------------- vertical limit constrtaint ----------------------
  circleY = constrain(circleY, humanBuiltArcCart[59][1] + (circleDiameter/2), builtNaturArcCart[29][1] - (circleDiameter/2));    // the middle of the arc is the tallest part of the triangle
  
  // ----------------- horizontal limit constraint ----------------------
  
  circleX = constrain(circleX, builtNaturArcCart[59][0] + (circleDiameter/2), builtNaturArcCart[0][0] - (circleDiameter/2));    
  
  // ----------------- constraint to builtNatur arc (bottom) --------------
  // the arc is split into horizontal segments of heights as follows (todo):
  // builtNaturArcCart[29][1] && builtNaturArcCart[29-1][1]    // height of box
  // builtNaturArcCart[59 - 29-1][0] , builtNaturArcCart[29][1] // horizontal constraint
  //
  // builtNaturArcCart[28][1] && builtNaturArcCart[28-1][1]    // height of box
  // builtNaturArcCart[59 - 28-1][0] , builtNaturArcCart[28][1] // horizontal constraint
  //
  // builtNaturArcCart[27][1] && builtNaturArcCart[27-1][1]    // height of box
  // builtNaturArcCart[59 - 27-1][0] , builtNaturArcCart[27][1] // horizontal constraint
  //
  
    fill(255,0,0); // red
   ellipse(builtNaturArcCart[59][0], builtNaturArcCart[59][1], 20, 20);
   
   fill(255, 0, 255); // magenta
 //   ellipse(naturHumanArcCart[59][0], naturHumanArcCart[59][1], 20, 20);
  
  println(builtNaturArcCart[0][0], " builtNaturArcCart x");
  
  if (circleX >= builtNaturArcCart[59][0] && circleX <= builtNaturArcCart[59-1][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-1][0] && circleX <= builtNaturArcCart[59-2][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-1][1] - (circleDiameter/2)); } 
  if (circleX >= builtNaturArcCart[59-2][0] && circleX <= builtNaturArcCart[59-3][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-2][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-3][0] && circleX <= builtNaturArcCart[59-4][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-3][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-4][0] && circleX <= builtNaturArcCart[59-5][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-4][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-5][0] && circleX <= builtNaturArcCart[59-6][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-5][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-6][0] && circleX <= builtNaturArcCart[59-7][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-6][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-7][0] && circleX <= builtNaturArcCart[59-8][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-7][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-8][0] && circleX <= builtNaturArcCart[59-9][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-8][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-9][0] && circleX <= builtNaturArcCart[59-10][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-9][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-10][0] && circleX <= builtNaturArcCart[59-11][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-10][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-11][0] && circleX <= builtNaturArcCart[59-12][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-11][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-12][0] && circleX <= builtNaturArcCart[59-13][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-12][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-13][0] && circleX <= builtNaturArcCart[59-14][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-13][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-14][0] && circleX <= builtNaturArcCart[59-15][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-14][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-15][0] && circleX <= builtNaturArcCart[59-16][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-15][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-16][0] && circleX <= builtNaturArcCart[59-17][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-16][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-17][0] && circleX <= builtNaturArcCart[59-18][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-17][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-18][0] && circleX <= builtNaturArcCart[59-19][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-18][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-19][0] && circleX <= builtNaturArcCart[59-20][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-19][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-20][0] && circleX <= builtNaturArcCart[59-21][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-20][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-21][0] && circleX <= builtNaturArcCart[59-22][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-21][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-22][0] && circleX <= builtNaturArcCart[59-23][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-22][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-23][0] && circleX <= builtNaturArcCart[59-24][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-23][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-24][0] && circleX <= builtNaturArcCart[59-25][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-24][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-25][0] && circleX <= builtNaturArcCart[59-26][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-25][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-26][0] && circleX <= builtNaturArcCart[59-27][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-26][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-27][0] && circleX <= builtNaturArcCart[59-28][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-27][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-28][0] && circleX <= builtNaturArcCart[59-29][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-28][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-29][0] && circleX <= builtNaturArcCart[59-30][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-29][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-30][0] && circleX <= builtNaturArcCart[59-31][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-30][1] - (circleDiameter/2)); } 
  if (circleX >= builtNaturArcCart[59-31][0] && circleX <= builtNaturArcCart[59-32][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-31][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-32][0] && circleX <= builtNaturArcCart[59-33][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-32][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-33][0] && circleX <= builtNaturArcCart[59-34][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-33][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-34][0] && circleX <= builtNaturArcCart[59-35][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-34][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-35][0] && circleX <= builtNaturArcCart[59-36][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-35][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-36][0] && circleX <= builtNaturArcCart[59-37][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-36][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-37][0] && circleX <= builtNaturArcCart[59-38][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-37][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-38][0] && circleX <= builtNaturArcCart[59-39][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-38][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-39][0] && circleX <= builtNaturArcCart[59-40][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-39][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-40][0] && circleX <= builtNaturArcCart[59-41][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-40][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-41][0] && circleX <= builtNaturArcCart[59-42][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-41][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-42][0] && circleX <= builtNaturArcCart[59-43][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-42][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-43][0] && circleX <= builtNaturArcCart[59-44][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-43][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-44][0] && circleX <= builtNaturArcCart[59-45][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-44][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-45][0] && circleX <= builtNaturArcCart[59-46][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-45][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-46][0] && circleX <= builtNaturArcCart[59-47][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-46][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-47][0] && circleX <= builtNaturArcCart[59-48][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-47][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-48][0] && circleX <= builtNaturArcCart[59-49][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-48][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-49][0] && circleX <= builtNaturArcCart[59-50][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-49][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-50][0] && circleX <= builtNaturArcCart[59-51][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-50][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-51][0] && circleX <= builtNaturArcCart[59-52][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-51][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-52][0] && circleX <= builtNaturArcCart[59-53][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-52][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-53][0] && circleX <= builtNaturArcCart[59-54][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-53][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-54][0] && circleX <= builtNaturArcCart[59-55][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-54][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-55][0] && circleX <= builtNaturArcCart[59-56][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-55][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-56][0] && circleX <= builtNaturArcCart[59-57][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-56][1] - (circleDiameter/2)); }
  if (circleX >= builtNaturArcCart[59-57][0] && circleX <= builtNaturArcCart[59-58][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-57][1] - (circleDiameter/2)); }  
  if (circleX >= builtNaturArcCart[59-58][0] && circleX <= builtNaturArcCart[59-59][0]) { circleY = constrain(circleY, 0 , builtNaturArcCart[59-58][1] - (circleDiameter/2)); }


  
  // ----------------- constraint to builtHuman (lhs) and naturHuman (rhs) arcs ----------------
  
  if (circleY <= humanBuiltArcCart[0][1] && circleY >= humanBuiltArcCart[1][1]) { circleX = constrain(circleX, humanBuiltArcCart[0][0] + (circleDiameter/2), naturHumanArcCart[59][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[1][1] && circleY >= humanBuiltArcCart[2][1]) { circleX = constrain(circleX, humanBuiltArcCart[1][0] + (circleDiameter/2), naturHumanArcCart[59-1][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[2][1] && circleY >= humanBuiltArcCart[3][1]) { circleX = constrain(circleX, humanBuiltArcCart[2][0] + (circleDiameter/2), naturHumanArcCart[59-2][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[3][1] && circleY >= humanBuiltArcCart[4][1]) { circleX = constrain(circleX, humanBuiltArcCart[3][0] + (circleDiameter/2), naturHumanArcCart[59-3][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[4][1] && circleY >= humanBuiltArcCart[5][1]) { circleX = constrain(circleX, humanBuiltArcCart[4][0] + (circleDiameter/2), naturHumanArcCart[59-4][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[5][1] && circleY >= humanBuiltArcCart[6][1]) { circleX = constrain(circleX, humanBuiltArcCart[5][0] + (circleDiameter/2), naturHumanArcCart[59-5][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[6][1] && circleY >= humanBuiltArcCart[7][1]) { circleX = constrain(circleX, humanBuiltArcCart[6][0] + (circleDiameter/2), naturHumanArcCart[59-6][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[7][1] && circleY >= humanBuiltArcCart[8][1]) { circleX = constrain(circleX, humanBuiltArcCart[7][0] + (circleDiameter/2), naturHumanArcCart[59-7][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[8][1] && circleY >= humanBuiltArcCart[9][1]) { circleX = constrain(circleX, humanBuiltArcCart[8][0] + (circleDiameter/2), naturHumanArcCart[59-8][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[9][1] && circleY >= humanBuiltArcCart[10][1]) { circleX = constrain(circleX, humanBuiltArcCart[9][0] + (circleDiameter/2), naturHumanArcCart[59-9][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[10][1] && circleY >= humanBuiltArcCart[11][1]) { circleX = constrain(circleX, humanBuiltArcCart[10][0] + (circleDiameter/2), naturHumanArcCart[59-10][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[11][1] && circleY >= humanBuiltArcCart[12][1]) { circleX = constrain(circleX, humanBuiltArcCart[11][0] + (circleDiameter/2), naturHumanArcCart[59-11][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[12][1] && circleY >= humanBuiltArcCart[13][1]) { circleX = constrain(circleX, humanBuiltArcCart[12][0] + (circleDiameter/2), naturHumanArcCart[59-12][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[13][1] && circleY >= humanBuiltArcCart[14][1]) { circleX = constrain(circleX, humanBuiltArcCart[13][0] + (circleDiameter/2), naturHumanArcCart[59-13][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[14][1] && circleY >= humanBuiltArcCart[15][1]) { circleX = constrain(circleX, humanBuiltArcCart[14][0] + (circleDiameter/2), naturHumanArcCart[59-14][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[15][1] && circleY >= humanBuiltArcCart[16][1]) { circleX = constrain(circleX, humanBuiltArcCart[15][0] + (circleDiameter/2), naturHumanArcCart[59-15][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[16][1] && circleY >= humanBuiltArcCart[17][1]) { circleX = constrain(circleX, humanBuiltArcCart[16][0] + (circleDiameter/2), naturHumanArcCart[59-16][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[17][1] && circleY >= humanBuiltArcCart[18][1]) { circleX = constrain(circleX, humanBuiltArcCart[17][0] + (circleDiameter/2), naturHumanArcCart[59-17][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[18][1] && circleY >= humanBuiltArcCart[19][1]) { circleX = constrain(circleX, humanBuiltArcCart[18][0] + (circleDiameter/2), naturHumanArcCart[59-18][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[19][1] && circleY >= humanBuiltArcCart[20][1]) { circleX = constrain(circleX, humanBuiltArcCart[19][0] + (circleDiameter/2), naturHumanArcCart[59-19][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[20][1] && circleY >= humanBuiltArcCart[21][1]) { circleX = constrain(circleX, humanBuiltArcCart[20][0] + (circleDiameter/2), naturHumanArcCart[59-20][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[21][1] && circleY >= humanBuiltArcCart[22][1]) { circleX = constrain(circleX, humanBuiltArcCart[21][0] + (circleDiameter/2), naturHumanArcCart[59-21][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[22][1] && circleY >= humanBuiltArcCart[23][1]) { circleX = constrain(circleX, humanBuiltArcCart[22][0] + (circleDiameter/2), naturHumanArcCart[59-22][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[23][1] && circleY >= humanBuiltArcCart[24][1]) { circleX = constrain(circleX, humanBuiltArcCart[23][0] + (circleDiameter/2), naturHumanArcCart[59-23][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[24][1] && circleY >= humanBuiltArcCart[25][1]) { circleX = constrain(circleX, humanBuiltArcCart[24][0] + (circleDiameter/2), naturHumanArcCart[59-24][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[25][1] && circleY >= humanBuiltArcCart[26][1]) { circleX = constrain(circleX, humanBuiltArcCart[25][0] + (circleDiameter/2), naturHumanArcCart[59-25][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[26][1] && circleY >= humanBuiltArcCart[27][1]) { circleX = constrain(circleX, humanBuiltArcCart[26][0] + (circleDiameter/2), naturHumanArcCart[59-26][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[27][1] && circleY >= humanBuiltArcCart[28][1]) { circleX = constrain(circleX, humanBuiltArcCart[27][0] + (circleDiameter/2), naturHumanArcCart[59-27][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[28][1] && circleY >= humanBuiltArcCart[29][1]) { circleX = constrain(circleX, humanBuiltArcCart[28][0] + (circleDiameter/2), naturHumanArcCart[59-28][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[29][1] && circleY >= humanBuiltArcCart[30][1]) { circleX = constrain(circleX, humanBuiltArcCart[29][0] + (circleDiameter/2), naturHumanArcCart[59-29][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[30][1] && circleY >= humanBuiltArcCart[31][1]) { circleX = constrain(circleX, humanBuiltArcCart[30][0] + (circleDiameter/2), naturHumanArcCart[59-30][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[31][1] && circleY >= humanBuiltArcCart[32][1]) { circleX = constrain(circleX, humanBuiltArcCart[31][0] + (circleDiameter/2), naturHumanArcCart[59-31][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[32][1] && circleY >= humanBuiltArcCart[33][1]) { circleX = constrain(circleX, humanBuiltArcCart[32][0] + (circleDiameter/2), naturHumanArcCart[59-32][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[33][1] && circleY >= humanBuiltArcCart[34][1]) { circleX = constrain(circleX, humanBuiltArcCart[33][0] + (circleDiameter/2), naturHumanArcCart[59-33][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[34][1] && circleY >= humanBuiltArcCart[35][1]) { circleX = constrain(circleX, humanBuiltArcCart[34][0] + (circleDiameter/2), naturHumanArcCart[59-34][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[35][1] && circleY >= humanBuiltArcCart[36][1]) { circleX = constrain(circleX, humanBuiltArcCart[35][0] + (circleDiameter/2), naturHumanArcCart[59-35][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[36][1] && circleY >= humanBuiltArcCart[37][1]) { circleX = constrain(circleX, humanBuiltArcCart[36][0] + (circleDiameter/2), naturHumanArcCart[59-36][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[37][1] && circleY >= humanBuiltArcCart[38][1]) { circleX = constrain(circleX, humanBuiltArcCart[37][0] + (circleDiameter/2), naturHumanArcCart[59-37][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[38][1] && circleY >= humanBuiltArcCart[39][1]) { circleX = constrain(circleX, humanBuiltArcCart[38][0] + (circleDiameter/2), naturHumanArcCart[59-38][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[39][1] && circleY >= humanBuiltArcCart[40][1]) { circleX = constrain(circleX, humanBuiltArcCart[39][0] + (circleDiameter/2), naturHumanArcCart[59-39][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[40][1] && circleY >= humanBuiltArcCart[41][1]) { circleX = constrain(circleX, humanBuiltArcCart[40][0] + (circleDiameter/2), naturHumanArcCart[59-40][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[41][1] && circleY >= humanBuiltArcCart[42][1]) { circleX = constrain(circleX, humanBuiltArcCart[41][0] + (circleDiameter/2), naturHumanArcCart[59-41][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[42][1] && circleY >= humanBuiltArcCart[43][1]) { circleX = constrain(circleX, humanBuiltArcCart[42][0] + (circleDiameter/2), naturHumanArcCart[59-42][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[43][1] && circleY >= humanBuiltArcCart[44][1]) { circleX = constrain(circleX, humanBuiltArcCart[43][0] + (circleDiameter/2), naturHumanArcCart[59-43][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[44][1] && circleY >= humanBuiltArcCart[45][1]) { circleX = constrain(circleX, humanBuiltArcCart[44][0] + (circleDiameter/2), naturHumanArcCart[59-44][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[45][1] && circleY >= humanBuiltArcCart[46][1]) { circleX = constrain(circleX, humanBuiltArcCart[45][0] + (circleDiameter/2), naturHumanArcCart[59-45][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[46][1] && circleY >= humanBuiltArcCart[47][1]) { circleX = constrain(circleX, humanBuiltArcCart[46][0] + (circleDiameter/2), naturHumanArcCart[59-46][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[47][1] && circleY >= humanBuiltArcCart[48][1]) { circleX = constrain(circleX, humanBuiltArcCart[47][0] + (circleDiameter/2), naturHumanArcCart[59-47][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[48][1] && circleY >= humanBuiltArcCart[49][1]) { circleX = constrain(circleX, humanBuiltArcCart[48][0] + (circleDiameter/2), naturHumanArcCart[59-48][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[49][1] && circleY >= humanBuiltArcCart[50][1]) { circleX = constrain(circleX, humanBuiltArcCart[49][0] + (circleDiameter/2), naturHumanArcCart[59-49][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[50][1] && circleY >= humanBuiltArcCart[51][1]) { circleX = constrain(circleX, humanBuiltArcCart[50][0] + (circleDiameter/2), naturHumanArcCart[59-50][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[51][1] && circleY >= humanBuiltArcCart[52][1]) { circleX = constrain(circleX, humanBuiltArcCart[51][0] + (circleDiameter/2), naturHumanArcCart[59-51][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[52][1] && circleY >= humanBuiltArcCart[53][1]) { circleX = constrain(circleX, humanBuiltArcCart[52][0] + (circleDiameter/2), naturHumanArcCart[59-52][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[53][1] && circleY >= humanBuiltArcCart[54][1]) { circleX = constrain(circleX, humanBuiltArcCart[53][0] + (circleDiameter/2), naturHumanArcCart[59-53][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[54][1] && circleY >= humanBuiltArcCart[55][1]) { circleX = constrain(circleX, humanBuiltArcCart[54][0] + (circleDiameter/2), naturHumanArcCart[59-54][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[55][1] && circleY >= humanBuiltArcCart[56][1]) { circleX = constrain(circleX, humanBuiltArcCart[55][0] + (circleDiameter/2), naturHumanArcCart[59-55][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[56][1] && circleY >= humanBuiltArcCart[57][1]) { circleX = constrain(circleX, humanBuiltArcCart[56][0] + (circleDiameter/2), naturHumanArcCart[59-56][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[57][1] && circleY >= humanBuiltArcCart[58][1]) { circleX = constrain(circleX, humanBuiltArcCart[57][0] + (circleDiameter/2), naturHumanArcCart[59-57][0] - (circleDiameter/2)); }
  if (circleY <= humanBuiltArcCart[58][1] && circleY >= humanBuiltArcCart[59][1]) { circleX = constrain(circleX, humanBuiltArcCart[58][0] + (circleDiameter/2), naturHumanArcCart[59-58][0] - (circleDiameter/2)); }


      // mix the human, built, nature sounds based on location of the mouse
      gainHuman = 1-sqrt(pow(pointHuman[0] - mouseX,2) + pow(pointHuman[1] - mouseY, 2)) / triangleSide;
      gainBuilt = 1-sqrt(pow(pointBuilt[0] - mouseX,2) + pow(pointBuilt[1] - mouseY, 2)) / triangleSide;
      gainNatur = 1-sqrt(pow(pointNatur[0] - mouseX,2) + pow(pointNatur[1] - mouseY, 2)) / triangleSide;
      humanSound.amp(gainHuman);
      builtSound.amp(gainBuilt);
      naturSound.amp(gainNatur);
      
      //humanSound.amp(1);
      //builtSound.amp(1);
      //naturSound.amp(1);
      
      //println("1");
      //print("human: ");
      //println(gainHuman);
      //print("Built: ");
      //println(gainBuilt);
      //print("Natur: "); 
      //println(gainNatur);
      // calculate percentage for each loop
      
   // } else {    // for if (mousePressed)...
      //mouse is inside the circle but not clicked
      //highlight the circle light green but don't move it
 //     fill(128, 256, 128);
   // }
  
  
  textSize(32);
  text("Human:  " + nf((gainHuman)*100,3,1) + "%", 10, 30); 
  textSize(32);
  text("Built:  " + nf((gainBuilt)*100,3,1) + "%", 10, 60); 
  textSize(32);
  text("Nature: " + nf((gainNatur)*100,3,1) + "%", 10, 90);

  ellipse(circleX, circleY, circleDiameter, circleDiameter);
}
