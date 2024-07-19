; lot.s - ロットロットロット
;


; 6502 - CPU の選択
.setcpu     "6502"

; 自動インポート
.autoimport +

; エスケープシーケンスのサポート
.feature    string_escapes


; ファイルの参照
;
.include    "apple2.inc"
.include    "iocs.inc"
.include    "app.inc"
.include    "game.inc"
.include    "lot.inc"


; コードの定義
;
.segment    "APP"

; ロットロットロットの初期化
;
.global _LotInitialize
.proc   _LotInitialize

    ; ロットロットロットの初期化

    ; 0 クリア
    lda     #<lot
    sta     LOT_0_DST_L
    lda     #>lot
    sta     LOT_0_DST_H
    ldy     #$00
:
    tya
    sta     (LOT_0_DST), y
    inc     LOT_0_DST_L
    bne     :+
    inc     LOT_0_DST_H
:
    lda     LOT_0_DST_L
    cmp     #<(lot + .sizeof (Lot))
    bne     :--
    lda     LOT_0_DST_H
    cmp     #>(lot + .sizeof (Lot))
    bne     :--

    ; スコアの初期化
    lda     #$00
    sta     lot + Lot::score_l
    sta     lot + Lot::score_h
    lda     #$01
    sta     lot + Lot::score_value_draw
    sta     lot + Lot::score_title_draw

    ; ハイスコアの初期化
    lda     #<LOT_HISCORE_DEFAULT
    sta     lot + Lot::hiscore_l
    lda     #>LOT_HISCORE_DEFAULT
    sta     lot + Lot::hiscore_h
    lda     #$01
    sta     lot + Lot::hiscore_value_draw
    sta     lot + Lot::hiscore_title_draw

    ; 終了
    rts

.endproc

; ロットロットロットをロードする
;
.global _LotLoad
.proc   _LotLoad

    ; フィールドの設定
    lda     #LOT_FIELD_NULL + $80
    ldx     #$00
:
    sta     lot + Lot::field + $0000, x
    sta     lot + Lot::field + $0100, x
    sta     lot + Lot::field + $0200, x
    inx
    bne     :-
    lda     #<(lot + Lot::field + $0040)
    sta     LOT_0_DST_L
    lda     #>(lot + Lot::field + $0040)
    sta     LOT_0_DST_H
    ldx     #$16
:
    lda     #(LOT_FIELD_BLOCK + LOT_FIELD_BLOCK_SIZE - $01) + $80
    ldy     #$00
:
    sta     (LOT_0_DST), y
    iny
    iny
    iny
    iny
    iny
    iny
    cpy     #($06 * $05)
    bne     :-
    lda     LOT_0_DST_L
    clc
    adc     #$20
    sta     LOT_0_DST_L
    bcc     :+
    inc     LOT_0_DST_H
:
    dex
    bne     :---
    lda     #(LOT_FIELD_BLOCK + LOT_FIELD_BLOCK_SIZE - $01) + $80
    ldx     #$00
:
    sta     lot + Lot::field + $0040, x
    sta     lot + Lot::field + $00e0, x
    sta     lot + Lot::field + $0180, x
    sta     lot + Lot::field + $0220, x
    sta     lot + Lot::field + $02c0, x
    inx
    cpx     #$19
    bne     :-
    lda     #(LOT_FIELD_BLOCK + LOT_FIELD_BLOCK_SIZE - $01) + $80
    sta     lot + Lot::field + $0000
    sta     lot + Lot::field + $0018
    sta     lot + Lot::field + $0020
    sta     lot + Lot::field + $0038

    ; カーソルの設定
    lda     #LOT_CURSOR_POSITION_START
    ldx     #$00
:
    sta     lot + Lot::cursor_position, x
    inx
    cpx     #LOT_CURSOR_SIZE
    bne     :-
    lda     #LOT_CURSOR_MOVE_NULL
    sta     lot + Lot::cursor_move

    ; 縦の壁の設定
    lda     #(LOT_FIELD_BLOCK + $1f) + $80
    sta     lot + Lot::vwall_block
    lda     #$00
    sta     lot + Lot::vwall_position
    lda     #(LOT_FIELD_BLOCK + $0f) + $80
    sta     lot + Lot::hwall_block
    lda     #$00
    sta     lot + Lot::hwall_position

    ; ゲームオーバーの設定
    lda     #$00
    sta     lot + Lot::over

    ; スコアの設定
    lda     #$00
    sta     lot + Lot::score_l
    sta     lot + Lot::score_h
    lda     #$01
    sta     lot + Lot::score_value_draw

    ; ハイスコアの設定
    lda     #$01
    sta     lot + Lot::hiscore_value_draw

    ; ガイドの初期化
    lda     #$01
    sta     lot + Lot::guide_draw

    ; 終了
    rts

.endproc

