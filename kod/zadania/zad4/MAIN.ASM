	ifndef	??version
?debug	macro
	endm
publicdll macro	name
	public	name
	endm
$comm	macro	name,dist,size,count
	comm	dist name:BYTE:count*size
	endm
	else
$comm	macro	name,dist,size,count
	comm	dist name[size]:BYTE:count
	endm
	endif
	?debug	V 300h
	?debug	S "main.cpp"
	?debug	C E93481C64E086D61696E2E637070
	?debug	C E961B6664E19433A5C424F524C414E44435C494E434C5544455C64+
	?debug	C 6F732E68
	?debug	C E962B6664E1B433A5C424F524C414E44435C494E434C5544455C5F+
	?debug	C 646566732E68
	?debug	C E962B6664E1B433A5C424F524C414E44435C494E434C5544455C73+
	?debug	C 7464696F2E68
	?debug	C E962B6664E1C433A5C424F524C414E44435C494E434C5544455C5F+
	?debug	C 6E66696C652E68
	?debug	C E962B6664E1B433A5C424F524C414E44435C494E434C5544455C5F+
	?debug	C 6E756C6C2E68
	?debug	C E961B6664E1E433A5C424F524C414E44435C494E434C5544455C69+
	?debug	C 6F73747265616D2E68
	?debug	C E962B6664E19433A5C424F524C414E44435C494E434C5544455C6D+
	?debug	C 656D2E68
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
_bmfh	label	word
	db	14 dup (?)
_bmih	label	word
	db	40 dup (?)
_BSS	ends
_DATA	segment word public 'DATA'
_video_memory	label	dword
	db	0
	db	0
	db	0
	db	160
_DATA	ends
_TEXT	segment byte public 'CODE'
   ;	
   ;	void graphicsMode()
   ;	
	assume	cs:_TEXT
@graphicsMode$qv	proc	near
	push	bp
	mov	bp,sp
	sub	sp,20
   ;	
   ;	{
   ;	    REGPACK regs; 
   ;	    regs.r_ax = 0x13;
   ;	
	mov	word ptr [bp-20],19
   ;	
   ;	    intr(0x10, &regs);
   ;	
	lea	ax,word ptr [bp-20]
	push	ax
	mov	ax,16
	push	ax
	call	near ptr _intr
	pop	cx
	pop	cx
   ;	
   ;	}
   ;	
	mov	sp,bp
	pop	bp
	ret	
@graphicsMode$qv	endp
   ;	
   ;	void textMode()
   ;	
	assume	cs:_TEXT
@textMode$qv	proc	near
	push	bp
	mov	bp,sp
	sub	sp,20
   ;	
   ;	{
   ;	    REGPACK regs; 
   ;	    regs.r_ax = 0x10;
   ;	
	mov	word ptr [bp-20],16
   ;	
   ;	    intr(0x10, &regs);
   ;	
	lea	ax,word ptr [bp-20]
	push	ax
	mov	ax,16
	push	ax
	call	near ptr _intr
	pop	cx
	pop	cx
   ;	
   ;	}
   ;	
	mov	sp,bp
	pop	bp
	ret	
@textMode$qv	endp
   ;	
   ;	void setColorsPallete()
   ;	
	assume	cs:_TEXT
@setColorsPallete$qv	proc	near
	push	bp
	mov	bp,sp
   ;	
   ;	{
   ;	    outportb(0x03C8, 0); //rozpocznij ustawianie palety od koloru nr 0
   ;	
	mov	dx,968
	mov	al,0
	out	dx,al
   ;	
   ;		for (int i = 0; i < 256; i++)
   ;	
	xor	cx,cx
	jmp	short @3@114
@3@58:
   ;	
   ;		{
   ;			outp(0x03C9,i * 63 / 255);//R
   ;	
	mov	al,cl
	mov	ah,0
	mov	dx,63
	imul	dx
	mov	bx,255
	cwd	
	idiv	bx
	mov	dx,969
	out	dx,al
   ;	
   ;			outp(0x03C9,i * 63 / 255);//G
   ;	
	mov	al,cl
	mov	ah,0
	mov	dx,63
	imul	dx
	mov	bx,255
	cwd	
	idiv	bx
	mov	dx,969
	out	dx,al
   ;	
   ;			outp(0x03C9,i * 63 / 255);//B
   ;	
	mov	al,cl
	mov	ah,0
	mov	dx,63
	imul	dx
	mov	bx,255
	cwd	
	idiv	bx
	mov	dx,969
	out	dx,al
	inc	cx
@3@114:
	cmp	cx,256
	jl	short @3@58
   ;	
   ;		}
   ;	}
   ;	
	pop	bp
	ret	
