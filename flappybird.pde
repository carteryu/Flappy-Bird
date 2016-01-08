import ddf.minim.*;

/* @pjs preload = "boring.png", "chooseText.png", "city.png",
 "cityIcon.png", "cityText.png", "classicText.png", "cloudIcon.png",
 "clouds.png", "gameOver.png", "logo.png", "ogIcon.png", "smallUnicorn.png",
 "space.png", "spaceIcon.png", "spaceText.png", "playAgain.png",
 "pressEnter.png", "returnHome.png", "pauseButton.png", "pauseText.png", "pressContinue.png",
 "flappyUp.png", "flappyDown.png", "flappyMiddle.png", "smallUnicorn.png", "unicorn.png",
 "pipeUp.png", "pipeDown.png";

 font = "04B_19__.TTF";
*/


Bird bird, unicornBird;
ArrayList<Pipe> pipeList;
Pipe pipe;
Minim minim;
AudioPlayer startTheme, levelTheme, gameOverTheme;

//image holders
PImage backgroundImg, cityIcon, spaceIcon, ogIcon, unicornIcon, logo, startBackground, cityText, ogText, spaceText, chooseText, unicornEasterEgg, gameOverText, playAgainText, pressEnterText, returnHomeText, pauseButton, pauseText, pressContinue;

//font holder
PFont scoreText;

//keep track of game states
//0 = start screen
//1 = game playing
//2 = game over
//3 = pause
int gameState;

//string holder to replace background with user choice
String imageName = "";
String soundName = "";

//Y position of flappyBird logo 
//and speed to move along Y axis to "flap"
float logoYSpeed = 0.5;
float logoY = 90;

//score variables
int score = 0;
int highScore = 0;

boolean isUnicorn = false;

boolean clearedPipe;

//start game state at 0 - start screen
void setup() {
  size(700, 500);
  isUnicorn = false;
  gameState = 0;
  score = 0;

  minim = new Minim(this);
  startTheme = minim.loadFile("startTheme.mp3");
  gameOverTheme = minim.loadFile("gameOverTheme.mp3");
  levelTheme = minim.loadFile("startTheme.mp3");

  bird = new Bird(275, 275);
  unicornBird = new Bird(275, 275, "smallUnicorn.png");
  pipeList = new ArrayList<Pipe>();
  pipeList.add(new Pipe());

  scoreText = loadFont("04B_19__.TTF",50);
  textFont(scoreText);
  controlSound();
}

void controlSound() {
  //start screen
  if (gameState == 0) {
    levelTheme.pause();
    levelTheme.rewind();
    gameOverTheme.pause();
    gameOverTheme.rewind();
    startTheme.rewind();
    startTheme.play();
  }
  //playing
  else if (gameState == 1) {
    startTheme.pause();
    startTheme.rewind();
    levelTheme.rewind();
    levelTheme.play();
  }
  //game over
  else if (gameState == 2) {
    levelTheme.pause();
    levelTheme.rewind();
    gameOverTheme.rewind();
    gameOverTheme.play();
  }
  //pause screen
  else if (gameState == 3) {
    levelTheme.pause();
  }
}

void pauseScreen() {
  controlSound();
  pauseText = loadImage("pauseText.png");
  pressContinue = loadImage("pressContinue.png");
  image(pauseText, 220, 180);
  image(pressContinue, 125, 260);
  noLoop();
}

//check which keys are pressed depending on game state
void keyPressed() {
  if (gameState == 2) {
    if (key == ENTER || key == RETURN) {
      if (isUnicorn == false) {
        score = 0;
        gameState = 1;
        levelTheme.rewind();
        gameOverTheme.rewind();
        startTheme.rewind();
      } 
      else if (isUnicorn == true) {
        score = 0;
        gameState = 1;
        levelTheme.rewind();
        gameOverTheme.rewind();
        startTheme.rewind();
      }
    } 
    else if (key == '1') {
      gameState = 0;
      levelTheme.rewind();
      gameOverTheme.rewind();
      startTheme.rewind();
    }
  } 
  else if (gameState == 3) {
    if (keyCode == SHIFT) {
      loop();
      gameState = 1;
    } 
    else {
     noLoop();
     gameState = 3;
    }
  }
}


