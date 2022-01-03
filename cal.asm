 include irvine32.inc
.386
	.model flat,stdcall
	.stack 4096
	ExitProcess PROTO, dwExitCode:DWORD

	
  
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

 main PROC                                ; main function
          lea edx, stringIn               
	  mov ecx, MAX+1
	  call ReadString
	  call splitByAdd	
 
 main ENDP
 
 splitByAdd PROC
 
	   xor esi, esi
	   xor edi, edi
	
	LOOP1:
		  mov cl, [edx + esi]
		  CMP cl, 0
		  JE End_Cont
		  cmp cl, SYM_ADD
		  JE ADD_Cont
		  cmp cl, SYM_SUB
		  JE SUB_Cont
		  mov [string1 + edi], cl
		  Inc_lbl: inc esi
		  inc edi
		  JMP LOOP1
		  
	ADD_Cont:
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
		  JE ADD_RES
		  MOV EAX, RES_MUL
		  SUB RES_ADD, EAX
		  JMP Cont_ADD	 
		
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
 
 splitByAdd ENDP 
 
