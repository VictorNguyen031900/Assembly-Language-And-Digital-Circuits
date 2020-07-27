#========================================================================
# Program Description:  This program requires the user to input a 9 character
# line and the program will then encrypt the mesage and then decrypt it.
# Author: Victor Nguyen
# Creation Date: 2/28/19
#========================================================================
.data
  input: .byte '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'
  space: .asciiz "\n"
  enc: .byte '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'
  space2: .asciiz "\n"
  dec: .byte '-', '-', '-', '-', '-', '-', '-', '-', '-', '-'
  space3: .asciiz "\n"
  inputMSG: .asciiz "\nEnter a 9 character string.\n"
  encryptMSG: .asciiz "\nYour encrypted message is:\n"
  decryptedMSG: .asciiz "\nYour decrypted message is:\n"
.text
main:
 li $v0, 4 #load print string "program"
 la $a0, inputMSG #load $a0 with inputMSG string 
 syscall #print string 
 li $v0, 8 #load recieve string "program"
 la $a0, input #load array input to $a0
 li $a1, 10 #allow only up to 9 characters
 syscall #call recieve string "program"
 li $t0, 10 #load $t0 with 10, decrement counter
 la $s1, enc #load $s1 with enc array
 la $s2, input #load $s2 with input array 
 la $s3, dec #load $s3 with dec array
loop:
  li $t2, 10 #load $t2 with 10, encryption and decryption key
  beq $t0, $0, print1 #If $t0(decrement counter) is equal to 0 then got to label print1
  lb $t1, 0($s2) #load byte $t1 with pointer of input array
  xor $t3, $t2, $t1 #XOR $t2 and $t1 in to $t3
  sb $t3, 0($s1) #set byte $t3 in to pointer stack of enc array
  li $t1, 0 #reset byte of $t1
  li $t3, 0 #reset byte of $t3
  li $t4, 0 #reset byte of $t4
  lb $t3, 0($s1) #load byte $t1 with point of input array
  xor $t4, $t2, $t3 #XOR $t2 and $t3 in to $t4
  sb $t4, 0($s3) #set byte $t4 in to pointer stack of dec array
  li $t3, 0 #reset byte of $t3
  li $t1, 0 #reset byte of $t1
  li $t4, 0 #reset byte of $t4
  addi $s3, $s3, 1 #increment $s3 by 1 
  addi $s2, $s2, 1 #increment $s2 by 1
  addi $s1, $s1, 1 #increment $s1 by 1
  subi $t0, $t0, 1 #decrement $t0 by 1
  j loop #jump to loop label
print1:
 li $v0, 4 #load print string "program"
 la $a0, space #load $a0 with space string
 syscall #print string
 la $a0, encryptMSG #load $a0 with encryptMSG string 
 syscall #print string 
 la $a0, enc #load $a0 with enc string(array of chars)
 syscall #print string
 la $a0, decryptedMSG #load $a0 wiht decryptedMSG string
 syscall #print string
 la $a0, dec #load $a0 with dec string(array of chars)
 syscall #print string
 li $v0, 10 #load end program "program"
 syscall #end program 
