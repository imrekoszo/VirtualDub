;	VirtualDub - Video processing and capture application
;	Copyright (C) 1998-2001 Avery Lee
;
;	This program is free software; you can redistribute it and/or modify
;	it under the terms of the GNU General Public License as published by
;	the Free Software Foundation; either version 2 of the License, or
;	(at your option) any later version.
;
;	This program is distributed in the hope that it will be useful,
;	but WITHOUT ANY WARRANTY; without even the implied warranty of
;	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;	GNU General Public License for more details.
;
;	You should have received a copy of the GNU General Public License
;	along with this program; if not, write to the Free Software
;	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

	.686
	.mmx
	.xmm
	.model	flat
	.const

x7c007c007c007c00	dq	7c007c007c007c00h
x03e003e003e003e0	dq	03e003e003e003e0h
x001f001f001f001f	dq	001f001f001f001fh

	.code

	extern _MMX_enabled : byte
	extern _ISSE_enabled : byte

	public	_DIBconvert_8_to_16
	public	_DIBconvert_8_to_24
	public	_DIBconvert_8_to_32
	public	_DIBconvert_16_to_32
	public	_DIBconvert_24_to_32
	public	_DIBconvert_16_to_24
	public	_DIBconvert_24_to_24
	public	_DIBconvert_16_to_16
	public	_DIBconvert_24_to_16



; void DIBconvert_8_to_32(
;	void *dest,		[ESP+ 4]
;	ulong dest_pitch,	[ESP+ 8]
;	void *src,		[ESP+12]
;	ulong src_pitch,	[ESP+16]
;	ulong width,		[ESP+20]
;	ulong height,		[ESP+24]
;	ulong *palette);	[ESP+28]

_DIBconvert_8_to_32:
	push	ebp
	push	edi
	push	esi
	push	edx
	push	ecx
	push	ebx
	push	eax

	mov	esi,[esp+12+28]
	mov	edi,[esp+4+28]

	mov	eax,[esp+20+28]
	mov	ebx,eax
	shl	ebx,2
	mov	edx,[esp+28+28]
	mov	ecx,[esp+24+28]

	sub	[esp+16+28],eax
	sub	[esp+8+28],ebx

DIBconvert832@y:
	mov	ebp,[esp+20+28]
	xor	eax,eax
DIBconvert832@x:
	mov	al,[esi]
	inc	esi
	mov	ebx,[eax*4+edx]	
	mov	[edi],ebx
	add	edi,4
	sub	ebp,1
	jne	DIBconvert832@x

	add	esi,[esp+16+28]
	add	edi,[esp+8+28]

	sub	ecx,1
	jne	DIBconvert832@y

	pop	eax
	pop	ebx
	pop	ecx
	pop	edx
	pop	esi
	pop	edi
	pop	ebp

	ret

; void DIBconvert_8_to_24(
;	void *dest,		[ESP+ 4]
;	ulong dest_pitch,	[ESP+ 8]
;	void *src,		[ESP+12]
;	ulong src_pitch,	[ESP+16]
;	ulong width,		[ESP+20]
;	ulong height,		[ESP+24]
;	ulong *palette);	[ESP+28]

_DIBconvert_8_to_24:
	push	ebp
	push	edi
	push	esi
	push	edx
	push	ecx
	push	ebx
	push	eax

	mov	esi,[esp+12+28]
	mov	edi,[esp+4+28]

	mov	eax,[esp+20+28]
	mov	ebx,eax
	lea	ebx,[ebx+eax*2]
	mov	edx,[esp+28+28]
	mov	ecx,[esp+24+28]

	sub	[esp+16+28],eax
	sub	[esp+8+28],ebx

DIBconvert824@y:
	mov	ebp,[esp+20+28]
	xor	eax,eax
DIBconvert824@x:
	mov	al,[esi]
	inc	esi
	mov	ebx,[eax*4+edx]	
	mov	[edi],ebx
	add	edi,3
	sub	ebp,1
	jne	DIBconvert824@x

	add	esi,[esp+16+28]
	add	edi,[esp+8+28]

	sub	ecx,1
	jne	DIBconvert824@y

	pop	eax
	pop	ebx
	pop	ecx
	pop	edx
	pop	esi
	pop	edi
	pop	ebp

	ret

