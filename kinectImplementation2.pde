import codeanticode.syphon.*;

import SimpleOpenNI.*;

SimpleOpenNI kinect;


import ddf.minim.analysis.*;
import ddf.minim.*;

SyphonServer server;

PGraphics  canvas;

Minim minim;
//AudioPlayer music;
AudioInput music;
ddf.minim.analysis.FFT fft;


BACKGROUNDPIXELS bPixels;


//set up all the invisible canvases
PGraphics highestPoint;
PGraphics fade;
PGraphics lastFrame;
PGraphics pixelArt;
PGraphics musicBars;

//how much lower to draw the people, to account for kinect angle
float fadeOffset = .15*height;


//color setup
int colorSwitch = 1;
int numPixels;

//lets get these colors going
color[] col = new color[5];
color[] col1 = new color[5];
color[] col2 = new color[5];
color[] col1Real = new color[5];
color[] col2Real = new color[5];

void setup() {
 size(640,480, OPENGL);
 
 canvas = createGraphics(width,  height,OPENGL);
 
 server = new SyphonServer(this, "Processing");
highestPoint = createGraphics(width, height);
fade = createGraphics(width,  height);
lastFrame = createGraphics(width, height);
pixelArt = createGraphics(width, height);
musicBars = createGraphics(width, height);

numPixels = width*height;

highestPoint.beginDraw();
highestPoint.background(0,0,0,0);
highestPoint.endDraw();


musicBars.beginDraw();
musicBars.background(0,0,0,0);
musicBars.endDraw();

bPixels = new BACKGROUNDPIXELS();


kinect = new SimpleOpenNI(this);
kinect.enableDepth();
kinect.enableRGB();
kinect.enableUser();

 
  kinect.depthMapRealWorld();
    kinect.setDepthToColor(true);
    
    minim = new Minim(this);
  
  //music = minim.loadFile("thetruth.mp3", 2048);
  music = minim.getLineIn(minim.STEREO,2048);
  // loop the file
  //music.loop();
  // create an FFT object that has a time-domain buffer the same size as jingle's sample buffer
  // and a sample rate that is the same as jingle's
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be 1024. 
  // see the online tutorial for more info.
  fft = new ddf.minim.analysis.FFT(music.bufferSize(), music.sampleRate());
  // use 128 averages.
  // the maximum number of averages we could ask for is half the spectrum size. 
  fft.linAverages(128);
    
    
    
    
    
       
  col[0] = color(105,55,104);
   col[1] = color(141,66,89);
    col[2] = color(169,68,72);
     col[3] = color(203,87,64);
     col[4] = color(249,185,88); 
    
    
    col1[0] = color(105,55,104);
   col1[1] = color(143,78,117);
    col1[2] = color(169,68,72);
     col1[3] = color(203,87,64);
     col1[4] = color(199,148,70);
   
     col1Real[0] = color(105,55,104);
   col1Real[1] = color(143,78,117);
    col1Real[2] = color(169,68,72);
     col1Real[3] = color(203,87,64);
     col1Real[4] = color(199,148,70);  


     
    
   col2[0] = color(34,93,143);
    col2[1] = color(60,93,255);
      col2[2] = color(136,226,250);
     col2[3] = color(255,235,39);
     col2[4] = color(111,184,204); 



   col2Real[0] = color(34,93,143);
    col2Real[1] = color(60,93,255);
      col2Real[2] = color(136,226,250);
     col2Real[3] = color(255,235,39);
     col2Real[4] = color(111,184,204); 
    
    
}



