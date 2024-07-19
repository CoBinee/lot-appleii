
;[DA80] Z80 DISASSEMBLER Rev 0.12 - DISASSEMBLY LIST OF [lotlotlot_c800.bin]


ORG     0C800H
;
;START  START
;
START:                                  ;C800:
        INC     HL                      ;C800: 23
        INC     HL                      ;C801: 23
        LD      E,(HL)                  ;C802: 5E
        INC     HL                      ;C803: 23
        LD      D,(HL)                  ;C804: 56
        LD      (0D37DH),DE             ;C805: ED537DD3
        PUSH    HL                      ;C809: E5
        LD      A,085H                  ;C80A: 3E85
        LD      (0D001H),A              ;C80C: 3201D0
        LD      HL,0D2E0H               ;C80F: 21E0D2
        LD      B,020H                  ;C812: 0620
LBLC814:                                ;C814:
        LD      (HL),020H               ;C814: 3620
        INC     HL                      ;C816: 23
        DJNZ    LBLC814                 ;C817: 10FB
        LD      DE,(0D300H)             ;C819: ED5B00D3
        LD      HL,0CFC0H               ;C81D: 21C0CF
        LD      A,D                     ;C820: 7A
        AND     003H                    ;C821: E603
        INC     A                       ;C823: 3C
        LD      C,006H                  ;C824: 0E06
        LD      B,000H                  ;C826: 0600
LBLC828:                                ;C828:
        ADD     HL,BC                   ;C828: 09
        DEC     A                       ;C829: 3D
        JR      NZ,LBLC828              ;C82A: 20FC
        LD      A,D                     ;C82C: 7A
        AND     00CH                    ;C82D: E60C
        RRCA                            ;C82F: 0F
        RRCA                            ;C830: 0F
        INC     A                       ;C831: 3C
        LD      C,0A0H                  ;C832: 0EA0
LBLC834:                                ;C834:
        ADD     HL,BC                   ;C834: 09
        DEC     A                       ;C835: 3D
        JR      NZ,LBLC834              ;C836: 20FC
        LD      A,E                     ;C838: 7B
        CP      0AAH                    ;C839: FEAA
        JR      NC,LBLC841              ;C83B: 3004
        CP      096H                    ;C83D: FE96
        JR      NC,LBLC84A              ;C83F: 3009
LBLC841:                                ;C841:
        LD      C,020H                  ;C841: 0E20
        LD      (HL),E                  ;C843: 73
        ADD     HL,BC                   ;C844: 09
        LD      (HL),E                  ;C845: 73
        ADD     HL,BC                   ;C846: 09
        LD      (HL),E                  ;C847: 73
        ADD     HL,BC                   ;C848: 09
        LD      (HL),E                  ;C849: 73
LBLC84A:                                ;C84A:
        INC     A                       ;C84A: 3C
        INC     E                       ;C84B: 1C
        CP      0B0H                    ;C84C: FEB0
        JR      NZ,LBLC85A              ;C84E: 200A
        LD      A,R                     ;C850: ED5F
        RRCA                            ;C852: 0F
        RRCA                            ;C853: 0F
        RRCA                            ;C854: 0F
        AND     00FH                    ;C855: E60F
        LD      D,A                     ;C857: 57
        LD      E,090H                  ;C858: 1E90
LBLC85A:                                ;C85A:
        LD      (0D300H),DE             ;C85A: ED5300D3
        LD      DE,(0D302H)             ;C85E: ED5B02D3
        LD      HL,0CF9BH               ;C862: 219BCF
        LD      A,D                     ;C865: 7A
LBLC866:                                ;C866:
        CP      005H                    ;C866: FE05
        JR      C,LBLC86E               ;C868: 3804
        SUB     005H                    ;C86A: D605
        JR      LBLC866                 ;C86C: 18F8
LBLC86E:                                ;C86E:
        INC     A                       ;C86E: 3C
        LD      C,0A0H                  ;C86F: 0EA0
        LD      B,000H                  ;C871: 0600
LBLC873:                                ;C873:
        ADD     HL,BC                   ;C873: 09
        DEC     A                       ;C874: 3D
        JR      NZ,LBLC873              ;C875: 20FC
        LD      A,D                     ;C877: 7A
        LD      C,006H                  ;C878: 0E06
