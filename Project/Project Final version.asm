.ORIG	x3000		;ORIGINATION ADDRESS
    
LEA R0, INSTRUCTIONS 	;prints string in sort
PUTS
AND R0, R0, #0      	;Print newline TO 
ADD R0, R0, #10     	;#10 = ascii for newline
OUT			;Write a char in R0 to screen
AND R0, R0, #0
JSR ASK4INPUT		;jumps to ASK4INPUT

JSR BUBBLESORT		;jumps to BUBBLESORT
AND R0, R0, #0      	;Print newline
ADD R0, R0, #10     	;#10 = ascii for newline
OUT			;Write a char in R0 to screen
AND R0, R0, #0
LEA R0, SORT		;prints string in sort
PUTS			;displays on console
AND R0, R0, #0      	;clear register
ADD R0, R0, #10     	;#10 = ascii for newline
OUT			;Write a char in R0 to screen
AND R0, R0, #0		;clears R0
JSR PRNTNUMS		;jumps to prntnums subroutine	
HALT			;Stop execution

STOP 			;can be called later to end program similar to flag
	HALT		;Stop execution

ASK4INPUT				;ask user for input

	ST R7, TEMP			;write data from register to memory
        JSR SAVREG			;jumps to SAVREG
        AND R1, R1, #0          	; Counter
	LEA R0, CONSOLE			;compute address,save in register
        PUTS				;displays on console
    	AND R0, R0, #0      		;clears R0
    	ADD R0, R0, #10     		;#10 = ascii for newline
    	OUT				;Write a char in R0 to screen
        A4ILOOP
        AND R2, R2, #0
        ADD R2, R2, #-8
        ADD R2, R1, R2
        BRz EXITLOOP			;conditional branch
            
        JSR SAVREG			;jump to SAVREG
        JSR GETINPUT			;jump to GETINPUT
        JSR LDREG			;jump to LDREG
        LD R0, INTARRY
        ADD R0, R0, R1
        LD R2, RESULT
        LDR R2, R2, #0
        STR R2, R0, #0
        ADD R1, R1, #1
        BR A4ILOOP
        EXITLOOP
        JSR LDREG			;jump to LDREG
        LD R7, TEMP			;read data from TEMP2 to register
RET					;JMP R7

GETINPUT

        ST R7, TEMP2
        JSR SAVREG
        AND R1, R1, #0          	;Store result in R1
        GILOOP
        AND R2, R2, #0      		;TEMP2 storage
        GETC                		;Get Char 
        OUT                 
        ADD R2, R0, #-10    		;If R0 == 10 then break
        BRz EXITGILOOP  		;condition for EXITGILOOP
        AND R2, R2, #0      		;Reinitialize R2
        ADD R2, R2, R0      		;R2 = R0
        ADD R2, R2, #-16    		;ASCII Offset
        ADD R2, R2, #-16    
        ADD R2, R2, #-16    
        BRn STOP           		;Error not an ASCII value of 48 or higher
        ADD R2, R2, #-9     		;Checking if ascii value is higher than 47
        BRp STOP           		;Error not an ASCII value of 57 or lower
        ADD R2, R2, #9      		;Peserving ACII value
        LD R3, MULTX       		;Load x3101
        LD R4, MULTY       		;Load x3102
        AND R5, R5, #0      		;Clear R5
        ADD R5, R5, xA      		;R5 = 10
        STR R1, R3, #0      		;Store value of R1 at address hold by R3
        STR R5, R4, #0      		;Store value of R5 at address hold by R4
        JSR SAVREG        		;jump to SAVREG
        JSR MULT            		;Jump to subroutine MULT
        JSR LDREG        		;Load registers
        LD R3, MULTR       		;Load x3103
        LDR R3, R3, #0      		;Load value from address to R3
        ADD R1, R3, R2      		;R1 = 10 * R1 + R2
        BR GILOOP
        EXITGILOOP			;condition met moves program here
        LD R2, RESULT    		;Store result at x3100
        STR R1, R2, #0          	;write data from register to memory
        JSR LDREG            		;jump to LDREG
        LD R7, TEMP2			;read data from TEMP2 to register
RET					;JMP R7

MULT

        LD R0, MULTX			;load MULTX to R0
        LDR R0, R0, #0
        LD R1, MULTY   			;Counter
        LDR R1, R1, #0
        AND R2, R2, #0  		;Result 
        MULTLOOP
        ADD R1, R1, #0
        BRnz MULTBREAK
        ADD R2, R2, R0
        ADD R1, R1, #-1
        BR MULTLOOP
        MULTBREAK
        LD R0, MULTR
        STR R2, R0, #0
RET					;JMP R7

