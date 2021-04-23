	AREA codigo, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT Start

Start						
	VLDR.F32 S0, =0			
    VLDR.F32 S1, =15			
	VLDR.F32 S2, =1			
	VLDR.F32 S3, =0			
	VLDR.F32 S4, =0		
	VLDR.F32 S5, =2		
	VLDR.F32 S6, =1		
	
	VLDR.F32 S7, =-1		

	VLDR.F32 S10, =5		; X (azimut en radianes)
	VLDR.F32 S19, =1000		; Coordenada de referencia
	VLDR.F32 S20, =10		; Distancia en metros
	
	VLDR.F32 S11, =1			
	VLDR.F32 S14, =0
	VLDR.F32 S15, =0
	VLDR.F32 S16, =0
	VLDR.F32 S16, =0	
	
COSENO
	VADD.F32 S0,S2			; Aumentar en 1 n

	VMUL.F32 S3 , S0 , S5
	BL factorial 			; 2n!
		
	VLDR.F32 S8, = 0 		; Contador subrutina Potencia.
	VLDR.F32 S9, = 1  		; S9 contendrá el valor de la potencia.
	BL potencia 			; (-1)^n

    VMUL.F32 S11, S5 , S0 	; 2n
	VLDR.F32 S12, = 0	 	; Contador subrutina Potencia.
	VLDR.F32 S13, = 1  		; S13 contendrá el valor de la potencia.
	BL potencia2 			; (x)^2n
	
	VMUL.F32 S14 , S13 , S9 ; (-1)^n * (x)^2n
	VDIV.F32 S15, S14 , S6  ; [(-1)^n * (x)^2n]/2n!
	VADD.F32 S16, S15;      ; Se acumula la sumatoria

	
	VCMP.F32 S0,S1			; Comparar si n llego al limite superior
	VMRS APSR_nzcv, FPSCR
	BLO COSENO 
	
Start2					   
	VADD.F32 S17,S2,S16
	VLDR.F32 S0, =0			; Valor de n.
	VLDR.F32 S2, =1			
	VLDR.F32 S3, =0			
	VLDR.F32 S4, =0			
	VLDR.F32 S5, =2		
	VLDR.F32 S6, =0		
	VLDR.F32 S7, =1		
	VLDR.F32 S8, =-1		
	VLDR.F32 S15, =0
	VLDR.F32 S16, =0
	VLDR.F32 S18, =0	
	
SENO
	VADD.F32 S0,S2			; Aumentar en 1 n
    
	VMUL.F32 S3 , S0 , S5   ; 2n
	VADD.F32 S4 , S3 , S2	; 2n +1
	BL factorial2 			; (2n + 1)!

	VLDR.F32 S11, = 0 		; Contador subrutina Potencia.
	VLDR.F32 S12, = 1  		; S12 contendrá el valor de la potencia.
	BL potencia3 			; (-1)^n
	
	VLDR.F32 S13, = 0 		; Contador subrutina Potencia.
	VLDR.F32 S14, = 1  		; S14 contendrá el valor de la potencia.
	BL potencia4 			; x^(2n+1)
	
	VMUL.F32 S15 , S12 , S14
	VDIV.F32 S16, S15 , S7
	VADD.F32 S18, S16
	
	VCMP.F32 S0,S1			; Comparar si n llego al limite superior
	
	
	VMRS APSR_nzcv, FPSCR
	BLO SENO 	

AzimutACoordenadas
	VADD.F32 S18,S10
	VMUL.F32 S21, S20 , S18
	VMUL.F32 S22, S20 , S17
	VADD.F32 S23, S19 , S21   ;Coordenada X
	VADD.F32 S24, S19 , S22	  ;Coordenada Y
Loop					   
	
	B Loop


factorial 
	VADD.F32 S4,S2  
    VMUL.F32 S6,S4
	VCMP.F32 S4,S3	
	VMRS APSR_nzcv, FPSCR
	BNE factorial	
	BX LR	

potencia 
    VMUL.F32 S9, S7
	VADD.F32 S8, S2
	VCMP.F32 S8, S0; 
	VMRS APSR_nzcv, FPSCR
	BNE potencia; 
	BX LR; 

potencia2
    VMUL.F32 S13, S10
	VADD.F32 S12, S2
	VCMP.F32 S12, S11; 
	VMRS APSR_nzcv, FPSCR
	BNE potencia2; 
	BX LR; 
	
	
factorial2 
	VADD.F32 S6,S2  
    VMUL.F32 S7,S6
	VCMP.F32 S6,S4	
	VMRS APSR_nzcv, FPSCR
	BNE factorial2	
	BX LR	
	
potencia3
    VMUL.F32 S12, S8
	VADD.F32 S11, S2
	VCMP.F32 S11, S0; 
	VMRS APSR_nzcv, FPSCR
	BNE potencia3; 
	BX LR; 	
	
potencia4
    VMUL.F32 S14, S10
	VADD.F32 S13, S2
	VCMP.F32 S13, S4; 
	VMRS APSR_nzcv, FPSCR
	BNE potencia4; 
	BX LR; 		
	
	
	
	
	ALIGN
	END