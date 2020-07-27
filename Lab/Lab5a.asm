#==================================================================================================
#Program Description: This program take the user's input and put it in an array and then the program
#will output the array backwards. 
#Author: Victor Nguyen
#Creation Date: 02/06/2019 
#==================================================================================================

.data
  Divider: .asciiz "===============================\n"
  InputElementsAmount: .asciiz "Enter the number of elements:\n"
  InputElementsErrorG: .asciiz "Error array can't have more than 10 elements, try again!!\n"
  InputElementsErrorL: .asciiz "Error array can't have less than 1 elements, try again!!\n"
  InputNumber: .asciiz "Enter number "
  InputNumberColon: .asciiz ":\t\t"
  ReverseArray: .asciiz "The content of array in reverse order is:\n"
  EnterSpace: .asciiz "\n"
  array1: .word 0 0 0 0 0 0 0 0 0 0 0
  arraySize: .word 
.text
main:
  li $v0, 4 #load print string "program"
  la $a0, InputElementsAmount #load string "InputElementAmount" in to address $a0
  syscall #print $a0 with loaded string
  li $v0, 5 #load recieve input "program"
  syscall #calls program, puts user's input into $v0
  li $t1, 1 #set a temp variable to 1 for use in a bit
  add $t0, $t1, $v0 #add user input($v0) with temp variable($t1) put in to $s0
  sw $t0, arraySize($0)
  lw $t0, arraySize($0)
  li $t1, 11 #set a temp variable to 11 to use for comparison
  bgt $t0, $t1, greaterThan #checks if $s0 is greater than 11($t0), if true then go to greaterThan label
  li $t1, 1 #set a temp variable to 1 to use for comparsion
  ble $t0, $t1, lessThan #checks if $s0 is less than 1($t0), if true then go to lessThan label
  li $v0, 4 #load print string "program"
  la $a0, Divider #load string "Divider" in to address $a0
  syscall #print $a0 with loaded string
  li $t1, 4 #set a temp variable to 4 to use in a bit
  li $t0, 1

whileLoop:
  lw $t2, arraySize($0)
  beq $t0, $t2, exit #checks to see it if $t0 is equal to $s0, if true go to exit label
  li $v0, 4 #load print string "program"
  la $a0, InputNumber #load string "InputNumber" in to address $a0
  syscall #print $a0 with loaded string
  li $v0, 1 #load print integer "program"
  add $a0, $t0, $0 #move $t0 to $a0
  syscall #print $a0 with loaded integer
  li $v0, 4 #load print string "program"
  la $a0, InputNumberColon #load string "InputNumberColon" in to address $a0
  syscall #print $a0 with loaded stirng
  li $v0, 5 #load recieve input "program"
  syscall #calls program, puts user's input into $v0
  sw $v0, array1($t1) #set word user input($v0) to "array1" in to index $t1
  addi $t1, $t1, 4 #increment index($t1) by 4
  add $t0, $t0, 1 #increment counter by 1
  j whileLoop #jump to whileLoop
  
greaterThan:
  li $v0, 4 #load print string "progrma"
  la $a0, InputElementsErrorG #load string "InputElementErrorG" in to address $a0
  syscall #print $a0 with loaded string
  j main #jump to main label
  
lessThan:
  li $v0, 4 #laod print string "program"
  la $a0, InputElementsErrorL #load string "InputElementErrorL" in to address $a0
  syscall #print $a0 with loaded string 
  j main #jump to main label

exit:
  li $v0, 4 #load print string "program"
  la $a0, Divider #load string "Divider" in to address $a0
  syscall #print $a0 with loaded string
  la $a0, ReverseArray #load string "ReverseArray" in to address $a0
  syscall #print $a0 with loaded string
  la $a0, Divider #load string "Divider" in to address $a0
  syscall #print $a0 with loaded string
  subi $t1, $t1, 4 #subtract $t1 by 4 so array can be printed correctly
  
exit2:
  beq $t1, $0, exit3 #checks if $t1 is equal to 0, if true go to label exit3
  lw $t2, array1($t1) #load from "array1" index $t1 and set to $t2
  subi $t1, $t1, 4 #subtract index by 4
  li $v0, 1 #load print integer "program"
  move $a0, $t2 #move $t2 to $a0
  syscall #print $a0 with loaded integer
  li $v0, 4 #load print string "progrma"
  la $a0, EnterSpace #load string "EnterSpace" in to address $a0
  syscall #print $a0 with loaded string
  j exit2 #jump to exit2 label
  
exit3:
  li $v0, 4 #load print string "program"
  la $a0, Divider #load string "Divider" in to address $a0
  syscall #print $a0 with loaded string
  li $v0, 10 #load end program value
  syscall #end program