;******************************************************
;
; void DIBconvert_8_to_16(
;	void *dest,		[ESP+ 4]
;	ulong dest_pitch,	[ESP+ 8]
;	void *src,		[ESP+12]
;	ulong src_pitch,	[ESP+16]
;	ulong width,		[ESP+20]
;	ulong height,		[ESP+24]
;	ulong *palette);	[ESP+28]
;
; This implementation is painfully bad, but it's not really
; worth optimizing much...

_DIBconvert_8_to_16:
	push	ebp
	push	edi
	push	esi
	push	edx
	push	ecx
	push	ebx
	push	eax

	mov	esi,[esp+12+28]
	mov	edi,[esp+4+28]

	mov	ebp,[esp+20+28]
	lea	eax,[ebp+ebp]
	sub	[esp+8+28],eax
	sub	[esp+16+28],ebp

	mov	edx,[esp+24+28]
DIBconvert816@y:
	mov	ebp,[esp+20+28]
	push	ebp
	push	edx
	shr	ebp,1
	jz	DIBconvert816@x2
DIBconvert816@x:
	xor	eax,eax			;u
	mov	ebx,[esp+28+36]		;v
	mov	al,[esi+1]		;u
	add	esi,2			;v
	mov	eax,[ebx+eax*4]		;u [AGI]

	mov	ebx,eax			;u
	mov	ecx,eax			;v
	shr	ebx,3			;u
	and	ecx,0000f800h		;v
	shr	eax,9			;u
	and	ebx,0000001fh		;v
	shr	ecx,6			;u
	and	eax,00007c00h		;v
	or	ebx,ecx			;u
	add	edi,4			;v
	or	ebx,eax			;u

	xor	ecx,ecx			;v
	mov	eax,[esp+28+36]		;u
	mov	cl,[esi-2]		;v
	mov	edx,ebx			;u
	mov	ecx,[eax+ecx*4]		;v [AGI]
	mov	eax,ecx			;u

	shl	edx,16			;u
	mov	ebx,ecx			;v
	shr	ebx,3			;u
	and	ecx,0000f800h		;v
	shr	eax,9			;u
	and	ebx,0000001fh		;v
	shr	ecx,6			;u
	and	eax,00007c00h		;v
	or	eax,ecx			;u
	or	edx,ebx			;v
	or	edx,eax			;u
	sub	ebp,1			;v
	mov	[edi-4],edx		;u
	jne	DIBconvert816@x		;v
DIBconvert816@x2:
	pop	edx
	pop	ebp
	and	ebp,1
	jz	DIBconvert816@x3
	xor	eax,eax
	mov	ecx,[esp+28+28]
	mov	al,[esi]
	mov	eax,[eax*4+ecx]
	inc	esi

	mov	ebx,eax
	mov	ecx,eax
	shr	ebx,3
	and	ecx,0000f800h
	shr	eax,9
	and	ebx,0000001fh
	shr	ecx,6
	and	eax,00007c00h
	or	ebx,ecx
	or	ebx,eax
	mov	[edi+0],bl
	mov	[edi+1],bh
	add	edi,2
DIBconvert816@x3:

	add	esi,[esp+16+28]
	add	edi,[esp+ 8+28]

	sub	edx,1
	jne	DIBconvert816@y

	pop	eax
	pop	ebx
	pop	ecx
	pop	edx
	pop	esi
	pop	edi
	pop	ebp

	ret

; void DIBconvert_16_to_32(
;	void *dest,		[ESP+ 4]
;	ulong dest_pitch,	[ESP+ 8]
;	void *src,		[ESP+12]
;	ulong src_pitch,	[ESP+16]
;	ulong width,		[ESP+20]
;	ulong height);		[ESP+24]

