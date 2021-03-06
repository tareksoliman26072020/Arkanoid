My goal is to immitate the game [Arkanoid](https://www.youtube.com/watch?v=Th-Z6QQ5AOQ)
# Arkanoid

The game is implemented in java using [processing](https://processing.org/)
### Game Structure:
+ I have main program that opens a window with proper dimensions.
+ The program have a global ArrayList for storing the blocks.
+ The ball and the paddle are global variables of this program.
+ The game starts with a welcoming pabel showing the the controls of the game, and expects the user to press any key to start the game.
+ the number of hit blocks and the score is shown while playing. the given score per a hit block depends on how many blocks are being hit before the ball returns to the paddle. The score is calculated with the sum function: $$\stackrel{ball\ is\ back\ to\ the\ paddle}{\underset{i=streak}{\Sigma } i}$$
+ The game is won when all blocks are hit/destroyed. Then a new windows is actived, showing the current score, and waiting on the user's input of key 'r' to restart the game.
+ The game is lost when the ball doesn't meet the paddle when it does down. Then the user's pressed 'r' to restart the game without restarting the program.

### Paddle and Ball:
+ objects for the ball and for the paddle.
+ Positions are stored as PVector objects.
+ PVector objects have methods for moving and for drawing,and  methods are called by the main program.
+ The paddle is controlled by using the keyboard.

### Bricks:
+ class Block for a brick's singleton.
+ The Block class have functions for drawing and colliding with the ball.
+ All Block objects are stored in the main programn's ArrayList in `Arkanoid`.
+ The collision with the ball work for all four sides of the brick.
+ collision detection looks realistic (firework).

### Special Bricks:
+ I have two classes for special bricks 'SlowingBlock'&amp; 'ExplosiveBlock'. both are inherit from the main brick class.
+ The two classes look different from the main class and both  looks different from each other.
+ When setting up the list of bricks in the main programm, a certain percentage of bricks should be special bricks.
+ The game has in total 177 bricks. 10 of them are of `SlowingBlock`, 10 of them are of `ExplosiveBlock`. ANd because they are inherited of `Block` they can be stored in the same ArrayList of `Block`.

### Particle System:
Whenever a brick is destroyed, a small particle system should display a brick explosion. A class named `Particle` is made for every produced particle in the explosion. This class can be found in the Block's file.

----

## Screenshots: ![](https://hackmd.informatik.uni-bremen.de/uploads/upload_5f11e93a39550b63a99a031b90c1bd32.png) ![](https://hackmd.informatik.uni-bremen.de/uploads/upload_79ce3f9dfce3c316e47ec0c874c64df1.png) ![](https://hackmd.informatik.uni-bremen.de/uploads/upload_f1ab023285d6af26f53cc30bf6dc27ab.png) ![](https://hackmd.informatik.uni-bremen.de/uploads/upload_7d56100b95296f4cff258db7ed9d9ba2.png)
