#==================================================================================================
#Program Description: This program calculates the total charge for a customer for a grocery store.
#Author: Victor Nguyen
#Creation Date: 02/21/2019 
#==================================================================================================
.data
  line1: .asciiz "How many grocery items did you purchase?\n"
  greaterMsg: .asciiz "\nInput was greater than 20. Please enter again.\n"
  lessMsg: .asciiz "\nInput was less than 1.  Please enter again.\n"
  itemPrice: .asciiz "\nPlease enter the price of item "
  coupon: .asciiz "\nPlease enter the number of coupons that you want to use.\n"
  couponError: .asciiz "\nToo many Coupons!! Please enter the number of coupons that you want to use."
  couponPriceError: .asciiz "\nThis coupon is not acceptable.\n"
  couponTotalSaved: .asciiz "\nYour total charge is: $"
  couponEnterAmount: .asciiz "\nPlease enter the amount of coupon "
  thankYouMsg: .asciiz "\nThank you for shopping with us.\n"
  enterSpace: .asciiz "\n"
  fillPArray: .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
  fillCArray: .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
  items: .word 0
.text
main:
  li $v0, 4
  la $a0, line1
  syscall  #output line1 String
  li $v0, 5
  syscall
  addi $s0, $v0, 0  #recieve input from user
  li $t1, 4
  sw $s0, items($t1)
  li $t0, 20
  bgt $s0, $t0, greaterThan  #check if input is greater than 20
  ble $s0, $0, lessThan  #check if input is less than or equal to 0
  addi $a1, $s0, 0  #move input to FillPriceArray function
  jal FillPriceArray
  addi $s1, $v1, 0  #sum is return through $v1
couponLabel:
  li $t1, 4
  lw $s0, items($t1)
  li $v0, 4
  la $a0, coupon
  syscall
  li $v0, 5
  syscall
  addi $t2, $v0, 0  #store input
  bgt $t2, $s0, couponFalse
  addi $a1, $t2,0  #send input to FillCouponArray
  jal FillCouponArray
  addi $s2, $v1, 0
  sub $s3, $s1, $s2
  li $v0, 4
  la $a0, couponTotalSaved
  syscall
  li $v0, 1
  addi $a0, $s3, 0
  syscall
  li $v0, 4
  la $a0, enterSpace
  syscall
  la $a0, thankYouMsg
  syscall
exit:
  li $v0, 10
  syscall  #end program
  
greaterThan:
  li $v0, 4
  la $a0, greaterMsg
  syscall
  j main
lessThan:
  li $v0, 4
  la $a0, lessMsg
  syscall
  j main
  
couponFalse:
  li $v0, 4
  la $a0, couponError
  syscall
  j couponLabel
  
#***************************************************************
FillPriceArray:
  addi $t3, $a1, 0
  li $t0, 0  #counter for loop
  li $t1, 4  #counter for array
  li $t4, 0
inFunctionLoop:
  beq $t0, $t3, equalExit
  li $v0, 4
  la $a0, itemPrice
  syscall
  li $v0, 1
  addi $a0, $t0, 0
  syscall
  li $v0, 4
  la $a0, enterSpace
  syscall
  li $v0, 5
  syscall
  addi $t2, $v0, 0
  sw $t2, fillPArray($t1)  #add input to fillPArray
  add $t4, $t4, $t2
  addi $t1, $t1, 4
  addi $t0, $t0, 1
  j inFunctionLoop
equalExit:
  addi $v1, $t4, 0
  jr $ra

#***************************************************************  
FillCouponArray:
  addi $t7, $a1, 0
  li $t0, 0  #counter for loop
  li $t1, 4  #counter for array
  li $t6, 0  #Coupon summ counter
  #lw $t3, items($1)
inCouponFunction:
  beq $t0, $t7, couponExit
  li $v0, 4
  la $a0, couponEnterAmount
  syscall
  li $v0, 1
  addi $a0, $t0, 0
  syscall
  li $v0, 4
  la $a0, enterSpace
  syscall
  li $v0, 5
  syscall
  addi $t2, $v0, 0 #user input for coupon $ amount
  li $t5, 10
  bge $t2, $t5, couponGreater
  lw $t5, fillPArray($t1)
  bge $t2, $t5, greaterPrice
  sw $t2, fillCArray($t1)
  add $t6, $t6, $t2
  addi $t0, $t0, 1
  addi $t1, $t1, 4
  j inCouponFunction
couponExit:
  addi $v1, $t6, 0
  jr $ra
  
couponGreater:
  sw $0, fillCArray($t1)
  li $v0, 4
  la $a0, couponPriceError
  syscall
  addi $t0, $t0, 1
  addi $t1, $t1, 4
  j inCouponFunction
  
greaterPrice:
  sw $0, fillCArray($t1)
  li $v0, 4
  la $a0, couponPriceError
  syscall
  addi $t0, $t0, 1
  addi $t1, $t1, 4
  j inCouponFunction