; ロットロットロットを更新する
;
.global _LotUpdate
.proc   _LotUpdate

    ; 新しいボールの生成
    lda     #LOT_FIELD_BALL + $80
    sta     lot + Lot::field + $0001

    ; 最下段のクリア
    ldx     #$00
:
    lda     lot + Lot::field + $02e0, x
    and     #$7f
    cmp     #LOT_FIELD_BALL
    bne     :+
    lda     #LOT_FIELD_NULL + $80
    sta     lot + Lot::field + $02e0, x
:
    inx
    cpx     #LOT_FIELD_SIZE_X
    bne     :--

    ; 縦の壁の更新
    lda     lot + Lot::vwall_block
    cmp     #((LOT_FIELD_BLOCK_OUT_END + $01) + $01) + $80
    bcc     :+
    cmp     #LOT_FIELD_BLOCK_IN_START + $80
    bcc     @vwall_next
:
    ldx     lot + Lot::vwall_position
    lda     @update_vwall_position_l, x
    sta     LOT_0_DST_L
    lda     @update_vwall_position_h, x
    sta     LOT_0_DST_H
    ldx     lot + Lot::vwall_block
    ldy     #$00
:
    txa
    sta     (LOT_0_DST), y
    tya
    clc
    adc     #$20
    tay
    cmp     #($20 * 4)
    bne     :-
@vwall_next:
    inc     lot + Lot::vwall_block
    lda     lot + Lot::vwall_block
    cmp     #(LOT_FIELD_BLOCK + LOT_FIELD_BLOCK_SIZE) + $80
    bcc     @vwall_end
    lda     #LOT_FIELD_BLOCK + $80
    sta     lot + Lot::vwall_block
    jsr     _IocsGetRandomNumber
    and     #$0f
    sta     lot + Lot::vwall_position
@vwall_end:

    ; 横の壁の更新
    lda     lot + Lot::hwall_block
    cmp     #((LOT_FIELD_BLOCK_OUT_END + $01) + $01) + $80
    bcc     :+
    cmp     #LOT_FIELD_BLOCK_IN_START + $80
    bcc     @hwall_next
:
    ldx     lot + Lot::hwall_position
    lda     @update_hwall_position_l, x
    sta     LOT_0_DST_L
    lda     @update_hwall_position_h, x
    sta     LOT_0_DST_H
    lda     lot + Lot::hwall_block
    ldy     #$00
:
    sta     (LOT_0_DST), y
    iny
    cpy     #$05
    bne     :-
@hwall_next:
    inc     lot + Lot::hwall_block
    lda     lot + Lot::hwall_block
    cmp     #(LOT_FIELD_BLOCK + LOT_FIELD_BLOCK_SIZE) + $80
    bcc     @hwall_end
    lda     #LOT_FIELD_BLOCK + $80
    sta     lot + Lot::hwall_block
:
    jsr     _IocsGetRandomNumber
    and     #$1f
    cmp     #$14
    bcs     :-
    sta     lot + Lot::hwall_position
@hwall_end:

    ; ランダムに穴を開ける
    lda     lot + Lot::score_h
    asl     a
    sta     LOT_0_WORK_0
    jsr     _IocsGetRandomNumber
    and     #$7f
    cmp     LOT_0_WORK_0
    bcs     @hole_end
    eor     lot + Lot::score_l
    sta     LOT_0_WORK_0
    lda     #$00
    asl     LOT_0_WORK_0
    adc     #$00
    sta     LOT_0_WORK_1
    lda     #$40
    clc
    adc     LOT_0_WORK_0
    sta     LOT_0_WORK_0
    lda     #$00
    adc     LOT_0_WORK_1
    sta     LOT_0_WORK_1
    lda     LOT_0_WORK_0
    and     #$1f
    beq     @hole_end
    lda     #<(lot + Lot::field)
    clc
    adc     LOT_0_WORK_0
    sta     LOT_0_DST_L
    lda     #>(lot + Lot::field)
    adc     LOT_0_WORK_1
    sta     LOT_0_DST_H
    lda     #LOT_FIELD_NULL + $80
    ldy     #$00
    sta     (LOT_0_DST), y
@hole_end:

    ; ボールの移動
    lda     #<(lot + Lot::field + (LOT_FIELD_SIZE_Y - $02) * LOT_FIELD_SIZE_X)
    sta     LOT_0_SRC_L
    lda     #>(lot + Lot::field + (LOT_FIELD_SIZE_Y - $02) * LOT_FIELD_SIZE_X)
    sta     LOT_0_SRC_H
    lda     #(LOT_FIELD_SIZE_X - $01)
    sta     LOT_0_WORK_0
    lda     #(LOT_FIELD_SIZE_Y - $01)
    sta     LOT_0_WORK_1
