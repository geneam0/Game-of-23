.model tiny
.386
.data	
    ; random num func
    align 4
    random_32 label dword
    dd 0ffffffffh ; any seed except 0
    arr  DW 24 DUP(?)
    ; getkeystroke func
    Up_arrow = 48h
    Down_arrow = 50h
    Left_arrow = 4Bh
    Right_arrow = 4Dh
    ESC_key = 27
    Space_key = 32
    One_key = 49
    Two_key = 50
    Three_key = 51
    Four_key = 52
    Five_key = 53
    Empty_char = 32
    zero_space dw 1492
.code
org 100h

start:
    
    ; set video memory
	mov ax, 0b800h 
    mov es, ax 

    ; print board and numbers
    call Printnum1
    
    ; loop through keyboard input
    gameLoop:
        call Getkeystroke
        jmp gameLoop

; Clear screen 
Clrscr PROC
    mov ah, 6
    xor al, al      ; pixel value
    mov bh, 3       ; video page
    xor cx, cx      ; x-coordinate
    mov dx, 184fh   ; y-coordinate
    int 10h         ; call BIOS
    ret
Clrscr ENDP

; Print screen
Printscr PROC
    topleft:
        mov dx, 1fc9h           ; fills top left edge
        mov es:[0],dx
        mov bx, 1fcdh           ; makes line yellow
        mov di, 2               ; print horiztonal line 0 at 2
        mov cx, 59  
    h1:
        mov es:[di],bx
        add di, 2
        dec cx
        jnz h1  
        mov bx, 1ecdh       ; makes line yellow
        mov di, 962         ; print horiztonal line 1 at 962
        mov cx, 59
    h2:
        mov es:[di],bx
        add di,2
        dec cx
        jnz h2
        mov bx, 1ecdh       ; makes line yellow
        mov di, 1922        ; print horiztonal line 2 at 1922
        mov cx, 59
    h3:
        mov es:[di],bx
        add di,2
        dec cx
        jnz h3
        mov bx, 1ecdh       ; makes line yellow
        mov di, 2882        ; print horiztonal line 3 at 2882
        mov cx, 59
    h4:
        mov es:[di],bx
        add di,2
        dec cx
        jnz h4       
        mov bx, 1fcdh       ; makes line white
        mov di, 3842        ; print horiztonal line 4 at 3842
        mov cx, 59
    top:
        mov es:[di],bx
        add di,2
        dec cx
        jnz top
        mov bx, 1fd1h       ; print borders of top
        mov es:[20], bx
        mov es:[40], bx
        mov es:[60], bx
        mov es:[80], bx
        mov es:[100], bx
        mov dx, 1fbbh       ; fills top right edge
        mov es:[120], dx 
        mov bx, 1fbah       ; makes line whites
        mov di, 160         ; print vertical line at 160
        mov cx, 59
    v1:
        mov es:[di],bx
        add di, 160  
        loop v1  
        mov bx, 1eb3h       ; makes line yellow
        mov di, 180         ; print vertical line at 180
        mov cx, 59    
    v2:
        mov es:[di],bx
        add di, 160  
        loop v2
        mov bx, 1eb3h       ; makes line yellow
        mov di, 200         ; print vertical line at 200
        mov cx, 59
    v3:
        mov es:[di],bx
        add di, 160  
        loop v3
        mov bx, 1eb3h       ; makes line yellow
        mov di, 220         ; print vertical line at 220
        mov cx, 59
    v4:
        mov es:[di],bx
        add di, 160  
        loop v4
        mov bx, 1eb3h       ; makes line yellow
        mov di, 240         ; print vertical line at 240
        mov cx, 59
    v5:
        mov es:[di],bx
        add di, 160  
        loop v5
        mov bx, 1eb3h       ; makes line yellow
        mov di, 260         ; print vertical line at 260
        mov cx, 59
    botleft:
        mov es:[di], bx
        add di, 160  
        loop botleft
        mov bx, 1fc8h        ; fills bottom left corner
        mov es:[3840], bx
        mov bx, 1fc4h       
        mov cx, 59
    v6:
        mov es:[di],bx
        add di, 2
        dec cx
        jnz v6  
        mov bx, 1fbah      
        mov di, 280           ; print vertical line at 280
        mov cx, 59
    right:
        mov es:[di], bx
        add di, 160  
        loop right     
        mov bx, 1fb6h          ; print borders of rightmost col
        mov bx, 1ec5h          ; print first line to seperate vertically
        mov cx, 59
    botright:
        mov es:[di],bx
        add di, 320  
        loop botright  
        mov bx, 1fcfh           ; print borders of bottom row
        mov es:[3860], bx
        mov es:[3880], bx
        mov es:[3900], bx
        mov es:[3920], bx
        mov es:[3940], bx
        mov bx, 1fbch           ; print bottom right edge
        mov es:[3960], bx 
        mov cx, 59
    ret
