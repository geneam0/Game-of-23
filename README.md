//==================================================================================== <br />
// Gene Lam <br />
// Professor: Michael Vulis <br />
// CSC21000-E Assembly Language <br />
//==================================================================================== <br />

This program is Game of 23 programmed in ASM. The code initializes the video memory and clears the screen at first. <br />
Then it draws the grid lines and prints the numbers according to the board. At first, the game initializes to board 1. <br />
By pressing keys: '1', '2', '3', '4', or '5', the player can alternate between board configuration. <br />

After initializing the board, the player can alter the board by pressing "UP", "DOWN", "LEFT", or "RIGHT" keys. <br />
This will shift a neight number piece into an empty slot. The player wins by getting the board in chronological order. <br />

Pressing the 'ESC' key will end the game. <br />

Main Functions: <br />
Clrscr			; Clears the screen using int 10h <br />
Printscr		; Prints the board grid <br />
Printnum1		; Prints the numbers on board 1 <br />
Printnum2		; Prints the numbers on board 2 <br />
Printnum3		; Prints the numbers on board 3 <br />
Printnum4 		; Prints the numbers on board 4 <br />
Printnum5		; Prints the numbers on board 5 <br />
Getkeystroke		; Gets the key stroke using int 16h <br />
Up_pressed		; Changes the board if "UP" key is pressed <br />
Down_pressed		; Changes the board if "DOWN" key is pressed <br />
Left_pressed		; Changes the board if "LEFT" key is pressed <br />
Right_pressed		; Changes the board if "RIGHT" key is pressed <br />
EndGame			; Clears screen and ends video memory <br />
