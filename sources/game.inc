; game.inc - ゲーム
; 


; ゼロページ
;
GAME_0                              :=  APP_0_USER
GAME_0_BLINK                        :=  APP_0_USER + $00
GAME_0_LOT                          :=  APP_0_USER + $01

; ゲーム
;

; ゲーム情報
;
.struct Game

    reserved        .byte

.endstruct
