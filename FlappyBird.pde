//variable creation

PImage barrier; //barrier image
PImage flappy; //bird image
PImage background; //background image
PImage barrierinvert; //rotated barrier
PImage deadflappy; //dead flappybird for game over screen
PImage gameover; //gameover image text
PImage startpage; //background for start page
PImage playbutton; //button to start game
PImage missile; //transparent missile image

float birdx; //bird x coordinate
float birdy; //bird y coordinate
float birdspeedx; //change to birdx
float birdspeedy; //change to birdy
float speedxchange; //the effect of each button press on x for bird
float speedychange; //the effect of each button press on y for bird
float coolDown; //cooldown between button presses
float barrierA; //x coordinate of barrier 1
float speedA; //speed of barrier 1
float speedAchange; //change in barrier 1's x coordinate
float toofar; //used for when bird flies out of frame on the right
float barrierB; //barrier 2 x coordinate
float speedBchange; //barrier 2 change in x coordinate
float barrierC; //barrier 3 x coordinate (bottom)
float speedCchange; //barrier 3 x coordinate change
float speedB; //speed of barrier 2
float speedC; //speed of barrier 3 (bottom and top)
float barrierC2; //barrier 3 (top) x coordinate
float lose; //used to ensure that a user cannot come out of the game over screen by spamming
float barrierAY; //barrier #1 y variable
float barrierAH; //barrier #1 height variable
float barrierBH; //barrier #2 height variable
float barrierCY; //barrier #3 bottom y variable
float barrierCH; //barrier #3 bottom height
float barrierC2H; //barrier #3 top height
float playbuttonx; //start button x
float playbuttony; //start button y
float playbuttonH; //start button height
float playbuttonW; //start button width
float namex; //name text x coordinate
float namespeedx; //speed name travels along x axis
float missilex; //missile x coordinate
float missiley; //missile y coordinate
float missilespeedx; //missile speed

int score; //score of the game
int screen; //which screen is displayed, 0-1-2 (opening screen, game screen, lose screen)

String gg; //you lose message
String respawn; //the message explaining how to retry
String goodluck; //introduction message
String start; //message explaining the controls
String scored; //what you scored in a round
String name; //my first and last name

void setup () {

  //one time setup
  size(640, 480); //size of screen

  background = loadImage("flappyg.png");
  flappy = loadImage("flappyi.png");
  barrier = loadImage("barrier.png");
  barrierinvert = loadImage("barrieru.png");
  deadflappy = loadImage("deadflappy.png");
  gameover = loadImage("gameover.png");
  startpage = loadImage("startscreen.png");
  playbutton = loadImage("playbutton.png");
  missile = loadImage("missile.png");

  screen = 0; //screen 0 is the startup screen
  birdspeedx = 5; //speed that x possition changes
  birdspeedy = 5; //speed that y position changes
  birdx = 0; //starts the bird at x = 0
  birdy = 0; //starts the bird at y = 0
  barrierA = 640; //this changes how long it will take the barrier 1 to enter frame
  speedA = -2.5; //barrier 1 speed
  speedB = -2.5; //barrier 2 speed
  speedAchange = 1060; //allows time between barriers 
  speedxchange = 3; //allows the button pressing and decides on how many pixels movements will be along x
  speedychange = 5; //allows the button pressing and decides on how many pixels movements will be along y
  toofar = -75; //resets the bird if he flies to far ahead
  barrierB = 960; //this changes how long it will take the barrier 2 to enter frame 
  speedBchange = 1060; //allows time between barriers
  barrierC = 1480; //this changes how long it will take the barrier 3 to enter frame
  barrierC2 = 1480; //this changes how long it will take the barrier 3 to enter frame
  speedCchange = 1060; //allows time between barriers
  speedC = -2.5; //barrier 3 bottom and top speed
  gg = "Game Over"; //game over screen text
  lose = 1000; //where the player is teleported when they lose
  respawn = "Press 'R' to Retry"; //small help message
  goodluck = "Welcome to Flappy Bird"; //goodluck and intro message
  start = "Press 'SPACE' to begin"; //basic controls message
  barrierAY = 100 + floor(random(200)); //randomizes barrier #1 y coordinate
  barrierAH = height - barrierAY; //adjusts barrier #1 height to fit screen after y coordinate change
  barrierBH = 200 + floor(random(200)); //changes barrier #2 height, y is the same as in this case the barrier is pointing down
  barrierCY = 100 + floor(random(280)); //changes barrrier #3 bottom to a random y coordinate
  barrierCH = height - barrierCY; //matches the height of barrier #3 bottom to its y value
  barrierC2H = height - barrierCH - 80; //find empty space where #3 bottom is not, uses it for barrier #3 top, 80 pixel gap
  score = 0; //score starts at 0 when game begins
  playbuttonx = 230; //x coordinate
  playbuttony = 330; //y coordinate
  playbuttonH = 100; //height 
  playbuttonW = 180; //width
  name = "Created By Isaiah Iruoha"; //name text
  namex = 20; //starting name x coordinate
  namespeedx = 2; //speed namex moves
  missilex = -260; //missile starts out of frame
  missiley = 0; //missile starts at 0 on the y axis
}

