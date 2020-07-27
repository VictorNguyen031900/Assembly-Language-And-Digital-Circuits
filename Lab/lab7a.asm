#=========================================================
# program description: user input convert integer to float
# author: Victor Nguyen
# creation date: 2/26/19
#=========================================================

.data
  userInput: .asciiz "\nPlease input a temperature in Celsius ==> "
  enterSpace: .asciiz "\n"
  userOutput: .asciiz "\nThe temperature in Fahrenheit is ==> "
  num1: .float 1.80 #label num1 declared as 1.80 used for converison
  num2: .float 32.00 #label num2 declared as 32 used for conversion
.text
main:
  li $v0, 4 #load print string program
  la $a0, userInput #load string into argument
  syscall #print string
  li $v0, 5 #load recieve input program
  syscall #call program
  mtc1 $v0, $f2 #move $v0(User Input) to coprocessor 1 $f2
  cvt.s.w $f4, $f2 #convert $f2 to a float and set into $f4
  l.s $f6, num1 #load in 1.80 to convert C to F into $f6
  l.s $f7, num2 #load in 32.00 to convert C to F into $f7
  mul.s $f8, $f6, $f4 #multiply 1.80 and $f4 and set into $f8
  add.s $f8, $f8, $f7 #add 32 and $f8 and set into $f8
  li $v0, 4 #load print string program
  la $a0, userOutput #load string into argument
  syscall #print string
  li $v0, 2 #load print float program
  mov.s $f12, $f8 #move $f8 to $f12
  syscall #print float
  li $v0, 10 #load end program
  syscall #end program
