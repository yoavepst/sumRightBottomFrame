.data
	matrix: .byte 1, 2, 3, 4, 1, 2, 3, 4
	.space 4
	row: .word 2
	col: .word 4 
.text main	
main:
sumRightBottomFrame:	
	mul $t6, $a1, $a2 # will be used to get to check last col
	add $t7, $t6, $a0 # will be used to get to check last col
	sub $a1, $a1, 1
	sub $a2, $a2, 1
	add $t0, $a2, $a0 # pointer to the address of the last number in row 0
	mul $t1, $a1, $a2
	add $t1, $t1, 1
	add $t1, $t1, $a0 # pointer to the address of the las number in col 0
	lb $t2, 0($t0) # the byte at matrix[0][$a2]
	lb $t3, 0($t1) # the byte at matrix[$a1][0]
	li $v0 , 0 # initialize the sum
	add $a2, $a2, 1 # will be used to get to the next row
row_sum:
	add $v0, $v0, $t2
	add $t0, $t0, $a2 #continue to the next row
	lb $t2, 0($t0) # the byte at matrix[i+$a2][$a2]
	bne $t0, $t7, row_sum
	
col_sum:
	add $v0, $v0, $t3
	addi $t1, $t1, 1 #continue at the same row
	lb $t3, 0($t1) # the byte at matrix[$a1][i+1]
	bne $t0, $t7, col_sum
	
fence:
	add $v0, $v0, $t2 #adding the right corner of the matrix
jr $ra 
