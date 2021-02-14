#include "lc4libc.h"

/*
 * #########################  SPRITE PATTERNS  #################################
 */

/*
 * The ship (triangle) will move in 8 different directions:
 *  \|/
 *  - -
 *  /|\
 * We will indicate which direction the ship, bullet and asteroids are facing by
 * using #defines. Each direction will be mapped to a value between 0 and 7. 
 * We can use enums in C, but the lcc compiler is not advanced enough to compile
 * enums. 
 * 
 * An example is typedef enum {CHICKEN, COW, RABBIT, HORSE} Animal;
 * Enums map each variable to a value (CHICKEN = 0, COW = 1...) in the same way
 * we are mapping directions using #defines.
 */
#define NORTH 0
#define NORTHEAST 1
#define EAST 2
#define SOUTHEAST  3
#define SOUTH  4
#define SOUTHWEST 5
#define WEST 6
#define NORTHWEST 7

/*
 * Objective 1:
 * Since we have 8 different directions, we need to know which sprite is associated
 * with a particular direction for the ship. If the player is facing NORTHEAST, the 
 * ship image should be pointing NORTHEAST. Defined below is a 2d array which 
 * holds the 8 sprites for the 8 directions. Each row contains the sprite for 
 * the current orientation based on the direction.
 *
 * Implement in this order:
 * North, Northeast, East, Southeast, South, Southwest, West, and Northwest
 */
lc4uint sprite_array[8][8] = {
    {0x18, 0x18, 0x3C, 0x3C, 0x7E, 0x7E, 0xFF, 0xFF},
    {0x7, 0x3F, 0xFF, 0x7E, 0x3E, 0x1E, 0xC, 0x4},
    {0xC0, 0xF0, 0xFC, 0xFF, 0xFF, 0xFC, 0xF0, 0xC0},
    {0x4, 0xC, 0x1E, 0x3E, 0x7E, 0xFF, 0x3F, 0x7},
    {0xFF, 0xFF, 0x7E, 0x7E, 0x3C, 0x3C, 0x18, 0x18},
    {0x20, 0x30, 0x78, 0x7C, 0x7E, 0xFF, 0xFC, 0xE0},
    {0x3, 0xF, 0x3F, 0xFF, 0xFF, 0x3F, 0xF, 0x3},
    {0xE0, 0xFC, 0xFF, 0x7E, 0x7C, 0x78, 0x30, 0x20}
};

/*
 * #######################  DEFINES #################################################
 */

//All possible game states
#define PLAYING_MODE           1
#define DEAD_SHIP_MODE         2
#define GAME_OVER_MODE         3
#define WON_MODE               4

//The number of lives a player starts out with
#define NUMBER_OF_LIVES        3

//Timer delay for lc4_getc_timer
#define GETC_TIMER             100

//The velocities of each object (how many pixels should an object move in a tick)
#define BULLET_VELOCITY        8
#define ASTEROID_VELOCITY      1
#define SHIP_VELOCITY          2

//The radiuses of the asteroids
#define BIG_ASTEROID           12
#define MID_ASTEROID           8
#define SMALL_ASTEROID         4

/*
 * ##############  DATA STRUCTURES THAT STORE THE GAME STATE  ##################
 */

//Current game state
int mode;

/*
 * Keeps track of the number of asteroids that the player needs to blow up
 *
 * The player wins when asteroids_remaining = 0.
 */
int asteroids_remaining;

/*
 * A struct for ship (A struct is like a java class, except it only holds variables like an array)
 */

typedef struct {
    //coordinates of the upper left corner of ship
    lc4int x;
    lc4int y;

    //current orientation of ship, based on last turn
    lc4int orientation;

    //number of player lives remaining
    lc4int lives;
} Ship;
Ship ship;

/*
 * Bullet struct
 */

typedef struct {
    //coordinates of the upper left corner of bullet
    lc4int x;
    lc4int y;

    //orientation of the bullet based on the direction the player shot it from
    lc4int orientation;

    //check if the bullet is on the screen.
    //if the bullet is on the screen, then the player cannot shoot
    lc4int exists;
} Bullet;
Bullet bullet;

/*
 * Asteroid struct
 *
 * x, y, radius, color will be parameters used to call the draw circle trap
 */
typedef struct {
    //coordinates of the upper left corner of bullet
    lc4int x, y;
    
    //size of the asteroid
    lc4uint radius;

    //color of the asteroid
    lc4uint color;

    //orientation of the asteroid
    int orientation;

    //used to check if the asteroid is destroyed and should split
    int exists;
} Asteroid;

