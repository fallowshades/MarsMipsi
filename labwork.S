  # labwork.S
  # Written 2015-2017 by F Lundevall
  # Skeleton file for IS1200/IS1500 lab 1.
  # The macros PUSH and POP are in the public domain.
  # Please add your own code at the end of the file.

  #
  # Please keep the two macros PUSH and POP unchanged
  #
.macro	PUSH reg
	addi	$sp,$sp,-4
	sw	\reg,0($sp)
.endm

.macro	POP reg
	lw	\reg,0($sp)
	addi	$sp,$sp,4
.endm
  #
  # Please add your own code below this line
  #





.data
	.align 2
mytime:	.word 0x5957
timstr:	.ascii "text more text lots of text\0"
	.text

  # previous assignment//note must above timeToStreing
  #
hexasc:
	andi $v0, $a0, 0xf #mask 4 lsb to reepresent decimal nr 0-15
	
	addi $v0, $v0, 0x30 #position in ascii table representing 1st  = 48nr
	
	# <= not 0-9
	ble $v0, 0x39, L1 #if statement ´hop over addition of letter converstion
	nop
	
	#assci additional right position -> letters
	addi $v0, $v0, 7 #letters are positioned 7 additional placments to the right
			#note +1 position from decimal nr.
L1:
	jr $ra
	nop
	
  # you can write your code for subroutine "hexasc" below this line
  #but i wrote timetostring
  #
.global time2string
time2string:
  ##1st letter
	PUSH $ra
	PUSH $a0 #addr
	PUSH $a1 #value //!need move to $a0 for hexasc f()
	
	#conform such hexasc mask bottom bits-> store in $a0
	srl $a0, $a1, 12 #shift towards 1st hour digit
	jal hexasc #will mask 4bit & convert
	nop
	
	POP $a1
	POP $a0 #the previous addr
	
	sb $v0,	0($a0)		#store at 1st string byte
	
##2nd letter
	PUSH $a0
	PUSH $a1
	srl $a0, $a1, 8 	#take second digit into msb4
	jal hexasc		#convert to char
	nop
	POP $a1
	POP $a0 		#addr of string
	sb $v0,	1($a0)		#store second digit at next index
	
##coolon
	li $t2,0x3A		# asscci code is ":"=
	sb $t2,2($t0)
	
#3rd letter
	PUSH $a0
	PUSH $a1
	srl $a0, $a1, 4 	#take thrid digit into msb4
	jal hexasc		#convert to char
	nop
	POP $a1
	POP $a0
	sb $v0,	3($a0)		#store third digit
	
#4th letter
	PUSH $a0		#argument a1 is unimportant now
	move $a0, $a1		#last digit such correct argument register
	
#null terminator	
	jal hexasc		##convert to char
	nop
	POP $t0
	sb $v0,	4 ($t0) 		#store 5th byte
	
	li $t2,0x00		#null terminator
	sb $t2,5($t0)		#end of word
	
	POP $ra		#return ra
	
	jr $ra 			#back to the future
	nop

.global delay
delay:
	#$t0 = i
	#$t1 = conditional
	#$s1 = argumen
	move $s1, $a0
	#addi $s1, $0, 0 #assignment // only consern outer loop
	
##outer brackets
while: 


	#whil3e( 0 < arg)
	slt $t1, $0 , $s1	#0 < $a0  --> 1 if ture(the reverse statement
	bne $t1, $0, done	#t1 = conditiond-> do if not equal, ie logic 1=true
	#beq $s1, $0, done #if equal other wise 0 = rist infinite loops (-1 is counter productive)
	#beq $t1, $0, done #if state ment if less than
	nop
	
	
	#logic
	addi $s1, $s1, -1	#ms = ms - 1
	
	#nested block initialization
	addi $t0, $0, 0 #initiate i
	addi $t3, $0, 4711
	
##inner brackets
for:
	#i <4711
	slt $t1, $t0, $t3  #i < delay --> 1 if ture
	beq $t1,$0, while	#back to while once i is not< constant
	nop
	
	addi $t0, $t0, 1		#i++
	j for
	nop
##
done: 

	jr $ra
	nop