@move_head:
    ldy     LOT_0_WORK_0
    lda     (LOT_0_SRC), y
    and     #$7f
    cmp     #(LOT_FIELD_BLOCK_OUT_END + $01)
    bne     :+
    lda     #LOT_FIELD_NULL + $80
    sta     (LOT_0_SRC), y
    jmp     @move_next
:
    cmp     #LOT_FIELD_BALL
    bne     @move_next
    lda     #LOT_FIELD_SIZE_X
    clc
    adc     LOT_0_WORK_0
    tay
    lda     (LOT_0_SRC), y
    and     #$7f
    beq     @move_ball
    ldy     LOT_0_WORK_0
    dey
    lda     (LOT_0_SRC), y
    and     #$7f
    beq     :+
    ldy     LOT_0_WORK_0
    iny
    lda     (LOT_0_SRC), y
    and     #$7f
    beq     @move_ball
    jmp     @move_next
:
    ldy     LOT_0_WORK_0
    iny
    lda     (LOT_0_SRC), y
    and     #$7f
    beq     :+
    dey
    dey
    jmp     @move_ball
:
    jsr     _IocsGetRandomNumber
    and     #$02
    sec
    sbc     #$01
    clc
    adc     LOT_0_WORK_0
    tay
;   jmp     @move_ball
@move_ball:
    lda     #LOT_FIELD_BALL + $80
    sta     (LOT_0_SRC), y
    lda     #LOT_FIELD_NULL + $80
    ldy     LOT_0_WORK_0
    sta     (LOT_0_SRC), y
@move_next:
    lda     LOT_0_WORK_0
    beq     :+
    dec     LOT_0_WORK_0
    jmp     @move_head
:
    dec     LOT_0_WORK_1
    beq     @move_end
    lda     LOT_0_SRC_L
    sec
    sbc     #LOT_FIELD_SIZE_X
    sta     LOT_0_SRC_L
    bcs     :+
    dec     LOT_0_SRC_H
:
    lda     #(LOT_FIELD_SIZE_X - $01)
    sta     LOT_0_WORK_0
    jmp     @move_head
@move_end:

    ; スコアの計算
    lda     lot + Lot::over
    bne     @score_end
    ldy     #$00
    ldx     #$07
:
    lda     lot + Lot::field + $02f9 - $0001, x
    and     #$7f
    beq     :+
    iny
    iny
:
    dex
    bne     :--
    ldx     #$05
:
    lda     lot + Lot::field + $02f3 - $0001, x
    and     #$7f
    beq     :+
    iny
:
    dex
    bne     :--
    ldx     #$05
:
    lda     lot + Lot::field + $02e7 - $0001, x
    and     #$7f
    beq     :+
    dey
    dey
    dey
:
    dex
    bne     :--
    tya
    beq     @score_end
    bmi     :+
    clc
    adc     lot + Lot::score_l
    sta     lot + Lot::score_l
    bcc     @score_value_draw
    inc     lot + Lot::score_h
    bne     @score_value_draw
    lda     #$ff
    sta     lot + Lot::score_l
    sta     lot + Lot::score_h
    jmp     @score_value_draw
:
    eor     #$ff
    sta     LOT_0_WORK_0
    inc     LOT_0_WORK_0
    lda     lot + Lot::score_l
    sec
    sbc     LOT_0_WORK_0
    sta     lot + Lot::score_l
    bcs     @score_value_draw
    dec     lot + Lot::score_h
    lda     lot + Lot::score_h
    cmp     #$ff
    bne     @score_value_draw
    lda     #$00
    sta     lot + Lot::score_l
    sta     lot + Lot::score_h
@score_value_draw:
    lda     #$01
    sta     lot + Lot::score_value_draw
@score_end:

    ; ゲームオーバーの取得
    ldx     #$05
:
    lda     lot + Lot::field + $02e1 - $0001, x
    and     #$7f
    beq     :+
    inc     lot + Lot::over
:
    dex
    bne     :--

    ; カーソルの移動
    lda     lot + Lot::over
    beq     :+
    jmp     @cursor_over
:
    ldx     lot + Lot::cursor_position + LOT_CURSOR_SIZE - $0002
    ldy     lot + Lot::cursor_position + LOT_CURSOR_SIZE - $0001
    jsr     @cursor_draw
    ldx     lot + Lot::cursor_position + $0000
    ldy     lot + Lot::cursor_position + $0001
    jsr     @cursor_draw
    ldx     #LOT_CURSOR_SIZE - $02
:
    lda     lot + Lot::cursor_position - $0001, x
    sta     lot + Lot::cursor_position + $0001, x
    dex
    bne     :-
    lda     IOCS_0_KEYCODE
    ldx     #LOT_CURSOR_MOVE_LEFT
    cmp     #'A'
    beq     :+
    cmp     #'J'
    beq     :+
    inx
    cmp     #'D'
    beq     :+
    cmp     #'L'
    beq     :+
    inx
    cmp     #'W'
    beq     :+
    cmp     #'I'
    beq     :+
    inx
    cmp     #'S'
    beq     :+
    cmp     #'K'
    bne     @cursor_move
