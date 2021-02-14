		.DATA
sprite_array 		.FILL #24
		.FILL #24
		.FILL #60
		.FILL #60
		.FILL #126
		.FILL #126
		.FILL #255
		.FILL #255
		.FILL #7
		.FILL #63
		.FILL #255
		.FILL #126
		.FILL #62
		.FILL #30
		.FILL #12
		.FILL #4
		.FILL #192
		.FILL #240
		.FILL #252
		.FILL #255
		.FILL #255
		.FILL #252
		.FILL #240
		.FILL #192
		.FILL #4
		.FILL #12
		.FILL #30
		.FILL #62
		.FILL #126
		.FILL #255
		.FILL #63
		.FILL #7
		.FILL #255
		.FILL #255
		.FILL #126
		.FILL #126
		.FILL #60
		.FILL #60
		.FILL #24
		.FILL #24
		.FILL #32
		.FILL #48
		.FILL #120
		.FILL #124
		.FILL #126
		.FILL #255
		.FILL #252
		.FILL #224
		.FILL #3
		.FILL #15
		.FILL #63
		.FILL #255
		.FILL #255
		.FILL #63
		.FILL #15
		.FILL #3
		.FILL #224
		.FILL #252
		.FILL #255
		.FILL #126
		.FILL #124
		.FILL #120
		.FILL #48
		.FILL #32
;;;;;;;;;;;;;;;;;;;;;;;;;;;;printnum;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
printnum
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-13	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRnp L5_asteroids
	LEA R7, L7_asteroids
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L4_asteroids
L5_asteroids
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L9_asteroids
	LDR R7, R5, #3
	NOT R7,R7
	ADD R7,R7,#1
	STR R7, R5, #-13
	JMP L10_asteroids
L9_asteroids
	LDR R7, R5, #3
	STR R7, R5, #-13
L10_asteroids
	LDR R7, R5, #-13
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRzp L11_asteroids
	LEA R7, L13_asteroids
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L4_asteroids
L11_asteroids
	ADD R7, R5, #-12
	ADD R7, R7, #10
	STR R7, R5, #-2
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #0
	STR R3, R7, #0
	JMP L15_asteroids
L14_asteroids
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	LDR R3, R5, #-1
	CONST R2, #10
	MOD R3, R3, R2
	CONST R2, #48
	ADD R3, R3, R2
	STR R3, R7, #0
	LDR R7, R5, #-1
	CONST R3, #10
	DIV R7, R7, R3
	STR R7, R5, #-1
L15_asteroids
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnp L14_asteroids
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRzp L17_asteroids
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
	CONST R3, #45
	STR R3, R7, #0
L17_asteroids
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L4_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;endl;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
endl
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, L20_asteroids
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L19_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;rand16;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
rand16
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	JSR lc4_lfsr
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #127
	AND R7, R7, R3
L21_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;init_asteroids;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
init_asteroids
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, asteroid_list
	CONST R3, #240
	HICONST R3, #127
	STR R3, R7, #3
	LEA R7, asteroid_list
	CONST R3, #12
	STR R3, R7, #2
	LEA R7, asteroid_list
	CONST R3, #1
	STR R3, R7, #4
	CONST R7, #100
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_lfsr_set_seed
	ADD R6, R6, #1	;; free space for arguments
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	LEA R3, asteroid_list
	STR R7, R3, #0
	JSR rand16
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	LEA R3, asteroid_list
	STR R7, R3, #1
	LEA R7, asteroid_list
	CONST R3, #1
	STR R3, R7, #5
	LEA R7, asteroid_list
	CONST R3, #0
	HICONST R3, #246
	STR R3, R7, #9
	LEA R7, asteroid_list
	CONST R3, #8
	STR R3, R7, #8
	LEA R7, asteroid_list
	CONST R3, #0
	STR R3, R7, #11
	LEA R7, asteroid_list
	CONST R3, #0
	HICONST R3, #246
	STR R3, R7, #15
	LEA R7, asteroid_list
	CONST R3, #8
	STR R3, R7, #14
	LEA R7, asteroid_list
	CONST R3, #0
	STR R3, R7, #17
	LEA R7, asteroid_list
	CONST R3, #0
	HICONST R3, #124
	STR R3, R7, #21
	LEA R7, asteroid_list
	CONST R3, #4
	STR R3, R7, #20
	LEA R7, asteroid_list
	CONST R3, #0
	STR R3, R7, #23
	LEA R7, asteroid_list
	CONST R3, #0
	HICONST R3, #124
	STR R3, R7, #27
	LEA R7, asteroid_list
	CONST R3, #4
	STR R3, R7, #26
	LEA R7, asteroid_list
	CONST R3, #0
	STR R3, R7, #29
	LEA R7, asteroid_list
	CONST R3, #33
	ADD R7, R7, R3
	CONST R3, #0
	HICONST R3, #124
	STR R3, R7, #0
	LEA R7, asteroid_list
	CONST R3, #32
	ADD R7, R7, R3
	CONST R3, #4
	STR R3, R7, #0
	LEA R7, asteroid_list
	CONST R3, #35
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
	LEA R7, asteroid_list
	CONST R3, #39
	ADD R7, R7, R3
	CONST R3, #0
	HICONST R3, #124
	STR R3, R7, #0
	LEA R7, asteroid_list
	CONST R3, #38
	ADD R7, R7, R3
	CONST R3, #4
	STR R3, R7, #0
	LEA R7, asteroid_list
	CONST R3, #41
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
L22_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;reset_ship;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
reset_ship
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, bullet
	CONST R3, #0
	STR R3, R7, #3
	LEA R7, ship
	CONST R3, #1
	STR R3, R7, #2
	LEA R7, ship
	CONST R3, #50
	STR R3, R7, #0
	CONST R3, #110
	STR R3, R7, #1
