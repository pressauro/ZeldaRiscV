# fs0 = pos x inimigo atual
# fs1 = pos y inimigo atual

.data
OCTOROK_POS_INICIAL: .half 32, 104
OCTOROK_SPRITE_PATH: .string "sprites/octorok.bin"
OCTOROK_SPRITE_POS: .half 0, 0
OCTOROK_SPRITE_DRAW: .half 16, 16
OCTOROK_SPRITE_SIZE: .half 68, 16
OCTOROK_POS: .half 48, 104
OCTOROK_POS_MATRIZ: .half 65

.text
MOVIMENTACAO_INIMIGO:
	beqz a0, INIMIGO_DIR
	
	li t0, 1
	beq a0, t0, INIMIGO_ESQ
	
	li t0, 2
	beq a0, t0, INIMIGO_CIMA
	
	li t0, 3
	beq a0, t0, INIMIGO_BAIXO
	

INIMIGO_RET:
	jr a1

INIMIGO_DIR:
	la t4, OCTOROK_POS_MATRIZ
	lh t3, (t4)
	
	li t0,1
	addi t2, t3, 1			
	add t1, s7, t2
	lb t1, (t1)
	beq t0, t1, INIMIGO_RET	# se a casa desejada for 1 retorna
	
	add t0, t3, s7
	sb zero, (t0)		# zera a casa antiga do inimigo
	add t0, t2, s7
	li t1, 5
	sb t1, (t0)			# atualiza a nova casa do inimigo pra 5
	addi t3, t3, 1
	sh t3, (t4)

	la t0, OCTOROK_POS
	lh t1, (t0)
	addi t1, t1, 16
	sh t1, (t0)
	
	#beqz a0, ANIMACAO_INIMIGO
	
	la t1, OCTOROK_SPRITE_POS
	li t0, 51
	sh t0, 0(t1) 
	
	jr a1

INIMIGO_ESQ:
	la t4, OCTOROK_POS_MATRIZ
	lh t3, (t4)
	
	li t0,1
	addi t2, t3, -1
	add t1, s7, t2
	lb t1, (t1)
	beq t0, t1, INIMIGO_RET	# se a casa desejada for 1 retorna
	
	
	
	add t0, t3, s7
	sb zero, (t0)		# zera a casa antiga do inimigo
	add t0, t2, s7
	li t1, 5
	sb t1, (t0)			# atualiza a nova casa do inimigo pra 5
	addi t3, t3, -1
	sh t3, (t4)

	la t0, OCTOROK_POS
	lh t1, (t0)
	addi t1, t1, -16
	sh t1, (t0)
	
	#beqz a0, ANIMACAO_INIMIGO
	
	la t1, OCTOROK_SPRITE_POS
	li t0, 34
	sh t0, 0(t1) 
	
	jr a1

INIMIGO_CIMA:
	la t4, OCTOROK_POS_MATRIZ
	lh t3, (t4)
	
	li t0,1
	addi t2, t3, -16
	add t1, s7, t2
	lb t1, (t1)
	beq t0, t1, INIMIGO_RET	# se a casa desejada for 1 retorna
	
	
	
	add t0, t3, s7
	sb zero, (t0)		# zera a casa antiga do inimigo
	add t0, t2, s7
	li t1, 5
	sb t1, (t0)			# atualiza a nova casa do inimigo pra 5
	addi t3, t3, -16
	sh t3, (t4)

	la t0, OCTOROK_POS
	lh t1, 2(t0)
	addi t1, t1, -16
	sh t1, 2(t0)
	
	#beqz a0, ANIMACAO_INIMIGO
	
	la t1, OCTOROK_SPRITE_POS
	li t0, 17
	sh t0, 0(t1) 
	
	jr a1

INIMIGO_BAIXO:
	la t4, OCTOROK_POS_MATRIZ
	lh t3, (t4)
	
	li t0,1
	addi t2, t3, 16
	add t1, s7, t2
	lb t1, (t1)
	beq t0, t1, INIMIGO_RET	# se a casa desejada for 1 retorna
	
	
	
	add t0, t3, s7
	sb zero, (t0)		# zera a casa antiga do inimigo
	add t0, t2, s7
	li t1, 5
	sb t1, (t0)			# atualiza a nova casa do inimigo pra 5
	addi t3, t3, 16
	sh t3, (t4)

	la t0, OCTOROK_POS
	lh t1, 2(t0)
	addi t1, t1, 16
	sh t1, 2(t0)
	
	#beqz a0, ANIMACAO_INIMIGO
	
	la t1, OCTOROK_SPRITE_POS
	li t0, 0
	sh t0, 0(t1) 
	
	jr a1
	
SLA_DIR:
	la t3, OCTOROK_POS
	lh t0, (t3)
	addi t0, t0, 16
	sh t0, (t3)
	jr a1

OCTOROK:
	
	
	csrr t0, 3073
	sub t0, t0, s10
	li t1, 200
	bltu t0, t1, NAO_MUDA_POS
	
	li a7, 42
	li a0, 0
	li a1, 4
	ecall
	
	
	bnez a0, J1
	jal a1, INIMIGO_DIR

J1:
	li t0, 1
	bne a0, t0, J2
	jal a1, INIMIGO_ESQ

J2:
	
	li t0, 2
	bne a0, t0, J3
	jal a1, INIMIGO_CIMA

J3:
	li t0, 3
	bne a0, t0, J4
	jal a1, INIMIGO_BAIXO
J4:
	#call MOVIMENTACAO_INIMIGO
	#addi t1, a0, 32
	#addi t2, a0, 40
	
	la t3, OCTOROK_POS
	#lh t0, (t3)
	#addi t0, t0, 16
	#sh t0, (t3)
	#lh t0, 2(t3)
	#addi t0, t0, 16
	#sh t0, 2(t3)
	
	#sh t1, (t3)
	#sh t2, 2(t3)
	csrr s10, 3073
	
NAO_MUDA_POS:
	la t3, OCTOROK_POS
	
	lh a1, (t3)
	lh a2, 2(t3)
	
	mv a0, s8
	#fcvt.w.s a1, fs0 
	#fcvt.w.s a2, fs1
	
	#li a1, 32
	#li a2, 104
	 
	la a3, OCTOROK_SPRITE_SIZE
	la a4, OCTOROK_SPRITE_DRAW
	mv a5, s0
	
	la t0, OCTOROK_SPRITE_POS
	lhu t1, 0(t0)
	lhu t0, 2(t0)
	
	mv a6, t1
	mv a7, t0
	ret

# NAO PRECISA
ANIMACAO_INIMIGO:
	#seqz t0, s5
	li t1, 1
	beqz s0, CONT_ANIMACAO_INIMIGO
	li t1, -1

CONT_ANIMACAO_INIMIGO:
	li t0, 16
	mul t1, t1, t0
	add a0, a0, t1
	sh a0, 0(a1)
	ret