LBLC87A:                                ;C87A:
        ADD     HL,BC                   ;C87A: 09
        SUB     005H                    ;C87B: D605
        JR      NC,LBLC87A              ;C87D: 30FB
        LD      A,E                     ;C87F: 7B
        CP      0AAH                    ;C880: FEAA
        JR      NC,LBLC888              ;C882: 3004
        CP      096H                    ;C884: FE96
        JR      NC,LBLC891              ;C886: 3009
LBLC888:                                ;C888:
        LD      (HL),E                  ;C888: 73
        INC     HL                      ;C889: 23
        LD      (HL),E                  ;C88A: 73
        INC     HL                      ;C88B: 23
        LD      (HL),E                  ;C88C: 73
        INC     HL                      ;C88D: 23
        LD      (HL),E                  ;C88E: 73
        INC     HL                      ;C88F: 23
        LD      (HL),E                  ;C890: 73
LBLC891:                                ;C891:
        INC     A                       ;C891: 3C
        INC     E                       ;C892: 1C
        CP      0B0H                    ;C893: FEB0
        JR      NZ,LBLC8A2              ;C895: 200B
LBLC897:                                ;C897:
        LD      A,R                     ;C897: ED5F
        AND     01FH                    ;C899: E61F
        CP      014H                    ;C89B: FE14
        JR      NC,LBLC897              ;C89D: 30F8
        LD      D,A                     ;C89F: 57
        LD      E,090H                  ;C8A0: 1E90
LBLC8A2:                                ;C8A2:
        LD      (0D302H),DE             ;C8A2: ED5302D3
        LD      HL,(0D37DH)             ;C8A6: 2A7DD3
        ADD     HL,HL                   ;C8A9: 29
        LD      A,R                     ;C8AA: ED5F
        LD      B,A                     ;C8AC: 47
        CP      H                       ;C8AD: BC
        JR      NC,LBLC8CB              ;C8AE: 301B
        LD      A,(0D37DH)              ;C8B0: 3A7DD3
        LD      HL,0D040H               ;C8B3: 2140D0
        XOR     B                       ;C8B6: A8
        LD      E,A                     ;C8B7: 5F
        LD      D,000H                  ;C8B8: 1600
        ADD     HL,DE                   ;C8BA: 19
        ADD     HL,DE                   ;C8BB: 19
        LD      (HL),020H               ;C8BC: 3620
        LD      HL,0D000H               ;C8BE: 2100D0
        LD      B,018H                  ;C8C1: 0618
        LD      DE,0020H                ;C8C3: 112000
LBLC8C6:                                ;C8C6:
        LD      (HL),0AFH               ;C8C6: 36AF
        ADD     HL,DE                   ;C8C8: 19
        DJNZ    LBLC8C6                 ;C8C9: 10FB
LBLC8CB:                                ;C8CB:
        LD      IX,0D2FFH               ;C8CB: DD21FFD2
LBLC8CF:                                ;C8CF:
        LD      A,(IX+0)                ;C8CF: DD7E00
        CP      095H                    ;C8D2: FE95
        JR      NZ,LBLC8DA              ;C8D4: 2004
        LD      (IX+0),020H             ;C8D6: DD360020
LBLC8DA:                                ;C8DA:
        CP      085H                    ;C8DA: FE85
        JR      NZ,LBLC922              ;C8DC: 2044
        LD      A,(IX+32)               ;C8DE: DD7E20
        CP      020H                    ;C8E1: FE20
        JR      NZ,LBLC8EF              ;C8E3: 200A
        LD      (IX+0),A                ;C8E5: DD7700
        LD      A,085H                  ;C8E8: 3E85
        LD      (IX+32),A               ;C8EA: DD7720
        JR      LBLC922                 ;C8ED: 1833
LBLC8EF:                                ;C8EF:
        LD      A,(IX+255)              ;C8EF: DD7EFF
        CP      020H                    ;C8F2: FE20
        JR      NZ,LBLC903              ;C8F4: 200D
        CP      (IX+1)                  ;C8F6: DDBE01
        JR      NZ,LBLC916              ;C8F9: 201B
        LD      A,R                     ;C8FB: ED5F
        AND     040H                    ;C8FD: E640
        JR      Z,LBLC90A               ;C8FF: 2809
        JR      LBLC916                 ;C901: 1813
LBLC903:                                ;C903:
        LD      A,(IX+1)                ;C903: DD7E01
        CP      020H                    ;C906: FE20
        JR      NZ,LBLC922              ;C908: 2018
