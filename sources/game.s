; game.s - ゲーム
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

; ゲームのエントリポイント
;
.global _GameEntry
.proc   _GameEntry

    ; アプリケーションの初期化

    ; VRAM のクリア
    jsr     _IocsClearVram

    ; ゲームの初期化

    ; Lot Lot Lot の初期化
    jsr     _LotInitialize

    ; 処理の設定
    lda     #<GameTitle
    sta     APP_0_PROC_L
    lda     #>GameTitle
    sta     APP_0_PROC_H
    lda     #$00
    sta     APP_0_STATE

    ; 終了
    rts

.endproc

; タイトルを表示する
;
.proc   GameTitle

    ; 初期化
    lda     APP_0_STATE
    bne     @initialized

    ; キーのクリア
    lda     #$00
    sta     IOCS_0_KEYCODE

    ; ロットロットロットの描画
    jsr     _LotDraw

    ; ロゴの表示
    lda     #$00
    sta     @logo_arg + $0000
    sta     @logo_arg + $0001
    sta     @logo_arg + $0004
:
    ldx     #<@logo_arg
    lda     #>@logo_arg
    jsr     _IocsDraw7x8Pattern
    inc     @logo_arg + $0000
    lda     @logo_arg + $0000
    cmp     #$20
    bne     :-
    lda     #$00
    sta     @logo_arg + $0000
    inc     @logo_arg + $0001
    lda     @logo_arg + $0001
    cmp     #$18
    bne     :-
    lda     #$05
    sta     @logo_arg + $0001
:
    ldx     #<@logo_arg
    lda     #>@logo_arg
    jsr     _IocsDraw7x8Pattern
    inc     @logo_arg + $0004
    inc     @logo_arg + $0000
    lda     @logo_arg + $0000
    cmp     #$20
    bne     :-
    lda     #$00
    sta     @logo_arg + $0000
    inc     @logo_arg + $0001
    lda     @logo_arg + $0001
    cmp     #($05 + $06)
    bne     :-

    ; 点滅の設定
    lda     #$00
    sta     GAME_0_BLINK

    ; 初期化の完了
    inc     APP_0_STATE
@initialized:

    ; キーの入力
@inkey:
    lda     APP_0_STATE
    cmp     #$01
    bne     @blink
    lda     IOCS_0_KEYCODE
    beq     @update

    ; BEEP
    ldx     #<@beep
    lda     #>@beep
    jsr     _IocsBeepQue
    
    ; 状態の更新
    inc     APP_0_STATE
    jmp     @update

    ; 点滅
@blink:
    inc     GAME_0_BLINK

    ; BEEP の監視
    lda     IOCS_0_BEEP_L
    ora     IOCS_0_BEEP_H
    bne     @update

    ; 処理の設定
    lda     #<GameLoad
    sta     APP_0_PROC_L
    lda     #>GameLoad
    sta     APP_0_PROC_H
    lda     #$00
    sta     APP_0_STATE
;   jmp     @update

    ; タイトルの更新
@update:

    ; HIT ANY KEY の描画
    lda     GAME_0_BLINK
    and     #$02
    bne     :+
    ldx     #<@key_0_arg
    lda     #>@key_0_arg
    jmp     :++
:
    ldx     #<@key_1_arg
    lda     #>@key_1_arg
:
    jsr     _IocsDrawString

    ; 終了
    rts

; ロゴ
@logo_tileset:

.incbin     "resources/tiles/logo.ts"

@logo_arg:

    .byte   $00, $00
    .word   @logo_tileset
    .byte   $00

; HIT ANY KEY
@key_0_string:

    .asciiz "HIT ANY KEY"

@key_0_arg:

    .byte   $0b
    .byte   $10
    .word   @key_0_string

@key_1_string:

    .asciiz "           "

@key_1_arg:

    .byte   $0b
    .byte   $10
    .word   @key_1_string