L23_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;reset_game_state;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
reset_game_state
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR init_asteroids
	ADD R6, R6, #0	;; free space for arguments
	JSR reset_ship
	ADD R6, R6, #0	;; free space for arguments
	LEA R7, bullet
	CONST R3, #0
	STR R3, R7, #3
	LEA R7, ship
	CONST R3, #3
	STR R3, R7, #3
	LEA R7, mode
	CONST R3, #1
	STR R3, R7, #0
	LEA R7, asteroids_remaining
	CONST R3, #7
	STR R3, R7, #0
L24_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_ship;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_ship
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #255
	HICONST R7, #255
	STR R7, R5, #-1
	LEA R7, mode
	LDR R7, R7, #0
	CONST R3, #3
	CMP R7, R3
	BRnp L26_asteroids
	CONST R7, #0
	HICONST R7, #124
	STR R7, R5, #-1
	JMP L27_asteroids
L26_asteroids
	LEA R7, mode
	LDR R7, R7, #0
	CONST R3, #4
	CMP R7, R3
	BRnp L28_asteroids
	CONST R7, #0
	HICONST R7, #51
	STR R7, R5, #-1
L28_asteroids
L27_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #0
	CMP R7, R3
	BRnp L30_asteroids
	LEA R7, sprite_array
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, ship
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L31_asteroids
L30_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #1
	CMP R7, R3
	BRnp L32_asteroids
	LEA R7, sprite_array
	ADD R7, R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, ship
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L33_asteroids
L32_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #2
	CMP R7, R3
	BRnp L34_asteroids
	LEA R7, sprite_array
	CONST R3, #16
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, ship
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L35_asteroids
L34_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #3
	CMP R7, R3
	BRnp L36_asteroids
	LEA R7, sprite_array
	CONST R3, #24
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, ship
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L37_asteroids
L36_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #4
	CMP R7, R3
	BRnp L38_asteroids
	LEA R7, sprite_array
	CONST R3, #32
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, ship
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L39_asteroids
L38_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #5
	CMP R7, R3
	BRnp L40_asteroids
	LEA R7, sprite_array
	CONST R3, #40
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, ship
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L41_asteroids
L40_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #6
	CMP R7, R3
	BRnp L42_asteroids
	LEA R7, sprite_array
	CONST R3, #48
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, ship
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
	JMP L43_asteroids
L42_asteroids
	LEA R7, sprite_array
	CONST R3, #56
	ADD R7, R7, R3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, ship
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_sprite
	ADD R6, R6, #4	;; free space for arguments
L43_asteroids
L41_asteroids
L39_asteroids
L37_asteroids
L35_asteroids
L33_asteroids
L31_asteroids
L25_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_asteroids;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_asteroids
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
L45_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	LDR R7, R7, #5
	CONST R3, #0
	CMP R7, R3
	BRz L49_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	LDR R3, R7, #3
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_circle
	ADD R6, R6, #4	;; free space for arguments
L49_asteroids
L46_asteroids
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #7
	CMP R7, R3
	BRn L45_asteroids
L44_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_bullet;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_bullet
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, bullet
	LDR R7, R7, #3
	CONST R3, #0
	CMP R7, R3
	BRz L52_asteroids
	CONST R7, #0
	HICONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, bullet
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_draw_pixel
	ADD R6, R6, #3	;; free space for arguments
L52_asteroids
L51_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;redraw;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
redraw
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	JSR lc4_reset_vmem
	ADD R6, R6, #0	;; free space for arguments
	JSR draw_bullet
	ADD R6, R6, #0	;; free space for arguments
	JSR draw_asteroids
	ADD R6, R6, #0	;; free space for arguments
	JSR draw_ship
	ADD R6, R6, #0	;; free space for arguments
	JSR lc4_blt_vmem
	ADD R6, R6, #0	;; free space for arguments
L54_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;split_asteroid;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
split_asteroid
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR get_opposite_orientation
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-2
	CONST R7, #6
	LDR R3, R5, #3
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #5
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRnp L56_asteroids
	LEA R7, asteroid_list
	CONST R3, #1
	STR R3, R7, #11
	LEA R7, asteroid_list
	CONST R3, #6
	LDR R2, R5, #3
	MUL R3, R3, R2
	ADD R3, R3, R7
	LDR R3, R3, #4
	STR R3, R7, #10
	LEA R7, asteroid_list
	CONST R3, #6
	LDR R2, R5, #3
	MUL R3, R3, R2
	ADD R3, R3, R7
	LDR R3, R3, #0
	STR R3, R7, #6
	LEA R7, asteroid_list
	CONST R3, #6
	LDR R2, R5, #3
	MUL R3, R3, R2
	ADD R3, R3, R7
	LDR R3, R3, #1
	STR R3, R7, #7
	LEA R7, asteroid_list
	CONST R3, #1
	STR R3, R7, #17
	LEA R7, asteroid_list
	LDR R3, R5, #-2
	STR R3, R7, #16
	LEA R7, asteroid_list
	CONST R3, #6
	LDR R2, R5, #3
	MUL R3, R3, R2
	ADD R3, R3, R7
	LDR R3, R3, #0
	CONST R2, #20
	ADD R3, R3, R2
	STR R3, R7, #12
	LEA R7, asteroid_list
	CONST R3, #6
	LDR R2, R5, #3
	MUL R3, R3, R2
	ADD R3, R3, R7
	LDR R3, R3, #1
	CONST R2, #20
	ADD R3, R3, R2
	STR R3, R7, #13
	JMP L57_asteroids