Printscr ENDP

; random seed generator
random proc
    push edx
    mov eax,[random_32]
    mov edx,0019660Dh
    mul edx
    add eax,3C6EF35Fh
    mov [random_32],eax
    pop edx
    ret
random endp

; random number generator
randnum proc
    push cx
    call random         ; new random in EAX
    mov cx, 23         ; random num in range 0 to 24
    mul cx             ; multiply
    mov ax, cx        ; return top 32 of 64 bits
    pop cx
    ret
randnum endp

; Print numbers for board 1
Printnum1 PROC
    ; clear screen
    call Clrscr 

    ; print board
    call Printscr

    mov dx, 0f32h       ; print out 2 
    mov es:[492],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[508],dx     ; location left
    mov dx, 0f35h       ; print out 5
    mov es:[512],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[528],dx     ; location left
    mov dx, 0f31h       ; print out 1
    mov es:[532],dx     ; location right

    mov dx, 0f34h       ; print out 4
    mov es:[552],dx     ; location right
    
    mov dx, 0f32h       ; print out 2
    mov es:[568],dx     ; location left
    mov dx, 0f30h       ; print out 0
    mov es:[572],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[588],dx     ; location left
    mov dx, 0f37h       ; print out 7
    mov es:[592],dx     ; location right

    mov dx, 0f39h       ; print out 9
    mov es:[1452],dx     ; location right

    mov dx, 0f33h       ; print out 3
    mov es:[1472],dx     ; location right

    mov zero_space, 1492
    mov dx, Empty_char      ; empty space
    mov es:[zero_space],dx     ; location right

    mov dx, 0f38h       ; print out 8
    mov es:[1512],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[1528],dx     ; location left
    mov dx, 0f36h       ; print out 6
    mov es:[1532],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[1548],dx     ; location left
    mov dx, 0f32h       ; print out 0
    mov es:[1552],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2408],dx     ; location left
    mov dx, 0f34h       ; print out 4
    mov es:[2412],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2432],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2448],dx     ; location left
    mov dx, 0f30h       ; print out 0
    mov es:[2452],dx     ; location right

    mov dx, 0f37h       ; print out 7
    mov es:[2472],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[2488],dx     ; location left
    mov dx, 0f33h       ; print out 3
    mov es:[2492],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2508],dx     ; location left
    mov dx, 0f39h       ; print out 9
    mov es:[2512],dx     ; location right

    mov dx, 0f35h       ; print out 5
    mov es:[3372],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3388],dx     ; location left
    mov dx, 0f33h       ; print out 3
    mov es:[3392],dx     ; location right

    mov dx, 0f36h       ; print out 6
    mov es:[3412],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3428],dx     ; location left
    mov dx, 0f32h       ; print out 2
    mov es:[3432],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3448],dx     ; location left
    mov dx, 0f38h       ; print out 8
    mov es:[3452],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[3468],dx     ; location left
    mov dx, 0f31h       ; print out 1
    mov es:[3472],dx     ; location right
    ret
Printnum1 ENDP

