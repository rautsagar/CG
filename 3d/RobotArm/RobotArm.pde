float dz=0;
float rx=0.45*TWO_PI, ry=0.06*TWO_PI;    // view angles
float l=1, w=.2;     // dimensions of boxes
float a1=TWO_PI/6, b1=TWO_PI/8, a2=TWO_PI/6, b2=TWO_PI/8, a3=TWO_PI/6, b3=TWO_PI/8; 
Boolean twistFree=false, light=true, animating=true, extraCredit = false;
float t=0, s=0;

void setup() {
  myFace = loadImage("data/Sagar.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  size(600, 600, P3D);
  }

void draw() {
  background(255);
  pushMatrix();
    translate(width/2,height/2,dz);
    scale(100);
    if(light) lights();
    rotateX(rx); rotateY(ry); 
    showFrame();
    
    if(twistFree) {
      
      if(extraCredit){
      pushMatrix();
        translate(l,0,0); rotateY(-(s*b1));  showLink();
        s = s/5;
        translate(l,w/2,0); rotateY(-(s/2*a2)); rotateZ(s*2*b2); showLink2();
        for(int i = 0 ; i < 11; i++){ 
        translate(l,0,0); rotateY(-(s/2*a3)); rotateZ(s*2*b3);  showLink2();
         
       }
       s = 5*s;
       popMatrix();
       }else{
         
         pushMatrix();
        translate(l,0,0);  rotateY(-(s*b1));  showLink();
        s = s/5;
        translate(l,w/2,0); rotateY(-(s/2*a2)); rotateZ(s*2*b2); showLink2();
       
        translate(l,0,0); rotateY(-(s/2*a3)); rotateZ(s*2*b3);  showLink2();
        s = 5*s; 
        popMatrix();
       
       }
           
             }
    else {
      
      pushMatrix();
        translate(l,0,0); rotateX(s*a1); rotateY(s*b1);  showLink();
        translate(l,0,0); rotateX(s*a2); rotateY(s*b2);  showLink(); 
        translate(l,0,0); rotateX(s*a3); rotateY(s*b3);  showLink(); 
      popMatrix();
      
      }
  popMatrix();
  noLights();
  if(keyPressed) {stroke(red); fill(white); ellipse(mouseX,mouseY,26,26); fill(red); text(key,mouseX-5,mouseY+4);}
  if(scribeText) {fill(black); displayHeader();}
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 
  if (animating) {t+=PI/180; if(t>=TWO_PI) t=0; s=(cos(t)+1)/2;}
  if(filming && (animating || change)) saveFrame("FRAMES/F"+nf(frameCounter++,4)+".tif");  
  change=false; // to avoid capturing frames when nothing happens
  }
  
void showFrame() {  
  pushMatrix(); translate(l/2,0,0); fill(255,0,0); box(l, w, w); popMatrix(); 
  pushMatrix(); translate(0,l/2,0); fill(0,255,0); box(w, l, w); popMatrix();
  pushMatrix(); translate(0,0,l/2); fill(0,0,255); box(w, w, l); popMatrix();
  }

void showLink() {pushMatrix(); translate(l/2,0,0); stroke(0); fill(yellow); box(l, w, 3*w); popMatrix(); }
void showLink2() {pushMatrix(); translate(l/2,-(w/2),0); stroke(0); fill(yellow); box(l, w, 3*w); popMatrix(); }
  
void mouseDragged() {
  if (!keyPressed) {rx-=PI*(mouseY-pmouseY)/width; ry-=PI*(mouseX-pmouseX)/height;}
  if (keyPressed && key=='1') {a1-=PI*(mouseX-pmouseX)/height; b1-=PI*(mouseY-pmouseY)/width; }
  if (keyPressed && key=='2') {a2-=PI*(mouseX-pmouseX)/height; b2-=PI*(mouseY-pmouseY)/width; }
  if (keyPressed && key=='3') {a3-=PI*(mouseX-pmouseX)/height; b3-=PI*(mouseY-pmouseY)/width; }
  change=true;
  }  
  
void mouseWheel(MouseEvent event) {
  dz -= 20*event.getAmount();   
  change=true;
  }

void keyPressed() {
  if(key=='?') scribeText=!scribeText;
  if(key=='!') snapPicture();
  if(key=='~') filming=!filming;
  if(key=='T') twistFree=!twistFree;
  if(key=='L') light=!light;
  if(key=='A') animating=!animating;
  if(key=='e') extraCredit =! extraCredit;
  change=true;
  }

// ************************************ IMAGES & VIDEO 
int pictureCounter=0, frameCounter=0;
Boolean filming=false, change=false;
PImage myFace; // picture of author's face, should be: data/pic.jpg in sketch folder
void snapPicture() {saveFrame("PICTURES/P"+nf(pictureCounter++,3)+".jpg"); }

// ******************************************COLORS 
color black=#000000, white=#FFFFFF, // set more colors using Menu >  Tools > Color Selector
   red=#FF0000, grey=#818181, green=#00FF01, blue=#0300FF, yellow=#FEFF00, cyan=#00FDFF, magenta=#FF00FB;
void pen(color c, float w) {stroke(c); strokeWeight(w);}

// ******************************** TEXT , TITLE, and USER's GUIDE
Boolean scribeText=true; // toggle for displaying of help text
void scribe(String S, float x, float y) {fill(0); text(S,x,y); noFill();} // writes on screen at (x,y) with current fill color
void scribeHeader(String S, int i) {fill(0); text(S,10,20+i*20); noFill();} // writes black at line i
void scribeHeaderRight(String S) {fill(0); text(S,width-7.5*S.length(),20); noFill();} // writes black on screen top, right-aligned
void scribeFooter(String S, int i) {fill(0); text(S,10,height-10-i*20); noFill();} // writes black on screen at line i from bottom
void scribeAtMouse(String S) {fill(0); text(S,mouseX,mouseY); noFill();} // writes on screen near mouse
void scribeMouseCoordinates() {fill(black); text("("+mouseX+","+mouseY+")",mouseX+7,mouseY+25); noFill();}
void displayHeader() { // Displays title and authors face on screen
    scribeHeader(title,0); scribeHeaderRight(name); 
    fill(white); image(myFace, width-myFace.width/2,25,myFace.width/2,myFace.height/2); 
    }
void displayFooter() { // Displays help text at the bottom
    scribeFooter(guide,1); 
    scribeFooter(menu,0); 
    }
String title ="CS6491-P13a: Robot arm aniamtion", name ="Sagar Raut",
       menu="?:help, !:picture, ~:(start/stop) recording, Q:quit",
       guide="drag:rotate, wheel:approach, 1,2,3+drag:joint angles, A:animate, T:twist, L:light "; // user's guide

// **************************** FILE SELECTION FOR SAVING AND LOADING MODELS 
String path="data/pts"; 
void saveToFile(File selection) {
  if (selection == null) println("Window was closed or the user hit cancel.");
  else path=selection.getAbsolutePath();
  println("    save path = "+path);
  }

void readFromFile(File selection) {
  if (selection == null) println("Window was closed or the user hit cancel or file not found.");
  else path=selection.getAbsolutePath();
  println("    read path = "+path);
  }