_DIBconvert_16_to_32:
	test	byte ptr _ISSE_enabled,1
	jne	DIBconvert_16_to_32_ISSE

	push	ebp
	push	edi
	push	esi
	push	edx
	push	ecx
	push	ebx
	push	eax

	mov	esi,[esp+12+28]
	mov	edi,[esp+4+28]

	mov	ebp,[esp+20+28]
	lea	eax,[ebp*4]
	lea	ebx,[ebp*2]
	sub	[esp+8+28],eax
	sub	[esp+16+28],ebx

	mov	edx,[esp+24+28]
DIBconvert1632@y:
	mov	ebp,[esp+20+28]
	push	ebp
	push	edx
	shr	ebp,1
	jz	DIBconvert1632@x2
DIBconvert1632@x:
	mov	eax,[esi]
	add	esi,4
	mov	edx,eax
	add	edi,8
	mov	ebx,eax
	mov	ecx,eax
	shl	ebx,9
	and	eax,0000001fh
	shl	ecx,6
	and	ebx,00f80000h
	shl	eax,3
	and	ecx,0000f800h
	or	ebx,ecx
	mov	ecx,edx
	or	eax,ebx
	mov	ebx,edx
	shr	ebx,7
	and	edx,001f0000h
	shr	ecx,10
	and	ebx,00f80000h
	shr	edx,13
	and	ecx,0000f800h
	or	ebx,ecx
	mov	[edi-8],eax
	or	edx,ebx
	sub	ebp,1
	mov	[edi-4],edx
	jne	DIBconvert1632@x
DIBconvert1632@x2:
	pop	edx
	pop	ebp
	and	ebp,1
	jz	DIBconvert1632@x3

	mov	eax,[esi]
	add	esi,2

	mov	ebx,eax
	mov	ecx,eax
	shl	ebx,9
	shl	ecx,6
	shl	eax,3
	and	ebx,00f80000h
	and	ecx,0000f800h
	and	eax,000000f8h
	or	ebx,ecx
	or	eax,ebx
	mov	[edi],eax
	add	edi,4

DIBconvert1632@x3:

	add	esi,[esp+16+28]
	add	edi,[esp+ 8+28]

	sub	edx,1
	jne	DIBconvert1632@y

	pop	eax
	pop	ebx
	pop	ecx
	pop	edx
	pop	esi
	pop	edi
	pop	ebp

	ret

DIBconvert_16_to_32_ISSE	proc near
	push		ebp
	push		edi
	push		esi
	push		ebx

	mov			eax, [esp+20+16]
	mov			ecx, [esp+12+16]
	mov			ebx, eax
	mov			edx, [esp+4+16]
	neg			ebx
	sub			eax, 3
	mov			esi, [esp+16+16]
	mov			edi, [esp+8+16]
	mov			ebp, [esp+24+16]
	mov			[esp+20+16], eax
	lea			esi, [esi+ebx*2]
	lea			edi, [edi+ebx*4]
	mov			[esp+16+16], esi
	mov			[esp+8+16], edi

	movq		mm6, x7c007c007c007c00
	movq		mm5, x001f001f001f001f
	movq		mm7, x03e003e003e003e0

vloop:
	mov			eax, [esp+20+16]
	test		eax, eax
	jle			leftovers

hloop:
	movq		mm0, [ecx]		;mm0 = p3 | p2 | p1 | p0
	movq		mm1, mm6

	movq		mm2, mm7
	pand		mm1, mm0		;mm1 = r3 | r2 | r1 | r0

	pand		mm2, mm0		;mm2 = g3 | g2 | g1 | g0
	psrlw		mm1, 7			;align r to top

	pand		mm0, mm5		;mm0 = b3 | b2 | b1 | b0
	psllw		mm2, 6			;align g to top

	psllw		mm0, 3			;align b to top
	movq		mm3, mm2

	punpcklwd	mm2, mm2		;mm2 = G1 | G1 | G0 | G0
	movq		mm4, mm0

	punpcklwd	mm0, mm1		;mm0 = R1 | B1 | R0 | B0
	add			edx, 16

	punpckhwd	mm3, mm3		;mm3 = G3 | G3 | G2 | G2
	paddd		mm0, mm2		;mm0 = G1R1G1B1|G0R0R0B0

	punpckhwd	mm4, mm1		;mm4 = R3 | B3 | R2 | B2
	add			ecx, 8

	paddd		mm4, mm3
	movntq		[edx-16], mm0

	nop
	sub			eax, 4

	movntq		[edx-8], mm4
	ja			hloop

	add			eax, 3
	jz			noleftovers
