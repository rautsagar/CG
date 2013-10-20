float dz=0;
float rx=-0.1*TWO_PI, ry=-0.04*TWO_PI;    // view angles
float l=1, w=.2;     // dimensions of boxes
float a1=TWO_PI/6, b1=TWO_PI/8, a2=TWO_PI/6, b2=TWO_PI/8, a3=TWO_PI/6, b3=TWO_PI/8; 
Boolean twistFree=false, light=true, animating=true, center=false;
float t=0, s=0;
float cx=1, cy=2;

void setup() {
  myFace = loadImage("data/Sagar.jpg");  // load image from file Sagar.jpg in folder data
  size(600, 600, P3D);
  }

void draw() {
  background(255);
  pushMatrix();
    translate(width/2,height/2,dz);
    scale(50);
    if(light) lights();
    rotateX(rx); rotateY(ry); 
    rotateX(PI/2);
    if(center) translate(-cx,-cy,0);
    showFrame();
    fill(yellow); pushMatrix(); translate(0,0,-.01); box(40,40,.01); popMatrix(); // floor
    fill(magenta); pushMatrix(); translate(cx,cy,0); sphere(0.1); popMatrix();
    fill(brown); 
    
    // place your code for showing a chair here
    Booth booth1 = new Booth();
    booth1.show();
    
  popMatrix();
  noLights();
  if(keyPressed) {stroke(red); fill(white); ellipse(mouseX,mouseY,26,26); fill(red); text(key,mouseX-5,mouseY+4);}
  if(scribeText) {fill(black); displayHeader();}
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 
  if (animating) {t+=PI/180; if(t>=TWO_PI) t=0; s=(cos(t)+1)/2;}
  if(filming && (animating || change)) saveFrame("FRAMES/F"+nf(frameCounter++,4)+".tif");  
  change=false; // to avoid capturing frames when nothing happens
  }
  
  
void mouseDragged() {
  if (!keyPressed) {rx-=PI*(mouseY-pmouseY)/height; ry+=PI*(mouseX-pmouseX)/width;};
  if (keyPressed && key=='c') {cx-=2.*(mouseX-pmouseX)/width; cy-=2.*(mouseY-pmouseY)/height; }
  }  
  
void mouseWheel(MouseEvent event) {
  dz -= event.getAmount();   
  change=true;
  }

void keyPressed() {
  if(key=='?') scribeText=!scribeText;
  if(key=='!') snapPicture();
  if(key=='~') filming=!filming;
  if(key=='T') twistFree=!twistFree;
  if(key=='C') center=!center;
  if(key=='L') light=!light;
  if(key=='A') animating=!animating;
  if(key=='Q') exit();
  change=true;
  }

// ************************************ IMAGES & VIDEO 
int pictureCounter=0, frameCounter=0;
Boolean filming=false, change=false;
PImage myFace; //  data/pic.jpg in sketch folder
void snapPicture() {saveFrame("PICTURES/P"+nf(pictureCounter++,3)+".jpg"); }

// ******************************************COLORS 
color black=#000000, white=#FFFFFF, // set more colors using Menu >  Tools > Color Selector
   red=#FF0000, green=#00FF01, blue=#0300FF, yellow=#FEFF00, cyan=#00FDFF, magenta=#FF00FB,
   grey=#818181, orange=#FFA600, brown=#B46005, metal=#B5CCDE;
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
String title ="CS6491-2013F-P13b: Chair", name ="Sagar Raut",
       menu="?:help, !:picture, ~:(start/stop) recording, Q:quit",
       guide="drag:rotate, wheel:approach, A:animate, T:twist, L:light, C:center, c+drag:move center "; // user's guide

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

// **************************** PRIMITIVE
void showFrame() { 
  noStroke(); 
  fill(metal); sphere(.15);
  fill(blue);  showArrow(1,0.08);
  fill(red); pushMatrix(); rotateY(PI/2); showArrow(1,0.08); popMatrix();
  fill(green); pushMatrix(); rotateX(-PI/2); showArrow(1,0.08); popMatrix();
  }

void showFan(float d, float r) {
  float da = TWO_PI/36;
  beginShape(TRIANGLE_FAN);
    vertex(0,0,d);
    for(float a=0; a<=TWO_PI+da; a+=da) vertex(r*cos(a),r*sin(a),0);
  endShape();
  }

void showCollar(float d, float r, float rd) {
  float da = TWO_PI/36;
  beginShape(QUAD_STRIP);
    for(float a=0; a<=TWO_PI+da; a+=da) {vertex(r*cos(a),r*sin(a),0); vertex(rd*cos(a),rd*sin(a),d);}
  endShape();
  }

void showCone(float d, float r) {showFan(d,r);  showFan(0,r);}

void showStub(float d, float r, float rd) {
  showCollar(d,r,rd); showFan(0,r);  pushMatrix(); translate(0,0,d); showFan(0,rd); popMatrix();
  }
  
void showArrow(float d, float r) {
  float dd=d/5;
  showStub(d-dd,r*2/3,r/3); pushMatrix(); translate(0,0,d-dd); showCone(dd,r); popMatrix();
  }  
  
void showBlock(float w, float d, float h, float x, float y, float z, float a) {
  pushMatrix(); translate(x,y,h/2); rotateZ(TWO_PI*a); box(w, d, h); popMatrix(); 
  }

