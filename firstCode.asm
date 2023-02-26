	.include "m328pdef.inc"
	.dseg

	.def quotient = r16 // quotient
	.def xL = r26
	.def xH = r27
	.def yL = r28
	.def yH = r29
	.def zL = r30
	.def zH = r31

	.equ divider = 0x02 // divisor
	.equ iNumber = 0x12E4
	.equ sNumber = 0x00E8

	.cseg
	.org 0x00

	ldi xL, low(iNumber) //low byte
	ldi xH, high(iNumber) // high byte

	ldi yL, low(sNumber)
	ldi yH, high(sNumber)

sub_numbers:
	sub xL, yL
	sbc xH, yH
	mov zL, xL

div:
	clc // clear carry-bit
	clr quotient
	subi zL, divider
	inc quotient
	brcc PC-2 // as long as R17-R16 difference > 0 (jump if carry is reset)
	dec quotient // when difference zL, divider < 0
	clr zl
	mov zL, quotient // restore quotient and adjust zL

end:
	sts 0x25, xL
	sts 0x30, xH
    
loop: rjmp loop