void draw() {
  
  
   
   
  
 // fade.loadPixels();
  lastFrame.beginDraw();
  lastFrame.background(0,0,0,0);
  lastFrame.image(fade.get(0,0,width,height),0,0);
  
  lastFrame.endDraw();
  
  fill(255,255,255,50);
  rect(0,0,width,height);
  
  musicBars.beginDraw();
musicBars.background(0,0,0,0);
musicBars.endDraw();

  
  fade.beginDraw();
  fade.background(0,0,0,4);

  fade.endDraw();
  
  
  
  
   
    //motion.filter(BLUR,3);
    
    
  
  
  
 // background(255,15);
  kinect.update();
   kinect.setDepthToColor(true);
  PImage depth = kinect.depthImage();
  PImage rgbImg = kinect.rgbImage();
 // image(depth,0,0);
  
  
  IntVector userList = new IntVector();
  
  kinect.getUsers(userList);

  if (userList.size() > 0) {
//   int userId = userList.get(0);
//  
//  println(userId);
// println(userList.get(0)) ;
   int[] userMapping = kinect.userMap();
    //draw(userMap,0,0);
    int[] depthMap = kinect.depthMap();
    loadPixels();
    //fade.beginDraw();
    fade.loadPixels();
    for (int i =0; i < userMapping.length; i++) {
    // if the pixel is part of the user
    int highest = 0;
    if (userMapping[i] != 0) {
      // set the sketch pixel to the rgb camera pixel
      
      
      
      fade.pixels[i] = rgbImg.pixels[i];
    } // if (userMap[i] != 0)
    
    
    
  } // (int i =0; i < userMap.length; i++)
 
  
 
 
 
  // update any changed pixels
  fade.updatePixels();
    
    
 
  
  loadPixels();
   for (int i = 0; i<userList.size(); i++) {
    int userId = userList.get(i);
   PVector position = new PVector();
  kinect.getCoM(userId, position);
 
 kinect.convertRealWorldToProjective(position, position);
fill(100,150,255);
ellipse(position.x, position.y, 25,25);
     
     PVector bBox = new PVector();
     PVector bBox2 = new PVector();
     kinect.getBoundingBox(userId, bBox, bBox2);
//     println(bBox);
//     println(bBox2.y);
     
//     rect(bBox.x,  bBox.y, 15,15);
//     rect(bBox2.x,bBox2.y,15,15);
     
    //highestPoint.loadPixels();
    depth.loadPixels();
     highestPoint.beginDraw();
     
     int hX = 0;
     int hY = 0;
     int closest = 8000;
     
     color highest = color(0,0,0);
     for (int yy = int(bBox.y); yy<bBox2.y; yy++) {
    for (int xx = int(bBox.x); xx<bBox2.x; xx++) {
       
         //println(xx + " " + yy);
        // int pNum = xx+(yy*int(bBox2.x));
         //highestPoint.set(xx,yy,color(0,0,0));
         int loc = xx + yy * width;
         int currDepth = depthMap[loc];
       // println(red(depth.get(xx,yy)));
         if (currDepth>0 && currDepth<closest && userMapping[loc] != 0) {
           //highest = highestPoint.get(xx,yy);
           closest = depthMap[loc];
           hX = xx;
           hY = yy;
         }
       
       
       
      
      } 
           }
         
         
     // println(hX + " " + hY);
      highestPoint.fill(0,255,255);
      highestPoint.rect(hX, hY,10,10);
        highestPoint.endDraw();
      //  highestPoint.updatePixels();         
     
     
   }
   
   
   
   
   
   
  
  
   }
   
   
   fft.forward(music.mix);
  int w = int(fft.specSize()/256);
  fill(0);
 int w2 = 2*2;
 int w4 = w*5;
 
 //lastFrame.beginDraw();
 
 lastFrame.beginDraw();
 musicBars.beginDraw();
 fade.beginDraw();
    //println(fft.avgSize());
  for(int i = 0; i < fft.avgSize(); i++)
  {
    // draw a rectangle for each average, multiply the value by 5 so we can see it better
      musicBars.fill(0,0,0);
      musicBars.rect(i*w4, height- fft.getAvg(i)*30, i*w + w4, fft.getAvg(i)*30); 
      musicBars.rect(width - i*w4 - (i*w + w4), height- fft.getAvg(i)*30, i*w + w4, fft.getAvg(i)*30); 
      PImage p = fade.get(i*w4, int(height- fft.getAvg(i)*30 + fadeOffset), i*w + w4, int(fft.getAvg(i)*17));
      
      fade.image(p,i*w4, int(height- fft.getAvg(i)*30) - 30);
     
        p = fade.get(width - i*w4 - (i*w + w4), int(height- fft.getAvg(i)*30), i*w + w4, int(fft.getAvg(i)*17)); 
        fade.image(p,width - i*w4 - (i*w + w4), int(height- fft.getAvg(i)*30) - 30);
     //motion.rect(0, i*w4,pixelArt.width - fft.getAvg(i)*85, i*w + w4);
      //motion.rect(0,0,300,300);  
}
  //lastFrame.endDraw();
    fade.endDraw();
  musicBars.endDraw();
   lastFrame.endDraw();
   waves();
  image(pixelArt,0,0); 
  
  image(fade,0,fadeOffset);
  //image(highestPoint,0,0);
 
  highestPoint.beginDraw();
  highestPoint.background(0,0,0,0);
  highestPoint.endDraw();
   
   image(lastFrame,0,0);
   
   //image(musicBars,0,0);
   PImage nn = get();
  canvas.beginDraw();
  
   canvas.image(nn,0,0);
   
   canvas.endDraw();
   //image(canvas,0,0);
   //image(nn,0,0);
  server.sendImage(canvas);
   
}









void waves() {
 
    pixelArt.beginDraw();
    pixelArt.loadPixels(); 
  
  
  
  
    
    
  
    for (int i = 0; i < numPixels; i++) { // For each pixel in the video frame...
    // println(i);
      //pixelArt.pixels[i] = color(0);
      // The following line does the same thing much faster, but is more technical
      //pixels[i] = 0xFF000000 | (diffR << 16) | (diffG << 8) | diffB;
      if (musicBars.pixels[i] == color(0)) {
       // println("shiit");
         //motion.pixels[i]=color(0);
        bPixels.drawPixel(i, pixelArt.pixels[i]);
        //pixelArtTracker.pixels[i] = color(255);
    
      }
    
    
     
      
    }
    
    

    
    bPixels.colorSwitcher();
   
    
    
    
    pixelArt.updatePixels();
    pixelArt.endDraw();
    
   
   
  
  
}


