# Chandler Juego
# CPTS 260 - HW 5 Part 1
# Due: 3/10/2023

    .data
welcomeMsg: .asciiz "Basic calculator. Operations: 0 => add, 1 => subtract, 2 => multiply, 3 => exit\n"
promptMsg1: .asciiz "Enter the first number: "
promptMsg2: .asciiz "Enter the second number: "
promptMsg3: .asciiz "Enter the operation type: "
resultMsg: .asciiz "The result is: "
exitMsg: .asciiz "Exiting the program."
nl: .asciiz "\n"

input1: .word 0 # memory location for user's first input
input2: .word 0 # memory lcoation for user's second input

    .text
    .globl main

main:
    ### initialize address for user's first and second inputs
    la $s0, input1
    la $s1, input2

    ### Welcome message
    li $v0, 4 # command to print string
    la $a0, welcomeMsg
    syscall

    jal runCalculator

runCalculator:
    ### Store values for add, subtract, multiply, exit
    li $t0, 0 # add
    li $t1, 1 # subtract
    li $t2, 2 # multiply
    li $t3, 3 # exit

    ### Prompt for first number
    li $v0, 4 # command to print a string
    la $a0, promptMsg1
    syscall
    ### Read user's first number
    li $v0, 5 # command to read an integer
    syscall
    sw $v0, input1 # move user's first input to $s0

    ### Prompt for second number
    li $v0, 4
    la $a0, promptMsg2
    syscall
    ### Get user's second number
    li $v0, 5
    syscall
    sw $v0, input2 # move user's second input into reg $s1

    ### Prompt for operation type
    li $v0, 4
    la $a0, promptMsg3
    syscall
    ### Get user's operation type
    li $v0, 5
    syscall
    move $t6, $v0
    
    ### Check if exit
    beq $t3, $t6, Exit # if exit operation chosen => Exit
    
    ### Not at exit => show result, loop back to prompting
    beq $t0, $t6, addOperation # user chose to add
    beq $t1, $t6, subtractOperation # user chose to subtract
    beq $t2, $t6, multiplyOperation # user chose to multiply

    jal runCalculator

addOperation:
    lw $t1, input1 # load first input
    lw $t2, input2 # load second input
    add $t0, $t1, $t2 # add inputs

    ### Print result to screen
    li $v0, 4
    la $a0, resultMsg
    syscall
    
    # show addition result
    li $v0, 1
    move $a0, $t0 # move content in $t0 reg to $a0 reg
    syscall

    # print newline (x2)
    li $v0, 4
    la $a0, nl
    syscall
    li $v0, 4
    la $a0, nl
    syscall


    jr $ra

subtractOperation:
    lw $t1, input1 # load first input
    lw $t2, input2 # load second input
    sub $t0, $t1, $t2

    ### Print result to screen
    li $v0, 4
    la $a0, resultMsg
    syscall

    # show subtraction result
    li $v0, 1
    move $a0, $t0
    syscall

    # print newline (x2)
    li $v0, 4
    la $a0, nl
    syscall
    li $v0, 4
    la $a0, nl
    syscall

    jr $ra

multiplyOperation:
    lw $t1, input1 # load first input
    lw $t2, input2 # load second input
    mul $t0, $t1, $t2

    ### Print result to screen
    li $v0, 4
    la $a0, resultMsg
    syscall

    # show mult result
    li $v0, 1
    move $a0, $t0
    syscall

    # print new line (x2)
    li $v0, 4
    la $a0, nl
    syscall
    li $v0, 4
    la $a0, nl
    syscall

    jr $ra

Exit:
    li $v0, 4
    la $a0, exitMsg
    syscall

    li $v0, 10
    syscall
