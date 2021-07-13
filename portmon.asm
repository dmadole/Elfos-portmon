; This software is copyright 2021 by David S. Madole.
; You have permission to use, modify, copy, and distribute
; this software so long as this copyright notice is retained.
; This software may not be used in commercial applications
; without express written permission from the author.
;
; The author grants a license to Michael H. Riley to use this
; code for any purpose he sees fit, including commercial use,
; and without any need to include the above notice.


           ; Include kernal API entry points

           include bios.inc
           include kernel.inc

           ; Define non-published API elements

d_type     equ     0444h

           ; Executable program header

           org     2000h - 6
           dw      start
           dw      end-start
           dw      start

start:     org     2000h
           br      main

           ; Build information

           db      7+80h              ; month
           db      13                 ; day
           dw      2021               ; year
           dw      1                  ; build
           db      'Written by David S. Madole',0

           ; Main code starts here

main:      ldi     '>'
           sep     scall
           dw      o_type

           ldi     high buffer
           phi     rf
           ldi     low buffer
           plo     rf

           sep     scall
           dw      o_input

           sep     scall
           dw      o_inmsg
           db      13,10,0

           ldi     high buffer
           phi     rf
           ldi     low buffer
           plo     rf

           sep     scall
           dw      f_ltrim

           lda     rf
           phi     rb

           smi     '/'
           lbnz    notdone

           sep     sret

notdone:   sep     scall
           dw      f_ltrim

           ldn     rf
           sep     scall
           dw      f_ishex
           lbnf    main

           sep     scall
           dw      f_hexin

           ghi     rd
           lbnz    main

           glo     rd
           lbz     main

           ani     0f8h
           lbnz    main

           ghi     rb
           smi     '?'
           lbz     input

           smi     '!'-'?'
           lbz     output

           lbr     main

input:     glo     rd
           adi     '0'
           sep     scall
           dw      o_type

           sep     scall
           dw      o_inmsg
           db      ': ',0

           ldi     high inpinst
           phi     rc
           ldi     low inpinst
           plo     rc

           glo     rd
           ori     68h
           str     rc

inpinst:   inp     1

           ldi     high buffer
           phi     rf
           ldi     low buffer
           plo     rf

           ldn     r2
           plo     rd
           sep     scall
           dw      f_hexout2

           ldi     0
           str     rf

           ldi     high buffer
           phi     rf
           ldi     low buffer
           plo     rf

           sep     scall
           dw      o_msg

           sep     scall
           dw      o_inmsg
           db      13,10,0

           lbr     main

output:    ldi     high outinst
           phi     rc
           ldi     low outinst
           plo     rc

           glo     rd
           ori     60h
           str     rc

outloop:   sep     scall
           dw      f_ltrim

           ldn     rf
           sep     scall
           dw      f_ishex
           lbnf    main

           sep     scall
           dw      f_hexin

           glo     rd
           str     r2
outinst:   out     1
           dec     r2

           lbr     outloop

end:       ; That's all folks!

buffer:    db      0