/*
 * Array storing the 7 possible asteroids. Imagine this array as a tree:
 *
 *     *  <-- big
 *    / \
 *   *   * <-- medium
 *  / \ / \
 * *  * *  * <-- small
 *
 * asteroid_list[0] stores the original, largest Asteroid.
 * asteroid_list[1] and asteroid_list[2] stores the smaller asteroids that 
 * form when asteroid_list[0] is destroyed by a big asteroid.
 *
 * asteroid_list[1] splits into asteroid_list[3], asteroid_list[4].
 *
 * asteroid_list[2] splits into asteroid_list[5], asteroid_list[6].
 *
 * Feel free to choose your own sizes and colors. Just make sure that 
 * the bigger asteroids split into smaller ones and each size has its own
 * color.
 */
Asteroid asteroid_list[7];

// ############################ DEBUGGING #################################

/************************************************
 *  Printnum - 
 *  Prints out the value on the lc4
 ***********************************************/

void printnum (int n) {
  int abs_n;
  char str[10], *ptr;

  // Corner case (n == 0)
  if (n == 0) {
    lc4_puts ((lc4uint*)"0");
    return;
  }
 
  abs_n = (n < 0) ? -n : n;

  // Corner case (n == -32768) no corresponding +ve value
  if (abs_n < 0) {
    lc4_puts ((lc4uint*)"-32768");
    return;
  }

  ptr = str + 10; // beyond last character in string

  *(--ptr) = 0; // null termination

  while (abs_n) {
    *(--ptr) = (abs_n % 10) + 48; // generate ascii code for digit
    abs_n /= 10;
  }

  // Handle -ve numbers by adding - sign
  if (n < 0) *(--ptr) = '-';

  lc4_puts((lc4uint*)ptr);
}

/************************************************
 *  endl - 
 *  Ends a line by printing a newline character
 ***********************************************/
void endl () {
  lc4_puts((lc4uint*)"\n");
}

/************************************************
 *  rand16 - 
 *  Generates a random 16 bit number and returns a value between 0 and 127
 ***********************************************/
 int rand16()
 {
    int lfsr;

    // Advance the lfsr seven times
    lfsr = lc4_lfsr();
    lfsr = lc4_lfsr();
    lfsr = lc4_lfsr();
    lfsr = lc4_lfsr();
    lfsr = lc4_lfsr();
    lfsr = lc4_lfsr();
    lfsr = lc4_lfsr();

    // return the last 7 bits
    return (lfsr & 0x7F);
 }


/*
 * Objective 2.1:
 * This function should set the color and sizes for the big, medium and small
 * asteroids. You can find some pretty colors defined in lc4libc.h :)
 * Make sure that you set the orientation of the biggest asteroid.
 * In addition, make sure that the biggest asteroid's position is randomized
 * using lfsr.
 */
void init_asteroids()
{
    // smallest asteroid
    // initialize asteroid #0
    asteroid_list[0].color = YELLOW;
    asteroid_list[0].radius = BIG_ASTEROID;
    asteroid_list[0].orientation = NORTHEAST;
    lc4_lfsr_set_seed(100);
    asteroid_list[0].x = rand16();
    asteroid_list[0].y = rand16();
    asteroid_list[0].exists = TRUE;

    // medium-sized asteroids
    // initialize asteroid #0
    asteroid_list[1].color = ORANGE;
    asteroid_list[1].radius = MID_ASTEROID;
    asteroid_list[1].exists = FALSE;
    // initialize asteroid #1
    asteroid_list[2].color = ORANGE;
    asteroid_list[2].radius = MID_ASTEROID;
    asteroid_list[2].exists = FALSE;

    // smallest asteroids
    // initialize asteroid #3
    asteroid_list[3].color = RED;
    asteroid_list[3].radius = SMALL_ASTEROID;
    asteroid_list[3].exists = FALSE;
    // initialize asteroid #4
    asteroid_list[4].color = RED;
    asteroid_list[4].radius = SMALL_ASTEROID;
    asteroid_list[4].exists = FALSE;
    // initialize asteroid #5
    asteroid_list[5].color = RED;
    asteroid_list[5].radius = SMALL_ASTEROID;
    asteroid_list[5].exists = FALSE;
    // initialize asteroid #0
    asteroid_list[6].color = RED;
    asteroid_list[6].radius = SMALL_ASTEROID;
    asteroid_list[6].exists = FALSE;
}

