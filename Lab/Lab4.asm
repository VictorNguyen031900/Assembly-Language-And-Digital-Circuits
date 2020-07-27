#===================================================================================================
#Program Description: This program adds up the user input amount of even numbers from more inputs 
#Author: Victor Nguyen
#Creation Date: 02/06/2019 
#==================================================================================================
.data
  arrow: .asciiz "==>"
  enterNum: .asciiz "Enter a number: "
  posNum: .asciiz "How many positive number that is devisable by you want to add?\n"
  errorMsg: .asciiz " **** ERROR:"
  notPositive: .asciiz " is not a positive number. Enter another number.\n"
  enterSpace: .asciiz "\n"
  notInRange: .asciiz " is not in the range of 1 to 100. Enter another number.\n"
  isDivisible: .asciiz " is divisible by 6\n"
  notDivisible: .asciiz " is not divisible by 6. Enter another number.\n"
  sumMsg: .asciiz "The Sum of the positive numbers between 1 and 100 that are devisable by 6, is: "
  divider: .asciiz "=======================================================================\n"
  greaterInput: .asciiz "\nYour input is greater than 20! Enter another number.\n"
  lessInput: .asciiz "\nYour input is less than 1! Enter another number.\n"
.text
  li $v0, 4  #load print string "program"
  la $a0, divider  #load address with divider string
  syscall #print string
main:
  la $a0, posNum #load address with posNum String
  syscall #print string
  la $v0, 5 #load recieve input "program"
  syscall #start "program"
  add $s1, $0, $v0  #User input for amounts of + numbers to add
  li $t0, 1
  ble $s1, $t0, lessThan
  li $t0, 20
  bge $s1, $t0, greaterThan
  li $s0, 0 #counter and set to 0
  li $s2, 0 #total and set to 0
whileLoop:
  beq $s0, $s1, exit #while loop check, keeps looping until $s0(counter) is equal to $s1(User Input)
  li $v0, 4 #load print string "program"
  la $a0, enterSpace #load address with enterSpace string
  syscall #print string
  la $a0, enterNum #load address with enterNum string
  syscall #pritn string
  li $v0, 5 #load recieve input "program"
  syscall #start "program"
  add $t0, $0, $v0 #set user input of potential positive # in $t0
  li $t1, -1 #load immediate -1 to $t1 to use in a bit
  ble $t0, $t1, else1 #check if user input is less than or equal to -1, if true then go to else1 label
  li $t1, 1
  ble $t0, $0, else2 #check if user input is less than or equal to 1, if true then go to else2 label
  li $t1, 100 #load immediate 1oo to $t1 to use in a bit
  bge $t0, $t1,else3 #check if user input is greater than 100, if true then go to else 3 label
  li $t1, 6 #load immediate 6 to $t1 to use in a bit
  div $t0, $t1 #divide $t0(user input) with $t1(set to 6)
  mfhi $t2 #move from high(remainder) to $t2
  mflo $t3 #move from low(quotient) to $t3
  bne $t2, $0, else4 #check is $t2(remainder) is equal to $0(constant 0), if then go to else4 label
  li $v0, 1 #load print integer "program"
  add $a0, $t0, $0 #move $t0(user input) to $a0(argument)
  syscall #print integer
  li $v0, 4 #load print string "program"
  la $a0, isDivisible #load address with isDivisible string
  syscall #print string
  add $s2, $s2, $t0 #add $t0(user input) to $s2(total)
  addi $s0, $s0, 1 #increase $s0(counter) by 1
  j whileLoop #jump back to the top of whileLoop
else1:
  li $v0, 4 #load print string "program"
  la $a0, arrow #load address with isDivisible string
  syscall #print string
  la $a0, errorMsg #load address with errorMsg string
  syscall #print string
  li $v0, 1 #load print integer "program"
  add $a0, $t0, $0 #move $t0(user input) to $a0(argument)
  syscall #print integer
  li $v0, 4 #load print string "program"
  la $a0, notPositive #load address with notPositive string
  syscall #print string
  j whileLoop #jump back to the top of whileLoop
else2:
  li $v0, 4 #load print string "program"
  la $a0, arrow #load address with arrow string
  syscall #print string
  la $a0, errorMsg #load address with errorMsg string
  syscall #print string
  li $v0, 1 #load print integer "program"
  add $a0, $t0, $0 #move $t0(user input) to $a0(argument)
  syscall #print integer
  li $v0, 4 #load print string "program"
  la $a0, notInRange #load address wiht notInRange string
  syscall #print string
  j whileLoop #jump back to the top of whileLoop
else3:
  li $v0, 4 #load print string "program"
  la $a0, arrow #load address with arrow string
  syscall #print string
  la $a0, errorMsg #load address with errorMsg string
  syscall #print string
  li $v0, 1 #load print integer "program"
  add $a0, $t0, $0 #move $t0(user input) to $a0(argument)
  syscall #print integer
  li $v0, 4 #load print string "program"
  la $a0, notInRange #load address with notInRange string
  syscall #print string
  j whileLoop #jump back to the top of whileLoop
else4:
  li $v0, 1 #load print integer "program"
  add $a0, $t0, $0 #move $t0(user input) to $a0(argument)
  syscall #print integer
  li $v0, 4 #load print string "program"
  la $a0, notDivisible #load address with notDivisible string
  syscall #print string
  j whileLoop #jump to the top of whileLoop
greaterThan:
  li $v0, 4
  la $a0, greaterInput
  syscall
  j main
lessThan:
  li $v0, 4
  la $a0, lessInput
  syscall
  j main
exit: 
  li $v0, 4 #load print string "program"
  la $a0, sumMsg #load address with sumMsg
  syscall #print string
  li $v0, 1 #load print integer "program"
  add $a0, $s2, $0 #move $s2(total) to $a0(argument)
  syscall #print integer
  li $v0, 4 #load print string "program"
  la $a0, enterSpace #load address with enterSpace string
  syscall #print string
  la $a0, divider #load address with divider string
  syscall #print string
  li $v0, 10 #load end program
  syscall #end program