:
    cpx     lot + Lot::cursor_move
    bne     :+
    ldx     #LOT_CURSOR_MOVE_NULL
:
    stx     lot + Lot::cursor_move
@cursor_move:
    ldx     lot + Lot::cursor_position + $0002
    ldy     lot + Lot::cursor_position + $0003
    lda     lot + Lot::cursor_move
    cmp     #LOT_CURSOR_MOVE_LEFT
    bne     :+
    cpx     #LOT_CURSOR_POSITION_LEFT
    beq     @cursor_moved
    dex
    jmp     @cursor_moved
:
    cmp     #LOT_CURSOR_MOVE_RIGHT
    bne     :+
    cpx     #LOT_CURSOR_POSITION_RIGHT
    beq     @cursor_moved
    inx
    jmp     @cursor_moved
:
    cmp     #LOT_CURSOR_MOVE_UP
    bne     :+
    cpy     #LOT_CURSOR_POSITION_TOP
    beq     @cursor_moved
    dey
    jmp     @cursor_moved
:
    cmp     #LOT_CURSOR_MOVE_DOWN
    bne     @cursor_moved
    cpy     #LOT_CURSOR_POSITION_BOTTOM
    beq     @cursor_moved
    iny
;   jmp     @cursor_moved
@cursor_moved:
    stx     lot + Lot::cursor_position + $0000
    sty     lot + Lot::cursor_position + $0001
@cursor_over:
    ldx     lot + Lot::cursor_position + LOT_CURSOR_SIZE - $0002
    ldy     lot + Lot::cursor_position + LOT_CURSOR_SIZE - $0001
    jsr     @cursor_undraw
    ldx     lot + Lot::cursor_position + $0000
    ldy     lot + Lot::cursor_position + $0001
    jsr     @cursor_undraw
    jmp     @cursor_end
@cursor_draw:
    lda     #$00
    sta     LOT_0_WORK_0
    tya
    lsr     a
    ror     LOT_0_WORK_0
    lsr     a
    ror     LOT_0_WORK_0
    lsr     a
    ror     LOT_0_WORK_0
    sta     LOT_0_WORK_1
    txa
    ora     LOT_0_WORK_0
    clc
    adc     #<(lot + Lot::field)
    sta     LOT_0_WORK_0
    lda     LOT_0_WORK_1
    adc     #>(lot + Lot::field)
    sta     LOT_0_WORK_1
    ldy     #$00
    lda     (LOT_0_WORK_0), y
    ora     #$80
    sta     (LOT_0_WORK_0), y
    iny
    lda     (LOT_0_WORK_0), y
    ora     #$80
    sta     (LOT_0_WORK_0), y
    ldy     #LOT_FIELD_SIZE_X
    lda     (LOT_0_WORK_0), y
    ora     #$80
    sta     (LOT_0_WORK_0), y
    iny
    lda     (LOT_0_WORK_0), y
    ora     #$80
    sta     (LOT_0_WORK_0), y
    rts
@cursor_undraw:
    lda     #$00
    sta     LOT_0_WORK_0
    tya
    lsr     a
    ror     LOT_0_WORK_0
    lsr     a
    ror     LOT_0_WORK_0
    lsr     a
    ror     LOT_0_WORK_0
    sta     LOT_0_WORK_1
    txa
    ora     LOT_0_WORK_0
    clc
    adc     #<(lot + Lot::field)
    sta     LOT_0_WORK_0
    lda     LOT_0_WORK_1
    adc     #>(lot + Lot::field)
    sta     LOT_0_WORK_1
    ldy     #$00
    lda     (LOT_0_WORK_0), y
    and     #$7f
    sta     (LOT_0_WORK_0), y
    iny
    lda     (LOT_0_WORK_0), y
    and     #$7f
    sta     (LOT_0_WORK_0), y
    ldy     #LOT_FIELD_SIZE_X
    lda     (LOT_0_WORK_0), y
    and     #$7f
    sta     (LOT_0_WORK_0), y
    iny
    lda     (LOT_0_WORK_0), y
    and     #$7f
    sta     (LOT_0_WORK_0), y
    rts
@cursor_end:

    ; ボールの入れ替え
    lda     lot + Lot::over
    beq     :+
    jmp     @swap_end
:
    lda     IOCS_0_KEYCODE
    cmp     #' '
    beq     :+
    cmp     #'F'
    beq     :+
    cmp     #'H'
    beq     :+
    jmp     @swap_end
:
    ldx     lot + Lot::cursor_position + LOT_CURSOR_SIZE - $0002
    ldy     lot + Lot::cursor_position + LOT_CURSOR_SIZE - $0001
    jsr     @swap_position
    stx     LOT_0_SRC_L
    sta     LOT_0_SRC_H
    ldx     lot + Lot::cursor_position + $0000
    ldy     lot + Lot::cursor_position + $0001
    jsr     @swap_position
    stx     LOT_0_DST_L
    sta     LOT_0_DST_H
    lda     #$04
    sta     LOT_0_WORK_0
    ldy     #$00
