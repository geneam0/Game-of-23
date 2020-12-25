//==================================================================================== <br />
// Gene Lam <br />
// Professor: Michael Vulis <br />
// CSC21000-E Assembly Language <br />
//==================================================================================== <br />

This program is Game of 23 programmed in ASM. The code initializes the video memory and clears the screen at first. 
Then it draws the grid lines and prints the numbers according to the board. At first, the game initializes to board 1.
By pressing keys: '1', '2', '3', '4', or '5', the player can alternate between board configuration.

After initializing the board, the player can alter the board by pressing "UP", "DOWN", "LEFT", or "RIGHT" keys.
This will shift a neight number piece into an empty slot. The player wins by getting the board in chronological order.

Pressing the 'ESC' key will end the game.

Main Functions:
Clrscr			; Clears the screen using int 10h
Printscr		; Prints the board grid
Printnum1		; Prints the numbers on board 1
Printnum2		; Prints the numbers on board 2
Printnum3		; Prints the numbers on board 3
Printnum4 		; Prints the numbers on board 4
Printnum5		; Prints the numbers on board 5
Getkeystroke		; Gets the key stroke using int 16h
Up_pressed		; Changes the board if "UP" key is pressed
Down_pressed		; Changes the board if "DOWN" key is pressed
Left_pressed		; Changes the board if "LEFT" key is pressed
Right_pressed		; Changes the board if "RIGHT" key is pressed
EndGame			; Clears screen and ends video memory
