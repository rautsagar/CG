class Table{
  float angle, height, width;
  Table(){
    angle = PI*0.05;
    height = 3;
    width = 4.5; 
  }
  
  void show(){
    fill(red); 
    //dRAW table LEGS
     
    //lower right
     pushMatrix(); translate(width/2,width/2,0); rotateY(-angle); rotateX(angle); showStub(height+.05,.1,.08); popMatrix();
     //lower left
     pushMatrix(); translate(-width/2,width/2,0); rotateY(angle); rotateX(angle); showStub(height+.05,.1,.08); popMatrix();
     //top left
      pushMatrix(); translate(-width/2,-width/2,0); rotateY(angle); rotateX(-angle); showStub(height+.05,.1,.08); popMatrix();
     //top right 
     pushMatrix(); translate(width/2,-width/2,0); rotateY(-angle); rotateX(-angle); showStub(height+.05,.1,.08); popMatrix();
     //tabletop
     fill(white);
     pushMatrix(); translate(0,0,height); box(width,width,.05); popMatrix();

}
}
