# Chandler Juego
# CPTS 260 - HW 5 Part 1
# Due: 3/10/2023

    .data
arr: .word 11, 12, -10, 13, 9, 12, 14, 15, -20, 0
arrLength: .word 10

maxMsg: .asciiz "The maximum is: "
minMsg: .asciiz "The minimum is: "
sumMsg: .asciiz "The summation is: "

exitMsg: .asciiz "Exiting the program."
newline: .asciiz "\n"

    .text
    .globl main

main:
    la $s0, arr # load address of the arr in memory
    la $s1, arrLength # load address of arrLength in memory

    # note: we use jal to save the $ra of calling function
    jal max # calculate max in the array
    jal min # calculate min in the array
    jal sum # calculate sum of array

    ### Exit
    j exit

max:
    li $t0, 0 # counter for the loop
    lw $t1, 0($s0) # init max as first element
    lw $t2, arrLength # $t2 contains array's length
    
    maxLoop:
        ### Getting to correct address in array
        mul $t3, $t0, 4 # $t3 = tracks bytes processed for elem address in arr
        add $t3, $t3, $s0 # $t3 = curr elem address in arr where $s0 contains base address
        lw $t4, 0($t3) # load the curr elem into $t4
        
        ### DEBUG: Print the whole list (perhaps for user's sake)
        #li $v0, 1
        #move $a0, $t4
        #syscall

        #li $v0, 4
        #la $a0, newline
        #syscall
        
        ### Greater than check
        bgt $t4, $t1, updateMax # if so => update max
        
        # if not => increment counter => go to loop
        addi $t0, $t0, 1
        bne $t0, $t2, maxLoop

        # all elems processed => print max => back to main
        li $v0, 4
        la $a0, maxMsg
        syscall

        li $v0, 1
        move $a0, $t1 # max value
        syscall

        li $v0, 4
        la $a0, newline
        syscall

        jr $ra
    
    updateMax:
        move $t1, $t4 # $t4 was > $t1, so relplace $t1 value with $t4 value
        addi $t0, $t0, 1 # increment counter
        bne $t0, $t2, maxLoop # return to loop if more elems to process

        # all elems processed => print max => back to main
        li $v0, 4
        la $a0, maxMsg
        syscall

        li $v0, 1
        move $a0, $t1 # max value
        syscall

        li $v0, 4
        la $a0, newline
        syscall

        jr $ra

min:
    li $t0, 0 # counter for the loop
    lw $t1, 0($s0) # init min as first element
    lw $t2, arrLength # $t2 contains array's length
    
    minLoop:
        ### Getting to correct address in array
        mul $t3, $t0, 4 # $t3 = tracks bytes processed for elem address in arr
        add $t3, $t3, $s0 # $t3 = curr elem address in arr where $s0 contains base address
        lw $t4, 0($t3) # load the curr elem into $t4
        
        ### DEBUG: Print the whole list (perhaps for user's sake)
        #li $v0, 1
        #move $a0, $t4
        #syscall

        #li $v0, 4
        #la $a0, newline
        #syscall
        
        ### Greater than check
        blt $t4, $t1, updateMin # if so => update min
        
        # if not => increment counter => go to loop
        addi $t0, $t0, 1
        bne $t0, $t2, minLoop

        # all elems processed => print max => back to main
        li $v0, 4
        la $a0, minMsg
        syscall

        li $v0, 1
        move $a0, $t1 # min value
        syscall

        li $v0, 4
        la $a0, newline
        syscall

        jr $ra
    
    updateMin:
        move $t1, $t4 # $t4 was < $t1, so relplace $t1 value with $t4 value
        addi $t0, $t0, 1 # increment counter
        bne $t0, $t2, minLoop # return to loop if more elems to process

        # all elems processed => print max => back to main
        li $v0, 4
        la $a0, minMsg
        syscall

        li $v0, 1
        move $a0, $t1 # min value
        syscall

        li $v0, 4
        la $a0, newline
        syscall

        jr $ra

sum:
    li $t0, 0 # counter for the loop
    li $t1, 0 # current sum
    lw $t2, arrLength # $t2 contains array's length

    sumLoop:
        ### Getting to correct address in array
        mul $t3, $t0, 4 # $t3 = tracks bytes processed for elem address in arr
        add $t3, $t3, $s0 # $t3 = curr elem address in arr where $s0 contains base address
        lw $t4, 0($t3) # load the curr elem into $t4
        
        ### DEBUG: Print the whole list (perhaps for user's sake)
        #li $v0, 1
        #move $a0, $t4
        #syscall

        #li $v0, 4
        #la $a0, newline
        #syscall
        
        # add to current sum
        add $t1, $t1, $t4
        
        # increment counter => go to loop
        addi $t0, $t0, 1
        bne $t0, $t2, sumLoop # if not all elements processed => keep looping

        # all elems processed => print sum => back to main
        li $v0, 4
        la $a0, sumMsg
        syscall

        li $v0, 1
        move $a0, $t1 # sum value
        syscall

        li $v0, 4
        la $a0, newline
        syscall

        jr $ra

exit:
    li $v0, 4
    la $a0, exitMsg
    syscall

    li $v0, 10
    syscall
