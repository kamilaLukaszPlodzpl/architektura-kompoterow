	ifndef	??version
?debug	macro
	endm
publicdll macro	name
	public	name
	endm
	endif
	?debug	V 300h
	?debug	S "TEST.C"
	?debug	C E9AEB1894E06544553542E43
_TEXT	segment byte public 'CODE'
_TEXT	ends
DGROUP	group	_DATA,_BSS
	assume	cs:_TEXT,ds:DGROUP
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
_BSS	ends
_TEXT	segment byte public 'CODE'
	?debug	C E80106544553542E43AEB1894E
   ;	
   ;	int x(int b)
   ;	
	?debug	L 1
	assume	cs:_TEXT
_x	proc	near
	?debug	B
	push	bp
	mov	bp,sp
	?debug	C E60162040A040000
	?debug	B
   ;	
   ;	{
   ;		return b;
   ;	
	?debug	L 3
	mov	ax,word ptr [bp+4]
	jmp	short @1@58
@1@58:
   ;	
   ;	}
   ;	
	?debug	L 4
	pop	bp
	ret	
	?debug	C E60162040A040000
	?debug	E
	?debug	E
_x	endp
   ;	
   ;	int main()
   ;	
	?debug	L 5
	assume	cs:_TEXT
_main	proc	near
	?debug	B
	push	bp
	mov	bp,sp
	sub	sp,2
	?debug	B
   ;	
   ;	{
   ;		int a = 5;
   ;	
	?debug	L 7
	mov	word ptr [bp-2],5
   ;	
   ;		return 0;
   ;	
	?debug	L 8
	xor	ax,ax
	jmp	short @2@58
@2@58:
   ;	
   ;	}
   ;	
	?debug	L 9
	mov	sp,bp
	pop	bp
	ret	
	?debug	C E601610402FEFF00
	?debug	E
	?debug	E
_main	endp
	?debug	C E9
	?debug	C FA00000000
_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
_TEXT	segment byte public 'CODE'
_TEXT	ends
	public	_main
	public	_x
_s@	equ	s@
	?debug	C EA0109
	?debug	C E31800000023040000
	?debug	C EC055F6D61696E181800
	?debug	C E31900000023040000
	?debug	C EC025F78191800
	end
