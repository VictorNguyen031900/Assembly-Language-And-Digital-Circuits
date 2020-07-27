#==================================================================================================
#Program Description: This program take the user's input and put it in an array and then the program
#get the median of the array 
#Author: Victor Nguyen
#Creation Date: 02/14/2019 
#==================================================================================================

.data
  Divider: .asciiz "===============================\n"
  InputElementsAmount: .asciiz "Enter the number of elements:\n"
  InputElementsErrorG: .asciiz "Error array can't have more than 10 elements, try again!!\n"
  InputElementsErrorL: .asciiz "Error array can't have less than 1 elements, try again!!\n"
  InputNumber: .asciiz "Enter number "
  InputNumberColon: .asciiz ":\t\t"
  isMedian: .asciiz "The median is:\t\t"
  EnterSpace: .asciiz "\n"
  array1: .word 0 0 0 0 0 0 0 0 0 0 0
  arraySize: .word 
  #arrayHalf: .word

.text
main:
  li $v0, 4 #load print string "program"
  la $a0, InputElementsAmount #load string "InputElementAmount" in to address $a0
  syscall #print $a0 with loaded string
  li $v0, 5 #load recieve input "program"
  syscall #calls program, puts user's input into $v0
  add $t0, $v0, $0
  sw $t0, arraySize #for example when enter 10 it is actually 11
  lw $t0, arraySize
  li $t1, 1 #set a temp variable to 1 for use in a bit
  add $t0, $t1, $v0 #add user input($v0) with temp variable($t1) put in to $s0
  li $t1, 11 #set a temp variable to 11 to use for comparison
  bgt $t0, $t1, greaterThan #checks if $s0 is greater than 11($t0), if true then go to greaterThan label
  li $t1, 1 #set a temp variable to 1 to use for comparsion
  ble $t0, $t1, lessThan #checks if $s0 is less than 1($t0), if true then go to lessThan label
  li $v0, 4 #load print string "program"
  la $a0, Divider #load string "Divider" in to address $a0
  syscall #print $a0 with loaded string
  li $t1, 1
  li $t2, 4
  j whileLoop
  
greaterThan:
  li $v0, 4 #load print string "program"
  la $a0, InputElementsErrorG #load string "InputElementErrorG" in to address $a0
  syscall #print $a0 with loaded string
  j main #jump to main label
  
lessThan:
  li $v0, 4 #laod print string "program"
  la $a0, InputElementsErrorL #load string "InputElementErrorL" in to address $a0
  syscall #print $a0 with loaded string 
  j main #jump to main label
  
whileLoop:
  lw $t0, arraySize
  addi $t0, $t0, 1
  beq $t1, $t0, whileLoopDone #checks to see it if $t0 is equal to $s0, if true go to exit label
  li $v0, 4 #load print string "program"
  la $a0, InputNumber #load string "InputNumber" in to address $a0
  syscall #print $a0 with loaded string
  li $v0, 1 #load print integer "program"
  add $a0, $t1, $0 #move $t0 to $a0
  syscall #print $a0 with loaded integer
  li $v0, 4 #load print string "program"
  la $a0, InputNumberColon #load string "InputNumberColon" in to address $a0
  syscall #print $a0 with loaded stirng
  li $v0, 5 #load recieve input "program"
  syscall #calls program, puts user's input into $v0
  sw $v0, array1($t2) #set word user input($v0) to "array1" in to index $t1
  addi $t2, $t2, 4 #increment index($t1) by 4
  addi $t1, $t1, 1 #increment counter by 1
  j whileLoop #jump to whileLoop
  
whileLoopDone:
  lw $t0, arraySize
  li $t1, 2
  div $t0, $t1
  mfhi $t2 #R
  mflo $t3 #Q
  li $t1, 4
  mult $t3, $t1
  mflo $t4 #P
  #sw $t4, arrayHalf
  beq $t2, $0, IsEven
  bgt $t2, $0, IsOdd
  j exit

IsEven:
  lw $t1, array1($t4) #$t1 SM
  addi $t4, $t4, 4 #get first middle
  lw $t2, array1($t4) #$t2 FM
  add $t3, $t1, $t2
  li $t0, 2
  div $t3, $t0
  mfhi $t1 #R
  mflo $t2 #Q
  move $s1, $0
  move $s1, $t2
  j exit

IsOdd:
  addi $t4, $t4, 4
  lw $t1, array1($t4)
  move $s1, $0
  move $s1, $t1
  j exit

exit:
  li $v0, 4 #load print string "program"
  la $a0, EnterSpace
  syscall
  la $a0, isMedian
  syscall
  li $v0, 1
  move $a0, $s1
  syscall
  li $v0, 4 #load print string "program"
  la $a0, EnterSpace
  syscall
  la $a0, Divider #load string "Divider" in to address $a0
  syscall #print $a0 with loaded string
  li $v0, 10 #load end program value
  syscall #end program
