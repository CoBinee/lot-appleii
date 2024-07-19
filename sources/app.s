; app.s - アプリケーション
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


; コードの定義
;
.segment    "APP"

; アプリケーションのエントリポイント
;
.proc   AppEntry

    ; アプリケーションの初期化

    ; VRAM のクリア
    jsr     _IocsClearVram

    ; 画面モードの設定
    sta     HIRES
    sta     LOWSCR
    sta     MIXCLR
    sta     TXTCLR

    ; ゼロページのクリア
    ldy     #APP_0
    lda     #$00
:
    sta     $00, y
    iny
    bne     :-

    ; デバッグの設定
    lda     #$00
    sta     app_debug_mix

    ; 処理の設定
    lda     #<_GameEntry
    sta     APP_0_PROC_L
    lda     #>_GameEntry
    sta     APP_0_PROC_H
    lda     #$00
    sta     APP_0_STATE

.endproc

; アプリケーションを更新する
;
.proc   AppUpdate

    ; 処理の繰り返し
@loop:

    ; IOCS の更新
    jsr     _IocsUpdate

    ; 処理の実行
    lda     #>(:+ - $0001)
    pha
    lda     #<(:+ - $0001)
    pha
    jmp     (APP_0_PROC)
:

    ; MIX の切り替え
    lda     IOCS_0_KEYCODE
    cmp     #$09
    bne     :++
    lda     app_debug_mix
    clc
    adc     #$01
    and     #$01
    sta     app_debug_mix
    bne     :+
    sta     MIXCLR
    jmp     :++
:
    sta     MIXSET
:

    ; ループ
    jmp     @loop

.endproc


; データの定義
;
.segment    "BSS"

; デバッグ
;
app_debug_mix:

    .res    $01