:
    lda     #$05
    sta     LOT_0_WORK_1
:
    lda     (LOT_0_SRC), y
    tax
    lda     (LOT_0_DST), y
    ora     #$80
    sta     (LOT_0_SRC), y
    txa
    ora     #$80
    sta     (LOT_0_DST), y
    iny
    dec     LOT_0_WORK_1
    bne     :-
    tya
    clc
    adc     #(LOT_FIELD_SIZE_X - $05)
    tay
    dec     LOT_0_WORK_0
    bne     :--
    ldx     #<@beep
    lda     #>@beep
    jsr     _IocsBeepQue
    jmp     @swap_end
@swap_position:
    lda     #<(lot + Lot::field + $0061)
    sta     LOT_0_WORK_0
    lda     #>(lot + Lot::field + $0061)
    sta     LOT_0_WORK_1
:
    txa
    sec
    sbc     #$06
    tax
    bcc     :+
    lda     LOT_0_WORK_0
    clc
    adc     #$06
    sta     LOT_0_WORK_0
    bcc     :-
    inc     LOT_0_WORK_1
    jmp     :-
:
    dey
    dey
    dey
:
    tya
    sec
    sbc     #$05
    tay
    bcc     :+
    lda     LOT_0_WORK_0
    clc
    adc     #$a0
    sta     LOT_0_WORK_0
    bcc     :-
    inc     LOT_0_WORK_1
    jmp     :-
:
    ldx     LOT_0_WORK_0
    lda     LOT_0_WORK_1
    rts
@swap_end:

    ; 終了
    rts

; 縦の壁
@update_vwall_position_l:
    .byte   <(lot + Lot::field + $0066)
    .byte   <(lot + Lot::field + $006c)
    .byte   <(lot + Lot::field + $0072)
    .byte   <(lot + Lot::field + $0078)
    .byte   <(lot + Lot::field + $0106)
    .byte   <(lot + Lot::field + $010c)
    .byte   <(lot + Lot::field + $0112)
    .byte   <(lot + Lot::field + $0118)
    .byte   <(lot + Lot::field + $01a6)
    .byte   <(lot + Lot::field + $01ac)
    .byte   <(lot + Lot::field + $01b2)
    .byte   <(lot + Lot::field + $01b8)
    .byte   <(lot + Lot::field + $0246)
    .byte   <(lot + Lot::field + $024c)
    .byte   <(lot + Lot::field + $0252)
    .byte   <(lot + Lot::field + $0258)
@update_vwall_position_h:
    .byte   >(lot + Lot::field + $0066)
    .byte   >(lot + Lot::field + $006c)
    .byte   >(lot + Lot::field + $0072)
    .byte   >(lot + Lot::field + $0078)
    .byte   >(lot + Lot::field + $0106)
    .byte   >(lot + Lot::field + $010c)
    .byte   >(lot + Lot::field + $0112)
    .byte   >(lot + Lot::field + $0118)
    .byte   >(lot + Lot::field + $01a6)
    .byte   >(lot + Lot::field + $01ac)
    .byte   >(lot + Lot::field + $01b2)
    .byte   >(lot + Lot::field + $01b8)
    .byte   >(lot + Lot::field + $0246)
    .byte   >(lot + Lot::field + $024c)
    .byte   >(lot + Lot::field + $0252)
    .byte   >(lot + Lot::field + $0258)

; 横の壁
@update_hwall_position_l:
    .byte   <(lot + Lot::field + $0041)
    .byte   <(lot + Lot::field + $0047)
    .byte   <(lot + Lot::field + $004d)
    .byte   <(lot + Lot::field + $0053)
    .byte   <(lot + Lot::field + $00e1)
    .byte   <(lot + Lot::field + $00e7)
    .byte   <(lot + Lot::field + $00ed)
    .byte   <(lot + Lot::field + $00f3)
    .byte   <(lot + Lot::field + $0181)
    .byte   <(lot + Lot::field + $0187)
    .byte   <(lot + Lot::field + $018d)
    .byte   <(lot + Lot::field + $0193)
    .byte   <(lot + Lot::field + $0221)
    .byte   <(lot + Lot::field + $0227)
    .byte   <(lot + Lot::field + $022d)
    .byte   <(lot + Lot::field + $0233)
    .byte   <(lot + Lot::field + $02c1)
    .byte   <(lot + Lot::field + $02c7)
    .byte   <(lot + Lot::field + $02cd)
    .byte   <(lot + Lot::field + $02d3)
