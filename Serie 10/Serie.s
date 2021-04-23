	AREA codigo, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT Start

Start						; Punto de inicio de programa.
	VLDR.F32 S0, =1			; Valor de n.
    VLDR.F32 S1, =10			; Límite superior.
	VLDR.F32 S2, =1			; Constante 1.
	VLDR.F32 S3, =1			; Constante 2.
	VLDR.F32 S4, =0			; Constante 3.
	VLDR.F32 S5, =1			; Constante 4.
	VLDR.F32 S8, =1			; Constante 5.
	VLDR.F32 S11, =1		; Constante 6.
	VLDR.F32 S12, =2		; Constante 7.
	VLDR.F32 S14, =0		; Constante 8.


Sumatoria
	BL factorial 		; n!
	
	VLDR.F32 S6, =0	    ; Contador subrutina Potencia.
	VLDR.F32 S7, =1 	; S7 contendrá el valor de la potencia.
	BL Potencia			; n^n
	
	VLDR.F32 S9, =0	    ; Contador subrutina Potencia 2^n.
	VLDR.F32 S10, =1 	; S10 contendrá el valor de la potencia.
	BL Potencia2		; 2^n
	
	VMUL.F32 S13 , S10 , S3 ; (2^n)(n!)
	VDIV.F32 S13 , S7       ; ((2^n)(n!))/(n^n)
	VADD.F32 S14 , S13      ; Sumatoria
	VCMP.F32 S0,S1			; Comparar si n llego al limite superior
	VADD.F32 S0,S2			; Aumentar en 1 n
	VMRS APSR_nzcv, FPSCR
	BLO Sumatoria 
	
Loop					    ; Ciclo infinito.
	B Loop
	
factorial 
	VADD.F32 S4,S5          
    VMUL.F32 S3,S4
	VCMP.F32 S4,S0	
	VMRS APSR_nzcv, FPSCR
	BNE factorial	
	BX LR	
	
Potencia				
	VMUL.F32 S7, S0 	
	VADD.F32 S6, S8 	
	VCMP.F32 S6, S0		
	VMRS APSR_nzcv, FPSCR
	BNE Potencia		
	BX LR		
	
Potencia2				
	VMUL.F32 S10, S12 	
	VADD.F32 S9, S11 	
	VCMP.F32 S9, S0		
	VMRS APSR_nzcv, FPSCR
	BNE Potencia2		
	BX LR		
	
	ALIGN
	END