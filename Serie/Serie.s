	AREA codigo, CODE, READONLY, ALIGN=2 ;AREA: Perminte definir bloques de codigo y datos CODE:Indica que es codigo de maquina.   READONLY: Indica que se estara trabajando en la ROM
	THUMB 								 ;Indica que tipo de instruccion se estara utilizando.
	EXPORT Start

Start				  	; Punto de inicio de programa.
	VLDR.F32 S0, =0  	; n.
	VLDR.F32 S1, =1	  	; Constante inicio de la serie.
    VLDR.F32 S5, =100 	; Limite superior de la serie.
	VLDR.F32 S6, =1	 
	
Sumatoria				; Ciclo de sumatoria.
	VADD.F32 S0, S1		; n = n+1zz
    VLDR.F32 S7, =0	    ; Contador subrutina Potencia.
	VLDR.F32 S8, =1 	; S8 contendrá el valor de la potencia.
	BL Potencia			; n^n
	VDIV.F32 S3, S1, S8 ; 1/n^n
	VADD.F32 S4, S3		; Sumatoria.
	VCMP.F32 S0, S5		; Comparar si n llego al limite superior.
	VMRS APSR_nzcv, FPSCR
	BLO Sumatoria		
	
	
Loop					; Ciclo infinito.
	B Loop

Potencia				; Subrutina para cálculo de potencia.
	VMUL.F32 S8, S0 	; Calculo de la potencia n^n
	VADD.F32 S7, S6 	; Aumentar en 1 el contador de potencia
	VCMP.F32 S7, S0		; Verificar si contador es igual a exponente.
	VMRS APSR_nzcv, FPSCR
	BNE Potencia		; Si no se ha terminado, continuar calculando.
	BX LR				; Volver a línea siguiente a BL usado.
	
	ALIGN
	END