leftovers:
	movzx		esi, word ptr [ecx]
	add			ecx, 2
	mov			edi, esi
	mov			ebx, esi
	shl			esi, 9
	and			edi, 000003e0h
	shl			edi, 6
	and			ebx, 0000001fh
	shl			ebx, 3
	and			esi, 00ff0000h
	add			ebx, edi
	add			ebx, esi
	mov			[edx], ebx
	add			edx, 4
	add			eax, 1
	jne			leftovers
noleftovers:
	add			ecx, [esp+16+16]
	add			edx, [esp+8+16]

	sub			ebp, 1
	jne			vloop

	emms
	pop			ebx
	pop			esi
	pop			edi
	pop			ebp

	ret
DIBconvert_16_to_32_ISSE	endp

;***************************************************
;
; void DIBconvert_24_to_32(
;	void *dest,		[ESP+ 4]
;	ulong dest_pitch,	[ESP+ 8]
;	void *src,		[ESP+12]
;	ulong src_pitch,	[ESP+16]
;	ulong width,		[ESP+20]
;	ulong height);		[ESP+24]

_DIBconvert_24_to_32:
	test	byte ptr _ISSE_enabled,1
	jne	DIBconvert_24_to_32_ISSE
	push	ebp
	push	edi
	push	esi
	push	edx
	push	ecx
	push	ebx

	mov	esi,[esp+12+24]
	mov	edi,[esp+4+24]

	mov	ecx,[esp+20+24]
	lea	eax,[ecx+ecx*2]
	lea	ebx,[ecx*4]
	sub	[esp+8+24],ebx
	sub	[esp+16+24],eax

	mov	edx,[esp+24+24]
DIBconvert2432@y:
	mov	ebp,[esp+20+24]
	shr	ebp,2
	push	edx
	jz	DIBconvert2432@x2
DIBconvert2432@x1:

	mov	eax,[esi]		;EAX: b1r0g0b0
	mov	ebx,[esi+4]		;EBX: g2b2r1g1

	mov	[edi],eax
	mov	ecx,ebx			;ECX: g2b2r1g1

	shr	eax,24			;EAX: ------b1
	mov	edx,[esi+8]		;EDX: r3g3b3r2

	shr	ecx,16			;ECX: ----g2b2
	add	edi,16

	shl	ebx,8			;EBX: b2r1g1--
	add	esi,12

	or	eax,ebx			;EAX: b2r1g1b1
	mov	ebx,edx			;EBX: r3g3b3r2

	shr	ebx,8			;EBX: --r3g3b3
	mov	[edi+4-16],eax

	shl	edx,16			;EDX: b3r2----
	mov	[edi+12-16],ebx

	or	edx,ecx			;EDX: b3r2g2b2
	sub	ebp,1

	mov	[edi+8-16],edx
	jne	DIBconvert2432@x1

DIBconvert2432@x2:
	pop	edx
	mov	ebx,[esp+20+24]
	and	ebx,3
	jz	DIBconvert2432@x4
DIBconvert2432@x3:
	mov	ax,[esi]
	mov	cl,[esi+2]
	mov	[edi],ax
	mov	[edi+2],cl
	add	esi,3
	add	edi,4
	sub	ebx,1
	jne	DIBconvert2432@x3
DIBconvert2432@x4:

	add	esi,[esp+16+24]
	add	edi,[esp+ 8+24]

	sub	edx,1
	jne	DIBconvert2432@y

	pop	ebx
	pop	ecx
	pop	edx
	pop	esi
	pop	edi
	pop	ebp

	ret