/*
 * Objective 2.2:
 * Initializes the ship and bullet's existence. You must initialize the
 * ship's starting position and orientation. It does not have to be random.
 */
void reset_ship()
{
    
    bullet.exists = FALSE;
    // initial ship position is bottom of screen facing Northeast
    ship.orientation = NORTHEAST;
    ship.x = 50;
    ship.y = 110;
}


/* Objective 2.25
 * Reset global game state to the beginning of the game. 
 * (Call the two functions you have defined above and
 * in addition, reset the lives, mode and number number of asteroids)
 * Call this function in the beginning of main and when the player
 * wins/loses
 */
void reset_game_state()
{
    // reset and intialize asteroids, bullet, and mode
    init_asteroids();
    reset_ship();
    bullet.exists = FALSE;
    ship.lives = NUMBER_OF_LIVES;
    mode = PLAYING_MODE;
    asteroids_remaining = 7;
}

/*
 * ######################  CODE THAT DRAWS THE SCENE  ##########################
 */

/*
 * Objective 3.1:
 * There has to be a way to indicate if the player has won, lost or is still playing based on the mode.
 * The ship's color will be the indicator.
 * If the ship is white, the player is playing and has not hit an asteroid.
 * If the ship is green, the the player has won
 * If the ship is red, the the player has lost
 *
 * Make sure that your orientation is correct when drawing the ship!
 *
 * You can use lc4_draw_sprite defined in lc4libc.h and pass the 
 * correct parameters to draw the sprite.
 */
void draw_ship()
{
    lc4uint color = WHITE;

    // red = game over
    if (mode == GAME_OVER_MODE) {
        color = RED;
    }
    // green = won
    else if (mode == WON_MODE) {
        color = GREEN;
    }

    // yellow = still playing
    // check for orientation and pick right beginning of sprite_array
    if (ship.orientation == NORTH) {
        lc4_draw_sprite(ship.x, ship.y, color, &sprite_array[0][0]);
    }
    else if (ship.orientation == NORTHEAST) {
        lc4_draw_sprite(ship.x, ship.y, color, &sprite_array[1][0]);
    }
    else if (ship.orientation == EAST) {
        lc4_draw_sprite(ship.x, ship.y, color, &sprite_array[2][0]);
    }
    else if (ship.orientation == SOUTHEAST) {
        lc4_draw_sprite(ship.x, ship.y, color, &sprite_array[3][0]);
    }
    else if (ship.orientation == SOUTH) {
        lc4_draw_sprite(ship.x, ship.y, color, &sprite_array[4][0]);
    }
    else if (ship.orientation == SOUTHWEST) {
        lc4_draw_sprite(ship.x, ship.y, color, &sprite_array[5][0]);
    } 
    else if (ship.orientation == WEST) {
        lc4_draw_sprite(ship.x, ship.y, color, &sprite_array[6][0]);
    }
    else {
        lc4_draw_sprite(ship.x, ship.y, color, &sprite_array[7][0]);
    }
    
}

/*
 * Objective 3.1:
 * Now we move on to drawing the asteroid. First, we need to check if any asteroids
 * exist and if so, draw them using lc4_draw_circle defined in lc4libc.h 
 * by passing the correct paramaters
 */
void draw_asteroids()
{
    int i;
    // loop over asteroids and draw them at the right location if they exist
    for (i = 0; i < 7; i= i+1) {
        if (asteroid_list[i].exists) {
            lc4_draw_circle(asteroid_list[i].x, asteroid_list[i].y,
                asteroid_list[i].radius, asteroid_list[i].color);
        }
    }
}

/*
 * Objective 3.25:
 * A bullet is going to be a pixel in size. Color it whatever you like :).
 * (Make sure you check if it exists)
 */
void draw_bullet()
{
    if (bullet.exists) {
        lc4_draw_pixel(bullet.x, bullet.y, RED);
    }
}

/*
 * This function assumes that PennSim is being run in double buffered mode.
 * Run using PennSim with java -jar PennSim.jar -d on terminal. The -d flag
 * starts PennSim in double buffered mode. If you don't start in double buffered
 * mode, you will get weird stuff happening on your screen :(
 */

void redraw()
{
    //clear video memory
    lc4_reset_vmem();

    //draw scene
    draw_bullet();
    draw_asteroids();
    draw_ship();

    //swap buffer to screen
    lc4_blt_vmem();
}