//determine which button was clicked/which level user chose
void checkButtonPress() {
  if (mousePressed) {
    if ((mouseX >= 100) && (mouseX <= 100 + 100 ) && (mouseY >= 330) && (mouseY <= 330 + 100)) {
      isUnicorn = false;
      spaceIcon.filter(GRAY);
      image(spaceIcon, 150, 380);
      gameState = 1;
      imageName = "space.png";
      levelTheme = minim.loadFile("spaceTheme.mp3");
      controlSound();
    } 
    else if ((mouseX >= 300) && (mouseX <= 300 + 100 ) && (mouseY >= 330) && (mouseY <= 330 + 100)) {
      isUnicorn = false;
      cityIcon.filter(GRAY);
      image(cityIcon, 350, 380);
      gameState = 1;
      imageName = "city.png";
      levelTheme = minim.loadFile("cityTheme.mp3");
      controlSound();
    } 
    else if ((mouseX >= 500) && (mouseX <= 500 + 100 ) && (mouseY >= 330) && (mouseY <= 330 + 100)) {
      isUnicorn = false;
      ogIcon.filter(GRAY);
      image(ogIcon, 550, 380);
      gameState = 1;
      imageName = "boring.png";
      levelTheme = minim.loadFile("classicTheme.mp3");
      controlSound();
    }
    //EASTER EGG!!
    else if ((mouseX >= 346) && (mouseX <= 346 + 58) && (mouseY >=  60) && (mouseY <= 60 + 50)) {
      isUnicorn = true;
      image(unicornEasterEgg, 375, 80);
      gameState = 1;
      imageName = "clouds.png";
      levelTheme = minim.loadFile("unicornTheme.mp3");
      controlSound();
    }
  }
}



