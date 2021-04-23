	AREA codigo, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT Start

Start		                ; Punto de inicio de programa.
	VLDR.F32 S0, =0			; Valor de n.
    VLDR.F32 S1, =50		; Límite superior.
	VLDR.F32 S2, =1			; Constante 1.
	VLDR.F32 S3, =1			; Constante 2.
	VLDR.F32 S4, =2			; Constante 3.
	VLDR.F32 S5, =1			; Constante 4.
	VLDR.F32 S6, =0			; Constante 5.
	VLDR.F32 S7, =1		    ; Constante 6.
	VLDR.F32 S8, =1		    ; Constante 7.
	VLDR.F32 S9, =0		    ; Constante 8.
	VLDR.F32 S10, =1		; Constante 9.
	VLDR.F32 S11, =0		; Constante 10.


Sumatoria
	VADD.F32 S0,S2			; Aumentar en 1 n
    VSQRT.F32 S3, S0        ; Raiz(n)
    VMUL.F32  S5, S4, S0    ; 2*n
	VADD.F32  S6, S3 , S5   ; 2n + Raiz(n)
	VMUL.F32  S7, S0, S0    ; n^2
	VMUL.F32  S8, S7, S0    ; n^3
	VADD.F32 S9, S8, S3     ; n^3 + Raiz(n)
	VDIV.F32 S10, S6, S9    ; [2n + Raiz(n)] / [n^3 + Raiz(n)]
	VADD.F32 S11, S10       ; Sumatoria
 	VCMP.F32 S0,S1			; Comparar si n llego al limite superior
	VMRS APSR_nzcv, FPSCR
	BLO Sumatoria 
Loop						; Ciclo infinito.
	B Loop

	ALIGN
	END