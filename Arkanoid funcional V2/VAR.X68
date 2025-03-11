; ==============================================================================
; GAME VARIABLES
; ==============================================================================

; --- PAD RELATED VARIABLES ----------------------------------------------------

PADPOSX         DS.W    1                       ; PAD Y COORDINATE

; --- SCOREBOARD RELATED VARIABLES ---------------------------------------------

SCOPOINT        DS.W    1                       ; NUMBER OF CAPTURED BALLS
SCOTIME         DS.W    1                       ; NUMBER OF THE TIME
LIFES           DS.W    1

; --- BLOCK VARIABLES ----------------------------------------------------------

BLOCKTOTAL      DS.W    1                       ; NUMBER OF BLOCKS
BLOCKPOSX       DS.W    1                       ; BLOCK X COORDINATES
BLOCKPOSY       DS.W    1                       ; BLOCK Y COORDINATES
BLOCKFCOL       DS.L    1                       ; BLOCK FIL COLOR
XLIST           DS.W    36                      ; BLOCK X COORDINATES LIST
YLIST           DS.W    36                      ; BLOCK Y COORDINATES LIST

; --- STATE RELATED VARIABLES ----------------------------------------------------------

STACUR      DS.W    1                           ; CURRENT STATE  
STANEXT     DS.W    1                           ; NEXT STATE
    

*; ---TIME RELATED VARIABLE ------------------------------------------------------
*AUTOTIMER       DS.W    1
*
*
* ADDQ.W #1(AUTOTIMER)
* CMP.W  #500,(AUTOTIMER)
* BLT    .DONE
* 
* MOVE   #2(STANEXT)



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