; BEEP
@beep:

    .byte   IOCS_BEEP_PI, 12
    .byte   IOCS_BEEP_PO, 12
    .byte   IOCS_BEEP_R,  240
    .byte   IOCS_BEEP_END

.endproc

; ゲームを読み込む
;
.proc   GameLoad

    ; 初期化
    lda     APP_0_STATE
    bne     @initialized

    ; ロットロットロットの読み込み
    jsr     _LotLoad

    ; 初期化の完了
    inc     APP_0_STATE
@initialized:

    ; 処理の設定
    lda     #<GameStart
    sta     APP_0_PROC_L
    lda     #>GameStart
    sta     APP_0_PROC_H
    lda     #$00
    sta     APP_0_STATE

    ; 終了
    rts

.endproc

; ゲームを開始する
;
.proc   GameStart

    ; 初期化
    lda     APP_0_STATE
    bne     @initialized

    ; ロットロットロットの描画
    jsr     _LotDraw

    ; スタートの描画
    ldx     #<@start_arg
    lda     #>@start_arg
    jsr     _IocsDrawString

    ; 初期化の完了
    inc     APP_0_STATE
@initialized:

    ; BEEP
    ldx     #<@beep
    lda     #>@beep
    jsr     _IocsBeepScore

    ; 処理の設定
    lda     #<GamePlay
    sta     APP_0_PROC_L
    lda     #>GamePlay
    sta     APP_0_PROC_H
    lda     #$00
    sta     APP_0_STATE

    ; 終了
@end:
    rts

; START
@start_string:

    .byte   "                         \n"
    .byte   "      *** START ***      \n"
    .byte   "                         "
    .byte   $00

@start_arg:

    .byte   $00
    .byte   $0a
    .word   @start_string

; BEEP
@beep:

    .byte   IOCS_BEEP_O4C,  16
    .byte   IOCS_BEEP_O4C,  16
    .byte   IOCS_BEEP_O4F,  16
    .byte   IOCS_BEEP_R,    8
    .byte   IOCS_BEEP_O4F,  8
    .byte   IOCS_BEEP_O4A,  16
    .byte   IOCS_BEEP_O5C,  128
    .byte   IOCS_BEEP_O4Ap, 8
    .byte   IOCS_BEEP_R,    8
    .byte   IOCS_BEEP_O4Ap, 8
    .byte   IOCS_BEEP_R,    8
    .byte   IOCS_BEEP_O4Ap, 8
    .byte   IOCS_BEEP_R,    8
    .byte   IOCS_BEEP_O5C,  16
    .byte   IOCS_BEEP_O5C,  16
    .byte   IOCS_BEEP_O5E,  16
    .byte   IOCS_BEEP_R,    8
    .byte   IOCS_BEEP_O5E,  8
    .byte   IOCS_BEEP_O5F,  16
    .byte   IOCS_BEEP_O5F,  16
    .byte   IOCS_BEEP_O5F,  16
    .byte   IOCS_BEEP_O5F,  16
    .byte   IOCS_BEEP_END

.endproc

; ゲームをプレイする
;
.proc   GamePlay

    ; 初期化
    lda     APP_0_STATE
    bne     @initialized

    ; フィールドの最描画
    ldx     #<@redraw_arg
    lda     #>@redraw_arg
    jsr     _LotRedrawField

    ; 初期化の完了
    inc     APP_0_STATE
@initialized:

    ; ロットロットロットの更新
    jsr     _LotUpdate

    ; ロットロットロットの描画
    jsr     _LotDraw

    ; ゲームオーバーの判定
    jsr     _LotGetOver
    tax
    beq     @end

    ; 処理の設定
    lda     #<GameOver
    sta     APP_0_PROC_L
    lda     #>GameOver
    sta     APP_0_PROC_H
    lda     #$00
    sta     APP_0_STATE

    ; 終了
@end:
    rts