L56_asteroids
	LDR R7, R5, #3
	CONST R3, #1
	CMP R7, R3
	BRnp L58_asteroids
	LEA R7, asteroid_list
	CONST R3, #1
	STR R3, R7, #23
	LEA R7, asteroid_list
	CONST R3, #6
	LDR R2, R5, #3
	MUL R3, R3, R2
	ADD R3, R3, R7
	LDR R3, R3, #4
	STR R3, R7, #22
	LEA R7, asteroid_list
	CONST R3, #6
	LDR R2, R5, #3
	MUL R3, R3, R2
	ADD R3, R3, R7
	LDR R3, R3, #0
	STR R3, R7, #18
	LEA R7, asteroid_list
	CONST R3, #6
	LDR R2, R5, #3
	MUL R3, R3, R2
	ADD R3, R3, R7
	LDR R3, R3, #1
	STR R3, R7, #19
	LEA R7, asteroid_list
	CONST R3, #1
	STR R3, R7, #29
	LEA R7, asteroid_list
	LDR R3, R5, #-2
	STR R3, R7, #28
	LEA R7, asteroid_list
	CONST R3, #6
	LDR R2, R5, #3
	MUL R3, R3, R2
	ADD R3, R3, R7
	LDR R3, R3, #0
	CONST R2, #20
	ADD R3, R3, R2
	STR R3, R7, #24
	LEA R7, asteroid_list
	CONST R3, #6
	LDR R2, R5, #3
	MUL R3, R3, R2
	ADD R3, R3, R7
	LDR R3, R3, #1
	CONST R2, #20
	ADD R3, R3, R2
	STR R3, R7, #25
	JMP L59_asteroids
L58_asteroids
	LDR R7, R5, #3
	CONST R3, #2
	CMP R7, R3
	BRnp L60_asteroids
	LEA R7, asteroid_list
	CONST R3, #35
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #0
	LEA R7, asteroid_list
	CONST R3, #34
	ADD R3, R7, R3
	CONST R2, #6
	LDR R1, R5, #3
	MUL R2, R2, R1
	ADD R7, R2, R7
	LDR R7, R7, #4
	STR R7, R3, #0
	LEA R7, asteroid_list
	CONST R3, #6
	LDR R2, R5, #3
	MUL R3, R3, R2
	ADD R3, R3, R7
	LDR R3, R3, #0
	STR R3, R7, #30
	LEA R7, asteroid_list
	CONST R3, #6
	LDR R2, R5, #3
	MUL R3, R3, R2
	ADD R3, R3, R7
	LDR R3, R3, #1
	STR R3, R7, #31
	LEA R7, asteroid_list
	CONST R3, #41
	ADD R7, R7, R3
	CONST R3, #1
	STR R3, R7, #0
	LEA R7, asteroid_list
	CONST R3, #40
	ADD R7, R7, R3
	LDR R3, R5, #-2
	STR R3, R7, #0
	LEA R7, asteroid_list
	CONST R3, #36
	ADD R3, R7, R3
	CONST R2, #6
	LDR R1, R5, #3
	MUL R2, R2, R1
	ADD R7, R2, R7
	LDR R7, R7, #0
	CONST R2, #20
	ADD R7, R7, R2
	STR R7, R3, #0
	LEA R7, asteroid_list
	CONST R3, #37
	ADD R3, R7, R3
	CONST R2, #6
	LDR R1, R5, #3
	MUL R2, R2, R1
	ADD R7, R2, R7
	LDR R7, R7, #1
	CONST R2, #20
	ADD R7, R7, R2
	STR R7, R3, #0
L60_asteroids
L59_asteroids
L57_asteroids
	CONST R7, #0
	STR R7, R5, #-1
L62_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	LDR R7, R7, #5
	CONST R3, #0
	CMP R7, R3
	BRz L66_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	LDR R7, R7, #1
	CONST R3, #0
	CMP R7, R3
	BRzp L68_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #1
L68_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	LDR R7, R7, #1
	CONST R3, #116
	CMP R7, R3
	BRnz L70_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	CONST R3, #116
	STR R3, R7, #1
L70_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRzp L72_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #0
L72_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	LDR R7, R7, #0
	CONST R3, #120
	CMP R7, R3
	BRnz L74_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	CONST R3, #120
	STR R3, R7, #0
L74_asteroids
L66_asteroids
L63_asteroids
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #7
	CMP R7, R3
	BRn L62_asteroids
L55_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;get_opposite_orientation;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
get_opposite_orientation
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	CONST R7, #6
	LDR R3, R5, #3
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	LDR R7, R7, #4
	CONST R3, #0
	CMP R7, R3
	BRnp L77_asteroids
	CONST R7, #4
	JMP L76_asteroids
L77_asteroids
	CONST R7, #6
	LDR R3, R5, #3
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	LDR R7, R7, #4
	CONST R3, #1
	CMP R7, R3
	BRnp L79_asteroids
	CONST R7, #7
	JMP L76_asteroids
L79_asteroids
	CONST R7, #6
	LDR R3, R5, #3
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	LDR R7, R7, #4
	CONST R3, #2
	CMP R7, R3
	BRnp L81_asteroids
	CONST R7, #6
	JMP L76_asteroids
L81_asteroids
	CONST R7, #6
	LDR R3, R5, #3
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	LDR R7, R7, #4
	CONST R3, #3
	CMP R7, R3
	BRnp L83_asteroids
	CONST R7, #5
	JMP L76_asteroids
