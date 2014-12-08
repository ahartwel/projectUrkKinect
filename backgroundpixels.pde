class BACKGROUNDPIXELS {
  
  
  
  
  
      int currColor = 1;
    int timer=0;
  int fullTimer = 0;
   BACKGROUNDPIXELS() {
  
    
   } 
  
  
   void update() {
     
   
   }
   
   
   void display() {
     
     
   }
   
   
   
   void colorSwitcher() {
     fullTimer++;
      //if (whiteTracker>=(numPixels-1)*.75) {
      if (fullTimer>15) {
       fullTimer=0;
       
      // println(timer);
    
   
     
    // println(currColor);
     
     
     
//     motion.beginDraw();
//     motion.background(0,0,0,0);
//     motion.endDraw();
     
       
    /* colorSwitch++;
     if (colorSwitch>=3) {
      colorSwitch=1; 
     }
      */ 
     switch(currColor) {
       
      case 1:
      
      if (timer>=8) {
         for (int i = 0; i<col.length;i++) {
           color c = col2[i];
         col[i] = c;
         }
    
     //println("COLOR TWO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      //println(col2);
      } else {
        for (int i = 0; i<col.length;i++) {
          
          col[i] = lerpColor(col[i],col2[i],.15);
        } 
      }
      
      if (timer==12) {
        //col = col2Real;
        currColor=2; 
      }
     break;
   
    
      case 2:
      
      if (timer>=8) {
        //timer=0;
     for (int i = 0; i<col.length;i++) {
       color c = col1[i];
         col[i] = c;
         }
     //   println("COLOR ONE!!!!!!!!!!!!!!!!");
     //   println(col1);
      } else {
        for (int i = 0; i<col.length;i++) {
       col[i] = lerpColor(col[i],col1[i],.15);
       //  col = col1;    
      
    } 
      }
      
      if (timer==12) {
        
     currColor=1; 
       }
       break; 
       
       
     }
     
     if (timer>=12) {
      timer=-1; 
     }
     timer++;
   
    
     
   }
     
     
     
     
   }
  
  
    void drawPixel(int pixNum, color currColor) {
      
      int newColor = 0;
      
      for (int i = 0; i<col.length; i++) {
       if (currColor == col[i]) {
        newColor = i+1;
       } 
        
      }
      if (newColor==5) {
       newColor=0; 
      }
      
      pixelArt.pixels[pixNum]=col[newColor];
      
      
    }
  
  
  void clearIt() {
    
    
  pixelArt.beginDraw();
  pixelArt.background(col[0]);
  pixelArt.endDraw(); 
    
  }
  
  
  
}