void draw () { 

  //continous movements
  if (screen == 0) { //startup page

    namex = namex + namespeedx; //causes name to move right
    background(startpage); //background image
    image(playbutton, playbuttonx, playbuttony, playbuttonW, playbuttonH); //button placement
    textSize(20); //name text size
    fill(0, 120); //name text colour
    text(name, namex, 465); //text itself

    if (namex > 400) namespeedx = -2; //these statements cause the name to stay within the page
    if (namex < 5) namespeedx = 2;
  } else if (screen == 1) { //game page

    background(background); //flappy bird background image

    frameRate(30); //frames per second of the game

    image(flappy, birdx, birdy, 75, 50); // Bird

    if (birdx == 0 && birdy == 0) { //if game has not started, show text below
      textSize(25); //font size 25
      fill(0, 120); //black and transparent
      text(goodluck, 180, 100); //goodluck text
      text(start, 190, 160); //how to start text
    }

    if (birdx != 0 || birdy != 0) { //allows the game to be started in a frozen state, see keyPressed for keys to start

      birdy = birdy + birdspeedy; //the change in the y coordinate
      birdx = birdx + birdspeedx; //the change in the x coordinate
      barrierA = barrierA + speedA; //changes the speed of barrier #1
      barrierB = barrierB + speedB; //changes the speed of barrier #2
      barrierC = barrierC + speedC; //changes the speed of barrier #3 bottom
      barrierC2 = barrierC2 + speedC; //changes the speed of barrier #3 top
      missilex = missilex - missilespeedx; //causes the missile to move

      image(barrier, barrierA, barrierAY, 160, barrierAH); // Barrier #1

      if ( barrierA < -175) {
        barrierA = speedAchange;  //if barrier goes out of frame on the left side it will be teleported to come into frame again on the right side
        barrierAY = 100 + floor(random(200)); //randomizes barrier #1 y coordinate
        barrierAH = height - barrierAY; //adjusts barrier #1 height to fit screen after y coordinate change
      }

      image(barrierinvert, barrierB, 0, 200, barrierBH); // Barrier #2

      if ( barrierB < -175) {
        barrierB = speedBchange; //if barrier goes out of frame on the left side it will be teleported to come into frame again on the right side
        barrierBH = 200 + floor(random(200)); //changes barrier #2 height, y is the same as in this case the barrier is pointing down
      }

      image(barrier, barrierC, barrierCY, 100, barrierCH); // Barrier #3 (1 bottom)

      if ( barrierC < -175) {
        barrierC = speedCchange; //if barrier goes out of frame on the left side it will be teleported to come into frame again on the right side
        barrierCY = 100 + floor(random(280)); //changes barrrier #3 bottom to a random y coordinate
        barrierCH = height - barrierCY; //matches the height of barrier #3 bottom to its y value
      }

      image(barrierinvert, barrierC2, 0, 100, barrierC2H); // Barrier #3 (2 top)

      if ( barrierC2 < -175) {
        barrierC2 = speedCchange; //if barrier goes out of frame on the left side it will be teleported to come into frame again on the right side
        barrierC2H = height - barrierCH - 80; //find empty space where #3 bottom is not, uses it for barrier #3 top, 80 pixel gap
      }

      image(missile, missilex, missiley, 220, 120); //image cadded
      if (barrierC + 100 < 0 && missilex < -200) { //if barrer #3 is out of frame, and missile is also out of frame, teleport the missile with the following
        missilespeedx = 3 + floor(random(5)); //randomized speed
        missiley = 30 + floor(random(400)); //randomized position on the y axis
        missilex = width; //just out of frame to the right
      }

      if (birdy < 1000) { //so that points are not counted after lose within the "game over" screen
        if (barrierA == -175) score = score + 1; //if x of the barrier 1,2,3 is about to be reset (-175) give +1 to the score
        if (barrierB == -175) score = score + 1;
        if (barrierC == -175) score = score + 1;
      }

      scored = "You got" + " " + "[" + score + "]" + " " + "point(s) that round!"; //text for screen 2, displays points earned

      textSize(35); //font size 35
      fill(0, 150); //transparent black text
      text(score, 580, 40); //score printed at 580,40

      //bouncing motion, changes the x and y coordinates 
      if ( birdx > 640) birdx = toofar; 
      if ( birdx < -5) birdspeedx = speedxchange;
      if ( birdy < 0) birdspeedy = speedychange; 

      if (coolDown > 0) coolDown = coolDown - 1; //if cooldown is not 0 then start counting down

      birdspeedy = birdspeedy + 0.5; //gravity
    }

    if (birdx + 45 >= barrierA && birdx + 45 <= barrierA + 175) { //if barrier #1 gets hit, small adjustments to make up for transparent bird PNG
      if (birdy + 20 >= barrierAY && birdy + 20 <= barrierAY + barrierAH) {
        screen = 2; //game over
      }
    }

    if (birdx + 40 >= barrierB && birdx + 40 <= barrierB + 215) { //if barrier #2 gets hit
      if (birdy + 15 >= 0 && birdy <= barrierBH - 25) {
        screen = 2; //game over
      }
    }

    if (birdx + 55 >= barrierC && birdx + 55 <= barrierC + 140) { //if barrier #3 (bottom) gets hit
      if (birdy + 15 >= barrierCY && birdy + 15 <= barrierCY + barrierCH) {
        screen = 2; //game over
      }
    }

    if (birdx + 55 >= barrierC2 && birdx + 55 <= barrierC2 + 130) { //if barrier #3 (top) gets hit
      if (birdy + 15 >= 0 && birdy + 15 <= barrierC2H) {
        screen = 2; //game over
      }
    }

    if (birdx + 40 >= missilex && birdx <= missilex + 160) { //collision detection for missile
      if (birdy + 15 >= missiley + 20 && birdy <= missiley + 55) {
        screen = 2; //game over
      }
    }

    if (birdy > 550) { //if the bird falls out of bounds
      screen = 2; //game over
    }
  } else if (screen == 2) { //lose page

    background(0); //black background
    image(gameover, 30, 30, 600, 180); //game over text
    fill(255, 255, 255); //white colour for text
    textSize(25); //text font size 25
    text(respawn, 220, 440); //respawn button text 
    text(scored, 140, 400); //your score that round
    image(deadflappy, 250, 230, 160, 100); //dead flappy bird image for game over screen
    birdy = birdy + lose; //stops user from spamming UP in order to get out of the Game Over screen
  }

  /* Troubleshooting tools
   textSize(15);
   fill(100,100,100);
   text("(" + mouseX + "," + mouseY + ")", 25,25);
   println(keyCode);
   println(barrierC2H);
   */
}