; Print numbers for board 2
Printnum2 PROC
    ; clear screen
    call Clrscr 

    ; print board
    call Printscr

    mov dx, 0f35h       ; print out 5
    mov es:[492],dx     ; location right

    mov dx, 0f31h       ; print out 5
    mov es:[512],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[528],dx     ; location left
    mov dx, 0f37h       ; print out 7
    mov es:[532],dx     ; location right

    mov dx, 0f33h       ; print out 3
    mov es:[552],dx     ; location right
    
    mov dx, 0f31h       ; print out 1
    mov es:[568],dx     ; location left
    mov dx, 0f30h       ; print out 0
    mov es:[572],dx     ; location right

    mov dx, 0f37h       ; print out 7
    mov es:[592],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[1448],dx     ; location left
    mov dx, 0f30h       ; print out 0
    mov es:[1452],dx     ; location right

    
    mov dx, 0f31h       ; print out 1
    mov es:[1468],dx     ; location left
    mov dx, 0f34h       ; print out 4
    mov es:[1472],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[1488],dx     ; location left
    mov dx, 0f36h       ; print out 6
    mov es:[1492],dx     ; location right

    mov dx, 0f38h       ; print out 8
    mov es:[1512],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[1528],dx     ; location left
    mov dx, 0f32h       ; print out 2
    mov es:[1532],dx     ; location right

    mov dx, 0f34h       ; print out 4
    mov es:[1552],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[2408],dx     ; location left
    mov dx, 0f33h       ; print out 3
    mov es:[2412],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2428],dx     ; location left
    mov dx, 0f38h       ; print out 8
    mov es:[2432],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[2452],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2468],dx     ; location left
    mov dx, 0f31h       ; print out 1
    mov es:[2472],dx     ; location right

    mov dx, 0f36h       ; print out 6
    mov es:[2492],dx     ; location right
    
    mov dx, 0f31h       ; print out 1
    mov es:[2508],dx     ; location left
    mov dx, 0f32h       ; print out 2
    mov es:[2512],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3368],dx     ; location left
    mov dx, 0f39h       ; print out 9
    mov es:[3372],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3388],dx     ; location left
    mov dx, 0f33h       ; print out 3
    mov es:[3392],dx     ; location right

    mov zero_space, 3412
    mov dx, Empty_char      ; empty space
    mov es:[zero_space],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[3428],dx     ; location left
    mov dx, 0f31h       ; print out 1
    mov es:[3432],dx     ; location right

    mov dx, 0f39h       ; print out 9
    mov es:[3452],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3468],dx     ; location left
    mov dx, 0f35h       ; print out 5
    mov es:[3472],dx     ; location right

    ret
Printnum2 ENDP

; Print numbers for board 3
Printnum3 PROC
    ; clear screen
    call Clrscr 

    ; print board
    call Printscr

    mov dx, 0f31h       ; print out 1
    mov es:[488],dx     ; location left
    mov dx, 0f35h       ; print out 5
    mov es:[492],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[508],dx     ; location left
    mov dx, 0f31h       ; print out 1
    mov es:[512],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[528],dx     ; location left
    mov dx, 0f37h       ; print out 7
    mov es:[532],dx     ; location right

    mov dx, 0f33h       ; print out 3
    mov es:[552],dx     ; location right
    
    mov dx, 0f31h       ; print out 1
    mov es:[568],dx     ; location left
    mov dx, 0f30h       ; print out 0
    mov es:[572],dx     ; location right

    mov dx, 0f37h       ; print out 7
    mov es:[592],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[1448],dx     ; location left
    mov dx, 0f30h       ; print out 0
    mov es:[1452],dx     ; location right

    
    mov dx, 0f31h       ; print out 1
    mov es:[1468],dx     ; location left
    mov dx, 0f34h       ; print out 4
    mov es:[1472],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[1488],dx     ; location left
    mov dx, 0f36h       ; print out 6
    mov es:[1492],dx     ; location right

    mov dx, 0f38h       ; print out 8
    mov es:[1512],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[1528],dx     ; location left
    mov dx, 0f32h       ; print out 2
    mov es:[1532],dx     ; location right

    mov dx, 0f34h       ; print out 4
    mov es:[1552],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[2408],dx     ; location left
    mov dx, 0f33h       ; print out 3
    mov es:[2412],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2428],dx     ; location left
    mov dx, 0f38h       ; print out 8
    mov es:[2432],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[2452],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2472],dx     ; location right

    mov dx, 0f36h       ; print out 6
    mov es:[2492],dx     ; location right
    
    mov dx, 0f31h       ; print out 1
    mov es:[2508],dx     ; location left
    mov dx, 0f39h       ; print out 9
    mov es:[2512],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3368],dx     ; location left
    mov dx, 0f32h       ; print out 2
    mov es:[3372],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3388],dx     ; location left
    mov dx, 0f33h       ; print out 3
    mov es:[3392],dx     ; location right
    
    mov dx, 0f32h       ; print out 2
    mov es:[3408],dx     ; location left
    mov dx, 0f31h       ; print out 1
    mov es:[3412],dx     ; location right

    mov zero_space, 3432
    mov dx, Empty_char      ; empty space
    mov es:[zero_space],dx     ; location right

    mov dx, 0f39h       ; print out 9
    mov es:[3452],dx     ; location right

    mov dx, 0f35h       ; print out 5
    mov es:[3472],dx     ; location right

    ret
