import de.bezier.guido.*;
int NUM_ROWS = 20;
int NUM_COLS = 20;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(8);
  Interactive.make( this );

  buttons = new Life[NUM_ROWS][NUM_COLS];
  for(int a = 0; a < NUM_ROWS; a++) {
  for(int b = 0; b < NUM_COLS; b++) {
  buttons[a][b]= new Life(a,b);
}
}
  buffer= new boolean[NUM_ROWS][NUM_COLS];
 for(int a = 0; a < NUM_ROWS; a++){
    for(int b = 0; b < NUM_COLS; b++){
      buffer[a][b] = buttons[a][b].getLife();
    }
  }
}

public void draw () {
  background(204, 204, 255);
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();
   for(int a = 0; a < NUM_ROWS; a++){
     for(int b = 0; b < NUM_COLS; b++){
       if(countNeighbors(a,b)==3)
       {
         buffer[a][b] = true;
       }
       else if (countNeighbors(a,b) == 2 && buttons[a][b].getLife() == true){
         buffer[a][b] = true;
       }
       else{
         buffer[a][b] = false;
       }
       buttons[a][b].draw();
     }
   }

  copyFromBufferToButtons();
}
public void keyPressed() {
  if(key == ' '){
    running =! running;
  }
  if(key == '1'){
    frameRate(3);
  }
  if(key == '2'){
    frameRate(8);
  }
}
public void copyFromBufferToButtons() {
  for (int a = 0; a < 20; a++) {
    for (int b = 0; b < 20; b++) {
      buttons[a][b].setLife(buffer[a][b]);
    }
  }
}

public void copyFromButtonsToBuffer() {
  for (int a = 0; a < 20; a++){
    for (int b = 0; b < 20; b++){
      buffer[a][b]= buttons[a][b].getLife();
    }
  }
}

public boolean isValid(int a, int b) {
  if(a >= 0 && a < NUM_ROWS && b >= 0 && b < NUM_COLS)
  {
    return true;
  }
  return false;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;                      
  if(isValid(row-1,col-1) && buttons[row-1][col-1].getLife()==true)
  neighbors++;
   if(isValid(row-1,col) && buttons[row-1][col].getLife()==true)
   neighbors++;
    if(isValid(row-1,col+1) && buttons[row-1][col+1].getLife()==true)
   neighbors++;
     if(isValid(row,col-1) && buttons[row][col-1].getLife()==true)
    neighbors++;
       if(isValid(row,col+1) && buttons[row][col+1].getLife()==true)
     neighbors++;
      if(isValid(row+1,col-1) && buttons[row+1][col-1].getLife()==true)
    neighbors++;
      if(isValid(row+1,col) && buttons[row+1][col].getLife()==true)
    neighbors++;
      if(isValid(row+1,col+1) && buttons[row+1][col+1].getLife()==true)
 neighbors++;
 return neighbors;
}
public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(204, 204, 255);
    else 
      fill(176,196,222 );
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    if (alive == true) {
      return true;
    }
    return false;
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
