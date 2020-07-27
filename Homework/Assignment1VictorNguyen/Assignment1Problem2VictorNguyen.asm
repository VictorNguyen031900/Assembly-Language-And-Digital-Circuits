#=================================================================================================
# Program Description: The programm will ask the user to enter the amount of element in the array
# from 1-20 and the user will enter each element in the array and it must be divisible by 3.  The
# program will then reverse the array and then print the array that was just reversed.
# Author: Victor Nguyen
# Creation Date: 2/26/2019
#=================================================================================================

.data
  userArraySize: .asciiz "\nEnter the amount of amount for the array: "
  userArraySizeError: .asciiz "\nSorry the array size should be between 1-20, please enter again."
  userInput: .asciiz "\nElement #"
  spaceEntry: .asciiz " "
  userInputNotPositive: .asciiz "\nSorry you input isn't positive, please enter again."
  userInputDivBy3Error: .asciiz "\nSorry your input isn't divisible by 3, please enter again."
  theArrayIs: .asciiz "\nThe array is "
  enterSpace: .asciiz "\n"
  array: .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 #The main array that can fit up to 20 integers.
  arrayElement: .word 0 #array used to hold element when reversing array
  
.text
main:
  jal readNum #get amount of elements
  add $s0, $v1, $0 #returns the input back to main
  add $a0, $s0, $0 #sents input from user to verifysum function
  jal verifySize #check amount of elements if => 1 or <= 20
  add $t0, $v1, $0 #returns either a 1 or 0
  li $t1, 1 #load $t1 with 1
  blt $t0, $t1, main #compares if user input for amount of elements is true (0<x<=20)
  add $a0, $s0, $0 #if it is less than 1 meaning 0 carry on sent user input to createArray function
  jal createArray #function is used to create the array and fill array with user input
  add $a1, $s0, $0 #passes array element amount from user to reverseArray function
  jal reverseArray #function is used to reverse the elements of the array
  add $a1, $s0, $0 #passes array element amount from user to printArray function
  jal printArray #function is used to print the array after it has been reversed
  li $v0, 10 #load end program "program"
  syscall #end program
#=================================================================================================
createArray:
  sub $sp, $sp, 4 #subtract 4 from the stack pointer to open space
  sw $ra, 0($sp) #load return address in stack pointer
  add $s0, $a0, $0 #user input
  li $t0, 0 #counter
  li $t6, 0 #array Position
loopCA:
  beq $t0, $s0, jumpToMain #if $t0(counter) is equal to $s0(user input array element amount)
  li $v0, 4 #load print string "program"
  la $a0, userInput #load $a0 wiht userInput string
  syscall #print string
  li $v0, 1 #load print integer "program"
  add $a0, $t0, $0 #load $a0 with $t0(counter) , used to display array index
  syscall #print integer
  li $v0, 4 #load print string "program"
  la $a0, spaceEntry #load $a0 with string spaceEntry
  syscall #print string
  li $v0, 5 #load recieve integer input "program"
  syscall #recieve input
  add $t1, $v0, $0 #move user input to $t1 to use later
  sw $t1, arrayElement($0) #move user input to array arrayElement to use to check +
  add $a1, $t1, $0 #pass $t1(user input element) to upcoming function
  jal checkNumPositive #call checkNumPositive function
  add $t2, $v1, $0 #from function returned integer, load to $t2
  li $t3, 1 #load $t3 with 1 to use later
  blt $t2, $t3, loopCA #checks if returned integer is 0 which means it pass check + test
  add $a1, $t1, $0 #pass $t1 to upcoming function
  jal divisibleBy3 #function is used to check if user element input is divisible by 3
  add $t2, $v1, $0 #recieve returned integer from function
  li $t3, 1 #load $t3 with 1 to use to laster
  blt $t2, $t3, loopCA #checks if $t2 is 0 which means user element input is divisible by 3
  lw $t1, arrayElement($0) #load user element input in array arrayElement 
  sw $t1, array($t6) #add $t1(user element input) in array at index $t6
  addi $t6, $t6, 4 #increase array index by 4 (4 because an integer is 4 bytes)
  addi $t0, $t0, 1 #increase counter by 1
  j loopCA #jump to label loopCA
jumpToMain: #label used if counter is equal to user element array amount
  lw $ra, 0($sp) #load from stack pointer to return address
  addi $sp, $sp, 4 #increase stack pointer to make available space
  jr $ra #jump to return address
#=================================================================================================
checkNumPositive: #function label to check if user element input is +
  add $t2, $a1, $0 #recieve integer from main and load to $t2
  li $t3, 1 #load $t3 with 1
  blt $t2, $t3, notPositive #checks if user element input is greater than or equal to 1
  add $v1, $t3, $0 #if true set 1 send back to create loop
  jr $ra #jump to return address