@setColorsPallete$qv	endp
   ;	
   ;	int printBitmap(const char* fileName)
   ;	
	assume	cs:_TEXT
@printBitmap$qpxzc	proc	near
	push	bp
	mov	bp,sp
	sub	sp,8
	push	si
	push	di
   ;	
   ;	{
   ;	    FILE *bmpFile = fopen(fileName, "rb");
   ;	
	mov	ax,offset DGROUP:s@
	push	ax
	push	word ptr [bp+4]
	call	near ptr _fopen
	pop	cx
	pop	cx
	mov	si,ax
   ;	
   ;	    if (bmpFile == NULL)
   ;	
	or	si,si
	jne	short @4@114
   ;	
   ;	    {
   ;	        cout << "Nie udalo sie otworzyc pliku: " << fileName << " !\n";
   ;	
	xor	ax,ax
	push	ax
	mov	ax,offset DGROUP:s@+3
	push	ax
	mov	ax,offset DGROUP:_cout
	push	ax
	call	near ptr @ostream@outstr$qpxzct1
	add	sp,6
	mov	ax,word ptr [bp+4]
	mov	word ptr [bp-2],ax
	xor	ax,ax
	push	ax
	push	word ptr [bp-2]
	mov	ax,offset DGROUP:_cout
	push	ax
	call	near ptr @ostream@outstr$qpxzct1
	add	sp,6
	xor	ax,ax
	push	ax
	mov	ax,offset DGROUP:s@+34
	push	ax
	mov	ax,offset DGROUP:_cout
	push	ax
	call	near ptr @ostream@outstr$qpxzct1
	add	sp,6
   ;	
   ;	        return 1;
   ;	
	mov	ax,1
@4@86:
	jmp	@4@310
@4@114:
   ;	
   ;	    }
   ;	    fread(&bmfh, sizeof(BITMAPFILEHEADER), 1 , bmpFile);
   ;	
	push	si
	mov	ax,1
	push	ax
	mov	ax,14
	push	ax
	mov	ax,offset DGROUP:_bmfh
	push	ax
	call	near ptr _fread
	add	sp,8
   ;	
   ;	    fread(&bmih, sizeof(BITMAPINFOHEADER), 1 , bmpFile);
   ;	
	push	si
	mov	ax,1
	push	ax
	mov	ax,40
	push	ax
	mov	ax,offset DGROUP:_bmih
	push	ax
	call	near ptr _fread
	add	sp,8
   ;	
   ;	    LONG size =  bmih.biWidth * bmih.biHeight;
   ;	
	mov	cx,word ptr DGROUP:_bmih+6
	mov	bx,word ptr DGROUP:_bmih+4
	mov	dx,word ptr DGROUP:_bmih+10
	mov	ax,word ptr DGROUP:_bmih+8
	call	near ptr N_LXMUL@
	mov	word ptr [bp-4],dx
	mov	word ptr [bp-6],ax
   ;	
   ;	    fseek(bmpFile,-size,2);
   ;	
	mov	ax,2
	push	ax
	mov	ax,word ptr [bp-4]
	mov	dx,word ptr [bp-6]
	neg	ax
	neg	dx
	sbb	ax,0
	push	ax
	push	dx
	push	si
	call	near ptr _fseek
	add	sp,8
   ;	
   ;	    for(WORD i = 0; i < size; i++)
   ;	
	xor	di,di
	jmp	short @4@198
@4@142:
   ;	
   ;	    {
   ;	        char color = fgetc(bmpFile);
   ;	
	push	si
	call	near ptr _fgetc
	pop	cx
	mov	byte ptr [bp-7],al
   ;	
   ;	        video_memory[(size-1)-i] = color;
   ;	
	mov	ax,word ptr [bp-6]
	dec	ax
	sub	ax,di
	les	bx,dword ptr DGROUP:_video_memory
	add	bx,ax
	mov	al,byte ptr [bp-7]
	mov	byte ptr es:[bx],al
	inc	di
@4@198:
	xor	ax,ax
	cmp	ax,word ptr [bp-4]
	jb	short @4@142
	jne	short @4@282
	cmp	di,word ptr [bp-6]
	jb	short @4@142
@4@282:
   ;	
   ;	    }
   ;	    fclose(bmpFile);
   ;	
	push	si
	call	near ptr _fclose
	pop	cx
   ;	
   ;	    return 0;
   ;	
	xor	ax,ax
	jmp	@4@86
@4@310:
   ;	
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
@printBitmap$qpxzc	endp
   ;	
   ;	int main()
   ;	
	assume	cs:_TEXT
_main	proc	near
	push	bp
	mov	bp,sp
	sub	sp,12
	push	si
	push	di
   ;	
   ;	{
   ;		WORD i = 0;
   ;	
	xor	si,si
   ;	
   ;	    char *fileName = "boat.bmp";
   ;	
	mov	di,offset DGROUP:s@+38
   ;	
   ;	    cout << "Podaj nazwe pliku: ";
   ;	
	xor	ax,ax
	push	ax
	mov	ax,offset DGROUP:s@+47
	push	ax
	mov	ax,offset DGROUP:_cout
	push	ax
	call	near ptr @ostream@outstr$qpxzct1
	add	sp,6
   ;	
   ;	    cin >> fileName;
   ;	
	push	di
	mov	ax,offset DGROUP:_cin
	push	ax
	call	near ptr @istream@$brsh$qpzc
	pop	cx
	pop	cx
   ;	
   ;	    cout << "\n";
   ;	
	xor	ax,ax
	push	ax
	mov	ax,offset DGROUP:s@+67
	push	ax
	mov	ax,offset DGROUP:_cout
	push	ax
	call	near ptr @ostream@outstr$qpxzct1
	add	sp,6
   ;	
   ;	    graphicsMode();
   ;	
	call	near ptr @graphicsMode$qv
   ;	
   ;	    setColorsPallete();
   ;	
	call	near ptr @setColorsPallete$qv
   ;	
   ;	    printBitmap(fileName);
   ;	
	push	di
	call	near ptr @printBitmap$qpxzc
	pop	cx
   ;	
   ;	
   ;	    char c = 'e';
   ;	
	mov	byte ptr [bp-1],101
@5@58:
   ;	
   ;	    do
   ;	    {
   ;	        c = cin.get();
   ;	
	mov	ax,offset DGROUP:_cin
	push	ax
	call	near ptr @istream@get$qv
	pop	cx
	mov	byte ptr [bp-1],al
   ;	
   ;	        switch(c)
   ;	
	mov	al,byte ptr [bp-1]
	cbw	
	cmp	ax,101
	je	short @5@198
	cmp	ax,109
	je	short @5@226
	jmp	@5@1262
@5@198:
   ;	
   ;	        {
   ;	            case 'e':
   ;	                textMode();
   ;	
	call	near ptr @textMode$qv
   ;	
   ;	                return 0;
   ;	
	xor	ax,ax
	jmp	@5@1318
@5@226:
   ;	
   ;	            case 'm':
   ;	                textMode();
   ;	
	call	near ptr @textMode$qv
   ;	
   ;	                cout << "0. Wyjdz\n";
   ;	
	xor	ax,ax
	push	ax
	mov	ax,offset DGROUP:s@+69
	push	ax
	mov	ax,offset DGROUP:_cout
	push	ax
	call	near ptr @ostream@outstr$qpxzct1
	add	sp,6
   ;	
   ;	                cout << "1. Zmien obrazek\n";
   ;	
	xor	ax,ax
	push	ax
	mov	ax,offset DGROUP:s@+79
	push	ax
	mov	ax,offset DGROUP:_cout
	push	ax
	call	near ptr @ostream@outstr$qpxzct1
	add	sp,6
   ;	
   ;	                cout << "2. Normalny obraz\n";
   ;	
	xor	ax,ax
	push	ax
	mov	ax,offset DGROUP:s@+97
	push	ax
	mov	ax,offset DGROUP:_cout
	push	ax
	call	near ptr @ostream@outstr$qpxzct1
	add	sp,6
   ;	
   ;	                cout << "3. Negatyw\n";
   ;	
	xor	ax,ax
	push	ax
	mov	ax,offset DGROUP:s@+116
	push	ax
	mov	ax,offset DGROUP:_cout
	push	ax
	call	near ptr @ostream@outstr$qpxzct1
	add	sp,6
   ;	
   ;	                cout << "4. Rozjasnij/Przyciemnij\n"; 
   ;	
	xor	ax,ax
	push	ax
	mov	ax,offset DGROUP:s@+128
	push	ax
	mov	ax,offset DGROUP:_cout
	push	ax
	call	near ptr @ostream@outstr$qpxzct1
	add	sp,6
   ;	
   ;	                cout << "5. Progowanie\n";
   ;	
	xor	ax,ax
	push	ax
	mov	ax,offset DGROUP:s@+154
	push	ax
	mov	ax,offset DGROUP:_cout
	push	ax
	call	near ptr @ostream@outstr$qpxzct1
	add	sp,6
   ;	
   ;	                int selectFunction = -1;
   ;	
	mov	word ptr [bp-4],-1
   ;	
   ;	                cin >> selectFunction;
   ;	
	lea	ax,word ptr [bp-4]
	push	ax
	mov	ax,offset DGROUP:_cin
	push	ax
	call	near ptr @istream@$brsh$qri
	pop	cx
	pop	cx
   ;	
   ;	                LONG size =  bmih.biWidth * bmih.biHeight;
   ;	
	mov	cx,word ptr DGROUP:_bmih+6
	mov	bx,word ptr DGROUP:_bmih+4
	mov	dx,word ptr DGROUP:_bmih+10
	mov	ax,word ptr DGROUP:_bmih+8
	call	near ptr N_LXMUL@
	mov	word ptr [bp-6],dx
	mov	word ptr [bp-8],ax
   ;	
   ;	                switch(selectFunction)
   ;	
	mov	bx,word ptr [bp-4]
	cmp	bx,5
	jbe	@@0
	jmp	@5@1234
@@0:
	shl	bx,1
	jmp	word ptr cs:@5@C1426[bx]
@5@366:
   ;	
   ;	                {
   ;	                    case 0://Wyjdz
   ;	                        textMode();
   ;	
	jmp	@5@198
@5@394:
   ;	
   ;	                        return 0;
   ;	                    case 1:
   ;	                        cout << "Podaj nazwe plik: ";
   ;	
	xor	ax,ax
	push	ax
	mov	ax,offset DGROUP:s@+169
	push	ax
	mov	ax,offset DGROUP:_cout
	push	ax
	call	near ptr @ostream@outstr$qpxzct1
	add	sp,6
   ;	
   ;	                        cin >> fileName;
   ;	
	push	di
	mov	ax,offset DGROUP:_cin
	push	ax
	call	near ptr @istream@$brsh$qpzc
	pop	cx
	pop	cx
   ;	
   ;	    		            graphicsMode();
   ;	
@5@422:
	call	near ptr @graphicsMode$qv
   ;	
   ;							setColorsPallete();
   ;	
	call	near ptr @setColorsPallete$qv
   ;	
   ;							printBitmap(fileName);
   ;	
	push	di
	call	near ptr @printBitmap$qpxzc
	pop	cx
   ;	
   ;	                        break;
   ;	
	jmp	@5@1234
@5@450:
	jmp	short @5@422
@5@478:
   ;	
   ;	                	case 2://Normalnie
   ;	    		            graphicsMode();
   ;							setColorsPallete();
   ;							printBitmap(fileName);
   ;	                		break;
   ;	                	case 3://Negatyw
   ;	                        graphicsMode();
   ;	
	call	near ptr @graphicsMode$qv
   ;	
   ;	                        setColorsPallete();
   ;	
	call	near ptr @setColorsPallete$qv
   ;	
   ;	                        printBitmap(fileName);
   ;	
	push	di
	call	near ptr @printBitmap$qpxzc
	pop	cx
   ;	
   ;	                        for(i = 0; i < size; i++)
   ;	
	xor	si,si
	jmp	short @5@562
@5@506:
   ;	
   ;	                        {
   ;	                            video_memory[i] = ~video_memory[i];
   ;	
	les	bx,dword ptr DGROUP:_video_memory
	add	bx,si
	mov	al,byte ptr es:[bx]
	not	al
	les	bx,dword ptr DGROUP:_video_memory
	add	bx,si
	mov	byte ptr es:[bx],al
	inc	si
@5@562:
	xor	ax,ax
	cmp	ax,word ptr [bp-6]
	jb	short @5@506
	jne	short @5@646
	cmp	si,word ptr [bp-8]
	jb	short @5@506
@5@646:
   ;	
   ;	                        }
   ;	                		break;
   ;	
	jmp	@5@1234
@5@674:
   ;	
   ;	                    case 4://Rosjasnienie
   ;	                        cout << "Wartosci dodatnie rozjasniaja, ujemne przyciemniaja. Podaj wartosc:\n";
   ;	
	xor	ax,ax
	push	ax
	mov	ax,offset DGROUP:s@+188
	push	ax
	mov	ax,offset DGROUP:_cout
	push	ax
	call	near ptr @ostream@outstr$qpxzct1
	add	sp,6
   ;	
   ;	                        int value3;
   ;	                        cin >> value3;
   ;	
	lea	ax,word ptr [bp-10]
	push	ax
	mov	ax,offset DGROUP:_cin
	push	ax
	call	near ptr @istream@$brsh$qri
	pop	cx
	pop	cx
   ;	
   ;	                        graphicsMode();
   ;	
	call	near ptr @graphicsMode$qv
   ;	
   ;	                        setColorsPallete();
   ;	
	call	near ptr @setColorsPallete$qv
   ;	
   ;	                        printBitmap(fileName);
   ;	
	push	di
	call	near ptr @printBitmap$qpxzc
	pop	cx
   ;	
   ;	                        for(i =0; i < size; i++)
   ;	
	xor	si,si
	jmp	short @5@898
@5@730:
   ;	
   ;	                        {
   ;	                            int x = video_memory[i];
   ;	
	les	bx,dword ptr DGROUP:_video_memory
	add	bx,si
	mov	al,byte ptr es:[bx]
	mov	ah,0
	mov	dx,ax
   ;	
   ;	                            x += value3;
   ;	
	add	dx,word ptr [bp-10]
   ;	
   ;	                            if(x > 255)
   ;	
	cmp	dx,255
	jle	short @5@786
   ;	
   ;	                                x = 255;
   ;	
	mov	dx,255
	jmp	short @5@842
@5@786:
   ;	
   ;	                            else if(x < 0)
   ;	
	or	dx,dx
	jge	short @5@842
   ;	
   ;	                                x = 0;
   ;	
	xor	dx,dx
@5@842:
   ;	
   ;	                            video_memory[i] = x;
   ;	
	les	bx,dword ptr DGROUP:_video_memory
	add	bx,si
	mov	byte ptr es:[bx],dl
	inc	si
@5@898:
	xor	ax,ax
	cmp	ax,word ptr [bp-6]
	jb	short @5@730
	jne	short @5@982
	cmp	si,word ptr [bp-8]
	jb	short @5@730
@5@982:
   ;	
   ;	                        }
   ;	                        break;
   ;	
	jmp	short @5@1234
@5@1010:
   ;	
   ;	                    case 5:
   ;	                        cout << "Podaj wartosc progu\n";
   ;	
	xor	ax,ax
	push	ax
	mov	ax,offset DGROUP:s@+257
	push	ax
	mov	ax,offset DGROUP:_cout
	push	ax
	call	near ptr @ostream@outstr$qpxzct1
	add	sp,6
   ;	
   ;	                        unsigned char value4;
   ;	                        cin >> value4;
   ;	
	lea	ax,word ptr [bp-11]
	push	ax
	mov	ax,offset DGROUP:_cin
	push	ax
	call	near ptr @istream@$brsh$qruc
	pop	cx
	pop	cx
   ;	
   ;	                        graphicsMode();
   ;	
	call	near ptr @graphicsMode$qv
   ;	
   ;	                        setColorsPallete();
   ;	
	call	near ptr @setColorsPallete$qv
   ;	
   ;	                        printBitmap(fileName);
   ;	
	push	di
	call	near ptr @printBitmap$qpxzc
	pop	cx
   ;	
   ;	                        for(i = 0; i < size; i++)
   ;	
	xor	si,si
	jmp	short @5@1122
@5@1038:
   ;	
   ;	                        {
   ;	                            if(video_memory[i] < value4)
   ;	
	les	bx,dword ptr DGROUP:_video_memory
	add	bx,si
	mov	al,byte ptr es:[bx]
	cmp	al,byte ptr [bp-11]
	jae	short @5@1094
   ;	
   ;	                            {
   ;	                                video_memory[i] = 0;
   ;	
	les	bx,dword ptr DGROUP:_video_memory
	add	bx,si
	mov	byte ptr es:[bx],0
@5@1094:
	inc	si
@5@1122:
	xor	ax,ax
	cmp	ax,word ptr [bp-6]
	jb	short @5@1038
	jne	short @5@1206
	cmp	si,word ptr [bp-8]
	jb	short @5@1038
@5@1206:
   ;	
   ;	                            }
   ;	                        }
   ;	                        break;
   ;	
	jmp	short @5@1234
@5@1234:
   ;	
   ;					}
   ;	                break;
   ;	
	jmp	short @5@1262
@5@1262:
   ;	
   ;	        }
   ;	    }while(c != 'e');
   ;	
	cmp	byte ptr [bp-1],101
	je	@@1
	jmp	@5@58
@@1:
	jmp	@5@198
@5@1318:
   ;	
   ;	    textMode();
   ;	   return 0;
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_main	endp
@5@C1426	label	word
	dw	@5@366
	dw	@5@394
	dw	@5@450
	dw	@5@478
	dw	@5@674
	dw	@5@1010
	?debug	C E9
	?debug	C FA00000000
_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
	db	'rb'
	db	0
	db	'Nie udalo sie otworzyc pliku: '
	db	0
	db	' !'
	db	10
	db	0
	db	'boat.bmp'
	db	0
	db	'Podaj nazwe pliku: '
	db	0
	db	10
	db	0
	db	'0. Wyjdz'
	db	10
	db	0
	db	'1. Zmien obrazek'
	db	10
	db	0
	db	'2. Normalny obraz'
	db	10
	db	0
	db	'3. Negatyw'
	db	10
	db	0
	db	'4. Rozjasnij/Przyciemnij'
	db	10
	db	0
	db	'5. Progowanie'
	db	10
	db	0
	db	'Podaj nazwe plik: '
	db	0
	db	'Wartosci dodatnie rozjasniaja, ujemne przyciemniaja. Podaj wa'
	db	'rtosc:'
	db	10
	db	0
	db	'Podaj wartosc progu'
	db	10
	db	0
_DATA	ends
_TEXT	segment byte public 'CODE'
_TEXT	ends
	public	_main
	extrn	N_LXMUL@:far
	public	@printBitmap$qpxzc
	public	@setColorsPallete$qv
	public	@textMode$qv
	public	@graphicsMode$qv
	public	_video_memory
	public	_bmih
	public	_bmfh
	extrn	_cout:word
	extrn	_cin:word
	extrn	@ostream@outstr$qpxzct1:near
	extrn	@istream@$brsh$qri:near
	extrn	@istream@$brsh$qruc:near
	extrn	@istream@$brsh$qpzc:near
	extrn	@istream@get$qv:near
	extrn	_fseek:near
	extrn	_fread:near
	extrn	_fopen:near
	extrn	_fgetc:near
	extrn	_fclose:near
_pokeb	equ	pokeb
_poke	equ	poke
_peekb	equ	peekb
_peek	equ	peek
	extrn	_intr:near
_s@	equ	s@
	end
