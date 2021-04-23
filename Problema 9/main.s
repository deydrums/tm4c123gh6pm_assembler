	AREA codigo, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT Start

Start		                
	LDR  R0, = 0			
    LDR  R1, = 10		;//INGRESE LA CANTIDAD DE MINUTOS DE LA LLAMADA
    LDR  R2, = 1		  
	LDR  R3, = 3	
	VLDR.F32 S0, =0.5 
	VLDR.F32 S1, =0.1
	VLDR.F32 S2, = 0
	
Costo1
	ADD R0, R2	
	VADD.F32 S2, S0		;Sumar 0.5 por cada minuto
 	CMP R0,R1			
    BEQ Loop

	CMP R0,R3			;Si el costo es mayor a 3, cobrar 0.1	
    BEQ Costo2
	
	BLO Costo1 
	
Costo2; 
	ADD R0, R2	
	VADD.F32 S2, S1		;Sumar 0.1 por cada minuto
	CMP R0,R1			
    BEQ Loop
	BLO Costo2 
	
Loop						; Ciclo infinito.
	B Loop
	
	ALIGN
	END