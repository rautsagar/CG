class Chair{
  float angle;
  
  Chair(){
  angle = PI*0.05; 
  }
  
  void show(){
    fill(brown); 
    //dRAW CHAIR LEGS
    //lower right
     pushMatrix(); translate(1,1,0); rotateY(-angle); rotateX(angle); showStub(2,.1,.08); popMatrix();
     //lower left
     pushMatrix(); translate(-1,1,0); rotateY(angle); rotateX(angle); showStub(2,.1,.08); popMatrix();
     //top left
      pushMatrix(); translate(-1,-1,0); rotateY(angle); rotateX(-angle); showStub(2,.1,.08); popMatrix();
     //top right 
     pushMatrix(); translate(1,-1,0); rotateY(-angle); rotateX(-angle); showStub(2,.1,.08); popMatrix();
     
    
     pushMatrix(); translate(0,0,2); box(2.1,2.1,.1);  rotateX(PI/2.1); translate(0,1.5,-1); box(2.1,2.9,.1); popMatrix();

}
}
