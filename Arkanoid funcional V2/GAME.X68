; =============================================================================
; TITLE    : GAME MANAGEMENT
; AUTHOR   : Valentino Coppola Ferrari y Constantino Byelov Serdiuk
; =============================================================================

;------------------------------------------------------------------------------
GAMEINIT
;
;
;------------------------------------------------------------------------------
            MOVEM.L D0-D7/A1-A3,-(A7)
            
            JSR PADINIT
            JSR POINTINIT
            
            ;BALL INIT
            LEA     BALLINIT,A1
            LEA     BALLUPD,A2
            LEA     BALLCONF,A3
            MOVE.W  #1,D0
         
            JSR     AGLADD
            
            ;BLOCK  INIT
            
            MOVE.L  #$00C0C0C0,(BLOCKFCOL)      ; SET BLOCK FILL COLOR
            MOVE.W  #80,(BLOCKPOSY)             ; SET FIRST WALL LINE Y
            MOVE.W  #50,(BLOCKPOSX)             ; SET FIRST WALL X IN A LINE
            
            MOVE.W  #30,(BLOCKTOTAL)
            MOVE.W  #2,D4
            MOVE.W  #9,D3
            
            
            MOVE.W  #BLOCKID,D0                 ; AGENT ID
            MOVE.W  (BLOCKPOSX),D1              ; AGENT INIT PARAMETER 1
            MOVE.W  (BLOCKPOSY),D2              ; AGENT INIT PARAMETER 2

            LEA     BLOCKINIT,A1                ; POINTER TO AGENT INIT FUNCTION
            LEA     BLOCKUPD,A2                 ; POINTER TO AGENT UPDATE FUNCTION
            LEA     BLOCKPLOT,A3                ; POINTER TO AGENT PLOT FUNCTION 

            BRA .ADDBLOCK
            
.LOOP       ADD.W   #60,(BLOCKPOSX)
            MOVE.W  (BLOCKPOSX),D1
            MOVE.W  (BLOCKPOSY),D2


.ADDBLOCK   JSR AGLADD
            DBRA D3,.LOOP
          
            MOVE.W  #9,D3
            MOVE.W  #50,(BLOCKPOSX)
            ADD.W  #35,(BLOCKPOSY)
            
            DBRA   D4,.ADDBLOCK
            MOVE.W  #50,(BLOCKPOSX)             
            MOVE.W  #80,(BLOCKPOSY) 
            
            MOVEM.L (A7)+,D0-D7/A1-A3
            RTS
            
            
;------------------------------------------------------------------------------
GAMEUPD
;UPDATE THE GAME
;
;------------------------------------------------------------------------------

            MOVEM.L D0-D7/A0-A2,-(A7)
            JSR     PADUPD
            JSR     POINTUPD
            JSR     FPSUPD
            
            LEA     XLIST,A1                ; LOAD (X,Y) BLOCK LIST 
            LEA     YLIST,A2
            MOVE.W  #BLOCKID,D0             ; LOAD BLOCKID INTO D0
            JSR     DMMFRSTO                ; GET FIRST AGENT SEARCHING THE ID
            
.LOADBLOCKS 
            CMP.L   #0,A0                   ; CHECK IF BLOCK EXISTS
            BEQ     .AGTUPD                 ; IF DOESN'T EXIST UPDATE AGENT LIST
            
            MOVE.W  8(A0),(A1)+             ; ADD AGENT (X,Y) COORDINATES TO LISTS
            MOVE.W  10(A0),(A2)+            
            
            JSR     DMMNEXTO                ; LOAD NEXT BLOCK
            BRA     .LOADBLOCKS             
            
            ; UPDATE AGENT LIST
.AGTUPD     JSR     AGLUPD                  ; UPDATE AGENT LIST  


            ; BLOCK AGENT KILL          
            LEA     BLOCKPOSX,A1            ; LOAD (X,Y) BLOCK COORDINATES
            LEA     BLOCKPOSY,A2
            MOVE.W  #BLOCKID,D0             ; LOAD BLOCKID INTO D0
            JSR     DMMFRSTO                ; GET FIRST AGENT SEARCHING THE ID
            
.BLOCKKILL  
            CMP.L   #0,A0                   ; CHECK IF EXISTS
            BEQ     .WIN                    ; IF IT DOESN'T EXIST CHECK IF PLAYER WON
            MOVE.W  (A1),D2
            MOVE.W  (A2),D3
            CMP.W    8(A0),D2               ; CHECK (X,Y) COORDINATES TO LOCATE THE 
                                            ; BLOCK THAT WE NEED TO KILL
            BNE     .NEXT                    
            CMP.W    10(A0),D3               
            BNE     .NEXT                   
            JSR     AGLKILL                 ; IF X=BLOCKPOSX & Y=BLOCKPOSY THEN WE HAVE LOCATED 
                                            ; THE BLOCK AND PROCED TO KILL IT
                                            
            ADD.W  #10,(SCOPOINT)           ; ADD 10 POINT TO SCOREBOARD FOR BLOCK BREAK
            MOVE.W  (BLOCKTOTAL),D4
            SUB.W   #1,D4                   ; DECREMENT Nº OF TOTAL BLOCKS 
            MOVE.W  D4,(BLOCKTOTAL)
            BRA     .WIN                    

.NEXT       
            JSR     DMMNEXTO                ; GET NEXT BLOCK
            BRA     .BLOCKKILL  

.WIN    
            MOVE.W  (BLOCKTOTAL),D5
            CMP.W   #0,D5                   ; CHECK IF THERE ARE WALLS LEFT 
            BNE     .CHECKLIFES             ; CHECK PLAYER LIFES
            MOVE.W  #2,(STANEXT)            ; IF TEHRE ARE NO WALLS LEFT AND PLAYER HAS LIFES 
                                            ; THE PLAYER WON AND IS REDIRECTED TO WIN STATE
            BRA     .END
            
.CHECKLIFES            
            CMP     #0,(LIFES)              ; CHECK IF PLAYER HAS MORE THAN 0 LIFES 
            BLE     .GOVER                  ; IF PLAYER HAS 0 OR LESS LIFES, THE PLAYER LOST AND IS REDIRECTED TO GAME OVER STATE
            BRA     .END
            
.GOVER      
            MOVE.W  #3,(STANEXT)            ; GAME OVER

.END        MOVEM.L (A7)+,D0-D7/A0-A2
            RTS

;------------------------------------------------------------------------------
GAMEPLOT
;
;
;------------------------------------------------------------------------------
            JSR AGLPLOT
            JSR POINTPLOT
            JSR PADCONF
            RTS
      





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
