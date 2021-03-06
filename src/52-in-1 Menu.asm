; ===================================================================================================
; Supervision 52-in-1 Menu ROM Disassemble
; by chimaera (2020)
; ===================================================================================================



; ===================================================================================================
; iNES header
; ===================================================================================================

INES_MAPPER         = 0             ; 0 = NROM
INES_PRG            = 1             ; Size of PRG ROM in 16 KB units (2 * 16KB PRG ROM)
INES_CHR            = 1             ; Size of CHR ROM in 8 KB units (Value 0 means the board uses CHR RAM) (1 * 8KB CHR ROM)
INES_MIRROR         = 1             ; 0 = horizontal mirroring, 1 = vertical mirroring
INES_SRAM           = 0             ; 1 = battery backed SRAM at $6000-7FFF

.include "./libs/iNES-header.inc"


; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; NES I/O Definitions
; ===================================================================================================

.include "./libs/IO-definitions.inc"


; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; Constants
; ===================================================================================================

; Last Section
ConstLastSection                                    = $03


; Column Sizes
ConstListPositionColumnSize                         = $09
ConstListPositionColumnSizeLastSection              = $08


; Game Boot Sequences Starting Adresses
;Section 1 Boot Sequences
ConstBootGameBootSequencesStartSection1AdressLow    = $01
ConstBootGameBootSequencesStartSection1AdressHigh   = $DA

;Section 2 Boot Sequences
ConstBootGameBootSequencesStartSection2AdressLow    = $21
ConstBootGameBootSequencesStartSection2AdressHigh   = $DB

;Section 3 Boot Sequences
ConstBootGameBootSequencesStartSection3AdressLow    = $41
ConstBootGameBootSequencesStartSection3AdressHigh   = $DC


; Galaxian NMI Start
ConstGalaxianNMI                                    = $E20C


; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; ZeroPage and OAM
; ===================================================================================================

.segment "ZEROPAGE"                   ; $0000 - $00FF

ZPAdressLow           = $00           ; LSB (Least Significant Byte)
ZPAdressHigh          = $01           ; MSB (Most Significant Bytte)

ZPBootGameCheck1      = $1B           ; Gets checked in NMI before $1C, if #$A5 then check $1C
ZPBootGameCheck2      = $1C           ; Gets checked in NMI after $1B, if #$5A JMP $E20C (Galaxian Start), else go to NMI_START

ZPUNK_30              = $30           ; OAM? ListSection?
ZPUNK_31              = $31           ; OAM? ListSection?

ZPListSection         = $32           ; Stores current section
ZPListSection_OLD     = $3A           ; Stores old section

ZPListPosition        = $33           ; Stores current list position
ZPListPositionY       = $34           ; Stores current list position Y coords
ZPListPositionX       = $35           ; Stores current list position X coords

ZPUNK_36              = $36           ; Something with ScreenAttributesUpdate

ZPSoundByte_OLD       = $38           ; Last played sound
ZPSoundByte           = $39           ; Sound to be played


ZPJoyPad1             = $F5           ; 
ZPJoyPad1_OLD         = $F3           ; 
ZPJoyPad2             = $F6           ; 
ZPJoyPad2_OLD         = $F4           ; 

ZPJoyPad_Pressed      = $F7           ; Not sure if correct

ZPJoyPad_Counter      = $37           ; Counts time button has been pressed, processes button again after certain time has passed

ZPPPUMASKByte         = $FE           ; 
ZPPPUCNTRLByte        = $FF           ; 


; ---------------------------------
; ---------------------------------



; -------------------
; OAM
; -------------------

.segment "OAM"
OAM                 = $0200         ;


; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; Reset vectors and binary includes
; ===================================================================================================

; 52-in-1 Reset vector
; 06.LEGENDRY, 08. BROS. II, 10.NINJA 2, 15.FLAPPY, 19.MACROSS, 21.STAR FORCE, 23.NINJA 1, 24.PIPELINE, 27.LODE RUNNER1,
; 28.LODE RUNNER2, 31.KING KONG 3, 32.MAPPY, 34.F-1 RACE, 35.ROAD FIGHTER, 36.PIN BALL, 39.GALAGA, 44.WRESTLE,
; 49.FORMATION Z, 52.FANCY BROS
.segment "RESETVA"                  ; $8/C003
;    STA $984F
    JMP ROM_START                   ; $D0E4


; 52-in-1 Reset vector
; 42.ICE CLIMBER
.segment "RESETVB"                  ; $8/C017
;    STA $984F
    JMP ROM_START                   ; $D0E4


; 52-in-1 Reset vector
; 33.EXCITE BIKE
.segment "RESETVC"                  ; $8/C187
;    STA $984F
    JMP ROM_START                   ; $D0E4


; 52-in-1 Reset vector
; 16.SPARTAN
.segment "RESETVD"                  ; $8/C25B
;    STA $984F
    JMP ROM_START                   ; $D0E4


; 52-in-1 Reset vector
; 38.POPEYE
.segment "RESETVE"                  ; $8/C64C
;    STA $984F
    JMP ROM_START                   ; $D0E4


; 52-in-1 Reset vector
; 30.KING KONG 2
.segment "RESETVF"                  ; $8/C671
;    STA $984F
    JMP ROM_START                   ; $D0E4


; 52-in-1 Reset vector
; 29.KING KONG 1
.segment "RESETVG"                  ; $8/C7A1
;    STA $984F
    JMP ROM_START                   ; $D0E4


; 52-in-1 Reset vector
; 25.MAHJONG 2
.segment "RESETVH"                  ; $8/CA46
;    STA $984F
    JMP ROM_START                   ; $D0E4


; 52-in-1 Reset vector
; JMP $ROM_START needs to be uncommented if 'Galaxian' part of rom is removed.
; The reason is to keep 1942 reset vector compability
; 13.1942
;.segment "RESETVI"                 ; $3/7/B/FF93 (1942)
;RESET:
;    STA $984F                      ; Mapper Call
;    JMP ROM_START                  ; $D0E4


; 52-in-1 Reset vector
; 01.ISLANDER, 02.GRADING, 03.P-D FIGHTING, 04.STAR SOLDIER, 05.GOONIES, 07.TETRIS, 09.TWIN BEE, 11.CITY CONECT.,
; 12.B-WINGS, 14.GYROOINE, 17.BOMBER MAN, 18.FRONT LINE, 20.1989GALAXIAN, 22.KUNG-FU, 26.MAHJONG 4, 37.BASE BALL,
; 40.GALAXIAN, 41.PAC-MAN, 43.1989 EXERION, 45.BATTLE CITY, 46.SKY DESTRYOER, 47.CHESS, 48.BALLOON FIGHT, 50.POOYAN,
; 51.CIRCUS TROUPE
.segment "RESETVJ"                  ; $3/7/B/FFF2
RESET:
    STA $984F                       ; Mapper Call
    JMP ROM_START                   ; $D0E4


; ===================================================================================================
; ===================================================================================================
; ===================================================================================================




; ===================================================================================================
; Binary includes: 4 Nin Uchi Mahjong leftovers
; ===================================================================================================

; These included binaries are completly safe to remove
; (I havent found any dependency in them atleast).
; They are included for the source to compile to a 1:1 copy of the original
;
; If you want to remove Galaxian, just remove the two included Galaxian parts.
; Just remember that you need to uncomment segment "RESETVI" $FF90 for
; the reset vector to work with 1942.

; 4 Nin Uchi Mahjong data
.segment "MAHJONGA"                     ; $C000
    .incbin "./includes/4 Nin Uchi Mahjong 01 0000-0002.bin"

; 4 Nin Uchi Mahjong data
.segment "MAHJONGB"                     ; $C006
    .incbin "./includes/4 Nin Uchi Mahjong 02 0006-0016.bin"


; 4 Nin Uchi Mahjong data
.segment "MAHJONGC"                     ; $C01A
    .incbin "./includes/4 Nin Uchi Mahjong 03 001A-0186.bin"


; 4 Nin Uchi Mahjong data
.segment "MAHJONGD"                     ; $C18A
    .incbin "./includes/4 Nin Uchi Mahjong 04 018A-025A.bin"


; 4 Nin Uchi Mahjong data
.segment "MAHJONGE"                     ; $C25E
    .incbin "./includes/4 Nin Uchi Mahjong 05 025E-064B.bin"


; 4 Nin Uchi Mahjong data
.segment "MAHJONGF"                     ; $C64F
    .incbin "./includes/4 Nin Uchi Mahjong 06 064F-0670.bin"


; 4 Nin Uchi Mahjong data
.segment "MAHJONGG"                     ; $C674
    .incbin "./includes/4 Nin Uchi Mahjong 07 0674-07A0.bin"


; 4 Nin Uchi Mahjong data
.segment "MAHJONGH"                     ; $C7A4
    .incbin "./includes/4 Nin Uchi Mahjong 08 07A4-0A45.bin"


; 4 Nin Uchi Mahjong data
.segment "MAHJONGI"                     ; $CA49
    .incbin "./includes/4 Nin Uchi Mahjong 09 0A49-0FFF.bin"


; 4 Nin Uchi Mahjong data
.segment "MAHJONGJ"                     ; $D099
    .incbin "./includes/4 Nin Uchi Mahjong 10 1099-10A2.bin"


; 4 Nin Uchi Mahjong data
.segment "MAHJONGK"                     ; $DD41
    .incbin "./includes/4 Nin Uchi Mahjong 11 1D41-1FFF.bin"



; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; Galaxian
; ===================================================================================================

; Galaxian - Extra code
.segment "GALAXIANA"                ; $CA49
    .include "./includes/Galaxian 01 1000-107A.asm"


; Galaxian - Main code
.segment "GALAXIANB"                ; $E000
    .incbin "./includes/Galaxian 02 2000-3FF1.bin"



; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; PPU Subroutines
; ===================================================================================================

; Start of actual menu code
.segment "CODEA"                    ; $D07B


; ------------------------------------
; --------PPUBackgroundEnable()-------
; ------------------------------------

; Enables background
PPUBackgroundEnable: 
    LDA ZPPPUMASKByte
    ;     BGRsbMmG
    ORA #%00001000                  ; #$08 (Bitwise OR with A, eg. "BitJoiner")
    STA ZPPPUMASKByte
    STA PPUMask_2001
RTS


; ------------------------------------



; --------------------------------------------
; --------PPUBackgroundSpriteDisable()--------
; --------------------------------------------

; Disables Background and Sprites
PPUBackgroundSpriteDisable:
    LDA ZPPPUMASKByte
    ;     BGRsbMmG
    AND #%11100111                  ; $E7
    STA ZPPPUMASKByte
    STA PPUMask_2001
RTS


; --------------------------------------------



; ------------------------------------------------
; --------PPUBackgroundTileSelectDisable()--------
; ------------------------------------------------

; Disable TileSelect
PPUBackgroundTileSelectDisable:
    LDA ZPPPUCNTRLByte
    ;     VPHBSINN
    AND #%11101111                  ; #$EF
    STA ZPPPUCNTRLByte
    STA PPUControl_2000
RTS


; ------------------------------------------------

; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; Reset routines
; ===================================================================================================

; Second part of menu code
.segment "CODEB"                    ; $D0A3

; ------------------------------
; --------OAMSetAdress()--------
; ------------------------------

; Set OAMAdress to $0200
OAMSetAdress:
    LDA #$00
    STA OAMAddr_2003
    LDA #$02
    STA OAMDMA_4014
RTS

; ------------------------------



; ----------------------------
; --------PPUClearNT()--------
; ----------------------------

; Clear Name Table
PPUClearNT:
    JSR PPUBackgroundSpriteDisable  ; First disable Sprite and Background
; Initialise Adress to clear
    LDA #$20                        ; MSB
    STA PPUAddr_2006
    LDA #$00                        ; LSB
    STA PPUAddr_2006                ; $0200
; Reset index
    LDA #$00
    LDY #$00
    LDX #$03

; Clears PPU $0000 - $02FF (PatternTable0/1 & NameTable0-3)
@Loop:
    STA PPUData_2007
    DEY                             ; DEY = #$00 - 1 = #$FF (00 to FF)
BNE @Loop                           ; Until Y = #$00

    DEX                             ; Decrease X = $03 and start over
BPL @Loop                           ; Until X = #$00

RTS

; ----------------------------



; -----------------------------
; --------PPUOAMClear()--------
; -----------------------------

; Clear OAM Table, Reset $0200 - $02FF
PPUOAMClear:
    LDX #$00

