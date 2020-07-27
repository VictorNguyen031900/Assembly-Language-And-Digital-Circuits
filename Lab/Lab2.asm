#Program Desciption: Output Strings and Integers
#Author: Victor Nguyen
#Creation Date: 01/29/2019

.data
  string1: .asciiz "Here is the Report of Top 5 employees in Erickson Company: \n"
  string2: .asciiz "=======================================================\n"
  string3: .asciiz "Last Name\tFirst Name\tPosition\tSalary\n"
  string4: .asciiz "~~~~~~~~~\t~~~~~~~~~~\t~~~~~~~~~\t~~~~~~~\n"
  string5: .asciiz "Smith\t\tAdam\t\tDirector\t"
  string6: .asciiz "\nHadden\t\tMary\t\tDirector\t"
  string7: .asciiz "\nSimpson\t\tMike\t\t\Manager\t\t"
  string8: .asciiz "\nWilliams\tAndrea\t\tDesigner\t"
  string9: .asciiz "\nAmer\t\tAli\t\tDesigner\t"
  string10: .asciiz "\n======================================================="
.text
  li $v0, 4
  la $a0, string1
  syscall
  la $a0, string2
  syscall
  la $a0, string3
  syscall
  la $a0, string4
  syscall
  la $a0, string5
  syscall
  li $v0, 1
  la $a0, 99010
  syscall
  li $v0, 4
  la $a0, string6
  syscall
  li $v0, 1
  la $a0, 95220
  syscall
  li $v0, 4
  la $a0, string7
  syscall
  li $v0, 1
  la $a0, 80000
  syscall
  li $v0, 4
  la $a0, string8
  syscall
  li $v0, 1
  la $a0, 70000
  syscall
  li $v0, 4
  la $a0, string9
  syscall
  li $v0, 1
  la $a0, 55000
  syscall
  li $v0, 4
  la $a0, string10
  syscall
  li $v0, 10
  syscall