LBLC90A:                                ;C90A:
        LD      A,020H                  ;C90A: 3E20
        LD      (IX+0),A                ;C90C: DD7700
        LD      A,085H                  ;C90F: 3E85
        LD      (IX+1),A                ;C911: DD7701
        JR      LBLC922                 ;C914: 180C
LBLC916:                                ;C916:
        LD      A,020H                  ;C916: 3E20
        LD      (IX+0),A                ;C918: DD7700
        LD      A,085H                  ;C91B: 3E85
        LD      (IX+255),A              ;C91D: DD77FF
        DEC     IX                      ;C920: DD2B
LBLC922:                                ;C922:
        DEC     IX                      ;C922: DD2B
        LD      A,IXh                   ;C924: DD7C
        CP      0CFH                    ;C926: FECF
        JR      NZ,LBLC8CF              ;C928: 20A5
        LD      HL,0D300H               ;C92A: 2100D3
        LD      DE,(0D37DH)             ;C92D: ED5B7DD3
        LD      B,007H                  ;C931: 0607
LBLC933:                                ;C933:
        DEC     HL                      ;C933: 2B
        LD      A,(HL)                  ;C934: 7E
        CP      085H                    ;C935: FE85
        JR      NZ,LBLC93E              ;C937: 2005
        INC     DE                      ;C939: 13
        INC     DE                      ;C93A: 13
        CALL    0CAE0H                  ;C93B: CDE0CA
LBLC93E:                                ;C93E:
        DJNZ    LBLC933                 ;C93E: 10F3
        LD      B,007H                  ;C940: 0607
LBLC942:                                ;C942:
        DEC     HL                      ;C942: 2B
        LD      A,(HL)                  ;C943: 7E
        CP      085H                    ;C944: FE85
        JR      NZ,LBLC94C              ;C946: 2004
        INC     DE                      ;C948: 13
        CALL    0CAF7H                  ;C949: CDF7CA
LBLC94C:                                ;C94C:
        DJNZ    LBLC942                 ;C94C: 10F4
        LD      B,006H                  ;C94E: 0606
LBLC950:                                ;C950:
        DEC     HL                      ;C950: 2B
        DJNZ    LBLC950                 ;C951: 10FD
        LD      B,006H                  ;C953: 0606
LBLC955:                                ;C955:
        DEC     HL                      ;C955: 2B
        LD      A,(HL)                  ;C956: 7E
        CP      085H                    ;C957: FE85
        JR      NZ,LBLC961              ;C959: 2006
        DEC     DE                      ;C95B: 1B
        DEC     DE                      ;C95C: 1B
        DEC     DE                      ;C95D: 1B
        CALL    0CB0EH                  ;C95E: CD0ECB
LBLC961:                                ;C961:
        DJNZ    LBLC955                 ;C961: 10F2
        LD      (0D37DH),DE             ;C963: ED537DD3
        LD      B,006H                  ;C967: 0606
        LD      C,000H                  ;C969: 0E00
LBLC96B:                                ;C96B:
        DEC     HL                      ;C96B: 2B
        LD      A,(HL)                  ;C96C: 7E
        CP      085H                    ;C96D: FE85
        JR      NZ,LBLC972              ;C96F: 2001
        INC     C                       ;C971: 0C
LBLC972:                                ;C972:
        DJNZ    LBLC96B                 ;C972: 10F7
        LD      A,C                     ;C974: 79
        LD      (0D37CH),A              ;C975: 327CD3
        LD      HL,0CAC0H               ;C978: 21C0CA
        LD      DE,0D2E0H               ;C97B: 11E0D2
        LD      BC,0020H                ;C97E: 012000
        LDIR                            ;C981: EDB0
        LD      HL,0D000H               ;C983: 2100D0
        LD      DE,1800H                ;C986: 110018
        LD      BC,0019H                ;C989: 011900
        CALL    005CH                   ;C98C: CD5C00
        LD      HL,0D020H               ;C98F: 2120D0
        LD      DE,1820H                ;C992: 112018
        LD      BC,0019H                ;C995: 011900
        CALL    005CH                   ;C998: CD5C00
        LD      HL,0D040H               ;C99B: 2140D0
        LD      DE,1840H                ;C99E: 114018
        LD      BC,02C0H                ;C9A1: 01C002
        CALL    005CH                   ;C9A4: CD5C00
        XOR     A                       ;C9A7: AF
        CALL    00D5H                   ;C9A8: CDD500
        LD      HL,0D370H               ;C9AB: 2170D3
        LD      DE,0D372H               ;C9AE: 1172D3
        LD      BC,0062H                ;C9B1: 016200
        LDDR                            ;C9B4: EDB8
        LD      DE,(0D312H)             ;C9B6: ED5B12D3
        CP      001H                    ;C9BA: FE01
        JR      Z,LBLC9C6               ;C9BC: 2808
        CP      002H                    ;C9BE: FE02
        JR      Z,LBLC9C6               ;C9C0: 2804
        CP      008H                    ;C9C2: FE08
        JR      NZ,LBLC9C9              ;C9C4: 2003
