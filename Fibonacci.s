;#Program to generate the Fibonacci series. R3 contains the generated series when program is running. Complete
;series can be seen from Memory location mentioned.

	 AREA     appcode, CODE, READONLY
     EXPORT __main
	 ENTRY
SIZE EQU 9;				;No of elements in series
Memory	EQU	0X20000000	;Starting address of series	
__main  FUNCTION	
		MOV R5,#Memory
		MOV R1,#0
		MOV R2,#1		
		MOV R3,#0		;R3 contains the element of the series when loop is running
		MOV R4,#0		
LOOP	CMP R4,#SIZE	;no of elements in the series
		ADD R3,R1,R2
		MOV R1,R2
		MOV R2,R3
		STRB R3,[R5,R4];
		ADD R4,#1
		BLE LOOP

stop B stop ; stop program
     ENDFUNC
     END