/*
 * #####################  CODE THAT HANDLES GAME STATE #########################
 */

/*
 * Objective 4:
 * This function takes an index of an asteroid and breaks into into its parts.
 * Set the existence of the the asteroid to false and set the existence of its 
 * children to true to make sure that the children will be drawn on the next frame.
 * In addition, the children's position and directions should be set as well.
 */
void split_asteroid(int i)
{   
    int j;
    int opposite = get_opposite_orientation(i);
    asteroid_list[i].exists = FALSE;

    // if we want to split biggest asteroid
    if (i == 0) {
        // first child
        asteroid_list[1].exists = TRUE;
        asteroid_list[1].orientation = asteroid_list[i].orientation;
        asteroid_list[1].x = asteroid_list[i].x;
        asteroid_list[1].y = asteroid_list[i].y;

        // second child
        // direction, x, and y != first child
        asteroid_list[2].exists = TRUE;
        asteroid_list[2].orientation = opposite;
        asteroid_list[2].x = asteroid_list[i].x + 20;
        asteroid_list[2].y = asteroid_list[i].y + 20;
    }
    // if we want to split medium-sized asteroid #1
    else if (i == 1) {
        // first child
        asteroid_list[3].exists = TRUE;
        asteroid_list[3].orientation = asteroid_list[i].orientation;
        asteroid_list[3].x = asteroid_list[i].x;
        asteroid_list[3].y = asteroid_list[i].y;

        // second child
        // direction, x, and y != first child
        asteroid_list[4].exists = TRUE;
        asteroid_list[4].orientation = opposite;
        asteroid_list[4].x = asteroid_list[i].x + 20;
        asteroid_list[4].y = asteroid_list[i].y + 20;

    }
    // if we want to split medium-sized asteroid #2
    else if (i == 2) {
        // first child
        asteroid_list[5].exists = TRUE;
        asteroid_list[5].orientation = asteroid_list[i].orientation;
        asteroid_list[5].x = asteroid_list[i].x;
        asteroid_list[5].y = asteroid_list[i].y;

        // second child
        // direction, x, and y != first child
        asteroid_list[6].exists = TRUE;
        asteroid_list[6].orientation = opposite;
        asteroid_list[6].x = asteroid_list[i].x + 20;
        asteroid_list[6].y = asteroid_list[i].y + 20;

    }

    // check whether new asteroids are out of bounds
    for (j = 0; j < 7; j= j+1) {
        if (asteroid_list[j].exists) {
            // check y axis
            if (asteroid_list[j].y < 0) {
                asteroid_list[j].y = 0;
            }
            if (asteroid_list[j].y > 116) {
                asteroid_list[j].y = 116;
            }
            // check x axis
            if (asteroid_list[j].x < 0) {
                asteroid_list[j].x = 0;
            }
            if (asteroid_list[j].x > 120) {
                asteroid_list[j].x = 120;
            }
        }
    }


}

/* helper function to find an asteroid's opposite direction
 * takes in the asteroid's index in the array and returns
 * the direction opposite to the one it currently has
 */
int get_opposite_orientation(int i) {
    if (asteroid_list[i].orientation == NORTH) {
        return SOUTH;
    }
    else if (asteroid_list[i].orientation == NORTHEAST) {
        return NORTHWEST;
    }
    else if (asteroid_list[i].orientation == EAST) {
        return WEST;
    }
    else if (asteroid_list[i].orientation == SOUTHEAST) {
        return SOUTHWEST;
    }
    else if (asteroid_list[i].orientation == SOUTH) {
        return NORTH;
    }
    else if (asteroid_list[i].orientation == SOUTHWEST) {
        return SOUTHEAST;
    }
    else if (asteroid_list[i].orientation == WEST) {
        return EAST;
    }
    return NORTHEAST;
}


/*
 * Objective 5.1:
 * Function checks if the bullet exists 
 * If not, create a bullet with the same orientation of the ship
 * and set the bullet's x/y to the ship's x/y.
 * NOTE: the bullet's x/y cannot be set to the same x/y of the ship
 * because the ship's x/y is the top left of the sprite.
 * The bullet's x/y must be set with offsets based on the orientation
 * of the ship
 */