@Loop:
; #$F8 every 4th Byte
    LDA #$F8
    STA OAM, X
; #$00 to the rest
    LDA #$00
    INX
    STA OAM, X
    INX
    STA OAM, X
    INX
    STA OAM, X
    INX                    
BNE @Loop                           ; Loop until X = #$FF -> #$00

RTS

; -----------------------------



; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; ROM_START Vector
; ===================================================================================================

ROM_START:
    SEI                             ; SEt Interrupt
    CLD                             ; CLear Decimal
    ;     VPHBSINN
    LDA #%00010000                  ; #$10
    STA PPUControl_2000
    LDX #$FF
    TXS

; Wait for first vblank
@vblankwait1:
    LDA PPUStatus_2002
BPL @vblankwait1

    ; Set adress $0700
    LDY #$07
    STY ZPAdressHigh
    LDY #$00
    STY ZPAdressLow
    TYA

; Clear internal RAM from $0000 to $07FF
@clrmem:
    STA (ZPAdressLow), Y
    INY
; Loops ZPAdressLow
BNE @clrmem

    DEC ZPAdressHigh
; Loops ZPAdressHigh
BPL @clrmem

    ;     VPHBSINN
    LDA #%00010000                  ; #$10
    STA ZPPPUCNTRLByte
    ;     BGRsbMmG
    LDA #%00000110                  ; #$06
    STA ZPPPUMASKByte
    STA PPUMask_2001

    ; Reset Scroll
    LDA #$00
    STA PPUScroll_2005              ; Write 1 X Scroll
    STA PPUScroll_2005              ; Write 2 Y Scroll
    JSR PPUClearNT                  ; Clear NameTable
    LDX #$00


; Load PaletteData
@LoadPaletteData:
    LDA PaletteData, X
    STA $0300, X
    INX
    CPX #$20                        ; Until X < #$20
BCC @LoadPaletteData

; PaletteData
; $1594 - $15B3
; 0F 0F 0F 20 | 0F 0F 0F 26 | 0F 0F 26 0F | 0F 06 0F 0F | BG
; 0F 0F 0F 06 | 0F 0F 0F 0F | 0F 0F 0F 0F | 0F 0F 0F 0F | SP

    LDX #$00

; Load Attributes
@LoadAttributeTable:
    LDA AttributeTableData, X
    STA $03C0, X
    INX
    CPX #$40                        ; Until X < #$40
BCC @LoadAttributeTable

; AttributeTableData
; $1554 - $1593
; AA AA AA AA AA AA AA AA AA AA A0 A0 A0 A0 AA AA <--- Top Bricks + Section x
; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <--- List
; 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <--- List
; F0 F0 F0 F0 F0 F0 F0 F0 FF FF FF FF FF FF FF FF <--- List + Bottom Bricks

    JSR PPUOAMClear

    ; Initialize Start Section to #$01
    LDA #$01
    STA ZPListSection
    STA ZPListSection_OLD
    ; Initialize ZPListPosition to #$04
    LDA #$04
    STA ZPListPosition

    ; What does it do here? Restore ZPListSection and ZPListPosition from CartRAM???===================================
    LDA $5FF0                       ; Load from CartRAM
    AND #$0F
    CMP #$05
BNE InitializeGame ; Change NAME? ==============================

    LDA $5FF1                       ; Load from CartRAM
    AND #$0F
    CMP #$0A
BNE InitializeGame ; Change NAME? ==============================

    LDA $5FF2                       ; Load from CartRAM
    AND #$0F
    STA ZPAdressLow
    LDA $5FF3                       ; Load from CartRAM
    TAY
    AND #$01
    ASL A
    ASL A
    ASL A
    ASL A
    ORA ZPAdressLow
    STA ZPAdressLow
    TYA
    AND #$06
    LSR A
BNE ___L9171

    ; Initialize ZPListSection to Section 1
    LDA #$01

___L9171:
    STA ZPListSection
    STA ZPListSection_OLD
    CMP #ConstLastSection           ; $03
BEQ ___L9183

    LDA ZPAdressLow
    CMP #$12
BCC ___L918B

    LDA #$04
BNE ___L918B

___L9183:
    LDA ZPAdressLow
    CMP #$10
BCC ___L918B

    LDA #$04

___L918B:
    STA ZPListPosition


InitializeGame:                     ; Needs Name Change?=================
    LDA #$05
    STA $5FF0                       ; Store to CartRAM
    LDA #$0A
    STA $5FF1                       ; Store to CartRAM

; Initialize NameTablePointerData to Position #$00 for backgrounddata
    LDA #$00                                
    JSR RLEDecoder

