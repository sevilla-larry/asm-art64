; Listing 4-3

; Demonstration of calls
; to C standard library malloc
; and free functions.

		option casemap:none

nl		=		10

		.const
ttlStr	byte	"Listing 4-3", 0
fmtStr	byte	"Addresses returned by malloc:", nl
		byte	"%ph", nl
		byte	"%ph", nl, 0

		.data
ptrVar	qword	?
ptrVar2	qword	?

		.code
		externdef printf:proc
		externdef malloc:proc
		externdef free:proc

; Return program title to C++ program:

			public getTitle
getTitle	proc
			lea rax, ttlStr
			ret
getTitle	endp


; Here is the "asmMain" function.

			public asmMain
asmMain		proc

; "Magic" instruction offered without
; explanation at this point:

			sub		rsp, 56

; C standard library malloc function.

; ptr = malloc(byteCnt);

			mov		rcx, 256		; Allocate 256 bytes
			call	malloc
			mov		ptrVar, rax		; Save pointer to buffer
			
			mov		rcx, 1024		; Allocate 1024 bytes
			call	malloc
			mov		ptrVar2, rax	; Save pointer to buffer

			lea		rcx, fmtStr
			mov		rdx, ptrVar
			mov		r8, rax			; Print addresses
			call	printf

; Free the storage by calling
; C standard library free function.

; free(ptrToFree);

			mov		rcx, ptrVar
			call	free

			mov		rcx, ptrVar2
			call	free


			add rsp, 56
			ret ; Returns to caller

asmMain		endp
			end
