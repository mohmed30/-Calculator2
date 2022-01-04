  
.386
	.model flat,stdcall
	.stack 4096
	ExitProcess PROTO, dwExitCode:DWORD
	
include C:\irvine\Irvine32.inc

	
  
  .date
                Zero = 0
		MAX = 100                             ; maximum characters of the equation
		stringIn BYTE MAX+1 DUP(?), 0         ; input equation 
		string1 BYTE MAX+1 DUP(?), 0          
		string2 BYTE MAX+1 DUP(?), 0
		SYM_ADD BYTE '+'                       ;store char + in memory 
		SYM_SUB BYTE '-'                       
		SYM_MUL BYTE '*'
		SYM_DIV BYTE '/'
		CURR_SYM_ADD BYTE '+'
		CURR_SYM_MUL BYTE '*'
		RES_ADD DWORD 0
		RES_MUL DWORD 1
		PARSE_RES DWORD 0
		errorChick DWORD 1
		errorMag  db 'Math Error can not divide by zero please Enter the right equation',0
		
.code

 main PROC                                
          lea edx, stringIn                    ;move offset address of stringIn to edx
	  mov ecx, MAX+1                       ;move MAX+1  to ecx it max string can be writen 
	  call ReadString                      ;it Reads a string of up to ECX non-null characters from input, stopping when the user presses the Enter key.
	  call splitByAdd	               
 
 main ENDP
 ;*******************************************************************************************
 ;Splitbyadd check all index until we found -or + operation 
 ;then splitbymul is called After return we check again all index after -or + operationAnd execute other operations
; *******************************************************************************************
 splitByAdd PROC
 
	   xor esi, esi                               ; make esi = zero
	   xor edi, edi                               ; make edi =zero 
	
	LOOP1:
		  mov cl, [edx + esi]                  ; mov  data segment memory location addressed by edx and esi to cl
		  CMP cl, 0                            ;compare cl with 0
		  JE End_Cont                          ; if equal jum to End_Cont
		  cmp cl, SYM_ADD                      ;compare cl with '+'   
		  JE ADD_Cont                          ;if equal jum to ADD_Cont         
		  cmp cl, SYM_SUB                      ;compare cl with SYM_SUB
		  JE SUB_Cont                          ;if equal jum to SUB_Cont
		  mov [string1 + edi], cl              ; mov cl to data segment memory location addressed by string1 and  edi
		  Inc_lbl: inc esi                     ;esi =esi+1 
		  inc edi                              ;edi=edi+1
		  JMP LOOP1 
 ;**********************************************************************************************************************
  ;this function calculate the blocks before and after this '+' sign then, it executes the adding operation
 ;**********************************************************************************************************************
	ADD_Cont:
		  push esi                               ; push all register which we need there valus later       
		  push edi
		  push edx
		  push ecx
		  call splitByMul
		  pop ecx                            ; pop all register because we back to function again    
		  pop edx
		  pop edi
		  pop esi
		  cmp CURR_SYM_ADD, '+'           ; compare CURR_SYM_ADD with '+' 
		  JE ADD_RES                      ;if equal jump to ADD_RES
		  MOV EAX, RES_MUL                ; not,, move RES_MUL to EAX 
		  SUB RES_ADD, EAX                ;Subtract RES_ADD from EAX
		  JMP Cont_ADD	                  ; jump to Cont_ADD
		
	ADD_RES:
           MOV EAX , RES_MUL         ;MOVE THE CONTENT IN RES_MUL INTO EAX REGISTRY
           ADD RES_ADD , EAX         ;ADDS THE TWO OPREANDS (EAX & RES_ADD) TOGETHER
           Cont_ADD : 
           MOV CURR_SYM_ADD, '+'     ;COPIES THE + SYMBOL INTO CURR_SYM_ADD
           MOV edi , -1              ;RESETS THE POINTER TO -1 OF THE PREVIOUS ADDRESS
           push EAX                  ;PRESERVE THE VALUE OF EAX 
           call resetstring1         ;RESETSTRING1 IS CALLED WHICH WILL PUT RETURN VALUE IN EAX
           pop eax                   ;RESTORES ORIGINAL EAX
           JMP Inc_lb1               ;JUMP INTO Inc_lb1
	   
 ;**********************************************************************************************************************
  ;this function calculate the blocks before and after this '-' sign then, it executes the subtracting process.
 ;**********************************************************************************************************************
 
	SUB_Cont:
	   push esi
	   push edi
	   push edx
	   push ecx
	   call splitByMul
	   pop ecx
	   pop edx
	   pop edi
	   pop esi
	   cmp CURR_SYM_ADD, '+'
	   JE ADD_RES2
	   MOV EAX, RES_MUL
	   SUB RES_ADD, EAX
	   JMP Cont_SUB
	   ADD_RES2:
	   MOV EAX, RES_MUL
	   ADD RES_ADD, EAX
	   Cont_SUB:
	   MOV CURR_SYM_ADD, '-'
	   MOV edi, -1
	   push eax
	   call resetstring1
	   pop eax
	   JMP Inc_lbl
	
	   
	End_Cont:
                  push esi       ;store value of the registers needed in splitbymul process
	          push edi       
		  push edx
		  push ecx
		  call splitByMul         
		  pop ecx                ;restore the values after the process
		  pop edx
		  pop edi
		  pop esi
		  cmp CURR_SYM_ADD, '+'    
		  JE ADD_RES3
		  MOV EAX, RES_MUL
		  SUB RES_ADD, EAX
		  JMP Cont_F2
		  
		  ADD_RES3:
		  MOV EAX, RES_MUL
		  ADD RES_ADD, EAX

	Cont_F2:
		  MOV CURR_SYM_ADD, '+'
		  push eax
		  call resetstring1
		  pop eax
		  ret
 
 splitByAdd ENDP 
 
 splitByMul PROC
 
		 MOV RES_MUL, 1
		 xor esi, esi                     ; make esi = zero 
		 xor edi, edi
		 xor ebx, ebx
		 xor ecx, ecx
		 lea edx, string2                 ; move offeset address of string2  to edx
		 
	LOOP2:
		 mov bl, [string1 + esi]
		 cmp bl, SYM_MUL
		 JE MUL_Cont
		 cmp bl, SYM_DIV
		 JE DIV_Cont
		 CMP bl, 0
		 JE End_Cont2
		 mov [string2 + edi], bl
		 inc ecx
		 Inc_lb2:
		 inc esi
		 inc edi
	       	 JMP LOOP2
		 
	 MUL_RES:
		 IMUL RES_MUL
		 MOV RES_MUL, EAX
		 Cont_MUL:
		 MOV CURR_SYM_MUL, '*'
		 MOV edi, -1
		 MOV ecx, 0
		 push eax
		 call resetstring2
		 pop eax
		 JMP Inc_lb2
		 
       
 
 
 splitByMul ENDP


 