L83_asteroids
	CONST R7, #6
	LDR R3, R5, #3
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	LDR R7, R7, #4
	CONST R3, #4
	CMP R7, R3
	BRnp L85_asteroids
	CONST R7, #0
	JMP L76_asteroids
L85_asteroids
	CONST R7, #6
	LDR R3, R5, #3
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	LDR R7, R7, #4
	CONST R3, #5
	CMP R7, R3
	BRnp L87_asteroids
	CONST R7, #3
	JMP L76_asteroids
L87_asteroids
	CONST R7, #6
	LDR R3, R5, #3
	MUL R3, R7, R3
	LEA R2, asteroid_list
	ADD R3, R3, R2
	LDR R3, R3, #4
	CMP R3, R7
	BRnp L89_asteroids
	CONST R7, #2
	JMP L76_asteroids
L89_asteroids
	CONST R7, #1
L76_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;shoot;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
shoot
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LEA R7, bullet
	LDR R7, R7, #3
	CONST R3, #0
	CMP R7, R3
	BRnp L92_asteroids
	LEA R7, mode
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L92_asteroids
	LEA R7, bullet
	CONST R3, #1
	STR R3, R7, #3
	LEA R7, bullet
	LEA R3, ship
	LDR R3, R3, #2
	STR R3, R7, #2
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #0
	CMP R7, R3
	BRnp L94_asteroids
	LEA R7, bullet
	LEA R3, ship
	LDR R2, R3, #0
	ADD R2, R2, #4
	STR R2, R7, #0
	LDR R3, R3, #1
	STR R3, R7, #1
	JMP L95_asteroids
L94_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #1
	CMP R7, R3
	BRnp L96_asteroids
	LEA R7, bullet
	LEA R3, ship
	LDR R2, R3, #0
	ADD R2, R2, #8
	STR R2, R7, #0
	LDR R3, R3, #1
	STR R3, R7, #1
	JMP L97_asteroids
L96_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #2
	CMP R7, R3
	BRnp L98_asteroids
	LEA R7, bullet
	LEA R3, ship
	LDR R2, R3, #0
	ADD R2, R2, #8
	STR R2, R7, #0
	LDR R3, R3, #1
	ADD R3, R3, #4
	STR R3, R7, #1
	JMP L99_asteroids
L98_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #3
	CMP R7, R3
	BRnp L100_asteroids
	LEA R7, bullet
	LEA R3, ship
	LDR R2, R3, #0
	ADD R2, R2, #8
	STR R2, R7, #0
	LDR R3, R3, #1
	ADD R3, R3, #8
	STR R3, R7, #1
	JMP L101_asteroids
L100_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #4
	CMP R7, R3
	BRnp L102_asteroids
	LEA R7, bullet
	LEA R3, ship
	LDR R2, R3, #0
	ADD R2, R2, #4
	STR R2, R7, #0
	LDR R3, R3, #1
	ADD R3, R3, #8
	STR R3, R7, #1
	JMP L103_asteroids
L102_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #5
	CMP R7, R3
	BRnp L104_asteroids
	LEA R7, bullet
	LEA R3, ship
	LDR R2, R3, #0
	STR R2, R7, #0
	LDR R3, R3, #1
	ADD R3, R3, #8
	STR R3, R7, #1
	JMP L105_asteroids
L104_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #6
	CMP R7, R3
	BRnp L106_asteroids
	LEA R7, bullet
	LEA R3, ship
	LDR R2, R3, #0
	STR R2, R7, #0
	LDR R3, R3, #1
	ADD R3, R3, #4
	STR R3, R7, #1
	JMP L107_asteroids
L106_asteroids
	LEA R7, bullet
	LEA R3, ship
	LDR R2, R3, #0
	STR R2, R7, #0
	LDR R3, R3, #1
	STR R3, R7, #1
L107_asteroids
L105_asteroids
L103_asteroids
L101_asteroids
L99_asteroids
L97_asteroids
L95_asteroids
L92_asteroids
L91_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;update_ship;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
update_ship
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R7, R5, #3
	CONST R3, #97
	CMP R7, R3
	BRnp L109_asteroids
	LEA R7, mode
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L109_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #0
	CMP R7, R3
	BRnp L111_asteroids
	LEA R7, ship
	CONST R3, #7
	STR R3, R7, #2
	JMP L110_asteroids
L111_asteroids
	LEA R7, ship
	ADD R7, R7, #2
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	JMP L110_asteroids
L109_asteroids
	LDR R7, R5, #3
	CONST R3, #100
	CMP R7, R3
	BRnp L113_asteroids
	LEA R7, mode
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L113_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #7
	CMP R7, R3
	BRnp L115_asteroids
	LEA R7, ship
	CONST R3, #0
	STR R3, R7, #2
	JMP L114_asteroids
L115_asteroids
	LEA R7, ship
	ADD R7, R7, #2
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	JMP L114_asteroids
L113_asteroids
	LDR R7, R5, #3
	CONST R3, #32
	CMP R7, R3
	BRnp L117_asteroids
	LEA R7, mode
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L117_asteroids
	JSR shoot
	ADD R6, R6, #0	;; free space for arguments
	JMP L118_asteroids
L117_asteroids
	LEA R7, mode
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L119_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #0
	CMP R7, R3
	BRnp L121_asteroids
	LEA R7, ship
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-2
	STR R3, R7, #0
	JMP L122_asteroids