void shoot() {
    if(bullet.exists == 0 && mode == PLAYING_MODE)
    {
        // make bullet
        bullet.exists = 1;
        bullet.orientation = ship.orientation;

        // find ship's orientation and adjust bullet's x and y
        // coordinates accordingly
        if (ship.orientation == NORTH) {
            bullet.x = ship.x + 4;
            bullet.y = ship.y;
        }
        else if (ship.orientation == NORTHEAST) {
            bullet.x = ship.x + 8;
            bullet.y = ship.y;
            
        }
        else if (ship.orientation == EAST) {
            bullet.x = ship.x + 8;
            bullet.y = ship.y + 4;
            
        }
        else if (ship.orientation == SOUTHEAST) {
            bullet.x = ship.x + 8;
            bullet.y = ship.y + 8;
        }
        else if (ship.orientation == SOUTH) {
            bullet.x = ship.x + 4;
            bullet.y = ship.y + 8;
        }
        else if (ship.orientation == SOUTHWEST) {
            bullet.x = ship.x;
            bullet.y = ship.y + 8;
        } 
        else if (ship.orientation == WEST) {
            bullet.x = ship.x;
            bullet.y = ship.y + 4;
        }
        else {
            bullet.x = ship.x;
            bullet.y = ship.y;  
        }
    }
}


/*
 * Objective 5.2:
 * The 'keypress' below corresponds to a key pressed by the player. keypress is
 * actually an lc4uint returned by lc4_getc_timer!
 *
 * You can compare the value of keypress to a character directly, or compare
 * against the ASCII value of a character (look up a table online).
 *
 * For example, (keypress == 'w') is equivalent to 
 * (keypress == 119) or (keypress == 0x77).
 *
 * a should rotate the ship one orientation to the left (counter-clockwise)
 * d should rotate the ship one orientation to the right (clockwise)
 * SPACE (' ') should create a bullet by setting bullet.exists to TRUE and 
 * setting its orientation and position correctly.
 *
 * In addition, if the user does not press a key, move in previously set
 * direction. (It gives an effect of floating in space)
 *
 * Make sure the ship isn't going off screen!
 * If so, make the ship "slide" along the edge. 
 * 
 * Example: P is the ship and there is wall. P is facing southwest.
 * P should just move west by SHIP_VELOCITY
 *          
 *        P
 * ---------------- <--  Wall
 *
 * ########### NEXT FRAME ###########
 * 
 *       P
 * ----------------
 * 
 * You can do this by checking the current orientation of the ship and the ship's position
 */

void update_ship(lc4uint keypress)
{
    // if user pressed a, move ship one orientation left
    if (keypress == 97 && mode == PLAYING_MODE) {
        if (ship.orientation == NORTH) {
            ship.orientation = NORTHWEST;
        }
        else {
            ship.orientation--;
        }
    }
    // if user pressed y, move ship one orientation right
    else if (keypress == 100 && mode == PLAYING_MODE) {
        if (ship.orientation == NORTHWEST) {
            ship.orientation = NORTH;
        }
        else {
            ship.orientation++;
        }
    }
    // if user pressed space bar, shipp
    else if (keypress == ' ' && mode == PLAYING_MODE) {
        shoot();
    }
    // else, move ship once in previous direction
    else {
        if (mode == PLAYING_MODE) {
            if (ship.orientation == NORTH) {
                ship.y = ship.y - SHIP_VELOCITY;
            }
            else if (ship.orientation == NORTHEAST) {
                ship.x = ship.x + SHIP_VELOCITY;
                ship.y = ship.y - SHIP_VELOCITY;
            }
            else if (ship.orientation == EAST) {
                ship.x = ship.x + SHIP_VELOCITY;  
            }
            else if (ship.orientation == SOUTHEAST) {
                ship.x = ship.x + SHIP_VELOCITY; 
                ship.y = ship.y + SHIP_VELOCITY; 
            }
            else if (ship.orientation == SOUTH) {
                ship.y = ship.y + SHIP_VELOCITY;
            }
            else if (ship.orientation == SOUTHWEST) {
                ship.x = ship.x - SHIP_VELOCITY; 
                ship.y = ship.y + SHIP_VELOCITY;
            } 
            else if (ship.orientation == WEST) {
                ship.x = ship.x - SHIP_VELOCITY;
            }
            else {
                ship.x = ship.x - SHIP_VELOCITY; 
                ship.y = ship.y - SHIP_VELOCITY; 
            }
        }
        
    }

    // check if ship is going off screen: y axis
    if (ship.y < 0) {
        ship.y = 0;
    }
    if (ship.y > 116) {
        ship.y = 116;
    }
    // check if ship is going off screen: x axis
    if (ship.x < 0) {
        ship.x = 0;
    }
    if (ship.x > 120) {
        ship.x = 120;
    }
}

