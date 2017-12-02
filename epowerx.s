;Program to create the exponential series e^x
;Ex: e^5=148.41315910
;As per IEEE 784 Standard S0 register should contain 0x431469c5, from this code you can see the output 0x431469c6
;Algo is 
;sum=1;temp=1
;while [ i < no_of_terms]
;temp=temp*power/i
;sum=sum+temp
;i++

	AREA     appcode, CODE, READONLY
	EXPORT __main
	ENTRY 
__main  FUNCTION	
	
	MOV R0,#20				;//Number of Terms which determines the accuracy
	VMOV.F32 S1,#5			;//Exponent Power		
	BL epower

epower  MOV R2,#1				;Loop Variable Register
		VMOV.F32 S3,#1.0		;Temporary Register
		VMOV.F32 S4,#1.0		;Sum Register
L1		CMP R0,R2
		VMULGE.F32 S3,S3,S1		;Mulitply temp=temp*power
		VMOV.F32 S5,R2			;Loop Variable need not be float,so copied into float register
		VCVT.F32.S32 S2,S5		;Conversion from signed 32 integer to float
		VDIVGE.F32 S3,S3,S2		;Division temp=temp*power/i
		VADDGE.F32 S4,S4,S3   	;Accumulation sum=sum+temp
		ADDGE R2,R2,#1
		BGE L1

	VMOV.F32 S0,S4				;//End result of Power series
	
stop B stop ; stop program
     ENDFUNC
     END