DIBconvert_24_to_32_ISSE:
	push	ebp
	push	edi
	push	esi
	push	ebx

	mov	esi,[esp+12+16]
	mov	edi,[esp+4+16]

	mov	ecx,[esp+20+16]
	lea	eax,[ecx+ecx*2]
	lea	ebx,[ecx*4]
	sub	[esp+8+16],ebx
	sub	[esp+16+16],eax

	mov	edx,[esp+24+16]
	mov	ebx,[esp+20+16]
	mov	ecx,[esp+16+16]
	mov	eax,[esp+ 8+16]
	
	;ebx	horizontal count backup
	;ecx	source modulo
	;edx	vertical count
	;esi	source
	;edi	destination
	;ebp	horizontal count
	
DIBconvert2432ISSE@y:
	mov	ebp,ebx
	shr	ebp,3
	jz	DIBconvert2432ISSE@x2
DIBconvert2432ISSE@x1:
	movq		mm0,[esi]		;mm0: g2b2r1g1b1r0g0b0
	movq		mm1,mm0			;
	
	psrlq		mm1,24			;mm1: ------g2b2r1g1b1
	movq		mm2,mm0			;
	
	movq		mm3,[esi+8]		;mm3: b5r4g4b4r3g3b3r2
	punpckldq	mm0,mm1			;mm0: b2r1g1b1b1r0g0b0	[qword 0 ready]
	
	movq		mm4,mm3			;mm4: b5r4g4b4r3g3b3r2
	psllq		mm3,48			;mm3: b3r2------------
	
	movq		mm5,mm4			;mm5: b5r4g4b4r3g3b3r2
	psrlq		mm2,16			;mm2: ----g2b2--------
	
	movq		mm1,[esi+16]		;mm1: r7g7b7r6g6b6r5g5
	por		mm2,mm3			;mm2: b3r2g2b2--------
	
	movntq		[edi],mm0		;
	psllq		mm4,24			;mm4: b4r3g3b3r2------
	
	movq		mm3,mm5			;mm3: b5r4g4b4r3g3b3r2
	psrlq		mm5,24			;mm5: ------b5r4g4b4r3
	
	movq		mm0,mm1			;mm0: r7g7b7r6g6b6r5g5
	psllq		mm1,40			;mm1: b6r5g5----------
	
	punpckhdq	mm2,mm4			;mm2: b4r3g3b3b3r2g2b2 [qword 1 ready]
	por		mm1,mm5			;mm1: b6r5g5b5r4g4b4r3
	
	movq		mm4,mm0			;mm4: r7g7b7r6g6b6r5g5
	punpckhdq	mm3,mm1			;mm3: b6r5g5b5b5r4g4b4 [qword 2 ready]
	
	movntq		[edi+8],mm2
	psrlq		mm0,16			;mm0: ----r7g7b7r6g6b6
	
	movntq		[edi+16],mm3
	psrlq		mm4,40			;mm4: ----------r7g7b7
	
	punpckldq	mm0,mm4			;mm0: --r7g7b7b7r6g6b6 [qword 3 ready]
	add		esi,24
	
	movntq		[edi+24],mm0
		
	add	edi,32
	sub	ebp,1
	jne	DIBconvert2432ISSE@x1

DIBconvert2432ISSE@x2:
	mov	ebp,ebx
	and	ebp,7
	jz	DIBconvert2432ISSE@x4
	movd	mm7,eax
DIBconvert2432ISSE@x3:
	mov	ax,[esi]
	mov	[edi],ax
	mov	al,[esi+2]
	mov	[edi+2],al
	add	esi,3
	add	edi,4
	sub	ebp,1
	jne	DIBconvert2432ISSE@x3
	
	movd	eax,mm7
DIBconvert2432ISSE@x4:
	add	esi,ecx
	add	edi,eax

	sub	edx,1
	jne	DIBconvert2432ISSE@y
	emms
	sfence
	pop	ebx
	pop	esi
	pop	edi
	pop	ebp


	ret



