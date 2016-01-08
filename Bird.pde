class Bird {
  //details about the bird 
  //position
  int xPos, yPos;
  PImage flappyUp, flappyDown, flappyMiddle;
  int birdWidth, birdHeight;

  //speed
  float speed = 0;

  //different states for the bird - currently have as colors, will be different bird images
  int state = 1;

  Bird(int x, int y) {
    //store position of bird
    xPos = x;
    yPos = y;
    flappyUp = loadImage("flappyUp.png");
    flappyDown = loadImage("flappyDown.png");
    flappyMiddle = loadImage("flappyMiddle.png");
    birdWidth = flappyUp.width;
    birdHeight = flappyUp.height;
  }

  Bird(int x, int y, String image) {
    //store position of bird
    xPos = x;
    yPos = y;
    flappyUp = loadImage(image);
    flappyDown = loadImage(image);
    flappyMiddle = loadImage(image);
  }

  void resetBird() {
    xPos = 275;
    yPos = 275;
    state = 1;
    speed = 0;
    image(flappyMiddle, xPos, yPos);
  }

  //if mouse pressed what happens? the bird will speed up + position up; after the button is released it will 
  //decrease back to what it was before, and the bird's position will go down

  void birdGo() {
    if (keyPressed == true || mousePressed) {
      if (key == ' ' || mousePressed) {  //or if space bar is pressed
        state = 2; //up state
        birdFly();
        //accelerate
      }
    } 
    else { //if mouse or space bar are not being pressed
      //deccelerate
      state = 1; //down neutral state
    }
    // always make the bird drop
    speed += 0.1;  
    yPos += speed;
  }

  //acceleration 
  //turn blue
  void birdFly() {
    speed -= 0.5;
  }

  //collision
  //if collide, turn red, reset game
  boolean checkHit() {
    if (yPos > height) { //collision with the landscape bottom
      return true;
    }
    if (yPos < 0) { //collision with the landscape top
      return true;
    } 
    else {
      return false;
    }
  }


  //display function
  void display() {

    //if up state
    if (state == 2) {
      image(flappyDown, xPos, yPos);
    }

    //if down/neutral state
    else if (state == 1) {
      image(flappyUp, xPos, yPos);
    }
  }

  int getTop() {
    return yPos - birdHeight;
  }

  int getYPos() {
    return yPos;
  }

  int getRight() {
    return xPos + birdWidth;
  }

  int getXPos() {
    return xPos;
  }
}