Printnum3 ENDP

; Print numbers for board 1
Printnum4 PROC
    ; clear screen
    call Clrscr 

    ; print board
    call Printscr

    mov zero_space, 492
    mov dx, Empty_char      ; empty space
    mov es:[zero_space],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[508],dx     ; location left
    mov dx, 0f35h       ; print out 5
    mov es:[512],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[528],dx     ; location left
    mov dx, 0f31h       ; print out 1
    mov es:[532],dx     ; location right

    mov dx, 0f34h       ; print out 4
    mov es:[552],dx     ; location right
    
    mov dx, 0f32h       ; print out 2
    mov es:[568],dx     ; location left
    mov dx, 0f30h       ; print out 0
    mov es:[572],dx     ; location right

    mov dx, 0f37h       ; print out 7
    mov es:[592],dx     ; location right

    mov dx, 0f39h       ; print out 9
    mov es:[1452],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[1468],dx     ; location right
    mov dx, 0f33h       ; print out 3
    mov es:[1472],dx     ; location right

    mov dx, 0f32h       ; print out 2 
    mov es:[1492],dx     ; location right

    mov dx, 0f38h       ; print out 8
    mov es:[1512],dx     ; location right

    mov dx, 0f36h       ; print out 6
    mov es:[1532],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[1548],dx     ; location left
    mov dx, 0f32h       ; print out 0
    mov es:[1552],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2408],dx     ; location left
    mov dx, 0f34h       ; print out 4
    mov es:[2412],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[2428],dx     ; location left
    mov dx, 0f31h       ; print out 1
    mov es:[2432],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2448],dx     ; location left
    mov dx, 0f30h       ; print out 0
    mov es:[2452],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2468],dx     ; location right
    mov dx, 0f37h       ; print out 7
    mov es:[2472],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[2488],dx     ; location left
    mov dx, 0f33h       ; print out 3
    mov es:[2492],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2508],dx     ; location left
    mov dx, 0f39h       ; print out 9
    mov es:[2512],dx     ; location right

    mov dx, 0f35h       ; print out 5
    mov es:[3372],dx     ; location right

    mov dx, 0f33h       ; print out 3
    mov es:[3392],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3408],dx     ; location left
    mov dx, 0f36h       ; print out 6
    mov es:[3412],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3428],dx     ; location left
    mov dx, 0f32h       ; print out 2
    mov es:[3432],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3448],dx     ; location left
    mov dx, 0f38h       ; print out 8
    mov es:[3452],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3472],dx     ; location right
    ret
Printnum4 ENDP

Printnum5 PROC
    ; clear screen
    call Clrscr 

    ; print board
    call Printscr

    mov dx, 0f31h       ; print out 1
    mov es:[488],dx     ; location left
    mov dx, 0f31h       ; print out 1
    mov es:[492],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[508],dx     ; location left
    mov dx, 0f33h       ; print out 3
    mov es:[512],dx     ; location right

    mov zero_space, 532
    mov dx, Empty_char      ; empty space
    mov es:[zero_space],dx     ; location right

    mov dx, 0f34h       ; print out 4
    mov es:[552],dx     ; location right
    
    mov dx, 0f32h       ; print out 2
    mov es:[568],dx     ; location left
    mov dx, 0f32h       ; print out 2
    mov es:[572],dx     ; location right

    mov dx, 0f37h       ; print out 7
    mov es:[592],dx     ; location right

    mov dx, 0f39h       ; print out 9
    mov es:[1452],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[1468],dx     ; location right
    mov dx, 0f35h       ; print out 5
    mov es:[1472],dx     ; location right

    mov dx, 0f38h       ; print out 8
    mov es:[1492],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[1512],dx     ; location right

    mov dx, 0f36h       ; print out 6
    mov es:[1532],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[1548],dx     ; location left
    mov dx, 0f31h       ; print out 1
    mov es:[1552],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2408],dx     ; location left
    mov dx, 0f34h       ; print out 4
    mov es:[2412],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[2428],dx     ; location left
    mov dx, 0f30h       ; print out 0
    mov es:[2432],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2448],dx     ; location left
    mov dx, 0f37h       ; print out 7
    mov es:[2452],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2468],dx     ; location right
    mov dx, 0f30h       ; print out 0
    mov es:[2472],dx     ; location right

    mov dx, 0f32h       ; print out 2
    mov es:[2488],dx     ; location left
    mov dx, 0f33h       ; print out 3
    mov es:[2492],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[2508],dx     ; location left
    mov dx, 0f36h       ; print out 6
    mov es:[2512],dx     ; location right

    mov dx, 0f35h       ; print out 5
    mov es:[3372],dx     ; location right

    mov dx, 0f33h       ; print out 3
    mov es:[3392],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3408],dx     ; location left
    mov dx, 0f39h       ; print out 9
    mov es:[3412],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3428],dx     ; location left
    mov dx, 0f32h       ; print out 2
    mov es:[3432],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3448],dx     ; location left
    mov dx, 0f38h       ; print out 8
    mov es:[3452],dx     ; location right

    mov dx, 0f31h       ; print out 1
    mov es:[3472],dx     ; location right
    ret