LBLC9C6:                                ;C9C6:
        DEC     E                       ;C9C6: 1D
        DEC     E                       ;C9C7: 1D
        DEC     E                       ;C9C8: 1D
LBLC9C9:                                ;C9C9:
        CP      002H                    ;C9C9: FE02
        JR      Z,LBLC9D5               ;C9CB: 2808
        CP      003H                    ;C9CD: FE03
        JR      Z,LBLC9D5               ;C9CF: 2804
        CP      004H                    ;C9D1: FE04
        JR      NZ,LBLC9D8              ;C9D3: 2003
LBLC9D5:                                ;C9D5:
        INC     D                       ;C9D5: 14
        INC     D                       ;C9D6: 14
        INC     D                       ;C9D7: 14
LBLC9D8:                                ;C9D8:
        CP      004H                    ;C9D8: FE04
        JR      Z,LBLC9E4               ;C9DA: 2808
        CP      005H                    ;C9DC: FE05
        JR      Z,LBLC9E4               ;C9DE: 2804
        CP      006H                    ;C9E0: FE06
        JR      NZ,LBLC9E7              ;C9E2: 2003
LBLC9E4:                                ;C9E4:
        INC     E                       ;C9E4: 1C
        INC     E                       ;C9E5: 1C
        INC     E                       ;C9E6: 1C
LBLC9E7:                                ;C9E7:
        CP      006H                    ;C9E7: FE06
        JR      Z,LBLC9F3               ;C9E9: 2808
        CP      007H                    ;C9EB: FE07
        JR      Z,LBLC9F3               ;C9ED: 2804
        CP      008H                    ;C9EF: FE08
        JR      NZ,LBLC9F6              ;C9F1: 2003
LBLC9F3:                                ;C9F3:
        DEC     D                       ;C9F3: 15
        DEC     D                       ;C9F4: 15
        DEC     D                       ;C9F5: 15
LBLC9F6:                                ;C9F6:
        LD      A,E                     ;C9F6: 7B
        CP      0A0H                    ;C9F7: FEA0
        JR      C,LBLC9FD               ;C9F9: 3802
        LD      E,0A0H                  ;C9FB: 1EA0
LBLC9FD:                                ;C9FD:
        CP      018H                    ;C9FD: FE18
        JR      NC,LBLCA03              ;C9FF: 3002
        LD      E,018H                  ;CA01: 1E18
LBLCA03:                                ;CA03:
        LD      A,D                     ;CA03: 7A
        CP      0B4H                    ;CA04: FEB4
        JR      C,LBLCA0A               ;CA06: 3802
        LD      D,0B4H                  ;CA08: 16B4
LBLCA0A:                                ;CA0A:
        CP      008H                    ;CA0A: FE08
        JR      NC,LBLCA10              ;CA0C: 3002
        LD      D,008H                  ;CA0E: 1608
