#==================================================================================================
#Program Description: This program take the user's input and calculates the binary number equivalent.
#Author: Victor Nguyen
#Creation Date: 02/19/2019 
#==================================================================================================

.data
 divider: .asciiz "==================================================\n"
 line1: .asciiz "Input a number in decimal form:\t"
 line2: .asciiz "The number "
 line3: .asciiz " in binary is:\t"
 enterSpace: .asciiz "\n"
 
 fillArray: .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

.text
main:
  li $v0, 4
  la $a0, divider
  syscall
  la $a0, line1
  syscall
  li $v0, 5
  syscall
  add $s0, $v0, $0
  li $v0, 4
  la $a0, divider
  syscall
  la $a0, line2
  syscall
  li $v0, 1
  add $a0, $s0, $0
  syscall
  li $v0, 4
  la $a0, line3
  syscall
  add $a1, $s0, $0
  jal BaseChange
  li $v0, 4
  la $a0, enterSpace
  syscall
  la $a0, divider
  syscall
  li $v0, 10
  syscall
  
BaseChange:
  add $s0, $a1, $0
  li $t4,1
divideLoop:
  add $s1, $t4, $0
  beq $s0, $0, printLoop
  addi $t4, $t4, 1
  li $t1, 2
  div $s0, $t1
  mfhi $t2 #R
  mflo $t3 #Q
  add $s0, $t3, $0
  sw $t2, 0($sp)
  addi $sp, $sp, -4
  j divideLoop
printLoop:
  li $t6, 32
  addi $t6, $t6, 1
  sub $t5, $t6, $s1
loop:
  beq $t5, $0, test
  li $v0, 1
  la $a0, 0
  syscall
  subi $t5, $t5, 1
  j loop
test:
  li $t0, 1
  beq $s1, $t0, exit
  addi $sp, $sp, 4
  lw $t1, 0($sp)
  li $v0, 1
  add $a0, $0, $t1
  syscall
  subi $s1, $s1, 1
  j test
exit:
  jr $ra