;****************************************************************************
;
; void DIBconvert_16_to_24(
;	void *dest,		[ESP+ 4]
;	ulong dest_pitch,	[ESP+ 8]
;	void *src,		[ESP+12]
;	ulong src_pitch,	[ESP+16]
;	ulong width,		[ESP+20]
;	ulong height);		[ESP+24]

_DIBconvert_16_to_24:
	push	ebp
	push	edi
	push	esi
	push	edx
	push	ecx
	push	ebx
	push	eax

	mov	esi,[esp+12+28]
	mov	edi,[esp+4+28]

	mov	ebp,[esp+20+28]
	mov	eax,ebp
	lea	ebx,[ebp*2]
	add	eax,ebx
	sub	[esp+8+28],eax
	sub	[esp+16+28],ebx

	mov	edx,[esp+24+28]
DIBconvert1624@y:
	mov	ebp,[esp+20+28]
	push	ebp
	push	edx
	shr	ebp,1
	jz	DIBconvert1624@x2
DIBconvert1624@x:
	mov	eax,[esi]
	add	esi,4
	mov	edx,eax
	add	edi,6
	mov	ebx,eax
	mov	ecx,eax
	shl	ebx,9
	and	eax,0000001fh
	shl	ecx,6
	and	ebx,00f80000h
	shl	eax,3
	and	ecx,0000f800h
	or	ebx,ecx
	mov	ecx,edx
	or	eax,ebx
	mov	ebx,edx
	shr	ebx,7
	and	edx,001f0000h
	shr	ecx,10
	and	ebx,00f80000h
	shr	edx,13
	and	ecx,0000f800h
	or	ebx,ecx
	mov	[edi-6],eax
	or	edx,ebx
	sub	ebp,1
	mov	[edi-3],edx
	jne	DIBconvert1624@x
DIBconvert1624@x2:
	pop	edx
	pop	ebp
	and	ebp,1
	jz	DIBconvert1624@x3

	mov	eax,[esi]
	add	esi,2

	mov	ebx,eax
	mov	ecx,eax
	shl	ebx,9
	shl	ecx,6
	shl	eax,3
	and	ebx,00f80000h
	and	ecx,0000f800h
	and	eax,000000f8h
	or	ebx,ecx
	or	eax,ebx
	mov	[edi],eax
	add	edi,3


DIBconvert1624@x3:

	add	esi,[esp+16+28]
	add	edi,[esp+ 8+28]

	sub	edx,1
	jne	DIBconvert1624@y

	pop	eax
	pop	ebx
	pop	ecx
	pop	edx
	pop	esi
	pop	edi
	pop	ebp

	ret

; void DIBconvert_24_to_24(
;	void *dest,		[ESP+ 4]
;	ulong dest_pitch,	[ESP+ 8]
;	void *src,		[ESP+12]
;	ulong src_pitch,	[ESP+16]
;	ulong width,		[ESP+20]
;	ulong height);		[ESP+24]
;
;	this isn't THAT stupid a function!!

_DIBconvert_24_to_24:
	push	edi
	push	esi
	push	edx
	push	ecx
	push	ebx
	push	eax

	cld
	mov	edx,[esp+24+24]

	mov	eax,[esp+20+24]
	mov	esi,[esp+12+24]
	mov	ebx,eax
	mov	edi,[esp+ 4+24]
	add	eax,eax
	add	eax,ebx
	mov	ebx,eax
	shr	eax,2
	and	ebx,3

DIBconvert2424@y:
	push	esi
	push	edi
	mov	ecx,eax
	rep	movsd
	mov	ecx,ebx
	rep	movsb
	pop	edi
	pop	esi
	add	esi,[esp+16+24]
	add	edi,[esp+ 8+24]

	sub	edx,1
	jne	DIBconvert2424@y

	pop	eax
	pop	ebx
	pop	ecx
	pop	edx
	pop	esi
	pop	edi

	ret