/*
 * Objective 5.3
 * Updates the asteroid's location based on 
 * the previous asteroid's orientation
 */
void move_asteroid(Asteroid *a)
{   
    // get asteroid's orientation and move it one step in that direction
    if (a->exists && mode == PLAYING_MODE) {
        if (a->orientation == NORTH) {
            a->y = a->y - ASTEROID_VELOCITY;
        }
        else if (a->orientation == NORTHEAST) {
            a->x = a->x + ASTEROID_VELOCITY;
            a->y = a->y - ASTEROID_VELOCITY;
            
        }
        else if (a->orientation == EAST) {
            a->x = a->x + ASTEROID_VELOCITY;  
        }
        else if (a->orientation == SOUTHEAST) {
            a->x = a->x + ASTEROID_VELOCITY; 
            a->y = a->y + ASTEROID_VELOCITY; 
        }
        else if (a->orientation == SOUTH) {
            a->y = a->y + ASTEROID_VELOCITY;
        }
        else if (a->orientation == SOUTHWEST) {
            a->x = a->x - ASTEROID_VELOCITY; 
            a->y = a->y + ASTEROID_VELOCITY;
        } 
        else if (a->orientation == WEST) {
            a->x = a->x - ASTEROID_VELOCITY;
        }
        else {
            a->x = a->x - ASTEROID_VELOCITY; 
            a->y = a->y - ASTEROID_VELOCITY; 
        }
    }
        
}

/*
 * Objective 6:
 * We need to check if a given point (ship or bullet) collides with an asteroid
 *
 * To check if a point is within an asteroid, check if the distance between the
 * center of the asteroid and the point is less than the radius of the asteroid.
 * Recall that the distance between (x1, y1) and (x2, y2) is
 * sqrt( (x1-x2)^2 + (y1-y2)^2 ).
 *
 * Thus, check if (x1-x2)^2 + (y1-y2)^2 < radius^2.
 *
 * NOTE: there is no built in power operator in C. Instead, use z^2 = z * z.
 *
 * Return TRUE if there is a collision, and FALSE otherwise.
 */
lc4bool check_point_collision(Asteroid *a, int x, int y)
{
    // distance between point and center of asteroid
    int distance = ((a->x - x)*(a->x - x)) + ((a->y - y)*(a->y - y));
    // if distance is smaller than radius, there's a collision
    if (distance < (a->radius * a->radius)) {
        return TRUE;
    }
    return FALSE;
}

/*
 * Objective 6.1
 * Use the method above to check if the bullet has collided with an asteroid
 * Appropriately set the exists variable, asteroids_remaining variable
 * and split the asteroid if possible
 * Takes in the index of the asteroid that was hit
 */
void check_bullet_collision(int i)
{
    // get asteroid
    Asteroid* asteroid = &asteroid_list[i];
    // if asteroid and bullet collide, get rid of bullet and asteroid
    if (check_point_collision(asteroid, bullet.x, bullet.y) && bullet.exists) {
        bullet.exists = FALSE;
        asteroid_list[i].exists = FALSE;
        asteroids_remaining--;
        // slip asteroid if possible
        split_asteroid(i);
    }
}

/*
 * Objective 6.2
 * Check if Asteroid collide with other Asteroid. Find if the distance
 * between the two centers is larger than the sum of their radii. If so, they
 * must be intersecting. Otherwise, they are not.
 * If they are intersection, reverse their orientations
 */
void check_asteroid_collision(int i)
{
    // j = index of other asteroid
    int j;
    int distance;
    int i_radius;
    int j_radius;
    int radius_sum;
    for (j = 0; j < 7; j= j+1) {
        if (asteroid_list[j].exists) {
            // check if we're comparing i to itself
            if (i != j) {
                // calculate distance between their centers
                distance = ((asteroid_list[i].x - asteroid_list[j].x)*
                (asteroid_list[i].x - asteroid_list[j].x)) +
                ((asteroid_list[i].y - asteroid_list[j].y)*
                (asteroid_list[i].y - asteroid_list[j].y));
                // get their radii
                i_radius = asteroid_list[i].radius;
                j_radius = asteroid_list[j].radius;
                radius_sum = i_radius + j_radius;

                // if distance between their centers is less than the sum of radii
                if (distance <= radius_sum * radius_sum) {
                    // change j's orientation only if they are not going in the same direction
                    if (asteroid_list[i].orientation != asteroid_list[j].orientation) {
                        asteroid_list[j].orientation = get_opposite_orientation(j);
                    }
                    // always change i's orientation
                    asteroid_list[i].orientation = get_opposite_orientation(i);
                }
            }
        }
    }
}

