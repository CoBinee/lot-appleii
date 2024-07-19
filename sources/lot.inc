; lot.inc - ロットロットロット
; 


; ゼロページ
;
LOT_0                               :=  GAME_0_LOT
LOT_0_SRC                           :=  GAME_0_LOT + $00
LOT_0_SRC_L                         :=  GAME_0_LOT + $00
LOT_0_SRC_H                         :=  GAME_0_LOT + $01
LOT_0_DST                           :=  GAME_0_LOT + $02
LOT_0_DST_L                         :=  GAME_0_LOT + $02
LOT_0_DST_H                         :=  GAME_0_LOT + $03
LOT_0_WORK_0                        :=  GAME_0_LOT + $04
LOT_0_WORK_1                        :=  GAME_0_LOT + $05

; ロットロットロット
;

; フィールド
;
LOT_FIELD_SIZE_X                    =   $20
LOT_FIELD_SIZE_Y                    =   $18
LOT_FIELD_SIZE                      =   $0300
LOT_FIELD_NULL                      =   $00
LOT_FIELD_BALL                      =   $01
LOT_FIELD_BLOCK                     =   $10
LOT_FIELD_BLOCK_OUT_START           =   $10
LOT_FIELD_BLOCK_OUT_END             =   $15
LOT_FIELD_BLOCK_IN_START            =   $2a
LOT_FIELD_BLOCK_IN_END              =   $2f
LOT_FIELD_BLOCK_SIZE                =   $20

; カーソル
LOT_CURSOR_SIZE                     =   $48 ; $64
LOT_CURSOR_POSITION_START           =   $03
LOT_CURSOR_POSITION_LEFT            =   $01
LOT_CURSOR_POSITION_RIGHT           =   $17
LOT_CURSOR_POSITION_TOP             =   $03
LOT_CURSOR_POSITION_BOTTOM          =   $15
LOT_CURSOR_MOVE_NULL                =   $00
LOT_CURSOR_MOVE_LEFT                =   $01
LOT_CURSOR_MOVE_RIGHT               =   $02
LOT_CURSOR_MOVE_UP                  =   $03
LOT_CURSOR_MOVE_DOWN                =   $04

; ハイスコア
LOT_HISCORE_DEFAULT                 =   1000

; ロットロットロット情報
;
.struct Lot

    ; フィールド
    field               .byte   $0300

    ; 縦の壁
    vwall_block         .byte
    vwall_position      .byte

    ; 横の壁
    hwall_block         .byte
    hwall_position      .byte

    ; カーソル
    cursor_position     .byte   $0064
    cursor_move         .byte

    ; ゲームオーバー
    over                .byte

    ; スコア
    score_l             .byte
    score_h             .byte
    score_value_draw    .byte
    score_title_draw    .byte

    ; ハイスコア
    hiscore_l           .byte
    hiscore_h           .byte
    hiscore_value_draw  .byte
    hiscore_title_draw  .byte

    ; ガイド
    guide_draw          .byte

.endstruct
