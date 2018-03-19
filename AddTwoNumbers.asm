// Add two numbers and store the result in memory
// Computes: RAM[2] = RAM[0] + RAM[1]
// Usage: open the CPU Emulator and store values in RAM[0] and RAM[1]

// First operand from registry 0
@0
D=M  // D = RAM[0]

// Second operand from registry 1
@1
D=D+M  // D = D + RAM[1]

// Result in registry 2
@2
M=D  // RAM[2] = D

// Best practice: end Hack program with an infinite loop to avoid 'NOP slide' attacks
@6
0;JMP