/*
 * Objective 7:
 * We'll have the asteroid bounce off the walls. Below, determine whether or not an 
 * asteroid is moving off-screen. If it is, reverse its direction.
 *
 * Eg. If the Asteroid is moving west off screen, change its orientation to
 * east. If the Asteroid is moving southwest and going to hit the left edge, its
 * orientation should be changed to southeast.
 */

void check_wall_collision(Asteroid *a)
{   
    // check top wall
    if ((a->y - a->radius) < (0 + ASTEROID_VELOCITY)) {
        // reverse orientations
        if (a->orientation == NORTH) {
            a->orientation = SOUTH;
        }
        else if (a->orientation == NORTHWEST) {
            a->orientation = SOUTHWEST;
        }
        else if (a->orientation == NORTHEAST) {
            a->orientation = SOUTHEAST;
        }
    }
    // check bottom wall
    else if ((a->y + a->radius) > (124 -  ASTEROID_VELOCITY)) {
        // reverse orientations
        if (a->orientation == SOUTH) {
            a->orientation = NORTH;
        }
        else if (a->orientation == SOUTHWEST) {
            a->orientation = NORTHWEST;
        }
        else if (a->orientation == SOUTHEAST) {
            a->orientation = NORTHEAST;
        }
    }
    // check left wall
    if ((a->x - a->radius) < (0 + ASTEROID_VELOCITY)) {
        // reverse orientations
        if (a->orientation == NORTHWEST) {
            a->orientation = NORTHEAST;
        }
        else if (a->orientation == WEST) {
            a->orientation = EAST;
        }
        else if (a->orientation == SOUTHWEST) {
            a->orientation = SOUTHEAST;
        }
    }
    // check right wall
    else if ((a->x +  a->radius) > (128 - ASTEROID_VELOCITY)) {
        // reverse orientations
        if (a->orientation == NORTHEAST) {
            a->orientation = NORTHWEST;
        }
        else if (a->orientation == EAST) {
            a->orientation = WEST;
        }
        else if (a->orientation == SOUTHEAST) {
            a->orientation = SOUTHWEST;
        }
    }
}

/*
 * Objective 7.1:
 * We need to check if the ship has collided with an Asteroid that's currently
 * being drawn on the screen.
 *
 * Return TRUE if the ship is okay (ie. did NOT collide with any Asteroid), and
 * return FALSE if the ship has collided with an active Asteroid.
 *
 * Since we don't have a center pixel, go through the four center pixels
 * and check if the ship has collided with the ship using the point
 */

lc4bool check_ship_collision()
{
    Asteroid* asteroid;
    int i;
    for (i = 0; i < 7; i= i+1) {
        // get asteroid
        asteroid = &asteroid_list[i];
        // check collisions in all four center points of asteroid
        if (asteroid->exists) {
            if ((check_point_collision(asteroid, ship.x + 3, ship.y + 3))
            || (check_point_collision(asteroid, ship.x + 3, ship.y + 4))
            || (check_point_collision(asteroid, ship.x + 4, ship.y + 3))
            || (check_point_collision(asteroid, ship.x + 4, ship.y + 4))) {
            return TRUE;
            }
        }
    }
    return FALSE;
}


//################## Putting it all together ################################

/*
 * Go through each asteroid and
 * 1) check their existence
 * 2) move them
 * 3) check their collision against the wall, bullet and other asteroids
 */

void update_asteroids()
{
    int i;
    for (i = 0; i < 7; i= i+1) {
        // get asteroid
        Asteroid* asteroid = &asteroid_list[i];
        // move exisiting asteroids and check for collisions
        if (asteroid->exists) {
            move_asteroid(asteroid);
            check_wall_collision(asteroid);
            check_bullet_collision(i);
            check_asteroid_collision(i);
        }
    }
}

/*
 * Objective 8.2:
 * Check if the bullet exists
 * and move the bullet according to its orientation
 * In addition, reset the bullet's existence if the bullet is out of the screen
 */

