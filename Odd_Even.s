;Program to find number in R1 is even or odd. R3 contains 0DD if odd else 'E

	 AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION	
	
		MOV R1,#8	;Number 1
		MOV R2,#2		
		UDIV R0,R1,R2
		MLS R0,R0,R2,R1
		CMP R0,#1
		ITE EQ
		MOVEQ R3,#0X0DD
		MOVNE R3,#0X0E
		
stop B stop ; stop program
     ENDFUNC
     END