@update_hwall_position_h:
    .byte   >(lot + Lot::field + $0041)
    .byte   >(lot + Lot::field + $0047)
    .byte   >(lot + Lot::field + $004d)
    .byte   >(lot + Lot::field + $0053)
    .byte   >(lot + Lot::field + $00e1)
    .byte   >(lot + Lot::field + $00e7)
    .byte   >(lot + Lot::field + $00ed)
    .byte   >(lot + Lot::field + $00f3)
    .byte   >(lot + Lot::field + $0181)
    .byte   >(lot + Lot::field + $0187)
    .byte   >(lot + Lot::field + $018d)
    .byte   >(lot + Lot::field + $0193)
    .byte   >(lot + Lot::field + $0221)
    .byte   >(lot + Lot::field + $0227)
    .byte   >(lot + Lot::field + $022d)
    .byte   >(lot + Lot::field + $0233)
    .byte   >(lot + Lot::field + $02c1)
    .byte   >(lot + Lot::field + $02c7)
    .byte   >(lot + Lot::field + $02cd)
    .byte   >(lot + Lot::field + $02d3)

; BEEP
@beep:

    .byte   IOCS_BEEP_PI, 12
    .byte   IOCS_BEEP_END

.endproc

; ゲームオーバーを取得する
;
.global _LotGetOver
.proc   _LotGetOver

    ; OUT
    ;   a = !0 -> ゲームオーバー

    ; オーバーの取得
    lda     lot + Lot::over

    ; 終了
    rts

.endproc

; ハイスコアを更新する
;
.global _LotRecord
.proc   _LotRecord

    ; OUT
    ;   a = !0 -> ハイスコアが更新された

    ; ハイスコアの更新
    lda     lot + Lot::score_h
    cmp     lot + Lot::hiscore_h
    bcc     :++
    bne     :+
    lda     lot + Lot::score_l
    cmp     lot + Lot::hiscore_l
    bcc     :++
    beq     :++
:
    lda     lot + Lot::score_l
    sta     lot + Lot::hiscore_l
    lda     lot + Lot::score_h
    sta     lot + Lot::hiscore_h
    lda     #$01
    sta     lot + Lot::hiscore_value_draw
    jmp     :++
:
    lda     #$00
:

    ; 終了
    rts

.endproc

; ハイスコアを取得する
;
.global _LotGetHiscore
.proc   _LotGetHiscore

    ; OUT
    ;   ax = ハイスコア

    ; ハイスコアの取得
    ldx     lot + Lot::hiscore_l
    lda     lot + Lot::hiscore_h

    ; 終了
    rts

.endproc

; フィールドを再描画する
;
.global _LotRedrawField
.proc   _LotRedrawField

    ; IN
    ;   ax[0] = 開始 X 位置
    ;   ax[1] = 開始 Y 位置
    ;   ax[2] = 幅
    ;   ax[3] = 高さ

    ; 再描画
    jsr     LotPrepareDrawField
:
    ldy     #$00
:
    lda     (LOT_0_DST), y
    ora     #$80
    sta     (LOT_0_DST), y
    iny
    cpy     LOT_0_WORK_0
    bne     :-
    lda     #LOT_FIELD_SIZE_X
    clc
    adc     LOT_0_DST_L
    sta     LOT_0_DST_L
    bcc     :+
    inc     LOT_0_DST_H
:
    dec     LOT_0_WORK_1
    bne     :---

    ; 終了
    rts

.endproc

; フィールドの描画を抑制する
;
.global _LotUndrawField
.proc   _LotUndrawField

    ; IN
    ;   ax[0] = 開始 X 位置
    ;   ax[1] = 開始 Y 位置
    ;   ax[2] = 幅
    ;   ax[3] = 高さ

    ; 再描画
    jsr     LotPrepareDrawField
:
    ldy     #$00
:
    lda     (LOT_0_DST), y
    and     #$7f
    sta     (LOT_0_DST), y
    iny
    cpy     LOT_0_WORK_0
    bne     :-
    lda     #LOT_FIELD_SIZE_X
    clc
    adc     LOT_0_DST_L
    sta     LOT_0_DST_L
    bcc     :+
    inc     LOT_0_DST_H
:
    dec     LOT_0_WORK_1
    bne     :---

    ; 終了
    rts

.endproc

