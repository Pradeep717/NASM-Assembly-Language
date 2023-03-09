%macro displayText 2

	mov rax,4
	mov rbx,1
	mov rcx,%1
	mov rdx,%2
	int 0x80
%endmacro

%macro getInput 2

	mov rax,3
	mov rbx,0
	mov rcx,%1
	mov rdx,%2
	int 0x80
	
%endmacro



section .data    
	; Initialize numbers
    	number3 db '0000' 
    	size3 equ $ - number3
    	number4 db '0000' 
    	size4 equ $ - number4
    	number5 db '3641'
    	size5 equ $ - number5
    
    	; Initialize new line character
	newline db 10
	newline_len equ $-newline
	
	; Initialize messages
	message0 db "All initialized values befor getting user inputs ",0,10
	msg0size equ $-message0
	
	message1 db "Enter fist input for Number1   : ",0
	msg1size equ $-message1
	
	message2 db "Enter second input for Number2 : ",0
	msg2size equ $-message2
	
	message3 db 10,"Number1 : ",0
	msg3size equ $-message3
	
	message4 db 10,"Number2 : ",0
	msg4size equ $-message4
	
	message5 db 10,"Number3 : ",0
	msg5size equ $-message5
	
	message6 db 10,"Number4 : ",0
	msg6size equ $-message6
	
	message7 db "Summation of Number3 and Number4 : ",0
	msg7size equ $-message7
	
	message8 db "Registration number : EG/2019/3641",0,10
	msg8size equ $-message8
	
	message9 db 10,"Number5 : ",0
	msg9size equ $-message9
	
	message10 db "Summation of Number3 and Number5 : ",0
	msg10size equ $-message10
	

section .bss
	result resb 5,
	result2 resb 5,
	number1 resb 5,
	number2 resb 5,
	
section .text
global _start
_start:

	;Textlables
	; Display registration number
	displayText message8,msg8size
	displayText newline, newline_len

	; Initialize numbers
	mov dword [number1],'XXXX'
	mov dword [number2],'XXXX'
	
    	; Display initial values
    	displayText message0,msg0size
    	
    	displayText message3,msg3size
    	displayText number1, 5
    	
    	displayText message4,msg4size
    	displayText number2, 5
    	
    	displayText message5,msg5size
    	displayText number3, 4 
    	
    	displayText message6,msg6size
    	displayText number4, 4
    	
    	displayText message9,msg9size
    	displayText number5, 4
    	
    	; Get user inputs
    	displayText newline, newline_len
    	displayText newline, newline_len
    	displayText message1,msg1size
    	getInput number1,5
    	displayText message2,msg2size
    	getInput number2,5
    	
    	
    	xor rax,rax
    	xor rbx,rbx
    	mov rsi,3
    	mov rcx,3	
	
add_digitsInNum1:
	mov al,byte[number1+rsi]
	cmp al,'0'
	jl skipchar1
	cmp al,'9'
	jg skipchar1
	sub al,'0'
	add [number3+rcx],al
	dec rcx

skipchar1:
	dec rsi
	cmp rsi,0
	jge add_digitsInNum1
	
	
	xor rax,rax
    	xor rbx,rbx
    	mov rsi,3
    	mov rcx,3	
	
add_digitsInNum2:
	mov al,byte[number2+rsi]
	cmp al,'0'
	jl skipchar2
	cmp al,'9'
	jg skipchar2
	sub al,'0'
	add [number4+rcx],al
	dec rcx

skipchar2:
	dec rsi
	cmp rsi,0
	jge add_digitsInNum2
	
	displayText message5,msg5size
    	displayText number3, 4 
    	
    	displayText message6,msg6size
    	displayText number4, 4
	
	
    	xor rax,rax
    	xor rbx,rbx
    	mov rsi, 3
	mov cl, 0
	mov r8,0
	
ADDNEXT:
	mov al,[number3+rsi]
	sub al,'0'
	add al,[number4+rsi]
	add al,cl
	mov cl,0
	cmp al,58
	jge innerloop1
	jmp NOCARRY
	
innerloop1:
	sub al,10
	mov cl,1
	cmp rsi,0 
	je innerloop2
	jmp NOCARRY
	
innerloop2:
	mov byte[result],'1'
	mov cl,0
	jmp NOCARRY
	

NOCARRY:
	mov [result+rsi+1],al
	dec rsi
	cmp rsi,0
	jge change
	
	displayText newline, newline_len
	
	call text
	displayText result, 5
	displayText newline, newline_len
	
	xor rax,rax
    	xor rbx,rbx
    	mov rsi, 5
	mov cl, 0
	
loop: 
	mov byte[result+rsi],0
	dec rsi
	cmp rsi,0
	jge loop
	
	xor rax,rax
    	xor rbx,rbx
    	mov rsi, 3
	mov cl, 0
	add r8,1
	cmp r8,1
	je ADDNEXT2
	call exit

ADDNEXT2:
    	
	mov al,[number3+rsi]
	sub al,'0'
	add al,[number5+rsi]
	add al,cl
	mov cl,0
	cmp al,58
	jge innerloop1
	jmp NOCARRY

change: 
	cmp r8,1
	je ADDNEXT2
	call ADDNEXT
	ret
	
text:
	cmp r8,1
	je sumNum3_num5
	call sumNum3_num4
	ret
	
sumNum3_num4:
	displayText message7,msg7size
	ret
	
sumNum3_num5:
	displayText message10,msg10size
	ret
	

exit:
	mov rax,1
	mov rbx,0
	int 0x80


