; =============================================================================
; TITLE    : PAD MANAGEMENT
; AUTHOR   : Valentino Coppola Ferrari y Constantino Byelov Serdiuk
; =============================================================================

;------------------------------------------------------------------------------
PADINIT
; INITIALIZE THE PAD
; Dividimos el tamaño de la pantalla en 2 para obtener la posición central
; y situamos nuestro pad ahí
;------------------------------------------------------------------------------
    
    MOVE.W #SCRWIDTH/2,(PADPOSX)
    RTS
    
; -----------------------------------------------------------------------------
PADUPD
; UPDATE THE PAD
;
; -----------------------------------------------------------------------------
     MOVE.W   D0,-(A7)
     MOVE.W  (MOUPOSX),D0

  ;CHECHK COLLISIONS
.CONT
    CMP.W   #PADWIDTH/2,D0
    BGE     .CONT2
    MOVE.W  #PADWIDTH/2,D0
    BRA     .DONE
.CONT2
    CMP.W   #SCRWIDTH-PADWIDTH/2,D0
    BLE     .DONE   
    MOVE.W  #SCRWIDTH-PADWIDTH/2,D0
    
.DONE
    MOVE.W  D0,(PADPOSX)
    MOVE.W  (A7)+,D0

    RTS
  


  
; -----------------------------------------------------------------------------
PADCONF
; CONFIGURATE THE PAD
; -----------------------------------------------------------------------------
  
  MOVEM.L D0-D4,-(A7)             ; STACK REGISTER
  
  MOVE.B #80,D0                   ;SET PEN COLOR TASK
  MOVE.L #PADPCOL,D1              ;PAD COLOR
  TRAP #15
  MOVE.B #81,D0
  MOVE.L #PADFCOL,D1              ;FILLCOL
  TRAP #15

  ;DEFINE COORDINATES
  MOVE.W (PADPOSX),D1
  SUB.W #PADWIDTH/2,D1
  MOVE.W D1,D3
  ADD.W #PADWIDTH,D3
  
  MOVE.W #PADY-PADHEIGH/2,D2
  MOVE.W #PADY+PADHEIGH/2,D4
  
  ;DRAW PAD
  MOVE.B    #87,D0
  TRAP      #15 
  
  MOVEM.L   (A7)+,D0-D4
  RTS
  
  
  
  
  
  






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
