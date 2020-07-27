#=======================================================================================
# Program Description: This program allows the user to find the largest element in 
#                      an array that the user created that has a size of 1-10
# Author: Victor Nguyen
# Creation Date: 03/07/19
#=======================================================================================
.data
  userIn: .asciiz "\nPlease enter how many elements you want in the array (1-10): " 
  userInError: .asciiz "The amount of elements you wanted for you array is invalid, please try again.\n"
  elementPart: .asciiz "\nElement #"
  maxElement: .asciiz "\nThe largest element in the array is "
  enterSpace: .asciiz "\n"
  spaceEntry: .asciiz " "
  array: .word 0 0 0 0 0 0 0 0 0 0
.text
main:
  li $v0, 4 #load print string "program"
  la $a0, userIn #load $a0 with userIn string
  syscall #print string
  li $v0, 5 #load recieve integer "program"
  syscall #execute "program"
  add $s0, $v0, $0 #move user input in to $s0
  li $t0, 1 #load $t0 with 1
  blt $s0, $t0, errorArray #checks if user input is less than 1 if true then go to errorArray label
  li $t0, 10 #load $t0 with 10
  bgt $s0, $t0, errorArray #checks is ser input is less than 10 if true then go to errorArray label
  li $t0, 0 #load $t0 with 0, reset $t0, counter
  li $t1, 0 #load $t1 with 0 , reset $t1, array index
loop:
  beq $t0, $s0, findMax #loop used to enter intgers in array
  li $v0, 4 #load print string "program"
  la $a0, elementPart #load $a0 with elementPart string
  syscall #print string
  li $v0, 1 #load print integer "program"
  add $a0, $t0, $0 #load $a0 with $t0 (counter)
  syscall #print integer
  li $v0, 4 #load print string "program"
  la $a0, spaceEntry #load $a0 with spaceEntry string
  syscall #print string
  li $v0, 5 #load recieve integer "program"
  syscall #execute "program"
  add $t2, $v0, $0 #moves user input to $t2
  sw $t2, array($t1) #puts $t2 in array at index $t1
  li $v0, 4 #load print string "program"
  la $a0, enterSpace #load $a0 with enterSpace string
  syscall #print string
  addi $t1, $t1, 4 #increment $t1(array index) by 4(word = 4 bytes)
  addi $t0, $t0, 1 #increment $t0(loop counter) by 1
  j loop #jump to label loop
findMax:
  li $t0, 0 #load $t0 with 0, reset $t0 to use later
  li $t1, 0 #load $t1 with 0, reset $t1 to user later
  lw $t2, array($t0) #load from array index $t0 to $t2
loop2:
  beq $t0, $s0, exit #loop used to find the largest element in the array
  lw $t3 , array($t1) #load from the array index $t1 to $t3
  bgt $t3, $t2, continued #checks is $t3 is greater than $t2, if so then go to continued label
  addi $t1, $t1, 4 #increment $t1(array index) by 4(word = 4 byte)
  addi $t0, $t0, 1 #increment $t0(loop counter) by 1
  j loop2 #jump to label loop2, $t3 WAS NOT greater than $t2
continued:
  add $t2, $t3, $0 #move $t3 to $t2 sinze $t3 was greater than $t2, $t2 represents largest element at the moment
  addi $t1, $t1, 4 #increment $t1(array index) by 4(word = 4 byte)
  addi $t0, $t0, 1 #increment $t0(loop counter) by 1
  j loop2 #jump to label loop2, $t3 WAS greater than $t2
exit:
  li $v0, 4 #load print string "program"
  la $a0, maxElement #load $a0 with maxElement string
  syscall #print string
  li $v0, 1 #load integer "program"
  add $a0, $t2, $0 #load $a0 with $t2(largest element in the array)
  syscall #print integer
  li $v0, 10 #load end program "program"
  syscall #end program
  
errorArray: #label used to output a message if the amount of elements the user wanted in the array is greater than 10 or less than 1
  li $v0, 4 #load print string "program"
  la $a0, userInError #load $a0 with userInError
  syscall #print string
  j main #jump to label main