SAVREG

        ST R7, TEMP2REG
        LD R7, STACK
        STR R0, R7, #0
        STR R1, R7, #1
        STR R2, R7, #2
        STR R3, R7, #3
        STR R4, R7, #4
        STR R5, R7, #5
        STR R6, R7, #6
        ADD R7, R7, #7
        LD R0, TEMP2REG
        STR R0, R7, #0
        ADD R7, R7, #1
        ST R7, STACK
        LD R7, TEMP2REG
RET					;JMP R7

LDREG

        ST R7, TEMP2REG         ; Store the current value of R7 as a TEMP2
        LD R7, STACK        	; Load the value at the top of the stack
        LD R0, EMPTY            ; Load the empty sentinel value 
        NOT R0, R0              ; Two's Complement
        ADD R0, R0, #1          
        LDR R1, R7 #0           ; Load the Value at the address hold by R7 in R1
        ADD R1, R1, R0          ; Add R1 and R0 together
        BRz LRBREAK            	;conditional branch looking for zero
        LDR R0, R7, #-8         ; Load R7 with an offset of -8 at R0
        LDR R1, R7, #-7         ; Load R7 with an offset of -7 at R1
        LDR R2, R7, #-6         ; Load R7 with an offset of -6 at R2
        LDR R3, R7, #-5         ; Load R7 with an offset of -5 at R3
        LDR R4, R7, #-4         ; Load R7 with an offset of -4 at R4
        LDR R5, R7, #-3         ; Load R7 with an offset of -3 at R5
        LDR R6, R7, #-2         ; Load R7 with an offset of -2 at R6
        LD R1, EMPTY            ; Load the value of empty sentinel
        STR R1, R7, #-1         ; Store the empty sentinel at the address hold by R7 with an offset of -1
        LDR R1, R7, #-7         ; Load the value from address hold by R7 with an offset of -7 at R7
        ADD R7, R7, #-8 
        ST R7, STACK
        LRBREAK  
        LD R7, TEMP2REG
RET				;JMP R7

BUBBLESORT

        ST R7, TEMP2      	;Save R7 into TEMP2
        JSR SAVREG        	;jump to SAVREG
        AND R1, R1, #0          ;Inintialize counter 1
        BUBSORTLOOP                            
        AND R3, R3, #0          ;Clear R3 
        ADD R3, R3, #-7      	;R3 = -7
        AND R4, R4, #0          ;Clear R4
        ADD R4, R3, R1          ;if counter1 < 7 then continue
        BRzp LOOPCOUNT          ;conditional branch
        AND R2, R2, #0          ;Inintialize counter 2
        BSLOOP
        AND R4, R4, #0          ;Clear R4
        ADD R4, R4, R1          ;R4 = R1
        NOT R4, R4              ;Two's complement of R4 (-R4)
        ADD R4, R4, #1          
        ADD R4, R4, #7          ;R4 = counter1 - 8
        NOT R4, R4              ;Two's complement
        ADD R4, R4, #1          
        ADD R4, R2, R4          ;counter2 - (counter1 - 7 - 1) < 0 or counter2 - counter1 + 8 < 0
        BRzp EXITBSL
        LD R0, INTARRY          ;Load value x3104
        ADD R0, R0, R2          ;x3104 + counter2
        LD R3, INTARRY          ;Load value x3104
        ADD R3, R3, R2          ;x3014 + counter2 + 1
        ADD R3, R3, #1          
        LDR R4, R0, #0          ;Load the value from address hold by R0 into R4 
        LDR R5, R3, #0          ;Load the value from address hold by R3 into R5
        AND R6, R6, #0          ;Clear R6
        ADD R6, R6, R5          ;R6 = R5
        NOT R6, R6              ;Two's Complement
        ADD R6, R6, #1          
        ADD R6, R4, R6          ;INTARRYAY[COUNTER1] - INTARRYAY[COUNTER2]
        BRnz BSI_GREATER_FALSE
        STR R4, R3, #0      	;Store address
        STR R5, R0, #0      	;Store address
        BSI_GREATER_FALSE  
        ADD R2, R2, #1          ;Increment counter2
        BR BSLOOP
        EXITBSL
        ADD R1, R1, #1      	;Increment coutnter1
        BR BUBSORTLOOP                     
        LOOPCOUNT
        JSR LDREG            	;jump to LDREG
        LD R7, TEMP2          	;Load R7 into TEMP2
RET				;JMP R7

