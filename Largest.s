;Program to find largest of three numbers. R1,R2 & R3 contains three numbers. R4 holds the largest number at end.
	 AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY 
__main  FUNCTION	
	
		MOV R1,#11
		MOV R2,#8		
		MOV R3,#3		
		MOV R4,#0
		CMP R1,R2
		BGT ITE1
		BLE ITE2
		
ITE1    CMP R1,R3
		MOVGT R4,R1
		MOVLE R4,R3
		B stop
		
ITE2	CMP R2,R3
		MOVGT R4,R2
		MOVLE R4,R3
		B stop
		
stop B stop ; stop program
     ENDFUNC
     END