#=============================================================================
#Program Description: This program program written to mimic a very basic calculator 
#Author: Victor Nguyen
#Creation Date: 01/31/2019 
#=============================================================================

.data
  string1: .asciiz "=============================================================================\n"
  string2: .asciiz "Program Description: This program program written to mimic a very basic calculator\n"
  string3: .asciiz "Author: Victor Nguyen\n" 
  string4: .asciiz "Creation Date:"
  string5: .asciiz "/"
  string6: .asciiz "\n"
  
  input: .asciiz "Please input the two numbers?\n"
  sum: .asciiz "Sum is:\t\t\t"
  diff: .asciiz "Difference is:\t\t"
  pro: .asciiz "Product is:\t\t"
  quo: .asciiz "Quotient is:\t\t"
  re: .asciiz "Remainder is:\t\t"
  
  
.text
  li $v0, 4			#load immediate value of 4 into $v0 to print string 
  la $a0, string1		#load the value of string1 into $a0
  syscall			#print string
  la $a0, string2		#load the value of string2 into $a0
  syscall			#print string
  la $a0, string3		#load the value of string3 into $a0
  syscall			#print string
  la $a0, string4		#load the value of string4 into $a0
  syscall			#print string
  li $v0, 1			#load immediate value of 1 into $v0 to print integer
  la $a0, 01			#load the value of integer into $a0
  syscall			#print integer
  li $v0, 4			#load immediate value of 4 into $v0 to print string 
  la $a0, string5		#load the value of string5 into $a0
  syscall			#print string
  li $v0, 1			#load immediate value of 1 into $v0 to print integer
  la $a0, 31			#load the value of integer into $a0
  syscall			#print integer
  li $v0, 4			#load immediate value of 4 into $v0 to print string 
  la $a0, string5		#load the value of string5 into $a0
  syscall			#print string
  li $v0, 1			#load immediate value of 1 into $v0 to print integer
  la $a0, 19			#load the value of integer into $a0
  syscall			#print integer
  li $v0, 4			#load immediate value of 4 into $v0 to print string 
  la $a0, string6		#load the value of string6 into $a0
  syscall			#print string
  la $a0, string1		#load the value of string1 into $a0
  syscall			#print string
  la $a0, input		#load the value of input into $a0
  syscall			#print string
  li $v0, 5			#load immediate value of 5 into $v0 to recieve input 
  syscall			
  add $s0, $0, $v0		#store $vo to $s0 
  li $v0, 5			#load immediate value of 5 into $v0 to recieve input
  syscall
  add $s1, $0, $v0		#store $vo to $s1
  li $v0, 4			#load immediate value of 4 into $v0 to print
  la $a0, sum			#load the value of sum into $a0
  syscall			#print string
  add $a0, $s0, $s1		#adds $s0 and $s1 then store value into $a0
  la $v0, 1			#load immediate value of 1 into $v0 to print integer
  syscall			#print integer
  li $v0, 4			#load immediate value of 4 into $v0 to print
  la $a0, string6		#load the value of string6 into $a0
  syscall			#print string
  la $a0, diff		#load the value of diff into $a0
  syscall			#print string
  sub $a0, $s0, $s1		#Subtracts $s0 and $s1 then store value into $a0
  la $v0, 1			#load immediate value of 1 into $v0 to print integer
  syscall			#print integer
  li $v0, 4			#load immediate value of 4 into $v0 to print
  la $a0, string6		#load the value of string6 into $a0
  syscall			#print string
  la $a0, pro			#load the value of pro into $a0
  syscall			#print string
  mult $s0, $s1		#multiply $s1 by $s2 and place the results into lo and hi
  mfhi $t0			#move the value of hi register into $t0
  mflo $t1			#move the value of 10 register into $t1
  li $v0, 1			#load immediate value of 1 into $v0 to print integer
  add $a0, $t1, $0		#store the content of $t1 to $a0
  syscall			#print integer
  li $v0, 4			#load immediate value of 4 into $v0 to print
  la $a0, string6		#load the value of string6 into $a0
  syscall			#print string
  la $a0, quo			#load the value of quo into $a0
  syscall			#print string
  div $s0, $s1		#divide $s0 by $s1 and place the quotient into “lo” and remainder in “hi” registers
  mfhi $t0			#move the value of hi register into $t0
  mflo $t1			#move the value of lo register into $t1
  li $v0, 1			#load immediate value of 1 into $v0 to print integer
  add $a0, $t1, $0		#store the content of $t1 to $a0
  syscall			#print integer
  li $v0, 4			#load immediate value of 4 into $v0 to print
  la $a0, string6		#load the value of string6 into $a0
  syscall			#print string
  la $a0, re			#load the value of re into $a0
  syscall			#print string
  li $v0, 1			#load immediate value of 1 into $v0 to print integer
  add $a0, $t0, $0		#store the content of $t0 to $a0
  syscall			#print intger
  li $v0, 10			#the code for termination of program 
  syscall			#call the termination system program

  