notPositive: #label if user element input is less than 1
  li $v0, 4 #load print string "program"
  la $a0, userInputNotPositive #load $a0 with userInputNotPositive string
  syscall #print string
  li $t3, 0 #load $t3 with 0
  add $v1, $t3, $0 #return $t3 to return address
  jr $ra #jump to return address
#=================================================================================================
divisibleBy3: #function label, function used to check if user element input is divisible by 3
 add $t2, $a1, $0 #recieve user element input from main to $t2
 li $t3, 3 #load $t3 with 3
 div $t2, $t3 #divide $t2 by $t3(3)
 mfhi $t4 #move from high register, remainder
 bgt $t4, $0, notDivisible #checks if remiander is greater than 0, if remainder = 0 then user element input is divisible by 3
 li $t5, 1 #load $t5 with 1
 add $v1, $t5, $0 #return value of $t5 to main
 jr $ra #jump to return address
notDivisible: #label used if remainder is greater than 0
  li $v0, 4 #load print string "program"
  la $a0, userInputDivBy3Error #load string userInputDivBy3Error
  syscall #print string
  li $t5, 0 #load $t5 with 0
  add $v1, $t5, $0 #return value of $t5 to main
  jr $ra #jump to return address
#=================================================================================================
reverseArray: #fucntion label, used to reserve the array
  add $t1, $a1, $0 #recieve user element array amount to $t1
  li $t2, 2 #load $t2 with 2
  div $t1, $t2 #divides the user element array amount by 2
  mflo $t3 #move from low register the quotient
  mul $t3, $t3, 4 #half of the array size multiplied by 4
  mul $t1, $t1, 4 #full array size multiplied by 4
  subi $t1, $t1, 4 #subtract full array size by 4
  li $t4, 0 #load $t4 with 0, the used as the beginning of the array
loopRA: #label used as loop
  beq $t4, $t3, doneReverse #if $t4 is equal to $t3 the reversing has been done
  lw $t2, array($t1) #load tail of array to $t2
  sw $t2, arrayElement($0) #set tail of array to arrayElement array to hold value
  lw $t2, array($t4) #load head of array to $t2
  sw $t2, array($t1) #set $t2 to tail of array
  lw $t2, arrayElement($0) #load value from arrayElement to $t2
  sw $t2, array($t4) #set $t2 to head of array
  subi $t1, $t1, 4 #decrement $t1 by 4
  addi $t4, $t4, 4 #increment $t4 by 4
  j loopRA #jump to lable loopRa
doneReverse: #lable used when reversing of the array is done
  jr $ra #jump to return address
#=================================================================================================
printArray: #function label, function is used to print the whole array
  add $t1, $a1, $0 #recieve passed user input element amount to $t1
  mul $t1, $t1, 4 #multiply $t1(user input) 
  li $t2, 0 #load $t0 with 0 to be as a counter
  li $v0, 4 #load print string "program"
  la $a0, theArrayIs #load $a0 with theArrayIs string
  syscall #print string
printLoop: #label used as a loop
  beq $t2, $t1, jumpMain #if counter is equal to passed in user input element amount then go to lable jumpMain
  lw $t3, array($t2) #load $t3 with index $t2 from array
  li $v0, 1 #load print integer "program"
  add $a0, $t3, $0 #load in $t3 to $a0
  syscall #print integer
  li $v0, 4 #load print string "program"
  la $a0, spaceEntry #load $a0 with string spaceEntry
  syscall #print string
  addi $t2, $t2, 4 #increment $t2(counter) by 4
  j printLoop #jump to printLoop label
jumpMain: #lable used if counter is equal to user input element amount
  jr $ra #jump to return label
#=================================================================================================
readNum: #function label, used to read the user input for array elements
  li $v0, 4 #load print string "program"
  la $a0, userArraySize #load $a0 with userArraySize stirng
  syscall #print string
  li $v0, 5 #load recieve input "program"
  syscall #recieve input and load it in to $v0
  add $t0, $v0, $0 #move user input to $t0
  add $v1, $t0, $0 #return user input to main
  jr $ra #jump to return label
#=================================================================================================
verifySize: #function label, used to verify user input is it meets criteria
  add $t0, $a0, $0 #recieve passed in integer from main to $t0
  li $t1, 1 #load $t1 with 1 to use later
  blt $t0, $t1, greatOrLess #compares $t0 and $t1 to see user input is less than 0
  li $t1, 20 #load $t1 with 20 to user later
  bgt $t0, $t1, greatOrLess #compares $t0 and $t1 to see user input is greater than 20
  li $t2, 1 #load $t2 with 1
  add $v0, $t2, $0 #return value of $t2 to main, 1 means it meets criteria
  jr $ra #jump to return address
greatOrLess: #label used if user input does not mean criteria
  li $v0, 4 #load print stirng "program"
  la $a0, userArraySizeError #load $a0 with userArraySizeError string
  syscall #print string
  li $t2, 0 #load $t2 with 0
  add $v0, $t2, $0 #return value of $t2 to main
  j main #jump to main label
#=================================================================================================
