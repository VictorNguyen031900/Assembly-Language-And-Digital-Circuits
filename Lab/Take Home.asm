#===================================================================================================
#Program Description: This program gets the factorial
#Author: Victor Nguyen
#Creation Date: 02/07/2019 
#==================================================================================================
.data
  userInput: .asciiz "\nEnter a number from zero to ten to get n!: "
  userInputG: .asciiz "\nYour input is greater than ten! Enter another number. \n"
  userInputL: .asciiz "\nYour input is less than zero! Enter another number. \n"
  factorialOutput: .asciiz " Factorial is "
  enterSpace: .asciiz "\n"
.text
main:
  li $s1, 1 #total
  li $v0, 4
  la $a0, userInput
  syscall
  li $v0, 5
  syscall
  add $s0, $0, $v0
  add $s2, $0, $s0 #decrease counter
  li $v0,4
  la $a0, enterSpace
  syscall
  li $t0, 0
  beq $s0, $0, zero
  li $t0, 0
  blt $s0, $t0, lessThan
  li $t0, 10
  bgt $s0, $t0, greaterThan
whileLoop:
  beq $s2, $0, exit
  mul $s1 ,$s1 ,$s2
  addi $s2, $s2, -1
  j whileLoop
zero:
  j exit
lessThan:
  li $v0, 4
  la $a0, userInputL
  syscall
  j main
greaterThan:
  li $v0, 4
  la $a0, userInputG
  syscall
  j main
exit:
  li $v0, 1
  add $a0, $s0, $0
  syscall
  li $v0, 4
  la $a0, factorialOutput
  syscall
  li $v0, 1
  add $a0, $s1, $0
  syscall
  li $v0, 4
  la $a0, enterSpace
  syscall
  li $v0, 10
  syscall