Printnum5 ENDP

; Get player input
Getkeystroke PROC
    mov ah, 10h             ; get key pressed
    int 16h
    
    cmp ah, Up_arrow        ; if you press the up arrow
    je Up_pressed
    cmp ah, Down_arrow      ; if you press the down arrow
    je  Down_pressed
    cmp ah, Left_arrow      ; if you press the left arrow 
    je  Left_pressed
    cmp ah, Right_arrow     ; if you press the right arrow 
    je  Right_pressed            

    cmp al, One_key         ; if you press 1
    je Printnum1
    cmp al, Two_key         ; if you press 2
    je Printnum2
    cmp al, Three_key       ; if you press 3
    je Printnum3
    cmp al, Four_key        ; if you press 4
    je Printnum4
    cmp al, Five_key        ; if you press 5
    je Printnum5
    cmp al, ESC_key         ; if you press ESC
    je EndGame
    ret
Getkeystroke ENDP

Up_pressed PROC
    mov bx, zero_space
    cmp bx, 3372
    jge endu
    mov dx, [es:[bx+960]]
    mov es:[bx], dx
    mov dx, [es:[bx-4+960]]
    mov es:[bx-4], dx
    mov es:[bx-4+960], Empty_char
    mov es:[bx+960], Empty_char
    add bx, 960
    mov zero_space, bx
    endu:
        nop
    ret
Up_pressed ENDP

Down_pressed PROC
    mov bx, zero_space
    cmp bx, 592
    jle endd
    mov dx, [es:[bx-960]]
    mov es:[bx], dx
    mov dx, [es:[bx-4-960]]
    mov es:[bx-4], dx
    mov es:[bx-4-960], Empty_char
    mov es:[bx-960], Empty_char
    sub bx, 960
    mov zero_space, bx
    endd:
        nop
    ret
Down_pressed ENDP

Left_pressed PROC
    mov bx, zero_space
    cmp bx, 592
    je endl
    cmp bx, 1552
    je endl
    cmp bx, 2512
    je endl
    cmp bx, 3472
    je endl
    mov dx, [es:[bx+20]]
    mov es:[bx], dx
    mov dx, [es:[bx-4+20]]
    mov es:[bx-4], dx
    mov es:[bx-4+20], Empty_char
    mov es:[bx+20], Empty_char
    add bx, 20
    mov zero_space, bx
    endl:
        nop
    ret
Left_pressed ENDP

Right_pressed PROC
    mov bx, zero_space
    cmp bx, 492
    je endr
    cmp bx, 1452
    je endl
    cmp bx, 2412
    je endl
    cmp bx, 3372
    je endl
    mov dx, [es:[bx-20]]
    mov es:[bx], dx
    mov dx, [es:[bx-4-20]]
    mov es:[bx-4], dx
    mov es:[bx-4-20], Empty_char
    mov es:[bx-20], Empty_char
    sub bx, 20
    mov zero_space, bx
    endr:
        nop
    ret
Right_pressed ENDP

EndGame PROC
    call Clrscr
    mov ah, 4ch
    int 21h
    ret
EndGame ENDP

end start