DIV

        LDI R0, DIVX   		;x
        LDI R1, DIVY   		;y
        AND R5, R5, #0  	;Clear R5 > counter
        AND R6, R6, #0  	;Clear R6 > sign
        ADD R0, R0, #0
        BRn XNEG      		;if x < 0 then x = -x
        ISYNEG
        ADD R1, R1, #0
        BRn YNEG
        BR YNOTNEG     		;if y < 0 then y = -x
        XNEG
        NOT R0, R0
      	ADD R0, R0, #1
     	NOT R6, R6
       	ADD R6, R6, #1
       	BR YNEG
        YNEG
      	NOT R1, R1
      	ADD R1, R1, #1
       	NOT R6, R6
      	ADD R6, R6, #1
      	BR ISYNEG
        YNOTNEG
        NOT R1, R1      	;twos compliment
        ADD R1, R1, #1  	; 
        DIVLOOP
      	ADD R0, R0, R1  	;then  x = x - y
    	BRn XISNEG       	;if x <= 0
     	ADD R5, R5, #1  	;counter++
      	BRz XISZERO      	;then  break
      	BR DIVLOOP
        EXITDVLOOP
        ADD R0, R0, #0      	;LC3 Does not like two labels next to each other so
        XISNEG               	;Add back R1 because R0 is the remainder
     	NOT R1, R1
     	ADD R1, R1, #1
      	ADD R0, R0, R1
        XISZERO
  	ADD R6, R6, #0
     	BRnz NOTNEG
     	NOT R0, R0      	;x = -x
     	ADD R0, R0, #1  
      	NOT R5, R5      	;counter = -counter
      	ADD R5, R5, #1  
      	NOTNEG
     	STI R5, DIVZ
     	STI R0, DIVREM
RET 				;JMP R7
 
   
DIVX           	.FILL   	x3300
DIVY           	.FILL		x3301
DIVZ           	.FILL		x3302
DIVREM         	.FILL		x3303
RESULT   	.FILL		x3200
MULTX          	.FILL		x3201
MULTY          	.FILL		x3202
MULTR          	.FILL		x3203
INTARRY         .FILL		x3204   
TEMP2REG        .FILL		x340C
STACK       	.FILL		x340D
EMPTY           .FILL		xC000
TEMP2           .FILL		x0
TEMP           	.FILL		x0
SORT          	.STRINGZ	"Sorted list of numbers: "
INSTRUCTIONS    .STRINGZ	"Bubble Sort Program: "
CONSOLE         .STRINGZ	"Enter 8 numbers to be sorted: "
    

PRNTNUMS
   
        ST R7, TEMP2
        JSR SAVREG
        AND R1, R1, #0      	; Clear R1 
        ADD R1, R1, #10     	; R1 = 10
        STI R1, DIVY       	; Loading constant 10 in DIVY
        ADD R1, R1, #-10    	; Setting R1 back to zero -> counter   
        PRNTLOOP
 	ADD R0, R1, #-8         ; counter < 8
   	BRzp EXITPRNTLOOP
   	LD  R0, INTARRY     	; Pointer to number array
	ADD R0, R0, R1      	; Pointer offset
    	LDR R0, R0, #0      	; number = arr[counter]
   	I_PRINTLOOP        	; Highest number allowed is 100 so we need 3 registers
                                ; R0 and R1 are already in use so lets use R4, R5, R6 
                                ; to carry the 3 digits we need and lets user R5 and R6 
      	STI R0, DIVX
     	JSR SAVREG		;jump to SAVREG
     	JSR DIV			;jump to DIV
    	JSR LDREG		;jump to LDREG
    	LDI R0, DIVZ
    	LDI R4, DIVREM     
    	ADD R4, R4, #15     	;ASCII Offset
    	ADD R4, R4, #15     
 	ADD R4, R4, #15     
    	ADD R4, R4, #3      
   	ADD R0, R0, #0
    	BRz PRINTCH1		;conditional statement 
      	STI R0, DIVX
     	JSR SAVREG		;jump to SAVREG
      	JSR DIV			;jump to DIV
      	JSR LDREG		;jump to LDREG
  	LDI R0, DIVZ
   	LDI R5, DIVREM     
   	ADD R5, R5, #15     	;ASCII Offset
   	ADD R5, R5, #15     
    	ADD R5, R5, #15     
    	ADD R5, R5, #3      
     	ADD R0, R0, #0
     	BRz PRINTCH2		;conditional statement
     	STI R0, DIVX
     	JSR SAVREG		;jump to SAVREG
      	JSR DIV			;jump to DIV
    	JSR LDREG		;jump to LDREG
     	LDI R0, DIVZ
      	LDI R6, DIVREM     
     	ADD R6, R6, #15     	;ASCII Offset
      	ADD R6, R6, #15     
    	ADD R6, R6, #15     
  	ADD R6, R6, #3      
      	ADD R0, R6, #0     
     	OUT			;Write a char to screen
    	PRINTCH2		;branch if zero
     	ADD R0, R5, #0
     	OUT			;Write a char to screen
   	PRINTCH1		;branch if zero
      	ADD R0, R4, #0
  	OUT			;Write a char to screen
     	AND R0, R0, #0      	; Print newline
    	ADD R0, R0, #10     
    	OUT			;Write a char to screen

    	ADD R1, R1, #1      	; counter++
      	BR PRNTLOOP
        EXITPRNTLOOP
        JSR LDREG		;jump to LDREG
        LD R7, TEMP2		;Load R7 into TEMP2
RET				;JMP R7

.END