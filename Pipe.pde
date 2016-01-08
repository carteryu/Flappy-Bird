class Pipe {
  int pipeXPos = width + 30;
  int pipeYTop, pipeYBottom;
  PImage pipeTop, pipeBottom;
  boolean hasScored;
  int pipeHeight, pipeWidth;
  boolean hasCreatedNewPipe = false;

  Pipe() {
    imageMode(CORNER);
    pipeTop = loadImage("pipeDown.png");
    pipeBottom = loadImage("pipeUp.png");
    hasScored = false;
    pipeHeight = pipeTop.height;
    pipeWidth = pipeTop.width;
    pipeYTop = int(random(-475, -125));
    pipeYBottom = (pipeHeight + pipeYTop) + 90;
  }

  void movePipe() {
    pipeXPos -= 1.5;
  }

  void displayPipe() {
    image(pipeTop, pipeXPos, pipeYTop);
    image(pipeBottom, pipeXPos, pipeYBottom);
  }


  boolean checkOnScreen() {
    if (getPipeX() <= -60) {
      return false;
    } 
    else {
      return true;
    }
  }

  int getPipeX() {
    return pipeXPos;
  }

  int getPipeYTop() {
    return pipeYTop;
  }

  int getPipeYBottom() {
    return pipeYBottom;
  }

  int getPipeHeight() {
    return pipeYTop + pipeHeight ;
  }

  int getPipeRight() {
    return getPipeX() + pipeWidth;
  }
}//class