; 最描画
@redraw_arg:

    .byte   $00, $0a, $19, $03

.endproc

; ゲームオーバーになる
;
.proc   GameOver

    ; 初期化
    lda     APP_0_STATE
    bne     @initialized

    ; ハイスコアの更新
    jsr     _LotRecord
    tax
    beq     :+
    ldx     #<@over_record_arg
    lda     #>@over_record_arg
    jsr     _IocsDrawString
    jmp     :++
:
    ldx     #<@over_norecord_arg
    lda     #>@over_norecord_arg
    jsr     _IocsDrawString
    jsr     _LotGetHiscore
    jsr     _IocsGetNumber5Chars
    stx     @over_score_arg + $0002
    sta     @over_score_arg + $0003
    ldx     #<@over_score_arg
    lda     #>@over_score_arg
    jsr     _IocsDrawString
:

    ; ロットロットロットの描画
    jsr     _LotDraw

;   ; BEEP
;   ldx     #<@beep
;   lda     #>@beep
;   jsr     _IocsBeepQue

    ; 初期化の完了
    inc     APP_0_STATE
@initialized:

;   ; ロットロットロットの更新
;   jsr     _LotUpdate

;   ; 描画の抑制
;   ldx     #<@undraw_arg
;   lda     #>@undraw_arg
;   jsr     _LotUndrawField

;   ; ロットロットロットの描画
;   jsr     _LotDraw

;   ; BEEP の監視
;   lda     IOCS_0_BEEP_L
;   ora     IOCS_0_BEEP_H
;   bne     @end

    ; BEEP
    ldx     #<@beep
    lda     #>@beep
    jsr     _IocsBeepScore

    ; 処理の設定
    lda     #<GameTitle
    sta     APP_0_PROC_L
    lda     #>GameTitle
    sta     APP_0_PROC_H
    lda     #$00
    sta     APP_0_STATE

    ; 終了
@end:
    rts

; GAME OVER
@over_record_string:

    .byte   "                         \n"
    .byte   "    *** GAME OVER ***    \n"
    .byte   "                         \n"
    .byte   "      YOU ARE TOP !      \n"
    .byte   "                         "
    .byte   $00

@over_record_arg:

    .byte   $00
    .byte   $09
    .word   @over_record_string

@over_norecord_string:

    .byte   "                         \n"
    .byte   "    *** GAME OVER ***    \n"
    .byte   "                         \n"
    .byte   "     TOP SCORE           \n"
    .byte   "                         "

@over_norecord_arg:

    .byte   $00
    .byte   $09
    .word   @over_norecord_string

@over_score_arg:

    .byte   $0f
    .byte   $0c
    .word   $0000

; 描画の抑制
@undraw_arg:

    .byte   $00, $09, $19, $05

; BEEP
@beep:

    .byte   IOCS_BEEP_O4B, 16
    .byte   IOCS_BEEP_O4A, 16
    .byte   IOCS_BEEP_O4G, 16
    .byte   IOCS_BEEP_O4E, 16
    .byte   IOCS_BEEP_O4B, 16
    .byte   IOCS_BEEP_O4A, 16
    .byte   IOCS_BEEP_O4G, 16
    .byte   IOCS_BEEP_O4E, 16
    .byte   IOCS_BEEP_O4C, 16
    .byte   IOCS_BEEP_O4D, 16
    .byte   IOCS_BEEP_O4E, 16
    .byte   IOCS_BEEP_O4F, 16
    .byte   IOCS_BEEP_O4G, 16
    .byte   IOCS_BEEP_O4A, 16
    .byte   IOCS_BEEP_O4B, 16
    .byte   IOCS_BEEP_O5C, 16
    .byte   IOCS_BEEP_O5C, 64
    .byte   IOCS_BEEP_R,   64
    .byte   IOCS_BEEP_END

.endproc


; データの定義
;
.segment    "BSS"

; ゲームの情報
;
game:
    .tag    Game