; 描画の準備をする
;
.proc   LotPrepareDrawField

    ; IN
    ;   ax[0] = 開始 X 位置
    ;   ax[1] = 開始 Y 位置
    ;   ax[2] = 幅
    ;   ax[3] = 高さ
    ; OUT
    ;   LOT_0_DST    = 描画位置
    ;   LOT_0_WORK_0 = 幅
    ;   LOT_0_WORK_1 = 高さ

    ; 描画の準備
    stx     LOT_0_SRC_L
    sta     LOT_0_SRC_H
    ldy     #$00
    lda     (LOT_0_SRC), y
    clc
    adc     #<(lot + Lot::field)
    sta     LOT_0_DST_L
    lda     #>(lot + Lot::field)
    adc     #$00
    sta     LOT_0_DST_H
    lda     #$00
    sta     LOT_0_WORK_0
    iny
    lda     (LOT_0_SRC), y
    lsr     a
    ror     LOT_0_WORK_0
    lsr     a
    ror     LOT_0_WORK_0
    lsr     a
    ror     LOT_0_WORK_0
    sta     LOT_0_WORK_1
    lda     LOT_0_WORK_0
    clc
    adc     LOT_0_DST_L
    sta     LOT_0_DST_L
    lda     LOT_0_WORK_1
    adc     LOT_0_DST_H
    sta     LOT_0_DST_H
    iny
    lda     (LOT_0_SRC), y
    sta     LOT_0_WORK_0
    iny
    lda     (LOT_0_SRC), y
    sta     LOT_0_WORK_1

    ; 終了
    rts

.endproc

; ロットロットロットを描画する
;
.global _LotDraw
.proc   _LotDraw

    ; ガイドの描画
    lda     lot + Lot::guide_draw
    beq     :+
    ldx     #<@draw_guide_arg
    lda     #>@draw_guide_arg
    jsr     _IocsDrawString
    lda     #$00
    sta     lot + Lot::guide_draw
:

    ; フィールドのガイド部分の非表示
    lda     #<@draw_guide_string
    sta     LOT_0_SRC_L
    lda     #>@draw_guide_string
    sta     LOT_0_SRC_H
    lda     #<(lot + Lot::field + $02e1)
    sta     LOT_0_DST_L
    lda     #>(lot + Lot::field + $02e1)
    sta     LOT_0_DST_H
    ldy     #$00
:
    lda     (LOT_0_SRC), y
    beq     :++
    cmp     #' '
    beq     :+
    lda     (LOT_0_DST), y
    and     #$7f
    sta     (LOT_0_DST), y
:
    iny
    jmp     :--
:

    ; 上段 8 行の描画
    lda     #$00
    sta     @draw_field_arg + $0000
    lda     #$00
    sta     @draw_field_arg + $0001
    lda     #<(lot + Lot::field + $0000)
    sta     LOT_0_SRC_L
    lda     #>(lot + Lot::field + $0000)
    sta     LOT_0_SRC_H
    jsr     @draw_8lines

    ; 中段 8 行の描画
    lda     #<(lot + Lot::field + $0100)
    sta     LOT_0_SRC_L
    lda     #>(lot + Lot::field + $0100)
    sta     LOT_0_SRC_H
    jsr     @draw_8lines

    ; 下段 8 行の描画
    lda     #<(lot + Lot::field + $0200)
    sta     LOT_0_SRC_L
    lda     #>(lot + Lot::field + $0200)
    sta     LOT_0_SRC_H
    jsr     @draw_8lines

    ; スコアの描画
    lda     lot + Lot::score_value_draw
    beq     :+
    ldx     lot + Lot::score_l
    lda     lot + Lot::score_h
    jsr     _IocsGetNumber5Chars
    stx     @draw_score_value_arg + $0002
    sta     @draw_score_value_arg + $0003
    ldx     #<@draw_score_value_arg
    lda     #>@draw_score_value_arg
    jsr     _IocsDrawString
    lda     #$00
    sta     lot + Lot::score_value_draw
:
    lda     lot + Lot::score_title_draw
    beq     :+
    ldx     #<@draw_score_title_arg
    lda     #>@draw_score_title_arg
    jsr     _IocsDrawString
    lda     #$00
    sta     lot + Lot::score_title_draw
:

    ; ハイスコアの描画
    lda     lot + Lot::hiscore_value_draw
    beq     :+
    ldx     lot + Lot::hiscore_l
    lda     lot + Lot::hiscore_h
    jsr     _IocsGetNumber5Chars
    stx     @draw_hiscore_value_arg + $0002
    sta     @draw_hiscore_value_arg + $0003
    ldx     #<@draw_hiscore_value_arg
    lda     #>@draw_hiscore_value_arg
    jsr     _IocsDrawString
    lda     #$00
    sta     lot + Lot::hiscore_value_draw
:
    lda     lot + Lot::hiscore_title_draw
    beq     :+
    ldx     #<@draw_hiscore_title_arg
    lda     #>@draw_hiscore_title_arg
    jsr     _IocsDrawString
    lda     #$00
    sta     lot + Lot::hiscore_title_draw
:

    ; カーソルの描画
    lda     lot + Lot::over
    bne     @cursor_end
    lda     lot + Lot::cursor_position + LOT_CURSOR_SIZE - $0001
    sta     @draw_cursor_arg + $0001
    lda     lot + Lot::cursor_position + LOT_CURSOR_SIZE - $0002
    sta     @draw_cursor_arg + $0000
    and     #$01
    asl     a
    asl     a
    asl     a
    clc
    adc     #$04
    sta     @draw_cursor_arg + $0004
    jsr     @cursor_draw
    lda     lot + Lot::cursor_position + $0001
    sta     @draw_cursor_arg + $0001
    lda     lot + Lot::cursor_position + $0000
    sta     @draw_cursor_arg + $0000
    and     #$01
    asl     a
    asl     a
    asl     a
    sta     @draw_cursor_arg + $0004
    jsr     @cursor_draw
    jmp     @cursor_end
