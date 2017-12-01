;* Circular queue--
;* Step 1: Enques 8 elements into queue of size 5 but only 5 elements will be dumped into queue.
;* Step 2: Dequeues 3 elements into queue.
;* Step 3: Enques 3 more elements into queue
;* Step 4: Dequeues until queue is empty.
;---------------
;* Register R9 for Dequeued element.
;* Memory location 0x21000000 is Queue Memory location.
	PRESERVE8
     THUMB
     AREA     appcode, CODE, READONLY
     EXPORT __main
SIZE EQU 4 ; Let the size of queue is 5
QUEUE EQU 0X20000000 ; Let the starting address of queue be 0x20000000 
	 ENTRY 
__main  FUNCTION	
        MOV R0, #SIZE ;  A queue of 5 bytes size
		MOV R1, #QUEUE;  Queue Base address
		MOV R2, #-1; 	 Points to the head of the queue relative to queue base address, Means empty queue
		MOV R3, #-1;	 Points to the tail fo the queue relative to queue base address, Means empty queue
		MOV R4, R1;
		MVN R5, #0;      Loop to fill all the location in the queue to 0XFFFF FFFF
		MVN R6, #0;
		MOV R8, #0xFF;
		MOV R11, #0xFF;
INIT	STRB R5, [R4], #1; 
		ADD R6, R6, #1;
		CMP R6, R0
		BNE INIT
		
		MOV R7, #5; 	 Random data generation to fill the queue, series 5,6,7,8,9
		
		;STEP 1
		
INSERT	BL ENQUEUE;		 		Enqueue element 
		ADD R7, R7, #1;			Increment data
		CMP R7,#12;		 		Loop tries to enqueue from 5 to 12, since queue size is 5 only 5-9 will be inserted
		BNE INSERT;
		
		;STEP 2
		BL DEQUEUE;				Check register r9 for dequed element
		BL DEQUEUE;
		BL DEQUEUE;
		
		;STEP 3
		MOV R7, #22;
		BL ENQUEUE;
		ADD R7, R7, #1;
		BL ENQUEUE;
		ADD R7, R7, #1;
		BL ENQUEUE;
		
		;STEP 4
EXIT	BL DEQUEUE;
		B EXIT
		
		B stop;					Stop the Program
		
	
ENQUEUE CMP R3, R0;				Compare if the queue is full
		MOVEQ R3,#0;			Go to the start of the queue
		CMN R0, R3;
		ADDEQ R3, R3,#1;
		LDRB R8,[R1,R3];		Load value in that location
		CMP R8, #0XFF;			Check if it 0xffff ffff
		ADDEQ R3, R3, #1;			If it is empty location
		STRBEQ R7, [R1, R3];	Start filling the queue
		CMP R2, #-1;			Compare if head still points to null 
		ADDEQ R2, R2, #1; 		Now head points to first element, As it is no more empty queue 
		MOV PC, R14;				Return to callee
		
DEQUEUE CMP R2, #-1;			Compare if the queue is empty
		BEQ stop;				Stop the program if it is empty
		LDRB R9,[R1,R2];		Load the data into register R9
		STRB R11,[R1,R2];		Store 0xfffffff in the empty location
		CMP R2,#4;
		ADD	R2,R2,#1;			Now head points to next location in queue
		MOVGE R2,#-1;
		MOV PC, R14;
		
		
		
stop B stop ; stop program
     ENDFUNC
     END