L121_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #1
	CMP R7, R3
	BRnp L123_asteroids
	LEA R7, ship
	LDR R3, R7, #0
	ADD R3, R3, #2
	STR R3, R7, #0
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-2
	STR R3, R7, #0
	JMP L124_asteroids
L123_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #2
	CMP R7, R3
	BRnp L125_asteroids
	LEA R7, ship
	LDR R3, R7, #0
	ADD R3, R3, #2
	STR R3, R7, #0
	JMP L126_asteroids
L125_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #3
	CMP R7, R3
	BRnp L127_asteroids
	LEA R7, ship
	LDR R3, R7, #0
	ADD R3, R3, #2
	STR R3, R7, #0
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #2
	STR R3, R7, #0
	JMP L128_asteroids
L127_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #4
	CMP R7, R3
	BRnp L129_asteroids
	LEA R7, ship
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #2
	STR R3, R7, #0
	JMP L130_asteroids
L129_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #5
	CMP R7, R3
	BRnp L131_asteroids
	LEA R7, ship
	LDR R3, R7, #0
	ADD R3, R3, #-2
	STR R3, R7, #0
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #2
	STR R3, R7, #0
	JMP L132_asteroids
L131_asteroids
	LEA R7, ship
	LDR R7, R7, #2
	CONST R3, #6
	CMP R7, R3
	BRnp L133_asteroids
	LEA R7, ship
	LDR R3, R7, #0
	ADD R3, R3, #-2
	STR R3, R7, #0
	JMP L134_asteroids
L133_asteroids
	LEA R7, ship
	LDR R3, R7, #0
	ADD R3, R3, #-2
	STR R3, R7, #0
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-2
	STR R3, R7, #0
L134_asteroids
L132_asteroids
L130_asteroids
L128_asteroids
L126_asteroids
L124_asteroids
L122_asteroids
L119_asteroids
L118_asteroids
L114_asteroids
L110_asteroids
	LEA R7, ship
	LDR R7, R7, #1
	CONST R3, #0
	CMP R7, R3
	BRzp L135_asteroids
	LEA R7, ship
	CONST R3, #0
	STR R3, R7, #1
L135_asteroids
	LEA R7, ship
	LDR R7, R7, #1
	CONST R3, #116
	CMP R7, R3
	BRnz L137_asteroids
	LEA R7, ship
	CONST R3, #116
	STR R3, R7, #1
L137_asteroids
	LEA R7, ship
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRzp L139_asteroids
	LEA R7, ship
	CONST R3, #0
	STR R3, R7, #0
L139_asteroids
	LEA R7, ship
	LDR R7, R7, #0
	CONST R3, #120
	CMP R7, R3
	BRnz L141_asteroids
	LEA R7, ship
	CONST R3, #120
	STR R3, R7, #0
L141_asteroids
L108_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;move_asteroid;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
move_asteroid
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R7, R5, #3
	LDR R7, R7, #5
	CONST R3, #0
	CMP R7, R3
	BRz L144_asteroids
	LEA R7, mode
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L144_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #0
	CMP R7, R3
	BRnp L146_asteroids
	LDR R7, R5, #3
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	JMP L147_asteroids
L146_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #1
	CMP R7, R3
	BRnp L148_asteroids
	LDR R7, R5, #3
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	LDR R7, R5, #3
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	JMP L149_asteroids
L148_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #2
	CMP R7, R3
	BRnp L150_asteroids
	LDR R7, R5, #3
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	JMP L151_asteroids
L150_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #3
	CMP R7, R3
	BRnp L152_asteroids
	LDR R7, R5, #3
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	LDR R7, R5, #3
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	JMP L153_asteroids
L152_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #4
	CMP R7, R3
	BRnp L154_asteroids
	LDR R7, R5, #3
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	JMP L155_asteroids
L154_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #5
	CMP R7, R3
	BRnp L156_asteroids
	LDR R7, R5, #3
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	LDR R7, R5, #3
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
	JMP L157_asteroids
L156_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #6
	CMP R7, R3
	BRnp L158_asteroids
	LDR R7, R5, #3
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	JMP L159_asteroids
L158_asteroids
	LDR R7, R5, #3
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	LDR R7, R5, #3
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
L159_asteroids
L157_asteroids
L155_asteroids
L153_asteroids
L151_asteroids
L149_asteroids
L147_asteroids
L144_asteroids
L143_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_point_collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_point_collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LDR R7, R5, #3
	LDR R3, R7, #0
	LDR R2, R5, #4
	SUB R3, R3, R2
	LDR R7, R7, #1
	LDR R2, R5, #5
	SUB R7, R7, R2
	MUL R3, R3, R3
	MUL R7, R7, R7
	ADD R7, R3, R7
	STR R7, R5, #-1
	LDR R7, R5, #3
	LDR R7, R7, #2
	LDR R3, R5, #-1
	MUL R7, R7, R7
	CMPU R3, R7
	BRzp L161_asteroids
	CONST R7, #1
	JMP L160_asteroids
L161_asteroids
	CONST R7, #0
L160_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_bullet_collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_bullet_collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	CONST R7, #6
	LDR R3, R5, #3
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	STR R7, R5, #-1
	LEA R7, bullet
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR check_point_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRz L164_asteroids
	LEA R7, bullet
	LDR R7, R7, #3
	CMP R7, R3
	BRz L164_asteroids
	LEA R7, bullet
	CONST R3, #0
	STR R3, R7, #3
	CONST R7, #6
	LDR R3, R5, #3
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	CONST R3, #0
	STR R3, R7, #5
	LEA R7, asteroids_remaining
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR split_asteroid
	ADD R6, R6, #1	;; free space for arguments