LBLCA10:                                ;CA10:
        LD      (0D310H),DE             ;CA10: ED5310D3
        LD      A,E                     ;CA14: 7B
        OR      D                       ;CA15: B2
        LD      B,E                     ;CA16: 43
        LD      E,A                     ;CA17: 5F
        LD      A,004H                  ;CA18: 3E04
        CALL    0093H                   ;CA1A: CD9300
        LD      E,B                     ;CA1D: 58
        LD      A,E                     ;CA1E: 7B
        LD      HL,1B00H                ;CA1F: 21001B
        CALL    004DH                   ;CA22: CD4D00
        INC     HL                      ;CA25: 23
        LD      A,D                     ;CA26: 7A
        CALL    004DH                   ;CA27: CD4D00
        INC     HL                      ;CA2A: 23
        XOR     A                       ;CA2B: AF
        CALL    004DH                   ;CA2C: CD4D00
        INC     HL                      ;CA2F: 23
        LD      A,005H                  ;CA30: 3E05
        CALL    004DH                   ;CA32: CD4D00
        LD      DE,(0D370H)             ;CA35: ED5B70D3
        LD      A,E                     ;CA39: 7B
        INC     HL                      ;CA3A: 23
        CALL    004DH                   ;CA3B: CD4D00
        LD      A,D                     ;CA3E: 7A
        INC     HL                      ;CA3F: 23
        CALL    004DH                   ;CA40: CD4D00
        LD      A,004H                  ;CA43: 3E04
        INC     HL                      ;CA45: 23
        CALL    004DH                   ;CA46: CD4D00
        INC     HL                      ;CA49: 23
        LD      A,009H                  ;CA4A: 3E09
        CALL    004DH                   ;CA4C: CD4D00
        XOR     A                       ;CA4F: AF
        CALL    00D8H                   ;CA50: CDD800
        AND     A                       ;CA53: A7
        JR      NZ,LBLCA5C              ;CA54: 2006
        XOR     A                       ;CA56: AF
        LD      (0D37FH),A              ;CA57: 327FD3
        JR      LBLCA9B                 ;CA5A: 183F
LBLCA5C:                                ;CA5C:
        LD      A,(0D37FH)              ;CA5C: 3A7FD3
        AND     A                       ;CA5F: A7
        JR      NZ,LBLCA9B              ;CA60: 2039
        INC     A                       ;CA62: 3C
        LD      (0D37FH),A              ;CA63: 327FD3
        LD      DE,(0D370H)             ;CA66: ED5B70D3
        CALL    MDLCAA4                 ;CA6A: CDA4CA
        PUSH    IX                      ;CA6D: DDE5
        POP     IY                      ;CA6F: FDE1
        LD      DE,(0D310H)             ;CA71: ED5B10D3
        CALL    MDLCAA4                 ;CA75: CDA4CA
        CALL    0CB25H                  ;CA78: CD25CB
        LD      C,004H                  ;CA7B: 0E04
LBLCA7D:                                ;CA7D:
        LD      B,005H                  ;CA7D: 0605
LBLCA7F:                                ;CA7F:
        LD      A,(IX+0)                ;CA7F: DD7E00
        LD      D,(IY+0)                ;CA82: FD5600
        LD      (IY+0),A                ;CA85: FD7700
        LD      (IX+0),D                ;CA88: DD7200
        INC     IX                      ;CA8B: DD23
        INC     IY                      ;CA8D: FD23
        DJNZ    LBLCA7F                 ;CA8F: 10EE
        LD      DE,001BH                ;CA91: 111B00
        ADD     IX,DE                   ;CA94: DD19
        ADD     IY,DE                   ;CA96: FD19
        DEC     C                       ;CA98: 0D
        JR      NZ,LBLCA7D              ;CA99: 20E2
LBLCA9B:                                ;CA9B:
        POP     HL                      ;CA9B: E1
        LD      DE,(0D37DH)             ;CA9C: ED5B7DD3
        LD      (HL),D                  ;CAA0: 72
        DEC     HL                      ;CAA1: 2B
        LD      (HL),E                  ;CAA2: 73
        RET                             ;CAA3: C9
MDLCAA4:                                ;CAA4:
        LD      IX,0CFBBH               ;CAA4: DD21BBCF
        LD      A,D                     ;CAA8: 7A
        SUB     004H                    ;CAA9: D604
        LD      BC,0006H                ;CAAB: 010600
LBLCAAE:                                ;CAAE:
        ADD     IX,BC                   ;CAAE: DD09
        SUB     030H                    ;CAB0: D630
        JR      NC,LBLCAAE              ;CAB2: 30FA
        LD      A,E                     ;CAB4: 7B
        SUB     014H                    ;CAB5: D614
        LD      C,0A0H                  ;CAB7: 0EA0
LBLCAB9:                                ;CAB9:
        ADD     IX,BC                   ;CAB9: DD09
        SUB     028H                    ;CABB: D628
        JR      NC,LBLCAB9              ;CABD: 30FA
        RET                             ;CABF: C9

