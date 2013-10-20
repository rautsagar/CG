class Booth{
  public Booth(){}
  void show(){
    Table table1 = new Table();
    Chair chair1 = new Chair();
    table1.show();
    
    for(int i = 0; i < 4; i++){
    rotateZ((PI/2)*i);
    pushMatrix();
    translate(0,3,0);
    chair1.show();
    popMatrix();
    
    }
     
  }

}