L164_asteroids
L163_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_asteroid_collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_asteroid_collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-6	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
L167_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	LDR R7, R7, #5
	CONST R3, #0
	CMP R7, R3
	BRz L171_asteroids
	LDR R7, R5, #3
	LDR R3, R5, #-1
	CMP R7, R3
	BRz L173_asteroids
	CONST R7, #6
	LEA R3, asteroid_list
	LDR R2, R5, #3
	MUL R2, R7, R2
	ADD R2, R2, R3
	LDR R1, R5, #-1
	MUL R7, R7, R1
	ADD R7, R7, R3
	LDR R3, R2, #0
	LDR R1, R7, #0
	SUB R3, R3, R1
	LDR R1, R2, #1
	LDR R0, R7, #1
	SUB R1, R1, R0
	MUL R3, R3, R3
	MUL R1, R1, R1
	ADD R3, R3, R1
	STR R3, R5, #-3
	LDR R3, R2, #2
	STR R3, R5, #-4
	LDR R7, R7, #2
	STR R7, R5, #-5
	LDR R7, R5, #-4
	LDR R3, R5, #-5
	ADD R7, R7, R3
	STR R7, R5, #-2
	LDR R7, R5, #-2
	LDR R3, R5, #-3
	MUL R7, R7, R7
	CMP R3, R7
	BRp L175_asteroids
	CONST R7, #6
	LEA R3, asteroid_list
	LDR R2, R5, #3
	MUL R2, R7, R2
	ADD R2, R2, R3
	LDR R2, R2, #4
	LDR R1, R5, #-1
	MUL R7, R7, R1
	ADD R7, R7, R3
	LDR R7, R7, #4
	CMP R2, R7
	BRz L177_asteroids
	LDR R7, R5, #-1
	STR R7, R5, #-6
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR get_opposite_orientation
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	CONST R3, #6
	LDR R2, R5, #-6
	MUL R3, R3, R2
	LEA R2, asteroid_list
	ADD R3, R3, R2
	STR R7, R3, #4
L177_asteroids
	LDR R7, R5, #3
	STR R7, R5, #-6
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR get_opposite_orientation
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	CONST R3, #6
	LDR R2, R5, #-6
	MUL R3, R3, R2
	LEA R2, asteroid_list
	ADD R3, R3, R2
	STR R7, R3, #4
L175_asteroids
L173_asteroids
L171_asteroids
L168_asteroids
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #7
	CMP R7, R3
	BRn L167_asteroids
L166_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_wall_collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_wall_collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
	LDR R7, R5, #3
	LDR R3, R7, #1
	LDR R7, R7, #2
	SUB R7, R3, R7
	CONST R3, #1
	CMPU R7, R3
	BRzp L180_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #0
	CMP R7, R3
	BRnp L182_asteroids
	LDR R7, R5, #3
	CONST R3, #4
	STR R3, R7, #4
	JMP L181_asteroids
L182_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #7
	CMP R7, R3
	BRnp L184_asteroids
	LDR R7, R5, #3
	CONST R3, #5
	STR R3, R7, #4
	JMP L181_asteroids
L184_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #1
	CMP R7, R3
	BRnp L181_asteroids
	LDR R7, R5, #3
	CONST R3, #3
	STR R3, R7, #4
	JMP L181_asteroids
L180_asteroids
	LDR R7, R5, #3
	LDR R3, R7, #1
	LDR R7, R7, #2
	ADD R7, R3, R7
	CONST R3, #123
	CMPU R7, R3
	BRnz L188_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #4
	CMP R7, R3
	BRnp L190_asteroids
	LDR R7, R5, #3
	CONST R3, #0
	STR R3, R7, #4
	JMP L191_asteroids
L190_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #5
	CMP R7, R3
	BRnp L192_asteroids
	LDR R7, R5, #3
	CONST R3, #7
	STR R3, R7, #4
	JMP L193_asteroids
L192_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #3
	CMP R7, R3
	BRnp L194_asteroids
	LDR R7, R5, #3
	CONST R3, #1
	STR R3, R7, #4
L194_asteroids
L193_asteroids
L191_asteroids
L188_asteroids
L181_asteroids
	LDR R7, R5, #3
	LDR R3, R7, #0
	LDR R7, R7, #2
	SUB R7, R3, R7
	CONST R3, #1
	CMPU R7, R3
	BRzp L196_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #7
	CMP R7, R3
	BRnp L198_asteroids
	LDR R7, R5, #3
	CONST R3, #1
	STR R3, R7, #4
	JMP L197_asteroids
L198_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #6
	CMP R7, R3
	BRnp L200_asteroids
	LDR R7, R5, #3
	CONST R3, #2
	STR R3, R7, #4
	JMP L197_asteroids
L200_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #5
	CMP R7, R3
	BRnp L197_asteroids
	LDR R7, R5, #3
	CONST R3, #3
	STR R3, R7, #4
	JMP L197_asteroids
L196_asteroids
	LDR R7, R5, #3
	LDR R3, R7, #0
	LDR R7, R7, #2
	ADD R7, R3, R7
	CONST R3, #127
	CMPU R7, R3
	BRnz L204_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #1
	CMP R7, R3
	BRnp L206_asteroids
	LDR R7, R5, #3
	CONST R3, #7
	STR R3, R7, #4
	JMP L207_asteroids
L206_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #2
	CMP R7, R3
	BRnp L208_asteroids
	LDR R7, R5, #3
	CONST R3, #6
	STR R3, R7, #4
	JMP L209_asteroids
