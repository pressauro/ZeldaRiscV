.eqv FRAME_CONTROL_ADDRESS	0xFF200604

.data
OVWRLD_SPRITE_POS: .half 257, 177
OVWRLD_SPRITE_DRAW: .half 256, 176
OVWRLD_SPRITE_SIZE: .half 772, 353
OVWRLD_SPRITE_PATH: .string "sprites/mundo.bin"

LINK_POS_INICIAL: .half 96,104
LINK_SPRITE_POS: .half 0,0
LINK_SPRITE_DRAW: .half 16, 16
LINK_SPRITE_SIZE: .half 140, 16
LINK_SPRITE_PATH: .string "sprites/link.bin"



.text
# s0 = frame atual
# s1 = endereço do arquivo do mapa
# s2 = endereço do arquivo do link
# s3 = pos x do link na tela
# s4 = pos y do link na tela
# s5 = direcao do link (0 - direita, 1 - esquerda, 2 - cima, 3 - baixo)
# s6 = pos do link na matriz
# s7 = endereço da matriz de colisao do mapa atual

SETUP:
	li		a7, 1024
	la		a0, OVWRLD_SPRITE_PATH
	li		a1, 0
	ecall
	mv s1, a0				# aloca mapa no s1
	
	li a7, 1024
	la a0, LINK_SPRITE_PATH
	li a1, 0
	ecall
	mv s2, a0				# aloca Link em s2
	
	la t0, LINK_POS_INICIAL	
	lhu s3, (t0)			# aloca pos x inicial em s3
	lhu s4, 2(t0)			# aloca pos y inicial em s4
	
	
	li s5, 3
	li s6, 68
	la s7, overworld_1
	
	li a7, 1024
	la a0, OCTOROK_SPRITE_PATH
	li a1, 0
	ecall
	mv s8, a0				# aloca Link em s2

LOOP_PRINCIPAL:
	csrr t0, 3073
	sub t0, t0, s11
	li t1, 75
	
	bltu t0, t1, LOOP_PRINCIPAL
	
	
	
	call INPUT_CHECK
	# RENDER MAP
	mv a0, s1
	li a1, 32
	li a2, 40
	la a3, OVWRLD_SPRITE_SIZE
	la a4, OVWRLD_SPRITE_DRAW
	mv a5, s0
	#la t0, MAP_POS
	la t0, OVWRLD_SPRITE_POS
	lhu	t1, 0(t0)
	lhu	t0, 2(t0)
	mv a6, t1
	mv a7, t0
	call RENDER
	
	la t0, overworld_2
	bne t0, s7, NAO_GERA_INIMIGO
	
	call OCTOROK
	call RENDER
	
NAO_GERA_INIMIGO:
	
	mv a0, s2
	mv a1, s3
	mv a2, s4
	la a3, LINK_SPRITE_SIZE
	la a4, LINK_SPRITE_DRAW
	mv a5, s0
	
	la t0, LINK_SPRITE_POS
	lhu t1, 0(t0)
	lhu t0, 2(t0)
	
	mv a6, t1
	mv a7, t0
	call RENDER
	
	li		t0, FRAME_CONTROL_ADDRESS
	sw s0, 0(t0)
	xori s0, s0, 1
	
	csrr s11, 3073
	
	j LOOP_PRINCIPAL

.include "render.s"
.include "input.s"
.include "matrizes.s"
.include "enemy.s"
