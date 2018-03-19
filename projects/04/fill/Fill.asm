// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// SCREEN is a built-in symbol of the Hack language. It represents the base address of the screen memory map.
// SCREEN start address: 16384 (0x4000)
// SCREEN   end address: 24575
// The screen memory map is 8k (8192), from 16384 to 24575

// A word in the memory of the Hack computer (so in its memory map as well) is 16 bit.
// 32 words in the memory map represent 1 row in the physical screen.
// E.g. the first 32 words in the memory map correspond to the first row in the physical screen.

// KBD is a built-in symbol of the Hack language. It represents the address of the keyboard input.
// KBD address: 24876 (0x6000)

    // Store value 24575 at location: lastWord
    @24575
    D = A
    @lastWord
    M = D

// "outer" loop that listens to the keyboard's input
(READKEYBOARDINPUT)
    @KBD
    D = M
    // If no key is pressed, KBD == 0
    @WHITESCREEN
    D;JEQ
 
    // If a key is pressed, KBD > 0 (any key in the character set is positive)
    @BLACKSCREEN
    D;JGT
 
(BLACKSCREEN)
    // Set -1 in register to draw 16 black pixels on the screen
    // -1 in a word of the memory is 1111111111111111 (16 ones)
    @1
    D = -A
    @fillValue
    M = D
    @FILLSCREEN
    0;JMP
 
(WHITESCREEN)
    // Set 0 in register to draw 16 white pixels on the screen
    // 0 in a word of the memory is 0000000000000000 (16 zeros)
    @0
    D = A
    @fillValue
    M = D
    @FILLSCREEN
    0;JMP

// "inner" loop that fills the screen, either in white or in black 
(FILLSCREEN)
    @SCREEN
    D = A
    @currentWord
    M = D
 
    (FILLWORD)
        @fillValue
        D = M
        @currentWord
        A = M
        M = D
    (ENDFILLWORD)
 
    // Check if we filled whole screen
    @lastWord
    D = M
    @currentWord
    D = D - M
 
    // If we have, jump to ENDFILLSCREEN
    @ENDFILLSCREEN
    D;JEQ
 
    // Else, increment current word
    @currentWord
    M = M + 1
 
    // Jump to FILLWORD
    @FILLWORD
    0;JMP
(ENDFILLSCREEN)

@READKEYBOARDINPUT
0;JMP