void mousePressed() {

  if (screen == 0) { //startup page

    if (mouseX > playbuttonx && mouseX < playbuttonx + playbuttonW && mouseY > playbuttony && mouseY < playbuttony + playbuttonH) screen = 1; //button pressed to enter the game
  }
}

void keyPressed() {

  if (keyCode == ' ') birdx = birdx + 0.01; //the following if statements are used to bring the bird out of birdx = 0 and birdy = 0 which starts the game
  if (keyCode == ' ') birdy = birdy + 0.01;
  if (keyCode == 87) birdx = birdx + 0.01;
  if (keyCode == 87) birdy = birdy + 0.01;
  if (keyCode == UP) birdx = birdx + 0.01;
  if (keyCode == UP) birdy = birdy + 0.01;

  if (keyCode == 82) { //if R is pressed the game will reset itself for another attempt
    screen = 1;
    birdy = 0; //because bird is frozen at 0,0 R press will move the bird there
    birdx = 0;
    birdspeedy = 5; //bird speed is increased depending on its fall so this sets the variables to default
    birdspeedx = 5;
    barrierA = 640; //barriers X value increases as it moves left, this sets them to their previous positions
    barrierB = 960;
    barrierC = 1480;
    barrierC2 = 1480;
    score = 0;  //resets the game score to 0
    missilex = -260; //resets missile position
  }

  if (coolDown == 0) { //cooldown for spamming the directional keys

    if (keyCode == ' ') { //space bar
      birdspeedy = -speedychange; //for all of these, if specific key is pressed, bird speed is changed
    }
    if (keyCode == UP) { //up arrow
      birdspeedy = -speedychange;
    }
    if (keyCode == 87) { //W key
      birdspeedy = -speedychange;
    }
    if (keyCode == LEFT) { //left arrow
      birdspeedx = -speedxchange;
    }
    if (keyCode == 65) { //A key
      birdspeedx = -speedxchange;
    }
    if (keyCode == RIGHT) { //right arrow
      birdspeedx = speedxchange;
    }
    if (keyCode == 68) { //D key
      birdspeedx = speedxchange;
    }
    coolDown = 2; //this sets the cooldown after the keypress
  }
}