;**********************************************************
;
; void DIBconvert_16_to_16(
;	void *dest,		[ESP+ 4]
;	ulong dest_pitch,	[ESP+ 8]
;	void *src,		[ESP+12]
;	ulong src_pitch,	[ESP+16]
;	ulong width,		[ESP+20]
;	ulong height);		[ESP+24]
;
;	this isn't THAT stupid a function!!

_DIBconvert_16_to_16:
	push	edi
	push	esi
	push	edx
	push	ecx
	push	ebx
	push	eax

	cld
	mov	edx,[esp+24+24]

	mov	eax,[esp+20+24]
	mov	esi,[esp+12+24]
	mov	edi,[esp+ 4+24]

DIBconvert1616@y:
	push	esi
	push	edi
	mov	ecx,eax
	shr	ecx,1
	rep	movsd
	mov	ecx,eax
	and	ecx,1
	add	ecx,ecx
	rep	movsb
	pop	edi
	pop	esi
	add	esi,[esp+16+24]
	add	edi,[esp+ 8+24]

	sub	edx,1
	jne	DIBconvert1616@y

	pop	eax
	pop	ebx
	pop	ecx
	pop	edx
	pop	esi
	pop	edi

	ret

;******************************************************
;
; void DIBconvert_24_to_16(
;	void *dest,		[ESP+ 4]
;	ulong dest_pitch,	[ESP+ 8]
;	void *src,		[ESP+12]
;	ulong src_pitch,	[ESP+16]
;	ulong width,		[ESP+20]
;	ulong height);		[ESP+24]

_DIBconvert_24_to_16:
	push	ebp
	push	edi
	push	esi
	push	edx
	push	ecx
	push	ebx
	push	eax

	mov	esi,[esp+12+28]
	mov	edi,[esp+4+28]

	mov	ebp,[esp+20+28]
	lea	eax,[ebp+ebp]
	lea	ebx,[ebp+eax]
	sub	[esp+8+28],eax
	sub	[esp+16+28],ebx

	mov	edx,[esp+24+28]
DIBconvert2416@y:
	mov	ebp,[esp+20+28]
	push	ebp
	push	edx
	shr	ebp,1
	jz	DIBconvert2416@x2
DIBconvert2416@x:
	mov	eax,[esi+3]		;u
	add	esi,6			;v

	mov	ebx,eax			;u
	mov	ecx,eax			;v
	shr	ebx,3			;u
	and	ecx,0000f800h		;v
	shr	eax,9			;u
	and	ebx,0000001fh		;v
	shr	ecx,6			;u
	and	eax,00007c00h		;v
	or	ebx,ecx			;u
	add	edi,4			;v
	or	ebx,eax			;u

	mov	ecx,[esi-6]		;v
	mov	edx,ebx			;u
	mov	eax,ecx			;v

	shl	edx,16			;u
	mov	ebx,ecx			;v
	shr	ebx,3			;u
	and	ecx,0000f800h		;v
	shr	eax,9			;u
	and	ebx,0000001fh		;v
	shr	ecx,6			;u
	and	eax,00007c00h		;v
	or	eax,ecx			;u
	or	edx,ebx			;v
	or	edx,eax			;u
	sub	ebp,1			;v
	mov	[edi-4],edx		;u
	jne	DIBconvert2416@x	;v
DIBconvert2416@x2:
	pop	edx
	pop	ebp
	and	ebp,1
	jz	DIBconvert2416@x3
	mov	eax,[esi]
	add	esi,3

	mov	ebx,eax
	mov	ecx,eax
	shr	ebx,3
	and	ecx,0000f800h
	shr	eax,9
	and	ebx,0000001fh
	shr	ecx,6
	and	eax,00007c00h
	or	ebx,ecx
	or	ebx,eax
	mov	[edi+0],bl
	mov	[edi+1],bh
	add	edi,2
DIBconvert2416@x3:

	add	esi,[esp+16+28]
	add	edi,[esp+ 8+28]

	sub	edx,1
	jne	DIBconvert2416@y

	pop	eax
	pop	ebx
	pop	ecx
	pop	edx
	pop	esi
	pop	edi
	pop	ebp

	ret

	end