; Get current section and decode it to the NameTable (#$01 Section 1, #$02 Section 2, #$03 Section 3)
    LDA ZPListSection
    JSR RLEDecoder

    JSR UpdateListSectionPosition

    JSR ScreenAttributesSet
    JSR PaletteRAMtoPPU
    JSR ScreenAttributesRAMtoPPU


    LDA #$00
    STA PPUScroll_2005              ; Write 1: X Scroll
    STA PPUScroll_2005              ; Write 2: Y Scroll

    JSR PPUBackgroundTileSelectDisable
    JSR PPUBackgroundEnable

    LDA ZPPPUCNTRLByte
    ORA #$80
    STA ZPPPUCNTRLByte
    STA PPUControl_2000

; Main loop to make sure CPU doesn't go on to Subroutines/NMI Vector
Main_Loop:
    JMP Main_Loop                   ; Jump forever



; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; SubRoutines
; ===================================================================================================

; ----------------------------
; --------RLEDecoder()--------
; ----------------------------

; RLE Decoding routing
; Subroutine needs A to be set before entering
RLEDecoder:
; Loads MSB and LSB adress from NameTablePointerData, X
    ASL A                           ; Shifts bits Left #$00 = #$00, #$01 = #$02, #$02 = #$04, #$03 = #$06
    TAX
    LDA NameTablePointerData, X
    STA ZPAdressLow

    INX
    LDA NameTablePointerData, X
    STA ZPAdressHigh

    LDY #$00                        ; Reset Y index for next part

; Load first byte of newly set adress (MSB+LSB) and check value
RLEControlByteCheck:
    LDA (ZPAdressLow), Y
BMI RLEControlByteFF

; PointerData
; $D5B4 - $D5BB / $15B4 - $15BB
; BC D5 38 D6 44 D7 67 D8


; Store value from data to NameTable if it doesn't contain instruction byte ($FD, $FE, $FF)
RLEStoretoPPUData:
    STA PPUData_2007
    JSR RLEIncreasePointerPosition  ; Increase pointer position
BCC RLEControlByteCheck

; Controlbyte $FF, Ends function, stops processing bytes in data
RLEControlByteFF:
    CMP #$FF
BNE RLEByteDecoder                  ; If not #$FF, goto byte decoder

RTS


; -------------------------------



; --------------------------------
; --------RLEByteDecoder()--------
; --------------------------------

; RLE Byte Decoder
; Checks if first byte is $FF, $FE or $FD
; If $FF, then end routine
; If $FE, then set new pointer adress
; If $FD, then repeat tile [x] times
RLEByteDecoder:

; Controlbyte $FE, Sets NameTable Adress before writing
; $FE $02 $00 ($0200) [Set NameTable adress with PPUAdress_2006], [MSB], [LSB]
    CMP #$FE
BNE @RLEControlByteFD               ; if not $FE, check if $FD

    ; Increase MSB position and store MSB to PPUAddress register, 1nd write
    JSR RLEIncreasePointerPosition
    LDA (ZPAdressLow), Y
    STA PPUAddr_2006

    ; Increase LSB position and store LSB to PPUAddress register, 2nd write
    JSR RLEIncreasePointerPosition
    LDA (ZPAdressLow), Y
    STA PPUAddr_2006

; Increase byte position again and do RLE Control Byte Check on next byte
@RLEIncreaseBytePosition:
    JSR RLEIncreasePointerPosition
BCC RLEControlByteCheck


@RLEControlByteFD:
; Controlbyte $FD, Writes specific tile #$XX times
; $FD $09 $61 (9 times, tile 61) [Store tiles to NameTable at previously set adress], [Number of Tiles to store], [Background tile to store]
    CMP #$FD
BNE RLEStoretoPPUData               ; If new byte is not $FD, assume it is a tile and store it to PPUData in RLEStoretoPPUData routine

    ; Increase pointer position and loads first byte after $FD to A and transfer to X as index
    JSR RLEIncreasePointerPosition
    LDA (ZPAdressLow), Y
    TAX
    ; Increases pointer again
    JSR RLEIncreasePointerPosition
    ; Load actual tile to A
    LDA (ZPAdressLow), Y

; Store to PPU until X = #$00
@RLEControlByteFDStorePPU_Loop:
    STA PPUData_2007
    DEX
BNE @RLEControlByteFDStorePPU_Loop

; When done increase pointer again
BEQ @RLEIncreaseBytePosition

; ------------------------------------------



; -----------------------------------------------
; --------RLEIncreasePointerPosition()--------
; -----------------------------------------------

; Increases MSB and LSB adressposition from NameTablePointerData, X
RLEIncreasePointerPosition:

    ; Adds 1 to LSB
    CLC
    LDA ZPAdressLow
    ADC #$01
    STA ZPAdressLow

    ; Adds to MSB only if Carry is set
    LDA ZPAdressHigh
    ADC #$00
    STA ZPAdressHigh
    CLC

RTS


; -----------------------------------------------



; ---------------------------------
; --------PaletteRAMtoPPU()--------
; ---------------------------------

PaletteRAMtoPPU:
    LDX #$00

; Sets PPUAddress to write to ($3F00 Palette RAM)

    ; MSB
    LDA #$3F
    STA PPUAddr_2006

    ; LSB
    LDA #$00
    STA PPUAddr_2006


; Stores Palette from RAM $0300, X to PPU
@PaletteRAMtoPPU_Loop:
    LDA $0300, X
    STA PPUData_2007
    INX
    CPX #$14
BCC @PaletteRAMtoPPU_Loop

RTS


; ------------------------------



; ------------------------------------------
; --------ScreenAttributesRAMtoPPU()--------
; ------------------------------------------

ScreenAttributesRAMtoPPU:
    LDX #$00

; Sets PPUAddress to write to ($23C0 NameTable 0 Attributes part)

    ; MSB
    LDA #$23
    STA PPUAddr_2006

    ; LSB
    LDA #$C0
    STA PPUAddr_2006


; Stores Screen Attributes from RAM $03C0, X to PPU
@ScreenAttributesRAMtoPPU_Loop:
    LDA $03C0,X
    STA PPUData_2007
    INX
    CPX #$40
BCC @ScreenAttributesRAMtoPPU_Loop

RTS


; --------------------------------------



; -------------------------------------------
; --------UpdateListSectionPosition()--------
; -------------------------------------------

UpdateListSectionPosition:
; Load ZPListSection and check if it is Section 3 and if so, branch (because lesser entries in list)
    LDA ZPListSection
    CMP #ConstLastSection                            ; $03
BEQ UpdateListSectionPositionSection3
; Check to see if ZPListPosition is in Column 2, if not then branch. If yes, then substract with #$09
    LDA ZPListPosition
    CMP #ConstListPositionColumnSize                 ; #$09
BCC UpdateListPositionColumn1

    SBC #ConstListPositionColumnSize

; If in Column 2, set Y Position to #$80 (right side)
UpdateListPositionColumn2:
    TAX
    LDA #$80
BNE UpdateListPositionNewXY

; If in Column 1, set Y Position to #$00 (left side)
UpdateListPositionColumn1:
    TAX
    LDA #$00

; Store new X/Y positions
UpdateListPositionNewXY:
    STA ZPListPositionY
    LDA #$40
    STA ZPListPositionX
    TXA

; Add #$10 to X Position for each in ListPosition to get X coordinates
UpdateListPositionAddToX:
BEQ ___L128A                                        ; Branch to next part when done

    CLC
    LDA #$10
    ADC ZPListPositionX
    STA ZPListPositionX
    DEX
BPL UpdateListPositionAddToX                        ; Loop back if there is still positive value in ListPosition (X)


; If ZPListSection 3 / Last Section
; Check to see if ListPosition is in Column 2, if not then branch. If yes, then substract with #$08
UpdateListSectionPositionSection3:
    LDA ZPListPosition
    CMP #ConstListPositionColumnSizeLastSection     ; #$08
; If in Column 1, Branch. Else substract with #$08
BCC UpdateListPositionColumn1

    SBC #ConstListPositionColumnSizeLastSection     ; #$08
    CLC
BCC UpdateListPositionColumn2

; Next Part not sure what this does =================================
___L128A:
    LDX ZPListPosition
    INX
    SED                                             ; SEt Decimal
    LDA #$00

; Loop: Adds 1 to A until X = 0
___L1290:
    CLC
    ADC #$01
    DEX
BNE ___L1290

; If Section = 1, Branch
    LDX ZPListSection
    CPX #$01
BEQ ___L12A8

; If Section = 2 Add #$18 to A then branch, if not Section = 2, branch
    CPX #$02
BNE ___LD2A5
    CLC
    ADC #$18
BNE ___L12A8

; If Section = 3 Add #$36 to A
___LD2A5:
    CLC
    ADC #$36

; Update OAM??, not sure ====================================
___L12A8:
    CLD
    TAX
    AND #$0F
    ORA #$30
    STA ZPUNK_30                    ; $30
    TXA
    LSR A
    LSR A
    LSR A
    LSR A
    AND #$0F
    ORA #$30
    STA ZPUNK_31                    ; $31
    LDA ZPListPositionY             ; $34
    STA $0203
    CLC
    ADC #$08
    STA $0207
    CLC
    ADC #$08
    STA $020B
    LDA ZPListPositionX             ; $35
    STA $0200
    STA $0204
    STA $0208
    LDA ZPUNK_30                    ; $30
    STA $0205
    LDA ZPUNK_31                    ; $31
    STA $0201
    LDA #$CF
    STA $0209
RTS


; -------------------------------------------


; --------------------------------------------
; -----------ScreenAttributesSet()-----------
; --------------------------------------------
ScreenAttributesSet:
    LDX #$10
    LDA #$00

; Reset ScreenAttributes to $00 with start at $03D0 (List text) since top part is bricks
@ScreenAttributesReset:
    STA $03C0, X
    INX
    CPX #$30
BCC @ScreenAttributesReset

; Resets $03F0 - $03F7 to (AND with $F0), since that part is shared between bottom bricks and text
@ScreenAttributesResetBottom:
    LDA $03C0, X
    AND #%11110000                  ; $F0
    STA $03C0, X
    INX
    CPX #$38
BCC @ScreenAttributesResetBottom

; Load ZPListSection and check if it Section = 3, if so branch (because of different nr of ListPositions)
    LDA ZPListSection
    CMP #ConstLastSection           ; $03
BEQ ___L1348

; Check if ZPListPosition is in left Column (Section 1 - 2)
    LDY #$D0                        ; ZPAdressLow if in left column
    LDA ZPListPosition
    CMP #ConstListPositionColumnSize
BCC ScreenAttributesChangeAttributes
; Or right Column (Section 1 - 2)
    LDY #$D4                        ; ZPAdressLow if in right column
    SBC #ConstListPositionColumnSize

ScreenAttributesChangeAttributes:
    LSR A ; LSR ZPListPosition that is loaded into A
    ROR ZPUNK_36                      ; $36
    TAX

___L1316:
BEQ ScreenAttributesSetAdress
    CLC
    TYA
    ADC #$08
    TAY
    DEX
BPL ___L1316

; Sets adress to $03D0 or $03D4 depending on left or right column
ScreenAttributesSetAdress:
    STY ZPAdressLow
    LDA #$03
    STA ZPAdressHigh
    LDY #$00

ScreenAttributesUpdate:
    LDA ZPUNK_36                                          ; $36
BMI ScreenAttributesUpdateBottomQuadrant

; Top Quadrant
    LDA (ZPAdressLow), Y
    ORA #%00000101                                      ; $05
    STA (ZPAdressLow), Y
BNE PaletteColorSectionChange

; Bottom Quadrant
ScreenAttributesUpdateBottomQuadrant:
    LDA (ZPAdressLow), Y
    ORA #%01010000                                      ; $50
    STA (ZPAdressLow), Y

; Change single palette color for each section (S1=RED, S2=GREEN, S3=BLUE)
PaletteColorSectionChange:
    INY
    CPY #$04
BCC ScreenAttributesUpdate
    LDX ZPListSection
    LDA PaletteSectionColors,X
    STA $030A                                           ; swap palette color of top brick color
RTS

; Palettechange for sections, change only color position 2
; $D550 - $D552 / €1550 - $1552 ????????????
; $D550, X(ZPListSection 1) = 16	Red
; $D550, X(ZPListSection 2) = 1A  Green
; $D550, X(ZPListSection 3) = 12  Blue
; 00 16 1A 12 PaletteSectionColors


; If ZPListSection is 3 / Last Section, and in left column (fewer listpositions than section 1 and 2)
___L1348:
    LDY #$D0                                            ; ZPAdressLow if in left column
    LDA ZPListPosition
    CMP #ConstListPositionColumnSizeLastSection         ; #$08
BCC ScreenAttributesChangeAttributes

; Or right column
    LDY #$D4                                            ; ZPAdressLow if in right column
    SBC #ConstListPositionColumnSizeLastSection         ; #$08
    CLC
BCC ScreenAttributesChangeAttributes


; --------------------------------------------


; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; NMI Vector
; ===================================================================================================

NMI:
; A Check to see if $1B == #$A5 and $1C == #$5A has been set in BootGame Routine
; If they are set, then NMI jumps to Galaxian NMI instead of 52-in-1 menu NMI
    PHA                             ; Push A to stack
    LDA #$A5
    CMP ZPBootGameCheck1            ; If $1B not #$A5 branch to NMI_52in1 
BNE NMI_52in1

    LDA #$5A
    CMP ZPBootGameCheck2            ; If $1C not #$5A branch to NMI_52in1
BNE NMI_52in1
    PLA                             ; Retrieve A from Stack
    JMP ConstGalaxianNMI            ; $E20C, Jumps to Galaxian which resides in the same 16kb PRG


; Start of the menu NMI
NMI_52in1:
; Save Y and X to stack and pull them at NMI end (A gets pushed to stack above)
    TYA
    PHA
    TXA
    PHA
    LDA ZPPPUCNTRLByte
; Disable NMI?
    AND #%01111111                  ; $7F
    STA PPUControl_2000

    LDA PPUStatus_2002
    JSR PPUBackgroundEnable

    JSR PlaySoundRoutine
    LDA ZPSoundByte_OLD
BEQ JoyPadHandleButtonPresses

; If ZPListSection has not changed compared to ZPListSection_OLD Do not change Section
    LDA ZPListSection
    CMP ZPListSection_OLD
BEQ PPUUpdateAttributesPalettes

; Else store new section into ZPListSection_OLD and clear NameTable
    STA ZPListSection_OLD
    JSR PPUClearNT

; Reset A to #$00 to start loading background to nametable
    LDA #$00
    JSR RLEDecoder

; Load ZPListSection into A to get pointers for that section
    LDA ZPListSection
    JSR RLEDecoder


PPUUpdateAttributesPalettes: ; Not sure if correctly named
    JSR ScreenAttributesSet
    JSR PaletteRAMtoPPU
    JSR ScreenAttributesRAMtoPPU

    LDA #$00
    STA PPUScroll_2005              ; Write 1: X Scroll
    STA PPUScroll_2005              ; Write 2: Y Scroll


JoyPadHandleButtonPresses:
; Reset sound byte to #$00 for no sound
    LDA #$00
    STA ZPSoundByte
    STA ZPSoundByte_OLD

; Poll JoyPad and store data to variables ZPJoyPad1 and ZPJoyPad2
    JSR JoyPadRoutine

; Check if SELECT, START, UP, DOWN, LEFT, RIGHT have been pressed, and branch if one of them have
    LDA ZPJoyPad1
    AND #%00111111                  ; $3F
BNE JoyPad_ResetContinouslyPressCounter

; Check if SELECT, UP, DOWN, LEFT, RIGHT have been pressed previously, and branch if one of them have
    LDA ZPJoyPad_Pressed 
    AND #%00101111                  ; $2F
BNE JoyPad_HoldUntilProcessingNextPress

; If no button has been pressed, store #$00 into $37 and go to END
    LDA #$00
    STA ZPJoyPad_Counter

JoyPadGoToEND:
    JMP JoyPad_Pressed_END



; ------------------------------
; JoyPad Check to delay button processing when holding the button
; ------------------------------

; Increases $37 until it is #$28 to stop processing continously held buttons too rapidly
; First repeat button process = slow
; after that = faster
JoyPad_HoldUntilProcessingNextPress:
    INC ZPJoyPad_Counter
    LDA ZPJoyPad_Counter
    CMP #$28                        ; When $37 is $28 Process continously held button again
BEQ JoyPad_SetJoyPad1toPressed

    CMP #$30                        ; When $37 is #$30 store #$28 to $37 again to process continously held button faster this time, if not $37 = #$30, then goto END
BCC JoyPadGoToEND

    LDA #$28
    STA ZPJoyPad_Counter

; Set ZPJoyPad1 to Pressed button and start processing button presses
JoyPad_SetJoyPad1toPressed:
    LDA ZPJoyPad_Pressed 
    STA ZPJoyPad1
BNE JoyPad_Pressed_RIGHT

JoyPad_ResetContinouslyPressCounter:
    LDA #$00
    STA ZPJoyPad_Counter

; ------------------------------



; ------------------------------
; JoyPad RIGHT
; ------------------------------

; Check if Right is pressed, if not continue
JoyPad_Pressed_RIGHT:
    LDA ZPJoyPad1
    AND #JOYPAD_RIGHT               ; %00000001 / $01
BEQ JoyPad_Pressed_LEFT

; What to do if RIGHT button pressed
; Play cursor move sound #$01
    LDA #$01
    STA ZPSoundByte

; Get current ZPListPosition and ZPListSection. If ZPListSection is 3, add less to ZPListPosition (Since there are fewer entries)
    LDA ZPListPosition
    LDX ZPListSection
    CPX #ConstLastSection                               ; $03
BEQ JoyPad_Pressed_RIGHT_Section3

; If ListPosition already is in the right column (ListPosition higher than #$09), then continue to next buttoncheck
    CMP #ConstListPositionColumnSize                    ; #$09
BCS JoyPad_Pressed_LEFT

; If Listposition is in the left column, then add #$09 to move cursor to the right side.
    ADC #ConstListPositionColumnSize                    ; #$09
    STA ZPListPosition
BNE JoyPad_Pressed_LEFT

; ------------------
;  IF IN SECTION 3.
; ------------------
; Only if in Section 3 / Last Section. If ListPosition already is in the right column (ListPosition higher than #$08), then continue to next buttoncheck
JoyPad_Pressed_RIGHT_Section3:
    CMP #ConstListPositionColumnSizeLastSection         ; #$08
BCS JoyPad_Pressed_LEFT

; Only if in Section 3 / Last Section. If Listposition is in the left column, then add #$08 to move cursor to the right side.
    ADC #ConstListPositionColumnSizeLastSection         ; #$08
    STA ZPListPosition

; ------------------------------



; ------------------------------
; JoyPad LEFT
; ------------------------------

JoyPad_Pressed_LEFT:
    LDA ZPJoyPad1
    AND #JOYPAD_LEFT                ; %00000010 / $02
BEQ JoyPad_Pressed_UP

; What to do if LEFT button pressed
; Play cursor move sound #$01
    LDA #$01
    STA ZPSoundByte

; Get current ZPListPositionX and ZPListSection. If ZPListSection is 3, substract less to ListPosition (Since there are fewer entries)
    LDA ZPListPosition
    LDX ZPListSection
    CPX #ConstLastSection                               ; $03
BEQ JoyPad_Pressed_LEFT_Section3

; If ListPosition already is in the left column (ListPosition lower than #$09), then continue to next buttoncheck
    CMP #ConstListPositionColumnSize                    ; #$09
BCC JoyPad_Pressed_UP

; If Listposition is in the right column, then substract #$09 to move cursor to the left side.
    SEC
    SBC #ConstListPositionColumnSize                    ; #$09
    STA ZPListPosition
BCS JoyPad_Pressed_UP

; ------------------
;  IF IN SECTION 3.
; ------------------
; Only if in Section 3 / Last Section. If ListPosition already is in the left column (ListPosition lower than #$08), then continue to next buttoncheck
JoyPad_Pressed_LEFT_Section3:
    CMP #ConstListPositionColumnSizeLastSection         ; #$08
BCC JoyPad_Pressed_UP

; Only if in Section 3 / Last Section. If Listposition is in the right column, then substract #$08 to move cursor to the left side.
    SEC
    SBC #ConstListPositionColumnSizeLastSection         ; #$08
    STA ZPListPosition

; ------------------------------



; ------------------------------
; JoyPad UP
; ------------------------------

JoyPad_Pressed_UP:
    LDA ZPJoyPad1
    AND #JOYPAD_UP                                      ; %00001000 / $08
BEQ JoyPad_Pressed_DOWN

; What to do if UP button pressed
; Play cursor move sound #$01
    LDA #$01
    STA ZPSoundByte

; Get current ListPosition and ZPListSection. If ZPListSection is 3, last ListPosition is a lower number (Since there are fewer entries)
    LDA ZPListPosition
    LDY #$10                                            ; Section 3
    LDX ZPListSection
    CPX #ConstLastSection                               ; $03
BEQ JoyPad_Pressed_UP_FirstPosition
; If not Section 3, ListPosition total is #$12
    LDY #$12

; Compare ListPosition to #$00. If not, then decrease ListPosition, else store last position (#$10 or #$12)
JoyPad_Pressed_UP_FirstPosition:
    CMP #$00
BNE JoyPad_Pressed_UP_ListPositionDecrease

; Store #$10 or #$12 to listposition to wrap around
    STY ZPListPosition

; Decrease ListPosition
JoyPad_Pressed_UP_ListPositionDecrease:
    DEC ZPListPosition

; ------------------------------



; ------------------------------
; JoyPad DOWN
; ------------------------------

JoyPad_Pressed_DOWN:
    LDA ZPJoyPad1
    AND #JOYPAD_DOWN                ; %00000100 / $04
BEQ JoyPad_Pressed_SELECT

; What to do if DOWN button pressed
; Play cursor move sound #$01
    LDA #$01
    STA ZPSoundByte

; Get current ListPosition and ZPListSection. If ZPListSection is 3, first ListPosition is a lower number (Since there are fewer entries)
    LDA ZPListPosition
    LDX ZPListSection
    CPX #ConstLastSection           ; $03
BEQ JoyPad_Pressed_DOWN_Section3

; If Not Section 3, and listposition is or over #$11, then set ListPosition to #$FF and increaste for A = #$00
; If Not Section 3, and listposition is under #$11, then increase ListPosition
    CMP #$11
BCS JoyPad_Pressed_DOWN_ListPositionSetFF
BCC JoyPad_Pressed_DOWN_ListPositionIncrease

; If Section 3, and ListPosition is, or is over #$0F, then set ListPosition to #$FF and increaste for A = #$00
; If Section 3, and listposition is under #$0F, then increase ListPosition
JoyPad_Pressed_DOWN_Section3:
    CMP #$0F
BCC JoyPad_Pressed_DOWN_ListPositionIncrease

; If at max Listposition, set A to #$FF and increase with one for A = #$00
JoyPad_Pressed_DOWN_ListPositionSetFF:
    LDA #$FF
    STA ZPListPosition

; Increase ListPosition
JoyPad_Pressed_DOWN_ListPositionIncrease:
    INC ZPListPosition

; ------------------------------



; ------------------------------
; JoyPad SELECT
; ------------------------------

JoyPad_Pressed_SELECT:
    LDA ZPJoyPad1
    AND #JOYPAD_SELECT              ; %00100000 / $20
BEQ JoyPad_Pressed_START

; What to do if SELECT button pressed
; Play select sound #$02
    LDA #$02
    STA ZPSoundByte
; Increase ZPListSection and if it goes over 3, then it resets to 1
    INC ZPListSection
    LDA ZPListSection
    CMP #$04
BCC JoyPad_Pressed_SELECT_Section3

    LDA #$01
    STA ZPListSection

; If Section is #$03 and Listposition is over #$0F, then set ListPosition to #$0F
JoyPad_Pressed_SELECT_Section3:
    CMP #ConstLastSection           ; $03
BNE JoyPad_Pressed_START

    LDA #$0F
    CMP ZPListPosition
BCS JoyPad_Pressed_START

    STA ZPListPosition

; ------------------------------



; ------------------------------
; JoyPad START
; ------------------------------

JoyPad_Pressed_START:
    LDA ZPJoyPad1
    AND #JOYPAD_START               ; #%00010000 / $10
BEQ JoyPad_Pressed_END

; What to do if START button pressed
; Play select sound #$02 and start PlaySoundRoutine
    LDA #$02
    STA ZPSoundByte
    JSR PlaySoundRoutine

JoyPad_Pressed_START_DoubleCheck:
; Double check that pressed button is Start ??
    JSR JoyPadRoutine
    LDA ZPJoyPad_Pressed
    ;AND 
    AND #JOYPAD_START               ; #%00010000 / $10
BNE JoyPad_Pressed_START_DoubleCheck

    JMP BootGame

; ------------------------------



; ------------------------------
; JoyPad END CHECK
; ------------------------------

JoyPad_Pressed_END:
    JSR UpdateListSectionPosition
    JSR OAMSetAdress

    LDA ZPPPUCNTRLByte
; Enable NMI
    ORA #%10000000                  ; $80
    STA PPUControl_2000

; Restores registers from stack
    PLA
    TAX
    PLA
    TAY
    PLA

RTI                                 ; Return from NMI



; ===================================================================================================
; ===================================================================================================
; ===================================================================================================


; ===================================================================================================
; IRQ Vector
; ===================================================================================================

; IRQ:
;     RTI



; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; NMI Routines
; ===================================================================================================

; ----------------------------------
; --------PlaySoundRoutine()--------
; ----------------------------------

PlaySoundRoutine:
    LDA ZPSoundByte
BEQ @PlaySoundRoutine_END

@PlaySoundCursor:
    ; Check if ZPSoundByte = 01 (cursor sound), if not then check if byte is 02 (select sound)
    CMP #$01
BNE @PlaySoundSelect

; If A = #$01 then play cursor sound
    LDA #$03
    STA APUStatus_4015
    LDA #$87
    STA SQ0Duty_4000
    LDA #$89
    STA SQ0Sweep_4001
    LDA #$F0
    STA SQ0Timer_4002
    LDA #$00
    STA SQ0Length_4003
BEQ @PlaySoundEndSound


@PlaySoundSelect:
    ; Check if ZPSoundByte = 02 (select sound), if not then reset ZPSoundByte to #$00
    CMP #$02
BNE @PlaySoundByteReset

; If A = #$02 then play cursor sound
    LDA #$02
    STA APUStatus_4015
    LDA #$3F
    STA SQ1Duty_4004
    LDA #$9A         
    STA SQ1Sweep_4005
    LDA #$FF
    STA SQ1Timer_4006
    LDA #$00
    STA SQ1Length_4007

@PlaySoundEndSound:
    LDA #$FF
    STA ZPSoundByte_OLD

@PlaySoundByteReset:
    LDA #$00
    STA ZPSoundByte

@PlaySoundRoutine_END:
RTS

; ----------------------------------



; -------------------------------
; --------JoyPadRoutine()--------
; -------------------------------

JoyPadRoutine:
    JSR JoyPad_Poll

; Check if JoyPad buttons have been pressed since last check ??
JoyPad_ButtonPressChangeCheck:
    LDY ZPJoyPad1
    LDA ZPJoyPad2

    PHA
    JSR JoyPad_Poll
    PLA

    CMP ZPJoyPad2
    BNE JoyPad_ButtonPressChangeCheck

    CPY ZPJoyPad1
    BNE JoyPad_ButtonPressChangeCheck

    LDX #$01

@JoyPad_PressesReleases:            ; Correct Name?=====================
    LDA ZPJoyPad1, X
    TAY
    EOR ZPJoyPad_Pressed , X           ; Not Sure?
    AND ZPJoyPad1, X
    STA ZPJoyPad1, X
    STY ZPJoyPad_Pressed , X
    DEX
BPL @JoyPad_PressesReleases

RTS

; -------------------------------



; ---------------------------------
; ---------JoyPad_Poll()-----------
; ---------------------------------

JoyPad_Poll:
    LDX #$00
    INX


; While the strobe bit is set, buttons will be continuously reloaded.
; This means that reading from JOYPAD1 will only return the state of the
; first button: button A.
    STX CTRL1_4016
    DEX

; By storing 0 into JOYPAD1, the strobe bit is cleared and the reloading stops.
; This allows all 8 buttons (newly reloaded) to be read from JOYPAD1.
    STX CTRL1_4016
    LDX #$08

@JoyPad_Poll_Loop:
; Controller #1
    LDA CTRL1_4016
    LSR A
    ROL ZPJoyPad1

    LSR A
    ROL ZPJoyPad1_OLD

; Controller #2
    LDA CTRL2_4017
    LSR A
    ROL ZPJoyPad2

    LSR A
    ROL ZPJoyPad2_OLD

;Loop 8 times for all buttons
    DEX
BNE @JoyPad_Poll_Loop

; Controller #1
    LDA ZPJoyPad1_OLD
    ORA ZPJoyPad1
    STA ZPJoyPad1

; Controller #2
    LDA ZPJoyPad2_OLD
    ORA ZPJoyPad2
    STA ZPJoyPad2
RTS

; ---------------------------------


; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; Data
; ===================================================================================================

; Start of menu data
.segment "RODATAA"                  ; $D550

; Starts at: $9550 - $9553 / $1550 - $1553
PaletteSectionColors:
    ; 16 = Red | 1A = Green | 12 = Blue | 
    .byte $00, $16, $1A, $12

; PaletteSectionColors
; $1550 - $1553
; 00 16 1A 12



; Starts at: $9554 - $9593 / $1554 - $1593
AttributeTableData:
    .byte %10101010, %10101010, %10101010, %10101010, %10101010, %10101010, %10101010, %10101010
    .byte %10101010, %10101010, %10100000, %10100000, %10100000, %10100000, %10101010, %10101010
    .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
    .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
    .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
    .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
    .byte %11110000, %11110000, %11110000, %11110000, %11110000, %11110000, %11110000, %11110000
    .byte %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111



; Starts at: $9594 - $95B3 / $1594 - $15B3
PaletteData:
    .byte $0F, $0F, $0F, $20        ; BG0
    .byte $0F, $0F, $0F, $26        ; BG1
    .byte $0F, $0F, $26, $0F        ; BG2
    .byte $0F, $06, $0F, $0F        ; BG3

    .byte $0F, $0F, $0F, $06        ; SP0
    .byte $0F, $0F, $0F, $0F        ; SP1
    .byte $0F, $0F, $0F, $0F        ; SP2
    .byte $0F, $0F, $0F, $0F        ; SP3



; Starts at: $D5B4 - $D5BB / $15B4 - $15BB
NameTablePointerData:
    ; BackgroundMenuTiles $D5BC / $15BC:
    .word NameTableBackgroundMenuTiles      ; .byte $BC, $D5 | $D5BC

    ; Section 1 $D638 / $1638
    .word NameTableSection1         ; .byte $38, $D6 | $D638

    ; Section 2 $D744 / $1744
    .word NameTableSection2         ; .byte $44, $D7 | $D744

    ; Section 3 $D867 / $1867
    .word NameTableSection3         ; .byte $67, $D8 | $D867



; Starts at: $D5BC - $D637 / $15BC - $1637
; $FE = [Set NameTable adress with PPUAdress_2006], [MSB], [LSB]
; $FD = [Store tiles to NameTable at previously set adress], [Number of repetitions], [Background tile to store]
; $FF = End Tileset
; If not any of above, assume the data is a Background tile
NameTableBackgroundMenuTiles:
    ; STARTBYTES
    .byte $FE, $20, $00
    ; Top Bricktiles $61 and $00
    .byte $FD, $67, $61             ; Tile 61, 67 times
    .byte $FD, $11, $00             ; Tile 00, 11 times
    .byte $FD, $0F, $61             ; Tile 61, 0F times
    .byte $FD, $11, $00             ; Tile 00, 11 times
    .byte $FD, $0F, $61             ; Tile 61, 0F times
    .byte $FD, $11, $00             ; Tile 00, 11 times
    .byte $FD, $28, $61             ; Tile 61, 28 times

    ; STARTBYTES
    .byte $FE, $23, $60
    ; Bottom BrickTiles $AC & $AD
    .byte $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD
    .byte $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC
    .byte $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD, $AC, $AD

    ; ENDBYTE
    .byte $FF

; BackgroundMenuTiles
; $15BC - $1637
; FE 20 00 FD 67 61 FD 11 00 FD 0F 61 FD 11 00 FD
; 0F 61 FD 11 00 FD 28 61 FE 23 60 AC AD AC AD AC
; AD AC AD AC AD AC AD AC AD AC AD AC AD AC AD AC
; AD AC AD AC AD AC AD AC AD AC AD AD AC AD AC AD
; AC AD AC AD AC AD AC AD AC AD AC AD AC AD AC AD
; AC AD AC AD AC AD AC AD AC AD AC AC AD AC AD AC
; AD AC AD AC AD AC AD AC AD AC AD AC AD AC AD AC
; AD AC AD AC AD AC AD AC AD AC AD FF




; Starts at: $D638 - $D743 / $1638 - $1743
NameTableSection1:
    ; STARTBYTES
    .byte $FE, $20, $8B
    ;       S    E    C    T    I    O    N         1
    .byte $53, $45, $43, $54, $49, $4F, $4E, $00, $31


    ; Column 1
    ; STARTBYTES
    .byte $FE, $21, $00
    ;       0    1    .    I   S     L    A    N    D    E    R
    .byte $30, $31, $CF, $49, $53, $4C, $41, $4E, $44, $45, $52
    ; STARTBYTES
    .byte $FE, $21, $40
    ;       0    2    .    G    R    A    D    I    N    G
    .byte $30, $32, $CF, $47, $52, $41, $44, $49, $4E, $47
    ; STARTBYTES
    .byte $FE, $21, $80
    ;       0    3    .    P    -    D         F    I    G    H    T    I    N    G  <-- MAX LENGTH
    .byte $30, $33, $CF, $50, $5B, $44, $00, $46, $49, $47, $48, $54, $49, $4E, $47
    ; STARTBYTES
    .byte $FE, $21, $C0
    ;       0    4    .    S    T    A    R         S    O    L    D    I    E    R  <-- MAX LENGTH
    .byte $30, $34, $CF, $53, $54, $41, $52, $00, $53, $4F, $4C, $44, $49, $45, $52
    ; STARTBYTES
    .byte $FE, $22, $00
    ;       0    5    .    G    O    O    N    I    E    S
    .byte $30, $35, $CF, $47, $4F, $4F, $4E, $49, $45, $53
    ; STARTBYTES
    .byte $FE, $22, $40
    ;       0    6    .    L    E    G    E    N    D    R    Y
    .byte $30, $36, $CF, $4C, $45, $47, $45, $4E, $44, $52, $59
    ; STARTBYTES
    .byte $FE, $22, $80
    ;       0    7    .    T    E    T    R    I    S
    .byte $30, $37, $CF, $54, $45, $54, $52, $49, $53
    ; STARTBYTES
    .byte $FE, $22, $C0
    ;       0    8    .    B    R    O    S    .         I    I
    .byte $30, $38, $CF, $42, $52, $4F, $53, $CF, $00, $49, $49
    ; STARTBYTES
    .byte $FE, $23, $00
    ;       0    9    .    T    W    I    N         B    E    E
    .byte $30, $39, $CF, $54, $57, $49, $4E, $00, $42, $45, $45


    ; Column 2
    ; STARTBYTES
    .byte $FE, $21, $10
    ;       1    0    .    N    I    N    J    A         2
    .byte $31, $30, $CF, $4E, $49, $4E, $4A, $41, $00, $32
    ; STARTBYTES
    .byte $FE, $21, $50
    ;       1    1    .    C    I    T    Y         C    O    N    E    C    T    .  <-- MAX LENGTH
    .byte $31, $31, $CF, $43, $49, $54, $59, $00, $43, $4F, $4E, $45, $43, $54, $CF
    ; STARTBYTES
    .byte $FE, $21, $90
    ;       1    2    .    B    -    W    I    N    G    S
    .byte $31, $32, $CF, $42, $5B, $57, $49, $4E, $47, $53
    ; STARTBYTES
    .byte $FE, $21, $D0
    ;       1    3    .    1    9    4    2
    .byte $31, $33, $CF, $31, $39, $34, $32
    ; STARTBYTES
    .byte $FE, $22, $10
    ;       1    4    .    G    Y    R    O    O    I    N   E
    .byte $31, $34, $CF, $47, $59, $52, $4F, $4F, $49, $4E, $45
    ; STARTBYTES
    .byte $FE, $22, $50
    ;       1    5    .    F    L    A    P    P    Y
    .byte $31, $35, $CF, $46, $4C, $41, $50, $50, $59
    ; STARTBYTES
    .byte $FE, $22, $90
    ;       1    6    .    S    P    A    R    T    A    N
    .byte $31, $36, $CF, $53, $50, $41, $52, $54, $41, $4E
    ; STARTBYTES
    .byte $FE, $22, $D0
    ;       1    7    .    B    O    M    B    E    R         M    A    N
    .byte $31, $37, $CF, $42, $4F, $4D, $42, $45, $52, $00, $4D, $41, $4E
    ; STARTBYTES
    .byte $FE, $23, $10
    ;       1    8    .    F    R    O    N    T         L    I    N    E
    .byte $31, $38, $CF, $46, $52, $4F, $4E, $54, $00, $4C, $49, $4E, $45
    ; ENDBYTE
    .byte $FF

; NameTableSection1
; $1638 - $1743
; FE 20 8B 53 45 43 54 49 4F 4E 00 31 FE 21 00 30
; 31 CF 49 53 4C 41 4E 44 45 52 FE 21 40 30 32 CF
; 47 52 41 44 49 4E 47 FE 21 80 30 33 CF 50 5B 44
; 00 46 49 47 48 54 49 4E 47 FE 21 C0 30 34 CF 53
; 54 41 52 00 53 4F 4C 44 49 45 52 FE 22 00 30 35
; CF 47 4F 4F 4E 49 45 53 FE 22 40 30 36 CF 4C 45
; 47 45 4E 44 52 59 FE 22 80 30 37 CF 54 45 54 52
; 49 53 FE 22 C0 30 38 CF 42 52 4F 53 CF 00 49 49
; FE 23 00 30 39 CF 54 57 49 4E 00 42 45 45 FE 21
; 10 31 30 CF 4E 49 4E 4A 41 00 32 FE 21 50 31 31
; CF 43 49 54 59 00 43 4F 4E 45 43 54 CF FE 21 90
; 31 32 CF 42 5B 57 49 4E 47 53 FE 21 D0 31 33 CF
; 31 39 34 32 FE 22 10 31 34 CF 47 59 52 4F 4F 49
; 4E 45 FE 22 50 31 35 CF 46 4C 41 50 50 59 FE 22
; 90 31 36 CF 53 50 41 52 54 41 4E FE 22 D0 31 37
; CF 42 4F 4D 42 45 52 00 4D 41 4E FE 23 10 31 38
; CF 46 52 4F 4E 54 00 4C 49 4E 45 FF




; Starts at: $D744 - $D866 / $1744 - $1866
NameTableSection2:
    ; STARTBYTES
    .byte $FE, $20, $8B
    ;       S    E    C    T    I    O    N         2
    .byte $53, $45, $43, $54, $49, $4F, $4E, $00, $32


    ; Column 1
    ; STARTBYTES
    .byte $FE, $21, $00
    ;       1    9    .    M    A    C    R    O    S    S
    .byte $31, $39, $CF, $4D, $41, $43, $52, $4F, $53, $53
    ; STARTBYTES
    .byte $FE, $21, $40
    ;       2    0    .    1    9    8    9    G    A    L    A    X    I    A    N
    .byte $32, $30, $CF, $31, $39, $38, $39, $47, $41, $4C, $41, $58, $49, $41, $4E
    ; STARTBYTES
    .byte $FE, $21, $80
    ;       2    1    .    S    T    A    R         F    O    R    C    E
    .byte $32, $31, $CF, $53, $54, $41, $52, $00, $46, $4F, $52, $43, $45
    ; STARTBYTES
    .byte $FE, $21, $C0
    ;       2    2    .    K    U    N    G    -    F    U
    .byte $32, $32, $CF, $4B, $55, $4E, $47, $5B, $46, $55
    ; STARTBYTES
    .byte $FE, $22, $00
    ;       2    3    .    N    I    N    J    A         1
    .byte $32, $33, $CF, $4E, $49, $4E, $4A, $41, $00, $31
    ; STARTBYTES
    .byte $FE, $22, $40
    ;       2    4    .    P    I    P    E    L    I    N    E
    .byte $32, $34, $CF, $50, $49, $50, $45, $4C, $49, $4E, $45
    ; STARTBYTES
    .byte $FE, $22, $80
    ;       2    5    .    M    A    H    J    O    N    G         2
    .byte $32, $35, $CF, $4D, $41, $48, $4A, $4F, $4E, $47, $00, $32
    ; STARTBYTES
    .byte $FE, $22, $C0
    ;       2    6    .    M    A    H    J    O    N    G         4
    .byte $32, $36, $CF, $4D, $41, $48, $4A, $4F, $4E, $47, $00, $34
    ; STARTBYTES
    .byte $FE, $23, $00
    ;       2    7    .    L    O    D    E         R    U    N    N    E    R    1
    .byte $32, $37, $CF, $4C, $4F, $44, $45, $00, $52, $55, $4E, $4E, $45, $52, $31


    ; Column 2
    ; STARTBYTES
    .byte $FE, $21, $10
    ;       2    8    .    L    O    D    E         R    U    N    N    E    R    2
    .byte $32, $38, $CF, $4C, $4F, $44, $45, $00, $52, $55, $4E, $4E, $45, $52, $32
    ; STARTBYTES
    .byte $FE, $21, $50
    ;       2    9    .    K    I    N    G         K    O    N    G         1
    .byte $32, $39, $CF, $4B, $49, $4E, $47, $00, $4B, $4F, $4E, $47, $00, $31
    ; STARTBYTES
    .byte $FE, $21, $90
    ;       3    0    .    K    I    N    G         K    O    N    G         2
    .byte $33, $30, $CF, $4B, $49, $4E, $47, $00, $4B, $4F, $4E, $47, $00, $32
    ; STARTBYTES
    .byte $FE, $21, $D0
    ;       3    1    .    K    I    N    G         K    O    N    G         3
    .byte $33, $31, $CF, $4B, $49, $4E, $47, $00, $4B, $4F, $4E, $47, $00, $33
    ; STARTBYTES
    .byte $FE, $22, $10
    ;       3    2    .    M    A    P    P    Y
    .byte $33, $32, $CF, $4D, $41, $50, $50, $59
    ; STARTBYTES
    .byte $FE, $22, $50
    ;       3    3    .    E    X    C    I    T    E         B    I    K    E
    .byte $33, $33, $CF, $45, $58, $43, $49, $54, $45, $00, $42, $49, $4B, $45
    ; STARTBYTES
    .byte $FE, $22, $90
    ;       3    4    .    F    -    1         R    A    C    E
    .byte $33, $34, $CF, $46, $5B, $31, $00, $52, $41, $43, $45
    ; STARTBYTES
    .byte $FE, $22, $D0
    ;       3    5    .    R    O    A    D         F    I    G    H    T    E    R
    .byte $33, $35, $CF, $52, $4F, $41, $44, $00, $46, $49, $47, $48, $54, $45, $52
    ; STARTBYTES
    .byte $FE, $23, $10
    ;       3    6    .    P    I    N         B    A    L    L
    .byte $33, $36, $CF, $50, $49, $4E, $00, $42, $41, $4C, $4C
    ; ENDBYTE
    .byte $FF


; NameTableSection2:
; $1744 - $1866
; FE 20 8B 53 45 43 54 49 4F 4E 00 32 FE 21 00 31
; 39 CF 4D 41 43 52 4F 53 53 FE 21 40 32 30 CF 31
; 39 38 39 47 41 4C 41 58 49 41 4E FE 21 80 32 31
; CF 53 54 41 52 00 46 4F 52 43 45 FE 21 C0 32 32
; CF 4B 55 4E 47 5B 46 55 FE 22 00 32 33 CF 4E 49
; 4E 4A 41 00 31 FE 22 40 32 34 CF 50 49 50 45 4C
; 49 4E 45 FE 22 80 32 35 CF 4D 41 48 4A 4F 4E 47
; 00 32 FE 22 C0 32 36 CF 4D 41 48 4A 4F 4E 47 00
; 34 FE 23 00 32 37 CF 4C 4F 44 45 00 52 55 4E 4E
; 45 52 31 FE 21 10 32 38 CF 4C 4F 44 45 00 52 55
; 4E 4E 45 52 32 FE 21 50 32 39 CF 4B 49 4E 47 00
; 4B 4F 4E 47 00 31 FE 21 90 33 30 CF 4B 49 4E 47
; 00 4B 4F 4E 47 00 32 FE 21 D0 33 31 CF 4B 49 4E
; 47 00 4B 4F 4E 47 00 33 FE 22 10 33 32 CF 4D 41
; 50 50 59 FE 22 50 33 33 CF 45 58 43 49 54 45 00
; 42 49 4B 45 FE 22 90 33 34 CF 46 5B 31 00 52 41
; 43 45 FE 22 D0 33 35 CF 52 4F 41 44 00 46 49 47
; 48 54 45 52 FE 23 10 33 36 CF 50 49 4E 00 42 41
; 4C 4C FF



; Starts at: $D867 - $D968 / $1867 - $1968
NameTableSection3:
    ; STARTBYTES
    .byte $FE, $20, $8B
    ;       S    E    C    T    I    O    N         3
    .byte $53, $45, $43, $54, $49, $4F, $4E, $00, $33


    ; Column 1
    ; STARTBYTES
    .byte $FE, $21, $00
    ;       3    7    .    B    A    S    E         B    A    L    L
    .byte $33, $37, $CF, $42, $41, $53, $45, $00, $42, $41, $4C, $4C
    ; STARTBYTES
    .byte $FE, $21, $40
    ;       3    8    .    P    O    P    E    Y    E
    .byte $33, $38, $CF, $50, $4F, $50, $45, $59, $45
    ; STARTBYTES
    .byte $FE, $21, $80
    ;       3    9    .    G    A    L    A    G    A
    .byte $33, $39, $CF, $47, $41, $4C, $41, $47, $41
    ; STARTBYTES
    .byte $FE, $21, $C0
    ;       4    0    .    G    A    L    A    X    I    A    N
    .byte $34, $30, $CF, $47, $41, $4C, $41, $58, $49, $41, $4E
    ; STARTBYTES
    .byte $FE, $22, $00
    ;       4    1    .    P    A    C    -    M    A    N
    .byte $34, $31, $CF, $50, $41, $43, $5B, $4D, $41, $4E
    ; STARTBYTES
    .byte $FE, $22, $40
    ;       4    2    .    I    C    E         C    L    I    M    B    E    R
    .byte $34, $32, $CF, $49, $43, $45, $00, $43, $4C, $49, $4D, $42, $45, $52
    ; STARTBYTES
    .byte $FE, $22, $80
    ;       4    3    .    1    9    8    9         E    X    E    R    I    O    N
    .byte $34, $33, $CF, $31, $39, $38, $39, $00, $45, $58, $45, $52, $49, $4F, $4E
    ; STARTBYTES
    .byte $FE, $22, $C0
    ;       4    4    .    W    R    E    S    T    L    E
    .byte $34, $34, $CF, $57, $52, $45, $53, $54, $4C, $45
    

    ; Column 2
    ; STARTBYTES
    .byte $FE, $21, $10
    ;       4    5    .    B    A    T    T    L    E         C    I    T    Y
    .byte $34, $35, $CF, $42, $41, $54, $54, $4C, $45, $00, $43, $49, $54, $59
    ; STARTBYTES
    .byte $FE, $21, $50
    ;       4    6    .    S    K    Y         D    E    S    T    R    Y    O    E    R
    .byte $34, $36, $CF, $53, $4B, $59, $00, $44, $45, $53, $54, $52, $59, $4F, $45, $52
    ; STARTBYTES
    .byte $FE, $21, $90
    ;       4    7    .    C    H    E    S    S
    .byte $34, $37, $CF, $43, $48, $45, $53, $53
    ; STARTBYTES
    .byte $FE, $21, $D0
    ;       4    8    .    B    A    L    L    O    O    N         F    I    G    H    T
    .byte $34, $38, $CF, $42, $41, $4C, $4C, $4F, $4F, $4E, $00, $46, $49, $47, $48, $54
    ; STARTBYTES
    .byte $FE, $22, $10
    ;       4    9    .    F    O    R    M    A    T    I    O    N         Z
    .byte $34, $39, $CF, $46, $4F, $52, $4D, $41, $54, $49, $4F, $4E, $00, $5A
    ; STARTBYTES
    .byte $FE, $22, $50
    ;       5    0    .    P    O    O    Y    A    N
    .byte $35, $30, $CF, $50, $4F, $4F, $59, $41, $4E
    ; STARTBYTES
    .byte $FE, $22, $90
    ;       5    1    .    C    I    R    C    U    S         T    R    O    U    P    E
    .byte $35, $31, $CF, $43, $49, $52, $43, $55, $53, $00, $54, $52, $4F, $55, $50, $45
    ; STARTBYTES
    .byte $FE, $22, $D0
    ;       5    2    .    F    A    N    C    Y         B    R    O    S    .
    .byte $35, $32, $CF, $46, $41, $4E, $43, $59, $00, $42, $52, $4F, $53, $CF
    ; ENDBYTE
    .byte $FF


; NameTableSection3:
; $1867 - $1968
; FE 20 8B 53 45 43 54 49 4F 4E 00 33 FE 21 00 33
; 37 CF 42 41 53 45 00 42 41 4C 4C FE 21 40 33 38
; CF 50 4F 50 45 59 45 FE 21 80 33 39 CF 47 41 4C
; 41 47 41 FE 21 C0 34 30 CF 47 41 4C 41 58 49 41
; 4E FE 22 00 34 31 CF 50 41 43 5B 4D 41 4E FE 22
; 40 34 32 CF 49 43 45 00 43 4C 49 4D 42 45 52 FE
; 22 80 34 33 CF 31 39 38 39 00 45 58 45 52 49 4F
; 4E FE 22 C0 34 34 CF 57 52 45 53 54 4C 45 FE 21
; 10 34 35 CF 42 41 54 54 4C 45 00 43 49 54 59 FE
; 21 50 34 36 CF 53 4B 59 00 44 45 53 54 52 59 4F
; 45 52 FE 21 90 34 37 CF 43 48 45 53 53 FE 21 D0
; 34 38 CF 42 41 4C 4C 4F 4F 4E 00 46 49 47 48 54
; FE 22 10 34 39 CF 46 4F 52 4D 41 54 49 4F 4E 00
; 5A FE 22 50 35 30 CF 50 4F 4F 59 41 4E FE 22 90
; 35 31 CF 43 49 52 43 55 53 00 54 52 4F 55 50 45
; FE 22 D0 35 32 CF 46 41 4E 43 59 00 42 52 4F 53
; CF FF


; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; BootGame code
; ===================================================================================================

; ----------------------------------
; ------------BootGame()------------
; ---------------------------------- 

; Start of last portion of menu code
.segment "CODEC"                    ; $D969


; Loads
BootGame:
    LDX #$00

@BootGame_Loop:
    LDA BootGameBankSwitchRoutine, X
    STA $0180, X

; This routine is a bankswitch routine for 06.LEGENDRY
; $19F2 - $1A00
; 48 29 02 D0 05 8D 90 A2 68 60 8D 91 A2 68 60

    INX
    CPX #$0F
BCC @BootGame_Loop


; Set values to $1B and $1C. This gets checked in NMI
; If they are set, NMI skips 52-in-1 menu NMI and goes to galaxians NMI instead.
    LDA #$A5
    STA ZPBootGameCheck1
    LDA #$5A
    STA ZPBootGameCheck2

; Load Section to get BootSequenceData Pointer
    LDA ZPListSection
    CMP #$01
BNE @BootGameSection2

; If Section 1, start at $DA01. Why not use pointers here?
@BootGameSection1:
    LDA #ConstBootGameBootSequencesStartSection1AdressLow    ; $01
    STA ZPAdressLow
    LDA #ConstBootGameBootSequencesStartSection1AdressHigh   ; $DA
    STA ZPAdressHigh
BNE @BootGameSection_END

; Section 1 BootCodes
;  ($DA01 - $DB20 / $1A01 - $1B20)
; 8D 00 80 4C 00 80 58 85 5B A9 02 85 5C 60 C6 5D
; 8D 84 80 4C 10 80 85 5B A9 01 85 5C 60 C6 5D C9
; 8D 08 81 4C 06 81 5B A9 01 85 5C 60 C6 5D A9 C8
; 8D 8C 81 4C 0A 80 60 A5 69 D0 02 38 60 C9 12 D0
; 8D 0E 82 4C 11 80 00 A0 C8 4C 8C DA C9 11 D0 0B
; 8D 90 A2 78 D8 A9 00 4C 04 80 DA A5 68 18 69 04
; 8D 12 83 4C 00 80 A5 68 C9 01 F0 1F 86 A1 84 A0
; 8D 94 83 78 D8 A9 10 4C 04 80 65 9E 85 A0 A5 A1
; 8D 15 A4 4C 11 80 F0 A6 A1 A4 A0 86 5C 84 5B 18
; 8D 96 94 4C 2F 81 85 A0 A9 00 65 A1 85 A1 20 C0
; 8D D8 94 4C 00 80 48 06 A0 26 A1 06 A0 26 A1 68
; 8D 1A A5 4C 00 80 65 A1 85 A1 06 A0 26 A1 60 A5
; 8D 9B A5 78 D8 A2 F3 4C 94 BF A1 85 A0 E6 A0 D0
; 8D 1C 86 4C A5 EF E9 0A 85 99 A5 9A E9 00 85 9A
; 8D 9D A6 4C 07 80 F0 11 A2 0F BD 00 02 E8 C9 FF
; 8D 1E 87 78 D8 A9 00 4C 5C 82 A5 12 D0 0D A9 24
; 8D 9F 97 4C 00 C0 A9 98 85 06 60 4C DC F9 85 98
; 8D E0 B7 4C 00 C0 C5 A5 1A D0 22 A5 19 29 04 F0



; If Section 2, start at $DB21
@BootGameSection2:
    CMP #$02
BNE @BootGameSection3

    LDA #ConstBootGameBootSequencesStartSection2AdressLow    ; $21
    STA ZPAdressLow
    LDA #ConstBootGameBootSequencesStartSection2AdressHigh   ; $DB
    STA ZPAdressHigh
BNE @BootGameSection_END

; Section 2 BootCodes
;  ($DB21 - $DC40 / $1B21 - $1C40)
; 8D 21 98 78 D8 A9 10 4C 04 80 98 85 03 A5 07 49
; 8D 62 B8 A9 FF 85 1A 4C 20 E0 4C 18 DB 20 38 C5
; 8D A3 98 78 D8 A2 FF 4C 04 C0 A9 99 85 06 60 A9
; 8D E4 B8 4C 0F C0 7E 85 84 A5 39 18 69 01 29 03
; 8D 25 B9 78 A9 00 4C 03 80 39 29 03 85 39 20 6A
; 8D 66 B9 78 D8 AD 02 20 10 FB 4C 07 C0 20 0F F7
; 8D A7 99 78 D8 A9 10 4C 47 CA 00 A0 2C 91 A2 C8
; 8D E8 99 4C 00 C0 91 A2 C8 A9 FF 91 A2 20 10 DE
; 8D 29 9A 78 D8 A2 FF 4C 04 C0 B9 E6 39 A5 39 29
; 8D 69 9A 78 D8 A2 FF 4C 04 C0 39 F0 0B A9 04 85
; 8D AA 9A 78 D8 A9 10 4C A2 C7 E4 A9 05 18 60 A9
; 8D EB BA 78 D8 A9 10 4C 72 C6 B5 76 C9 FF F0 0F
; 8D 2C 9B 78 D8 AD 02 20 10 FB 4C 07 C0 18 60 C6
; 8D 6D 9B 4C 31 C0 7F 20 24 DC B0 05 20 76 DF 38
; 8D AE 9B 78 D8 A9 00 4C 88 C1 24 DC B0 02 38 60
; 8D EF 9B AD 02 20 10 FB 4C 05 C0 B0 02 38 60 C6
; 8D 30 BC 4C 10 C0 6A F4 A5 0F 85 40 85 A2 A5 10
; 8D 71 BC 78 D8 AD 02 20 10 FB 4C 07 C0 C9 FF D0



; If Section 3, start at $DC41
@BootGameSection3:
    LDA #ConstBootGameBootSequencesStartSection3AdressLow    ; $41
    STA ZPAdressLow
    LDA #ConstBootGameBootSequencesStartSection3AdressHigh   ; $DC
    STA ZPAdressHigh

; Section 3 BootCodes
;  ($DC41 - $DD40 / $1C41 - $1D40)
; 8D B2 BC 4C C7 C3 06 A5 47 C9 04 D0 2F A5 48 05
; 8D F3 BC 78 D8 A9 10 4C 4D C6 8E DC A0 30 B1 A2
; 8D 34 BD 78 D8 A9 00 4C 04 C0 C9 04 D0 06 A9 01
; 8D 62 B8 A9 00 85 1A 4C 20 E0 18 60 A9 00 A0 30
; 8D 75 BD 4C 35 C0 E4 A9 01 85 61 18 60 A0 31 B1
; 8D B6 BD 78 D8 A9 10 4C 18 C0 04 A9 04 D0 2F A0
; 8D F7 BD 4C 00 80 DB CC A0 31 B1 A2 29 01 D0 06
; 8D 38 9E 78 A2 FF 4C 03 80 08 A0 42 B1 A2 C9 03
; 8D 79 BE 4C 70 C0 07 20 D4 DC 90 02 A9 00 A0 30
; 8D BA BE 4C 00 C0 A2 F0 1C A5 84 C9 02 B0 16 A0
; 8D FB 9E 4C 00 C7 0A A5 60 38 F1 A2 29 30 F0 07
; 8D 3C BF 4C 00 C0 60 A5 86 85 9D 85 9C C6 9C A2
; 8D 7D BF 78 A9 00 4C 03 80 03 85 9C A2 00 20 FC
; 8D BE 9F 4C 00 C0 9C A2 00 20 FC F6 B0 12 E6 9C
; 8D FF 9F 4C 00 C0 09 E6 9C A2 00 20 FC F6 90 08
; 8D 94 A3 78 D8 A9 10 4C 04 80 A0 2E B1 A2 F0 22



; After establishing BootSequenceData pointer, get ListPosition to get Data position
@BootGameSection_END:
    LDX ZPListPosition

; Increase ZPAdressLow by #$10 (16) each ListPosition to get BootSequenceData for the correct game
@BootGameGetDataPosition:
BEQ @BootGameLoadBoodCodeToRAM

    CLC
    LDA #$10
    ADC ZPAdressLow
    STA ZPAdressLow
    LDA #$00
    ADC ZPAdressHigh
    STA ZPAdressHigh
    DEX
BPL @BootGameGetDataPosition

; Load BootSequenceData into RAM ($0400) for each Y (#$10/16)
@BootGameLoadBoodCodeToRAM:
    LDY #$00   ; Reset Y to 0

@BootGameLoadBoodCodeToRAM_Loop:
    LDA (ZPAdressLow), Y
    STA $0400, Y
    INY
    CPY #$10
BCC @BootGameLoadBoodCodeToRAM_Loop


; Don't know whats happening here, storing listposition to CartRAM?
    LDA ZPListPosition
    TAY
    STA $5FF2                       ; Store to CartRAM
    TYA
    LSR A
    LSR A
    LSR A
    LSR A
    AND #$01
    STA ZPAdressLow
    LDA ZPListSection
    ASL A
    ORA ZPAdressLow
    STA $5FF3                       ; Store to CartRAM

; Resets MSB/LSB to 0
    LDA #$00
    STA ZPAdressLow
    STA ZPAdressHigh
    LDX #$00
    TXA

; Reset sound channel adresses $4000 - $4007
@BootGameResetSound:
    STA SQ0Duty_4000, X
    INX
    CPX #$08
BCC @BootGameResetSound

    STA APUStatus_4015


; Jump to BootSequence at $0400
    JMP $0400


; ---------------------------------- 



; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; BootGame Data
; ===================================================================================================

; Last segment of menu data
.segment "RODATAB"                  ; $D9F2

; Special mapper routine stored in $0180. Used in 06.LEGENDRY
; Starts at: $D9F2 - $DA00 / $19F2 - $1A00
BootGameBankSwitchRoutine:
    .byte $48, $29, $02, $D0, $05, $8D, $90, $A2, $68, $60, $8D, $91, $A2, $68, $60

; BootGameBankSwitchRoutine
; $19F2 - $1A00
; 48 29 02 D0 05 8D 90 A2 68 60 8D 91 A2 68 60
;
; $0180  PHA       (48)
; $0181  AND #$02  (29 02)
; $0183  BNE $018A (D0 05)
; $0185  STA $A290 (8D 90 A2) [1010 0010 1001 0000]
; $0188  PLA       (67)
; $0189  RTS       (60)
;
; $018A  STA $A291 (8D 91 A2) [1010 0010 1001 0001]
; $018D  PLA (68)
; $018E  RTS (60)



; Starts at: $DA01 - $DB20 / $1A01 - $1B20
BootGameBootSequencesSection1:
    ; Column 1
    ; 01.ISLANDER
    ; STA $8000 | JMP $8000 | 
    .byte $8D, $00, $80, $4C, $00, $80, $58, $85, $5B, $A9, $02, $85, $5C, $60, $C6, $5D
    ; 02.GRADING 
    ; STA $8084 | JMP $8010 | 
    .byte $8D, $84, $80, $4C, $10, $80, $85, $5B, $A9, $01, $85, $5C, $60, $C6, $5D, $C9
    ; 03.P-D FIGHTING
    ; STA $8108 | JMP $8106 | 
    .byte $8D, $08, $81, $4C, $06, $81, $5B, $A9, $01, $85, $5C, $60, $C6, $5D, $A9, $C8
    ; 04.STAR SOLDIER
    ; STA $818C | JMP $800A | 
    .byte $8D, $8C, $81, $4C, $0A, $80, $60, $A5, $69, $D0, $02, $38, $60, $C9, $12, $D0
    ; 05.GOONIES
    ; STA $820E | JMP $8011 | 
    .byte $8D, $0E, $82, $4C, $11, $80, $00, $A0, $C8, $4C, $8C, $DA, $C9, $11, $D0, $0B
    ; 06.LEGENDRY
    ; STA $A290 | SEI | CLD | LDA #$00 | JMP $8004 | 
    .byte $8D, $90, $A2, $78, $D8, $A9, $00, $4C, $04, $80, $DA, $A5, $68, $18, $69, $04
    ; 07.TETRIS
    ; STA $8312 | JMP $8000 | 
    .byte $8D, $12, $83, $4C, $00, $80, $A5, $68, $C9, $01, $F0, $1F, $86, $A1, $84, $A0
    ; 08.BROS. II
    ; STA $8394 | SEI | CLD | LDA #$10 | JMP $8004 | 
    .byte $8D, $94, $83, $78, $D8, $A9, $10, $4C, $04, $80, $65, $9E, $85, $A0, $A5, $A1
    ; 09.TWIN BEE
    ; STA $A415 | JMP $8011 | 
    .byte $8D, $15, $A4, $4C, $11, $80, $F0, $A6, $A1, $A4, $A0, $86, $5C, $84, $5B, $18

    ; Column 2
    ; 10.NINJA 2
    ; STA $9496 | JMP $812F | 
    .byte $8D, $96, $94, $4C, $2F, $81, $85, $A0, $A9, $00, $65, $A1, $85, $A1, $20, $C0
    ; 11.CITY CONECT.
    ; STA $94D8 | JMP $8000 | 
    .byte $8D, $D8, $94, $4C, $00, $80, $48, $06, $A0, $26, $A1, $06, $A0, $26, $A1, $68
    ; 12.B-WINGS
    ; STA $A51A | JMP $8000 | 
    .byte $8D, $1A, $A5, $4C, $00, $80, $65, $A1, $85, $A1, $06, $A0, $26, $A1, $60, $A5
    ; 13.1942
    ; STA $A59B | SEI | CLD | LDX $F3 | JMP $BF94 | 
    .byte $8D, $9B, $A5, $78, $D8, $A2, $F3, $4C, $94, $BF, $A1, $85, $A0, $E6, $A0, $D0
    ; 14.GYROOINE
    ; STA $861C | JMP $EFA5 | 
    .byte $8D, $1C, $86, $4C, $A5, $EF, $E9, $0A, $85, $99, $A5, $9A, $E9, $00, $85, $9A
    ; 15.FLAPPY
    ; STA $A69D | JMP $8007 | 
    .byte $8D, $9D, $A6, $4C, $07, $80, $F0, $11, $A2, $0F, $BD, $00, $02, $E8, $C9, $FF
    ; 16.SPARTAN
    ; STA $871E | SEI | CLD | LDA #$00 | JMP $825C | 
    .byte $8D, $1E, $87, $78, $D8, $A9, $00, $4C, $5C, $82, $A5, $12, $D0, $0D, $A9, $24
    ; 17.BOMBER MAN
    ; STA $979F | JMP $C000 | 
    .byte $8D, $9F, $97, $4C, $00, $C0, $A9, $98, $85, $06, $60, $4C, $DC, $F9, $85, $98
    ; 18.FRONT LINE
    ; STA $B7E0 | JMP $C000 | 
    .byte $8D, $E0, $B7, $4C, $00, $C0, $C5, $A5, $1A, $D0, $22, $A5, $19, $29, $04, $F0


; Section 1 BootSequences
;  $1A01 - $1B20
; 8D 00 80 4C 00 80 58 85 5B A9 02 85 5C 60 C6 5D
; 8D 84 80 4C 10 80 85 5B A9 01 85 5C 60 C6 5D C9
; 8D 08 81 4C 06 81 5B A9 01 85 5C 60 C6 5D A9 C8
; 8D 8C 81 4C 0A 80 60 A5 69 D0 02 38 60 C9 12 D0
; 8D 0E 82 4C 11 80 00 A0 C8 4C 8C DA C9 11 D0 0B
; 8D 90 A2 78 D8 A9 00 4C 04 80 DA A5 68 18 69 04
; 8D 12 83 4C 00 80 A5 68 C9 01 F0 1F 86 A1 84 A0
; 8D 94 83 78 D8 A9 10 4C 04 80 65 9E 85 A0 A5 A1
; 8D 15 A4 4C 11 80 F0 A6 A1 A4 A0 86 5C 84 5B 18
; 8D 96 94 4C 2F 81 85 A0 A9 00 65 A1 85 A1 20 C0
; 8D D8 94 4C 00 80 48 06 A0 26 A1 06 A0 26 A1 68
; 8D 1A A5 4C 00 80 65 A1 85 A1 06 A0 26 A1 60 A5
; 8D 9B A5 78 D8 A2 F3 4C 94 BF A1 85 A0 E6 A0 D0
; 8D 1C 86 4C A5 EF E9 0A 85 99 A5 9A E9 00 85 9A
; 8D 9D A6 4C 07 80 F0 11 A2 0F BD 00 02 E8 C9 FF
; 8D 1E 87 78 D8 A9 00 4C 5C 82 A5 12 D0 0D A9 24
; 8D 9F 97 4C 00 C0 A9 98 85 06 60 4C DC F9 85 98
; 8D E0 B7 4C 00 C0 C5 A5 1A D0 22 A5 19 29 04 F0



; Starts at: $DB21 - $DC40 / $1B21 - $1C40
BootGameBootSequencesSection2:
    ; Column 1
    ; 19.MACROSS
    ; STA $9821 | SEI | CLD | LDA #$10 | JMP $8004 | 
    .byte $8D, $21, $98, $78, $D8, $A9, $10, $4C, $04, $80, $98, $85, $03, $A5, $07, $49
    ; 20.1989GALAXIAN
    ; STA $B862 | LDA $FF | STA $1A | JMP $E020 | 
    .byte $8D, $62, $B8, $A9, $FF, $85, $1A, $4C, $20, $E0, $4C, $18, $DB, $20, $38, $C5
    ; 21.STAR FORCE
    ; STA $98A3 | SEI | CLD | LDX $FF | JMP $C004 | 
    .byte $8D, $A3, $98, $78, $D8, $A2, $FF, $4C, $04, $C0, $A9, $99, $85, $06, $60, $A9
    ; 22.KUNG-FU
    ; STA $B8E4 | JMP $C00F | 
    .byte $8D, $E4, $B8, $4C, $0F, $C0, $7E, $85, $84, $A5, $39, $18, $69, $01, $29, $03
    ; 23.NINJA 1
    ; STA $B925 | SEI | LDA #$00 | JMP $8003 | 
    .byte $8D, $25, $B9, $78, $A9, $00, $4C, $03, $80, $39, $29, $03, $85, $39, $20, $6A
    ; 24.PIPELINE
    ; STA $B966 | SEI | CLD | LDA $2002 | BPL $0405 | JMP $C007 |
    .byte $8D, $66, $B9, $78, $D8, $AD, $02, $20, $10, $FB, $4C, $07, $C0, $20, $0F, $F7
    ; 25.MAHJONG 2
    ; STA $99A7 | SEI | CLD | LDA #$10 | JMP $CA47 | 
    .byte $8D, $A7, $99, $78, $D8, $A9, $10, $4C, $47, $CA, $00, $A0, $2C, $91, $A2, $C8
    ; 26.MAHJONG 4
    ; STA $99E8 | JMP $C000 | 
    .byte $8D, $E8, $99, $4C, $00, $C0, $91, $A2, $C8, $A9, $FF, $91, $A2, $20, $10, $DE
    ; 27.LODE RUNNER1
    ; STA $9A29 | SEI | CLD | LDX $FF | JMP $C004 | 
    .byte $8D, $29, $9A, $78, $D8, $A2, $FF, $4C, $04, $C0, $B9, $E6, $39, $A5, $39, $29
    
    ; Column 2
    ; 28.LODE RUNNER2
    ; STA $9A69 | SEI | CLD | LDX #$FF | JMP $C004 | 
    .byte $8D, $69, $9A, $78, $D8, $A2, $FF, $4C, $04, $C0, $39, $F0, $0B, $A9, $04, $85
    ; 29.KING KONG 1
    ; STA $9AAA | SEI | CLD | LDA #$10 | JMP $C7A2 | 
    .byte $8D, $AA, $9A, $78, $D8, $A9, $10, $4C, $A2, $C7, $E4, $A9, $05, $18, $60, $A9
    ; 30.KING KONG 2
    ; STA $BAEB | SEI | CLD | LDA #$10 | JMP $C672 | 
    .byte $8D, $EB, $BA, $78, $D8, $A9, $10, $4C, $72, $C6, $B5, $76, $C9, $FF, $F0, $0F
    ; 31.KING KONG 3
    ; STA $9B2C | SEI | CLD | LDA $2002 | BPL $0405 | JMP $C007 |
    .byte $8D, $2C, $9B, $78, $D8, $AD, $02, $20, $10, $FB, $4C, $07, $C0, $18, $60, $C6
    ; 32.MAPPY
    ; STA $9B6D | JMP $C031 | 
    .byte $8D, $6D, $9B, $4C, $31, $C0, $7F, $20, $24, $DC, $B0, $05, $20, $76, $DF, $38
    ; 33.EXCITE BIKE
    ; STA $9BAE | SEI | CLD | LDA #$00 | JMP $C188 | 
    .byte $8D, $AE, $9B, $78, $D8, $A9, $00, $4C, $88, $C1, $24, $DC, $B0, $02, $38, $60
    ; 34.F-1 RACE
    ; STA $9BEF | LDA $2002 | BPL $0403 | JMP $C005 |
    .byte $8D, $EF, $9B, $AD, $02, $20, $10, $FB, $4C, $05, $C0, $B0, $02, $38, $60, $C6
    ; 35.ROAD FIGHTER
    ; STA $BC30 | JMP $C010 | 
    .byte $8D, $30, $BC, $4C, $10, $C0, $6A, $F4, $A5, $0F, $85, $40, $85, $A2, $A5, $10
    ; 36.PIN BALL
    ; STA $BC71 | SEI | CLD | LDA $2002 | BPL $0405 | JMP $C007 |
    .byte $8D, $71, $BC, $78, $D8, $AD, $02, $20, $10, $FB, $4C, $07, $C0, $C9, $FF, $D0


; Section 2 BootCodes
;  $1B21 - $1C40
; 8D 21 98 78 D8 A9 10 4C 04 80 98 85 03 A5 07 49
; 8D 62 B8 A9 FF 85 1A 4C 20 E0 4C 18 DB 20 38 C5
; 8D A3 98 78 D8 A2 FF 4C 04 C0 A9 99 85 06 60 A9
; 8D E4 B8 4C 0F C0 7E 85 84 A5 39 18 69 01 29 03
; 8D 25 B9 78 A9 00 4C 03 80 39 29 03 85 39 20 6A
; 8D 66 B9 78 D8 AD 02 20 10 FB 4C 07 C0 20 0F F7
; 8D A7 99 78 D8 A9 10 4C 47 CA 00 A0 2C 91 A2 C8
; 8D E8 99 4C 00 C0 91 A2 C8 A9 FF 91 A2 20 10 DE
; 8D 29 9A 78 D8 A2 FF 4C 04 C0 B9 E6 39 A5 39 29
; 8D 69 9A 78 D8 A2 FF 4C 04 C0 39 F0 0B A9 04 85
; 8D AA 9A 78 D8 A9 10 4C A2 C7 E4 A9 05 18 60 A9
; 8D EB BA 78 D8 A9 10 4C 72 C6 B5 76 C9 FF F0 0F
; 8D 2C 9B 78 D8 AD 02 20 10 FB 4C 07 C0 18 60 C6
; 8D 6D 9B 4C 31 C0 7F 20 24 DC B0 05 20 76 DF 38
; 8D AE 9B 78 D8 A9 00 4C 88 C1 24 DC B0 02 38 60
; 8D EF 9B AD 02 20 10 FB 4C 05 C0 B0 02 38 60 C6
; 8D 30 BC 4C 10 C0 6A F4 A5 0F 85 40 85 A2 A5 10
; 8D 71 BC 78 D8 AD 02 20 10 FB 4C 07 C0 C9 FF D0



; Starts at: $DC41 - $DD40 / $1C41 - $1D40
BootGameBootSequencesSection3:
    ; Column 1
    ; 37.BASE BALL
    ; STA $BCB2 | JMP $C3C7 | 
    .byte $8D, $B2, $BC, $4C, $C7, $C3, $06, $A5, $47, $C9, $04, $D0, $2F, $A5, $48, $05
    ; 38.POPEYE
    ; STA $BCF3 | SEI | CLD | LDA #$10 | JMP $C64D | 
    .byte $8D, $F3, $BC, $78, $D8, $A9, $10, $4C, $4D, $C6, $8E, $DC, $A0, $30, $B1, $A2
    ; 39.GALAGA
    ; STA $BD34 | SEI | CLD | LDA #$00 | JMP $C004 | 
    .byte $8D, $34, $BD, $78, $D8, $A9, $00, $4C, $04, $C0, $C9, $04, $D0, $06, $A9, $01
    ; 40.GALAXIAN
    ; STA $B862 | LDA #$00 | STA $1A | JMP $E020 | 
    .byte $8D, $62, $B8, $A9, $00, $85, $1A, $4C, $20, $E0, $18, $60, $A9, $00, $A0, $30
    ; 41.PAC-MAN
    ; STA $BD75 | JMP $C035 | 
    .byte $8D, $75, $BD, $4C, $35, $C0, $E4, $A9, $01, $85, $61, $18, $60, $A0, $31, $B1
    ; 42.ICE CLIMBER
    ; STA $BDB6 | SEI | CLD | LDA #$10 | JMP $C018 | 
    .byte $8D, $B6, $BD, $78, $D8, $A9, $10, $4C, $18, $C0, $04, $A9, $04, $D0, $2F, $A0
    ; 43.1989 EXERION
    ; STA $BDF7 | JMP $8000 | 
    .byte $8D, $F7, $BD, $4C, $00, $80, $DB, $CC, $A0, $31, $B1, $A2, $29, $01, $D0, $06
    ; 44.WRESTLE
    ; STA $9E38 | SEI | LDX #$FF | JMP $8003 | 
    .byte $8D, $38, $9E, $78, $A2, $FF, $4C, $03, $80, $08, $A0, $42, $B1, $A2, $C9, $03
    
    ; Column 2
    ; 45.BATTLE CITY
    ; STA $BE79 | JMP $C070 | 
    .byte $8D, $79, $BE, $4C, $70, $C0, $07, $20, $D4, $DC, $90, $02, $A9, $00, $A0, $30
    ; 46.SKY DESTRYOER
    ; STA $BEBA | JMP $C000 | 
    .byte $8D, $BA, $BE, $4C, $00, $C0, $A2, $F0, $1C, $A5, $84, $C9, $02, $B0, $16, $A0
    ; 47.CHESS
    ; STA $9EFB | JMP $C700 | 
    .byte $8D, $FB, $9E, $4C, $00, $C7, $0A, $A5, $60, $38, $F1, $A2, $29, $30, $F0, $07
    ; 48.BALLOON FIGHT
    ; STA $BF3C | JMP $C000 | 
    .byte $8D, $3C, $BF, $4C, $00, $C0, $60, $A5, $86, $85, $9D, $85, $9C, $C6, $9C, $A2
    ; 49.FORMATION Z
    ; STA $BF7D | SEI | LDA #$00 | JMP $8003 | 
    .byte $8D, $7D, $BF, $78, $A9, $00, $4C, $03, $80, $03, $85, $9C, $A2, $00, $20, $FC
    ; 50.POOYAN
    ; STA $9FBE | JMP $C000 | 
    .byte $8D, $BE, $9F, $4C, $00, $C0, $9C, $A2, $00, $20, $FC, $F6, $B0, $12, $E6, $9C
    ; 51.CIRCUS TROUPE
    ; STA $9FFF | JMP $C000 | 
    .byte $8D, $FF, $9F, $4C, $00, $C0, $09, $E6, $9C, $A2, $00, $20, $FC, $F6, $90, $08
    ; 52.FANCY BROS.
    ; STA $A394 | SEI | CLD | LDA #$10 | JMP $8004 | 
    .byte $8D, $94, $A3, $78, $D8, $A9, $10, $4C, $04, $80, $A0, $2E, $B1, $A2, $F0, $22


; Section 3 BootCodes
;  $1C41 - $1D40
; 8D B2 BC 4C C7 C3 06 A5 47 C9 04 D0 2F A5 48 05
; 8D F3 BC 78 D8 A9 10 4C 4D C6 8E DC A0 30 B1 A2
; 8D 34 BD 78 D8 A9 00 4C 04 C0 C9 04 D0 06 A9 01
; 8D 62 B8 A9 00 85 1A 4C 20 E0 18 60 A9 00 A0 30
; 8D 75 BD 4C 35 C0 E4 A9 01 85 61 18 60 A0 31 B1
; 8D B6 BD 78 D8 A9 10 4C 18 C0 04 A9 04 D0 2F A0
; 8D F7 BD 4C 00 80 DB CC A0 31 B1 A2 29 01 D0 06
; 8D 38 9E 78 A2 FF 4C 03 80 08 A0 42 B1 A2 C9 03
; 8D 79 BE 4C 70 C0 07 20 D4 DC 90 02 A9 00 A0 30
; 8D BA BE 4C 00 C0 A2 F0 1C A5 84 C9 02 B0 16 A0
; 8D FB 9E 4C 00 C7 0A A5 60 38 F1 A2 29 30 F0 07
; 8D 3C BF 4C 00 C0 60 A5 86 85 9D 85 9C C6 9C A2
; 8D 7D BF 78 A9 00 4C 03 80 03 85 9C A2 00 20 FC
; 8D BE 9F 4C 00 C0 9C A2 00 20 FC F6 B0 12 E6 9C
; 8D FF 9F 4C 00 C0 09 E6 9C A2 00 20 FC F6 90 08
; 8D 94 A3 78 D8 A9 10 4C 04 80 A0 2E B1 A2 F0 22

; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; Vectors
; ===================================================================================================

;
; vectors placed at top 6 bytes of memory area
;

.segment "VECTORS"                  ; Special adresses 6502 needs to operate
    .word NMI                       ; non-maskable interrupt (NMI), $FFFA-$FFFB = NMI vector, https://wiki.nesdev.com/w/index.php/NMI
    .word RESET                     ; Reset vector, $FFFC-$FFFD = Reset vector
    .byte $B4, $D3
;    .word IRQ                      ; IRQ vector, $FFFE-$FFFF = IRQ/BRK vector



; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



; ===================================================================================================
; CHR ROM
; ===================================================================================================

.segment "TILES"                    ; CHAracter data
    .incbin "52-in-1 Menu.chr"



; ===================================================================================================
; ===================================================================================================
; ===================================================================================================