@cursor_draw:
    ldx     #<@draw_cursor_arg
    lda     #>@draw_cursor_arg
    jsr     _IocsDraw7x8Pattern
    inc     @draw_cursor_arg + $0000
    inc     @draw_cursor_arg + $0004
    ldx     #<@draw_cursor_arg
    lda     #>@draw_cursor_arg
    jsr     _IocsDraw7x8Pattern
    dec     @draw_cursor_arg + $0000
    inc     @draw_cursor_arg + $0001
    inc     @draw_cursor_arg + $0004
    ldx     #<@draw_cursor_arg
    lda     #>@draw_cursor_arg
    jsr     _IocsDraw7x8Pattern
    inc     @draw_cursor_arg + $0000
    inc     @draw_cursor_arg + $0004
    ldx     #<@draw_cursor_arg
    lda     #>@draw_cursor_arg
    jsr     _IocsDraw7x8Pattern
    rts
@cursor_end:

    ; 終了
    rts

    ; 8 行の描画
@draw_8lines:
    lda     #$00
    sta     LOT_0_WORK_0
:
    ldy     LOT_0_WORK_0
    lda     (LOT_0_SRC), y
    bpl     :+
    and     #$7f
    sta     (LOT_0_SRC), y
    tax
    lda     @draw_field_tile_0, x
    sta     @draw_field_arg + $0004
    ldx     #<@draw_field_arg
    lda     #>@draw_field_arg
    jsr     _IocsDraw7x8Pattern
:
    inc     @draw_field_arg + $0000
    inc     LOT_0_WORK_0
    ldy     LOT_0_WORK_0
    lda     (LOT_0_SRC), y
    bpl     :+
    and     #$7f
    sta     (LOT_0_SRC), y
    tax
    lda     @draw_field_tile_1, x
    sta     @draw_field_arg + $0004
    ldx     #<@draw_field_arg
    lda     #>@draw_field_arg
    jsr     _IocsDraw7x8Pattern
:
    lda     @draw_field_arg + $0000
    clc
    adc     #$01
    and     #$1f
    sta     @draw_field_arg + $0000
    bne     :+
    inc     @draw_field_arg + $0001
:
    inc     LOT_0_WORK_0
    bne     :----
    rts

; フィールドのタイルセット
@draw_field_tileset:

.incbin     "resources/tiles/bg.ts"

; フィールドのタイル
@draw_field_tile_0:

    .byte   $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte   $04, $06, $08, $0a, $0c, $0e, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte   $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $0e, $0c, $0a, $08, $06, $04

@draw_field_tile_1:

    .byte   $01, $03, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
    .byte   $05, $07, $09, $0b, $0d, $0f, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
    .byte   $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $0f, $0d, $0b, $09, $07, $05

; フィールドの描画コマンド
@draw_field_arg:

    .byte   $00
    .byte   $00
    .word   @draw_field_tileset
    .byte   $00

; スコアの文字列
@draw_score_title_string:

    .asciiz "SCORE"
;   .byte   _TO, _KU, _TE, __N, $00

; スコアの描画コマンド
@draw_score_value_arg:

    .byte   $23
    .byte   $01
    .word   $0000

@draw_score_title_arg:

    .byte   $20
    .byte   $00
    .word   @draw_score_title_string

; ハイスコアの文字列
@draw_hiscore_title_string:

    .asciiz "TOP"
;   .byte   _SA, __I, _KO, __U, _TO, _KU, _TE, __N, $00

; ハイスコアの描画コマンド
@draw_hiscore_value_arg:

    .byte   $23
    .byte   $04
    .word   $0000

@draw_hiscore_title_arg:

    .byte   $20
    .byte   $03
    .word   @draw_hiscore_title_string


; カーソルのタイルセット
@draw_cursor_tileset:

.incbin     "resources/sprites/cursor_e.ts"
.incbin     "resources/sprites/cursor_o.ts"

; カーソルの描画コマンド
@draw_cursor_arg:

    .byte   $00
    .byte   $00
    .word   @draw_cursor_tileset
    .byte   $00

; ガイドの文字列
@draw_guide_string:

    .asciiz "OVER   - 3         + 1   + 2"

; ガイドの描画コマンド
@draw_guide_arg:

    .byte   $01
    .byte   $17
    .word   @draw_guide_string

.endproc


; データの定義
;
.segment    "BSS"

; ロットロットロットの情報
;
lot:
    .tag    Lot