L208_asteroids
	LDR R7, R5, #3
	LDR R7, R7, #4
	CONST R3, #3
	CMP R7, R3
	BRnp L210_asteroids
	LDR R7, R5, #3
	CONST R3, #5
	STR R3, R7, #4
L210_asteroids
L209_asteroids
L207_asteroids
L204_asteroids
L197_asteroids
L179_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;check_ship_collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
check_ship_collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
L213_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	STR R7, R5, #-2
	LDR R7, R5, #-2
	LDR R7, R7, #5
	CONST R3, #0
	CMP R7, R3
	BRz L217_asteroids
	LEA R7, ship
	LDR R3, R7, #1
	ADD R3, R3, #3
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR check_point_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRnp L223_asteroids
	LEA R7, ship
	LDR R3, R7, #1
	ADD R3, R3, #4
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR check_point_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRnp L223_asteroids
	LEA R7, ship
	LDR R3, R7, #1
	ADD R3, R3, #3
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R7, R7, #4
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR check_point_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRnp L223_asteroids
	LEA R7, ship
	LDR R3, R7, #1
	ADD R3, R3, #4
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R7, R7, #4
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR check_point_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #3	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRz L219_asteroids
L223_asteroids
	CONST R7, #1
	JMP L212_asteroids
L219_asteroids
L217_asteroids
L214_asteroids
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #7
	CMP R7, R3
	BRn L213_asteroids
	CONST R7, #0
L212_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;update_asteroids;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
update_asteroids
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	CONST R7, #0
	STR R7, R5, #-1
L225_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	STR R7, R5, #-2
	LDR R7, R5, #-2
	LDR R7, R7, #5
	CONST R3, #0
	CMP R7, R3
	BRz L229_asteroids
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR move_asteroid
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR check_wall_collision
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR check_bullet_collision
	ADD R6, R6, #1	;; free space for arguments
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR check_asteroid_collision
	ADD R6, R6, #1	;; free space for arguments
L229_asteroids
L226_asteroids
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #7
	CMP R7, R3
	BRn L225_asteroids
L224_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;update_bullet;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
update_bullet
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
	LEA R7, bullet
	LDR R7, R7, #3
	CONST R3, #0
	CMP R7, R3
	BRz L232_asteroids
	LEA R7, bullet
	LDR R7, R7, #2
	CONST R3, #0
	CMP R7, R3
	BRnp L234_asteroids
	LEA R7, bullet
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-8
	STR R3, R7, #0
	JMP L235_asteroids
L234_asteroids
	LEA R7, bullet
	LDR R7, R7, #2
	CONST R3, #1
	CMP R7, R3
	BRnp L236_asteroids
	LEA R7, bullet
	LDR R3, R7, #0
	ADD R3, R3, #8
	STR R3, R7, #0
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-8
	STR R3, R7, #0
	JMP L237_asteroids
L236_asteroids
	LEA R7, bullet
	LDR R7, R7, #2
	CONST R3, #2
	CMP R7, R3
	BRnp L238_asteroids
	LEA R7, bullet
	LDR R3, R7, #0
	ADD R3, R3, #8
	STR R3, R7, #0
	JMP L239_asteroids
L238_asteroids
	LEA R7, bullet
	LDR R7, R7, #2
	CONST R3, #3
	CMP R7, R3
	BRnp L240_asteroids
	LEA R7, bullet
	LDR R3, R7, #0
	ADD R3, R3, #8
	STR R3, R7, #0
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #8
	STR R3, R7, #0
	JMP L241_asteroids
L240_asteroids
	LEA R7, bullet
	LDR R7, R7, #2
	CONST R3, #4
	CMP R7, R3
	BRnp L242_asteroids
	LEA R7, bullet
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #8
	STR R3, R7, #0
	JMP L243_asteroids
L242_asteroids
	LEA R7, bullet
	LDR R7, R7, #2
	CONST R3, #5
	CMP R7, R3
	BRnp L244_asteroids
	LEA R7, bullet
	LDR R3, R7, #0
	ADD R3, R3, #-8
	STR R3, R7, #0
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #8
	STR R3, R7, #0
	JMP L245_asteroids
L244_asteroids
	LEA R7, bullet
	LDR R7, R7, #2
	CONST R3, #6
	CMP R7, R3
	BRnp L246_asteroids
	LEA R7, bullet
	LDR R3, R7, #0
	ADD R3, R3, #-8
	STR R3, R7, #0
	JMP L247_asteroids
L246_asteroids
	LEA R7, bullet
	LDR R3, R7, #0
	ADD R3, R3, #-8
	STR R3, R7, #0
	ADD R7, R7, #1
	LDR R3, R7, #0
	ADD R3, R3, #-8
	STR R3, R7, #0
L247_asteroids
L245_asteroids
L243_asteroids
L241_asteroids
L239_asteroids
L237_asteroids
L235_asteroids
L232_asteroids
	LEA R7, bullet
	STR R7, R5, #-1
	LDR R3, R7, #1
	CONST R2, #0
	CMP R3, R2
	BRn L252_asteroids
	LDR R7, R5, #-1
	LDR R7, R7, #0
	STR R7, R5, #-2
	CMP R7, R2
	BRn L252_asteroids
	CONST R7, #124
	LDR R2, R5, #-2
	CMP R2, R7
	BRp L252_asteroids
	CONST R7, #128
	CMP R3, R7
	BRnz L248_asteroids
L252_asteroids
	LEA R7, bullet
	CONST R3, #0
	STR R3, R7, #3