void draw() {
  //if game is playing
  if (gameState == 1) {
    levelTheme.play();
    startTheme.pause();
    startTheme.rewind();
    gameOverTheme.pause();
    gameOverTheme.rewind();
    
    imageMode(CORNER);

    //display level selected by user
    backgroundImg = loadImage(imageName);
    image(backgroundImg, 0, 0, width, height);

    //check if pause button was clicked  
    if (mousePressed) {
      if ((mouseX >= 20) && (mouseX <= 20 + 40 ) && (mouseY >= 15) && (mouseY <= 15 + 40)) {
        backgroundImg = loadImage(imageName);
        image(backgroundImg, 0, 0);
        gameState = 3;
      }
    }

    //move/display bird
    if (isUnicorn == false) {
      bird.birdGo();
      bird.display();

      for (int i = 0; i < pipeList.size(); i++) {
        pipeList.get(i).movePipe();
        pipeList.get(i).displayPipe();

        if (pipeList.get(i).getPipeX() < 450 && pipeList.get(i).hasCreatedNewPipe == false) {
          pipeList.add(new Pipe());
          pipeList.get(i).hasCreatedNewPipe = true;
        }
        
        if (bird.getRight() - 20 < pipeList.get(i).getPipeRight() && bird.getRight() > pipeList.get(i).getPipeX()) {
          if (bird.getYPos() > (pipeList.get(i).getPipeYTop() + 500) && (bird.getYPos() + 30) < pipeList.get(i).getPipeYBottom()) {
            if (!pipeList.get(i).hasScored) {
              score++;
              pipeList.get(i).hasScored = true;
            }
          } 
          else {
            gameState = 2;
          }
        }
        
        //remove pipe when it gets to end of screen
        if (!pipeList.get(i).checkOnScreen()) {
          pipeList.remove(pipeList.get(i));
        }
      } //arrayList for loop

      if (bird.checkHit()) {
        gameState = 2;
      }
    } //if isUnicorn = false 

    //move/display unicorn
    else if (isUnicorn == true) {
      unicornBird.birdGo();
      unicornBird.display();

      for (int i = 0; i < pipeList.size (); i++) {
        pipeList.get(i).movePipe();
        pipeList.get(i).displayPipe();

        if (pipeList.get(i).getPipeX() < -40) {
          pipeList.remove(pipeList.get(i));
        }

        if (pipeList.get(i).getPipeX() == 450) {
          pipeList.add(new Pipe());
        }

        if (unicornBird.getRight() < pipeList.get(i).getPipeRight() && unicornBird.getRight()+ 20 > pipeList.get(i).getPipeX()) {
          if (unicornBird.getYPos() > (pipeList.get(i).getPipeYTop() + 500) && (unicornBird.getYPos() + 35) < pipeList.get(i).getPipeYBottom()) {
            if (!pipeList.get(i).hasScored) {
              score++;
              pipeList.get(i).hasScored = true;
            }
          } 
          else {
            gameState = 2;
          }
        }
      } //for arrayList
      if (unicornBird.checkHit()) {
        gameState = 2;
      }
    } //unicorn == true

    //display text when > 0
    if (score > 0) {
      text(score, 325, 80);
    }
    
    //pause button
    pauseButton = loadImage("pauseButton.png");
    image(pauseButton, 20, 15);
    
  } // gamestate 1

  //if start screen
  else if (gameState == 0) {
    levelTheme.pause();
    gameOverTheme.pause();
    startTheme.play();

    score = 0;
    isUnicorn = false;
    noStroke();
    imageMode(CENTER);

    //load button images and text
    spaceIcon = loadImage("spaceIcon.png");
    cityIcon = loadImage("cityIcon.png");
    ogIcon = loadImage("ogIcon.png");
    logo = loadImage("logo.png");
    startBackground = loadImage("boring.png");

    cityText = loadImage("cityText.png");
    spaceText = loadImage("spaceText.png");
    ogText = loadImage("classicText.png");
    chooseText = loadImage("chooseText.png");

    unicornEasterEgg = loadImage("smallUnicorn.png");

    //draw images
    image(startBackground, width/2, height/2);
    image(unicornEasterEgg, 375, 85);
    image(logo, 350, logoY);
    image(chooseText, 350, 245);

    image(spaceIcon, 150, 380);
    image(spaceText, 150, 307);

    image(cityIcon, 350, 380);
    image(cityText, 350, 307);

    image(ogIcon, 550, 380);
    image(ogText, 550, 307);

    //move logo up/down along y axis at preset speed
    logoY += logoYSpeed;

    //if logo hits certain point reverse speed
    if (logoY > 105 || logoY < 90) {
      logoYSpeed *= -1;
    }
    checkButtonPress();
  }

  //game over
  else if (gameState == 2) {
    levelTheme.pause();
    gameOverTheme.play();
    
    pipeList.clear();
    pipeList.add(new Pipe());
    
    //update high score if necessary
    if (score > highScore) {
      highScore = score;
    }

    if (isUnicorn == true) {
      unicornBird.resetBird();
    } 
    
    else if (isUnicorn == false) {
      bird.resetBird();
    }

    backgroundImg = loadImage(imageName);
    gameOverText = loadImage("gameOver.png");

    image(backgroundImg, 0, 0);
    image(gameOverText, 235, 80);

    playAgainText = loadImage("playAgain.png");
    pressEnterText = loadImage("pressEnter.png");
    returnHomeText = loadImage("returnHome.png");

    image(playAgainText, 225, 295);
    image(pressEnterText, 177, 345);
    image(returnHomeText, 173, 375);

    textAlign(CENTER);
    text("YOUR SCORE: " + score, width/2, 200);
    text("HIGH SCORE: " + highScore, width/2, 260);
  }

  //PAUSE
  else if (gameState == 3) {
    pauseScreen();
  }
}

