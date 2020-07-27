#===================================================================================================
#Program Description: This program adds up the user input amount of even numbers from more inputs 
#Author: Victor Nguyen
#Creation Date: 02/05/2019 
#==================================================================================================
.data
QuestionText: .asciiz "How many even numbers you like to add together? "
SumText: .asciiz "The sum of the numbers is "
EnterText: .asciiz "\n"
.text
main:
  li $v0, 4
  la $a0, QuestionText
  syscall
  li $v0, 5
  syscall
  add $s1, $0, $v0 #user input for example 5
  li $s0, 0 #counter
  li $s2, 0 #total
whileloop:
  beq $s0, $s1, exit #while loop do this until counter = user input then exit
  li $v0, 5 #load program recieve input
  syscall
  add $t0, $v0, $0 #user input hopefully it's even
  li $t1, 2 #divide by 2 in the future
  div $t0, $t1 #divive user input with 2
  mfhi $t2 #remainder
  mflo $t3 #quotient
  bne $t2, $0, else #if else loop to check is remainder = 0 which means even
  add $s2, $s2, $t0 #add user input to total variable
  addi $s0, $s0, 1 #increases the counter by 1 if remainder = 0
  j whileloop #jump back to the top of while loop label
else:
  j whileloop #jump back to the top of while loop label
exit:
  li $v0, 4 #load print string program
  la $a0, SumText #load address with SumText
  syscall #print Sumtext
  li $v0, 1 #load print integer program
  add $a0, $s2, 0 #moves total variable to address
  syscall #print integer
  li $v0, 10
  syscall