L248_asteroids
L231_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;update_game_state;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
update_game_state
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-3	;; allocate stack space for local variables
	;; function body
	CONST R7, #7
	STR R7, R5, #-2
	LEA R7, mode
	LDR R7, R7, #0
	CONST R3, #1
	CMP R7, R3
	BRnp L254_asteroids
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR update_ship
	ADD R6, R6, #1	;; free space for arguments
	JSR update_bullet
	ADD R6, R6, #0	;; free space for arguments
	JSR update_asteroids
	ADD R6, R6, #0	;; free space for arguments
	JSR check_ship_collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRz L256_asteroids
	LEA R7, mode
	CONST R3, #2
	STR R3, R7, #0
L256_asteroids
	CONST R7, #0
	STR R7, R5, #-1
L258_asteroids
	CONST R7, #6
	LDR R3, R5, #-1
	MUL R7, R7, R3
	LEA R3, asteroid_list
	ADD R7, R7, R3
	STR R7, R5, #-3
	LDR R7, R5, #-3
	LDR R7, R7, #5
	CONST R3, #0
	CMP R7, R3
	BRz L262_asteroids
	LDR R7, R5, #-2
	ADD R7, R7, #-1
	STR R7, R5, #-2
L262_asteroids
L259_asteroids
	LDR R7, R5, #-1
	ADD R7, R7, #1
	STR R7, R5, #-1
	LDR R7, R5, #-1
	CONST R3, #7
	CMP R7, R3
	BRn L258_asteroids
	LDR R7, R5, #-2
	CONST R3, #7
	CMP R7, R3
	BRnp L264_asteroids
	LEA R7, L266_asteroids
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, mode
	CONST R3, #4
	STR R3, R7, #0
L264_asteroids
L254_asteroids
	LEA R7, mode
	LDR R7, R7, #0
	CONST R3, #2
	CMP R7, R3
	BRnp L267_asteroids
	LEA R7, ship
	ADD R7, R7, #3
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
	LEA R7, L269_asteroids
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, ship
	LDR R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR printnum
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, ship
	LDR R7, R7, #3
	CONST R3, #1
	CMP R7, R3
	BRnp L270_asteroids
	LEA R7, L272_asteroids
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L271_asteroids
L270_asteroids
	LEA R7, L273_asteroids
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
L271_asteroids
	LEA R7, ship
	LDR R7, R7, #3
	CONST R3, #1
	CMP R7, R3
	BRzp L274_asteroids
	LEA R7, mode
	CONST R3, #3
	STR R3, R7, #0
	LEA R7, L276_asteroids
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JMP L275_asteroids
L274_asteroids
	LEA R7, mode
	CONST R3, #1
	STR R3, R7, #0
	JSR reset_ship
	ADD R6, R6, #0	;; free space for arguments
L275_asteroids
L267_asteroids
	LEA R7, mode
	LDR R7, R7, #0
	CONST R3, #4
	CMP R7, R3
	BRnp L277_asteroids
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR update_ship
	ADD R6, R6, #1	;; free space for arguments
L277_asteroids
	LEA R7, mode
	LDR R7, R7, #0
	STR R7, R5, #-3
	CONST R3, #3
	CMP R7, R3
	BRz L281_asteroids
	CONST R7, #4
	LDR R3, R5, #-3
	CMP R3, R7
	BRnp L279_asteroids
L281_asteroids
	LDR R7, R5, #3
	CONST R3, #114
	CMP R7, R3
	BRnp L282_asteroids
	JSR reset_game_state
	ADD R6, R6, #0	;; free space for arguments
L282_asteroids
L279_asteroids
L253_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;main;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
main
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
	LEA R7, L285_asteroids
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L286_asteroids
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L287_asteroids
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L288_asteroids
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	CONST R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR printnum
	ADD R6, R6, #1	;; free space for arguments
	LEA R7, L289_asteroids
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_puts
	ADD R6, R6, #1	;; free space for arguments
	JSR reset_game_state
	ADD R6, R6, #0	;; free space for arguments
	JMP L291_asteroids
L290_asteroids
	CONST R7, #100
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_getc_timer
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR update_game_state
	ADD R6, R6, #1	;; free space for arguments
	JSR redraw
	ADD R6, R6, #0	;; free space for arguments
L291_asteroids
	JMP L290_asteroids
	CONST R7, #0
L284_asteroids
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
asteroid_list 		.BLKW 42
		.DATA
bullet 		.BLKW 4
		.DATA
ship 		.BLKW 4
		.DATA
asteroids_remaining 		.BLKW 1
		.DATA
mode 		.BLKW 1
		.DATA
L289_asteroids 		.STRINGZ " lives left\n"
		.DATA
L288_asteroids 		.STRINGZ "You have "
		.DATA
L287_asteroids 		.STRINGZ "Press space to fire!\n"
		.DATA
L286_asteroids 		.STRINGZ "Press a to turn left, d to turn right\n"
		.DATA
L285_asteroids 		.STRINGZ "Welcome to Asteroid!\n"
		.DATA
L276_asteroids 		.STRINGZ "You've lost :(\n"
		.DATA
L273_asteroids 		.STRINGZ " lives left\n"
		.DATA
L272_asteroids 		.STRINGZ " life left\n"
		.DATA
L269_asteroids 		.STRINGZ "You have "
		.DATA
L266_asteroids 		.STRINGZ "You've won\n"
		.DATA
L20_asteroids 		.STRINGZ "\n"
		.DATA
L13_asteroids 		.STRINGZ "-32768"
		.DATA
L7_asteroids 		.STRINGZ "0"
