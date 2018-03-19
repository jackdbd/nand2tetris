// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[3], respectively.)

// Add R0 to itself R1 times.

    // @times counts down from R1. When it reaches 0, jump to END
    @R1
    D=M
    @times
    M=D  // M[@times] = R1

    // we use R2 to store the current SUM in R2
    @R2
    M=0

(LOOP)
    // jump to END if @times = 0
    @times
    D=M
    @END
    D;JEQ

    // decrement @times
    @R1
    D=D-1  // D = @times - 1
    @times
    M=D // and now, @times = @times - 1

    // update the current SUM in R2.
    @R2
    D=M
    @R0
    D=D+M // D = SUM + R0
    @R2
    M=D //and, now SUM = SUM + R0

    // infinite loop
    @LOOP
    0;JMP

(END)
    @END
    0;JMP