	.include "m328pdef.inc"
	.dseg

	.def quotient = r16      // частное
	.def xL = r26
	.def xH = r27
	.def yL = r28
	.def yH = r29
	.def zL = r30
	.def zH = r31

	.equ divider = 0x02      // делитель
	.equ iNumber = 0x12E4
	.equ sNumber = 0x00E8

	.cseg
	.org	0x00

	ldi xL, low(iNumber)    //младший байт
	ldi xH, high(iNumber)   //старший байт

	ldi yL, low(sNumber)
	ldi yH, high(sNumber)

sub_numbers:
	sub xL, yL
	sbc xH, yH
	mov zL, xL

div:   
	clc                     // очищаем carry-bit
    clr   quotient
	subi  zL, divider
    inc   quotient         
    brcc  PC-2              // до тех пор пока разность R17-R16 > 0 (переход, если перенос сброшен)
    dec   quotient          // когда разность zL, divider < 0
	clr   zl
    mov   zL, quotient      // восстанавливаем quotient и корректируем zL 

end:
    sts 0x25, xL
	sts 0x30, xH
    
loop: rjmp loop
