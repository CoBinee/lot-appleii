
;[DA80] Z80 DISASSEMBLER Rev 0.12 - DISASSEMBLY LIST OF [lotlotlot_cae0.bin]


ORG	0CAE0H
;
;START	START
;
START1:					;CAE0: 
        EXX				;CAE0: D9	"�"	
        XOR	A			;CAE1: AF	"�"	
        LD	E,00AH			;CAE2: 1E0A	"  "	
        CALL	0093H			;CAE4: CD9300	"�  "	
        LD	A,001H			;CAE7: 3E01	"> "	
        LD	E,000H			;CAE9: 1E00	"  "	
        CALL	0093H			;CAEB: CD9300	"�  "	
        LD	A,00CH			;CAEE: 3E0C	"> "	
        LD	E,018H			;CAF0: 1E18	"  "	
        CALL	0093H			;CAF2: CD9300	"�  "	
        JR	LBLCB39			;CAF5: 1842	" B"	
START2:
        EXX				;CAF7: D9	"�"	
        XOR	A			;CAF8: AF	"�"	
        LD	E,0C8H			;CAF9: 1EC8	" �"	
        CALL	0093H			;CAFB: CD9300	"�  "	
        LD	A,001H			;CAFE: 3E01	"> "	
        LD	E,000H			;CB00: 1E00	"  "	
        CALL	0093H			;CB02: CD9300	"�  "	
        LD	A,00CH			;CB05: 3E0C	"> "	
        LD	E,004H			;CB07: 1E04	"  "	
        CALL	0093H			;CB09: CD9300	"�  "	
        JR	LBLCB39			;CB0C: 182B	" +"	
START3:
        EXX				;CB0E: D9	"�"	
        XOR	A			;CB0F: AF	"�"	
        LD	E,064H			;CB10: 1E64	" d"	
        CALL	0093H			;CB12: CD9300	"�  "	
        LD	A,001H			;CB15: 3E01	"> "	
        LD	E,002H			;CB17: 1E02	"  "	
        CALL	0093H			;CB19: CD9300	"�  "	
        LD	A,00CH			;CB1C: 3E0C	"> "	
        LD	E,020H			;CB1E: 1E20	"  "	
        CALL	0093H			;CB20: CD9300	"�  "	
        JR	LBLCB39			;CB23: 1814	"  "	
START4:
        EXX				;CB25: D9	"�"	
        XOR	A			;CB26: AF	"�"	
        LD	E,A			;CB27: 5F	"_"	
        CALL	0093H			;CB28: CD9300	"�  "	
        LD	A,001H			;CB2B: 3E01	"> "	
        LD	E,005H			;CB2D: 1E05	"  "	
        CALL	0093H			;CB2F: CD9300	"�  "	
        LD	A,00CH			;CB32: 3E0C	"> "	
        LD	E,032H			;CB34: 1E32	" 2"	
        CALL	0093H			;CB36: CD9300	"�  "	
LBLCB39:				;CB39: 
        LD	A,003H			;CB39: 3E03	"> "	
        LD	E,000H			;CB3B: 1E00	"  "	
        CALL	0093H			;CB3D: CD9300	"�  "	
        LD	A,R			;CB40: ED5F	" _"	
        ADD	A,080H			;CB42: C680	"� "	
        LD	E,A			;CB44: 5F	"_"	
        LD	A,002H			;CB45: 3E02	"> "	
        CALL	0093H			;CB47: CD9300	"�  "	
        LD	E,0F8H			;CB4A: 1EF8	"  "	
        LD	A,007H			;CB4C: 3E07	"> "	
        CALL	0093H			;CB4E: CD9300	"�  "	
        LD	A,008H			;CB51: 3E08	"> "	
        LD	E,010H			;CB53: 1E10	"  "	
        CALL	0093H			;CB55: CD9300	"�  "	
        LD	A,009H			;CB58: 3E09	"> "	
        LD	E,010H			;CB5A: 1E10	"  "	
        CALL	0093H			;CB5C: CD9300	"�  "	
        LD	A,00AH			;CB5F: 3E0A	"> "	
        LD	E,008H			;CB61: 1E08	"  "	
        CALL	0093H			;CB63: CD9300	"�  "	
        LD	A,00DH			;CB66: 3E0D	"> "	
        LD	E,000H			;CB68: 1E00	"  "	
        CALL	0093H			;CB6A: CD9300	"�  "	
        EXX				;CB6D: D9	"�"	
        RET				;CB6E: C9	"�"	
        NOP				;CB6F: 00	" "	