void update_bullet()
{
    // if bullet is on screen
    if(bullet.exists) {
        // get orientation and move one step accordingly
        if (bullet.orientation == NORTH) {
            bullet.y = bullet.y - BULLET_VELOCITY;
        }
        else if (bullet.orientation == NORTHEAST) {
            bullet.x = bullet.x + BULLET_VELOCITY;
            bullet.y = bullet.y - BULLET_VELOCITY;
            
        }
        else if (bullet.orientation == EAST) {
            bullet.x = bullet.x + BULLET_VELOCITY;  
        }
        else if (bullet.orientation == SOUTHEAST) {
            bullet.x = bullet.x + BULLET_VELOCITY; 
            bullet.y = bullet.y + BULLET_VELOCITY; 
        }
        else if (bullet.orientation == SOUTH) {
            bullet.y = bullet.y + BULLET_VELOCITY;
        }
        else if (bullet.orientation == SOUTHWEST) {
            bullet.x = bullet.x - BULLET_VELOCITY; 
            bullet.y = bullet.y + BULLET_VELOCITY;
        } 
        else if (bullet.orientation == WEST) {
            bullet.x = bullet.x - BULLET_VELOCITY;
        }
        else {
            bullet.x = bullet.x - BULLET_VELOCITY; 
            bullet.y = bullet.y - BULLET_VELOCITY; 
        }
    }

    // if bullet goes off screen, set its existence to fall
    if (bullet.y < 0 || bullet.x < 0 || bullet.x > 124 || bullet.y > 128) {
        bullet.exists = FALSE;
    }
}

/*
 * Objective 9
 * Update the entire game loop. Takes a keyboard keypress and
 * depending on the mode, processes the keyboard input and 
 * updates all the positions by calling the functions you've written above.
 * In addition, prints out the correct text depending on the current 
 * game mode.
 *
 * The user should be only able to press r when the player has lost/won
 */
void update_game_state(lc4uint keypress)
{
    int i;
    int num_asteroids = 7;
    /* If PLAYING_MODE active, go through game logic. */
    if(mode == PLAYING_MODE) {
        update_ship(keypress);
        update_bullet();
        update_asteroids();

        // if ship and asteroid collide, dead ship mode
        if (check_ship_collision()) {
            mode = DEAD_SHIP_MODE;
        }

        // count number of asteroids left
        for (i = 0; i < 7; i= i+1) {
            Asteroid* asteroid = &asteroid_list[i];
            if (asteroid->exists) {
                num_asteroids--;
            }
        }
        // if no asteroids exist, player has won
        if (num_asteroids == 7) {
            // tell player they have won
            lc4_puts((lc4uint*)"You've won\n");
            mode = WON_MODE;
        }
    }

    /* Dead ship Mode */
    if(mode == DEAD_SHIP_MODE) {
        // update number of lives
        ship.lives--;
        // tell player they have lost a life
        lc4_puts((lc4uint*)"You have ");
        printnum(ship.lives);

        // write "life" if there's only one life left
        if (ship.lives == 1) {
            lc4_puts((lc4uint*)" life left\n");
        }
        // else write lives
        else {
            lc4_puts((lc4uint*)" lives left\n");
        }

        // if ship is out of lives, player has lost
        if (ship.lives < 1) {
            mode = GAME_OVER_MODE;
            // tell player they have lost
            lc4_puts((lc4uint*)"You've lost :(\n");
        }
        else {
            // if there's still lives left, keep playing
            mode = PLAYING_MODE;
            reset_ship();        }
    }

    if(mode == WON_MODE) {
        // if player has won, make ship green
        update_ship(keypress);
    }

    /*
     * Mode where we've won/lost and we want to restart by pressing r
     */

    if(mode == GAME_OVER_MODE || mode == WON_MODE) {
        if(keypress == 'r') {
            reset_game_state();
        }
    }
}

/*
 * ############################  MAIN PROGRAM  #################################
 */

int main()
{
    lc4uint keypress;

    //Print the introduction by invoking the PUTS trap. This function is
    //declared in lc4libc.h.
    lc4_puts((lc4uint*)"Welcome to Asteroid!\n");
    lc4_puts((lc4uint*)"Press a to turn left, d to turn right\n");
    lc4_puts((lc4uint*)"Press space to fire!\n");

    // tell player how many lives they have at the beginning
    lc4_puts((lc4uint*)"You have ");
    printnum(NUMBER_OF_LIVES);
    lc4_puts((lc4uint*)" lives left\n");

    reset_game_state();

    //Main action loop happens here
    while(TRUE) {
        keypress = lc4_getc_timer(GETC_TIMER);
        update_game_state(keypress);
        redraw();
    }

    return 0;
}
