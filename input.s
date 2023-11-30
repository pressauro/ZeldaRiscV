.text
INPUT_CHECK:
	li t1,0xFF200000		# endereco do KDMMIO
	lw t0,0(t1)				
	andi t0,t0,0x0001		
   	beq t0,zero,INPUT_FIM   	   	
  	lw t0,4(t1)  			# t0 = valor da tecla pressionada
  	
  	li t1, 'w'
  	beq t0, t1, LINK_CIMA
  	
  	li t1, 'a'
  	beq t0, t1, LINK_ESQ
  	
  	li t1, 's'
  	beq t0, t1, LINK_BAIXO
  	
  	li t1, 'd'
  	beq t0, t1, LINK_DIR
  	
INPUT_FIM:
	ret

LINK_DIR:
	li t0,1
	addi t2, s6, 1
	add t1, s7, t2
	lb t1, (t1)
	beq t0, t1, INPUT_FIM	# se a casa desejada for 1 retorna
	
	li t0, 4
	beq t0, t1, MUDA_OVERWORLD
	
	li t0, 5
	beq t0, t1, INPUT_FIM
	
	add t0, s6, s7
	sb zero, (t0)		# zera a casa antiga do link
	add t0, t2, s7
	li t1, 2
	sb t1, (t0)			# atualiza a nova casa do link pra 2
	addi s6, s6, 1

	addi s3, s3, 16
	
	#MUDAR RENDER ANTIGO
	beqz s5, ANIMACAO
	li s5, 0
	la a1, LINK_SPRITE_POS
	li a0, 50
	sh a0, 0(a1) 
	
	ret

LINK_ESQ:
	li t0,1
	addi t2, s6, -1
	add t1, s7, t2
	lb t1, (t1)
	beq t0, t1, INPUT_FIM	# se a casa desejada for 1 retorna
	
	li t0, 4
	beq t0, t1, MUDA_OVERWORLD
	
	li t0, 5
	beq t0, t1, INPUT_FIM
	
	add t0, s6, s7
	sb zero, (t0)		# zera a casa antiga do link
	add t0, t2, s7
	li t1, 2
	sb t1, (t0)			# atualiza a nova casa do link pra 2
	addi s6, s6, -1

	addi s3, s3, -16
	
	#MUDAR RENDER ANTIGO
	li t0, 1
	beq s5, t0, ANIMACAO
	
	li s5, 1
	la a1, LINK_SPRITE_POS
	li a0, 103
	sh a0, 0(a1) 
	
	ret

LINK_CIMA:
	li t0,1
	addi t2, s6, -16
	add t1, s7, t2
	lb t1, (t1)
	beq t0, t1, INPUT_FIM	# se a casa desejada for 1 retorna
	
	li t0, 4
	beq t0, t1, MUDA_OVERWORLD
	
	li t0, 5
	beq t0, t1, INPUT_FIM
	
	add t0, s6, s7
	sb zero, (t0)		# zera a casa antiga do link
	add t0, t2, s7
	li t1, 2
	sb t1, (t0)			# atualiza a nova casa do link pra 2
	addi s6, s6, -16

	addi s4, s4, -16
	
	#MUDAR RENDER ANTIGO
	li t0, 2
	beq s5, t0, ANIMACAO
	
	li s5, 2
	la a1, LINK_SPRITE_POS
	li a0, 68
	sh a0, 0(a1) 
	
	ret

LINK_BAIXO:
	li t0,1
	addi t2, s6, 16
	add t1, s7, t2
	lb t1, (t1)
	beq t0, t1, INPUT_FIM	# se a casa desejada for 1 retorna
	
	li t0, 4
	beq t0, t1, MUDA_OVERWORLD
	
	li t0, 5
	beq t0, t1, INPUT_FIM
	
	add t0, s6, s7
	sb zero, (t0)		# zera a casa antiga do link
	add t0, t2, s7
	li t1, 2
	sb t1, (t0)			# atualiza a nova casa do link pra 2
	addi s6, s6, 16

	addi s4, s4, 16
	
	
	#MUDAR RENDER ANTIGO
	li t0, 3
	beq s5, t0, ANIMACAO
	
	li s5, 3
	la a1, LINK_SPRITE_POS
	li a0, 0
	sh a0, 0(a1) 
	
	#la t0, link_baixo
	#la t1, LINK_SPRITE
	#sw t0, (t1)
	
	ret
	
# PODE RETIRAR ANIMACAO
ANIMACAO:
	#seqz t0, s5
	li t1, 1
	beqz s0, CONT_ANIMACAO
	li t1, -1

CONT_ANIMACAO:
	li t0, 16
	mul t1, t1, t0
	add a0, a0, t1
	sh a0, 0(a1)
	ret

MUDA_OVERWORLD:
	la t0, overworld_2
	beq t0, s7, MUDA_OVERWORLD_2
	
	la t0, OVWRLD_SPRITE_POS
	sh zero, (t0)
	sh zero, 2(t0)
	
	li s3, 224
	li s4, 184
	
	la s7, overworld_2
	li s6, 156
	
	#
	
	#la a0,tile			# carrega o endereco do sprite 'map' em a0
	#li a1,0				# x = 0
	#li a2,0				# y = 0
	#li a3,0				# frame = 0
	#li a4, 1
	#call PRINT			# imprime o sprite
	#li a3,1				# frame = 1
	#li a4, 1
	#call PRINT			# imprime o sprite
	
	
	ret
	
MUDA_OVERWORLD_2:
	la t0, OVWRLD_SPRITE_POS
	li t1, 257
	sh t1, (t0)
	li t1, 177
	sh t1, 2(t0)
	
	li s3, 144
	li s4, 56
	
	la s7, overworld_1
	li s6, 23
	
	#call GERA_OCTOROK
	
	ret
	
