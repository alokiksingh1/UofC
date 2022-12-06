// CPSC 355 LEC01 TUT08

// ASSIGNMENT 2
// part(c)

// Author: Alokik Singh Kinra
// UCID: 30124487
// Date: October 6, 2021
//
// Brief Description:
// The file assign2a.asm  creates an ARMv8 assembly language program based on the C code given and
// does Bit Reversal using Shift and Bitwise Logical Operations

//we will use 32-bit registers in this program

// let's define the 32 bit registers

define(x_r, w20)        // w20 register will be represented as x
define(y, w21)          // w21 register will be represented as y
define(t1, w22)         // w22 register will be represented as t1
define(t2, w23)         // w23 register will be represented as t2
define(t3, w24)         // w24 register will be represented as t3
define(t4, w25)         // w25 register will be represented as t4


output_string:          .string "ORIGINAL : =0x%08X     REVERSED : =0x%08X\n "          // declaring an output_string variable for printing the output

                        .balign 4                                                       // are divisible by 4 as all the adresses should be aligned with the word length of the machine

                        .global main                                                    // it is a pseudo op which sets the start label to main
                                                                                        // it will make sure that the main label is picked by the linker


main:                   stp     x29, x30,[sp,-16]!                                      // store the FP and LP stack in stack with two double spaces
                        mov     x29, sp                                                 // move the sp to the FP

                        mov     x_r, 0x01FF01FF                                         // initialize the x_r variable

                        b	step1                                                   // unconditional branch to step1

step1:                                                                                  // equivalent to step 1 in the C code

                        and     t1, x_r, 0x55555555                                     // using bitwise 'and' operation for x with hexadecimal number '0x55555555' and storing in t1
                        lsl     t1, t1, 1                                               // bitwise shift left t1 by 1

                        lsr     t2, x_r, 1                                              // bitwise shift right x_r by 1
                        and     t2, t2, 0x55555555                                      // bitwise 'and' operation for t2 with hexadecimal number '0x55555555' and storing in t2

                        orr     y, t1, t2                                               // bitwise 'or' operation for t1 and t2 and storing value in y


step2:                                                                                  // equivalent to step 2 in C code
                        and     t1, y, 0x33333333                                       // using bitwise 'and' operation for y with hexadecimal number '0x33333333' and storing in t1
                        lsl     t1, t1, 2                                               // bitwise shift left t1 by 2

                        lsr     t2, y, 2                                                // bitwise shift right y by 2
                        and     t2, t2, 0x33333333                                      // using bitwise 'and' operation for t2 with hexadecimal number '0x33333333' and storing in t2


                        orr     y, t1, t2                                               // using bitwise 'or' operation for t1 and t2 and storing in y


step3:                                                                                  // equivalent to step 3 in C code
                        and     t1, y, 0x0F0F0F0F                                       // using bitwise 'and' operation for y with hexadecimal number '0x0F0F0F0F' and storing in t1
                        lsl     t1, t1, 4                                               // bitwise shift left t1 by 4

                        lsr     t2, y, 4                                                // bitwise shift right y by 4
                        and     t2, t2, 0x0F0F0F0F                                      // using bitwise 'and' operation for t2 with hexadecimal number '0x0F0F0F0F' and storing in t2

                        orr     y, t1, t2                                               // using bitwise 'or' operation for t1 and t2 and storing in y

step4:                                                                                  // equivalent to step 4 in the C code
                        lsl     t1, y, 24                                               // bitwise shift left y by 24

                        and     t2, y, 0xFF00                                           // using bitwise 'and' operation for y with hexadecimal number '0xFF00' and storing in t2
                        lsl     t2, t2, 8                                               // bitwise shift left t2 by 8

                        lsr     t3, y, 8                                                // bitwise shift right y by 8
                        and     t3, t3, 0xFF00                                          // using bitwise 'and' operation for t3 with hexadecimal number 'oxFF00' and storing in t3

                        lsr     t4, y, 24                                               // bitwise shift right y by 24

                        orr     y, t1, t2                                               // using bitwise 'or' operation for t1 and t2 and storing in y to get t1|t2
                        orr     y, y, t3                                                // using bitwise 'or' operation for already found value of y with t3 to get t1|t2|t3
                        orr     y, y, t4                                                // using bitwise 'or' operation for again found value of y with t4 to get y=t1|t2|t3|t4

                        b	display                                                 // unconditional branching to display


display:                                                                                // label display is used for displaying the output
                        ldr     w0, =output_string                                      // load the address of output_string to w0 register

                        mov     w1, x_r                                                 // move the contents of x_r to w1 register
                        mov     w2, y                                                   // move the contents of y to w2 register

                        bl	printf                                                  // call printf


exit:
                        ldp     x29, x30, [sp], 16                                      // restore sp to x29 and x30 then do sp + 16 and set to sp
                        ret                                                             // return to the OS





