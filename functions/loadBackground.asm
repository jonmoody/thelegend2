LoadBackground:
  LDA $2002
  LDA #$20
  STA $2006
  LDA #$00
  STA $2006

  LDX #$00
  LDY #$00
.Loop:
  LDA [pointerBackgroundLowByte], y
  STA $2007

  INY
  CPY #$00
  BNE .Loop

  INC pointerBackgroundHighByte
  INX
  CPX #$04
  BNE .Loop
  RTS

LoadBackgroundExtra:
  LDA $2002
  LDA #$20
  STA $2006
  LDA #$00
  STA $2006

  LDX #$00
  LDY #$00
.Loop:
  LDA [pointerBackgroundLowByte], y
  CLC
  ADC #$80
  STA $2007

  INY
  CPY #$00
  BNE .Loop

  INC pointerBackgroundHighByte
  INX
  CPX #$04
  BNE .Loop
  RTS

LoadBackgroundExtra2:
  LDA $2002
  LDA #$24
  STA $2006
  LDA #$00
  STA $2006

  LDX #$00
  LDY #$00
.Loop:
  LDA [pointerBackgroundLowByte], y
  CLC
  ADC #$80
  STA $2007

  INY
  CPY #$00
  BNE .Loop

  INC pointerBackgroundHighByte
  INX
  CPX #$04
  BNE .Loop
  RTS

LoadBackground2:
  LDA $2002
  LDA #$24
  STA $2006
  LDA #$00
  STA $2006

  LDX #$00
  LDY #$00
.Loop:
  LDA [pointerBackgroundLowByte], y
  STA $2007

  INY
  CPY #$00
  BNE .Loop

  INC pointerBackgroundHighByte
  INX
  CPX #$04
  BNE .Loop
  RTS

LoadBackground3:
  LDA $2002
  LDA #$28
  STA $2006
  LDA #$00
  STA $2006

  LDX #$00
  LDY #$00
.Loop:
  LDA [pointerBackgroundLowByte], y
  STA $2007

  INY
  CPY #$00
  BNE .Loop

  INC pointerBackgroundHighByte
  INX
  CPX #$04
  BNE .Loop
  RTS

ClearBackground:
  LDA $2002
  LDA #$20
  STA $2006
  LDA #$00
  STA $2006

  LDX #$00
  LDY #$00
.Loop:
  LDA #$00
  STA $2007

  INY
  CPY #$00
  BNE .Loop

  INX
  CPX #$04
  BNE .Loop
  RTS

LoadCapturedTextScreen:
  LDA $2002
  LDA #$21
  STA $2006
  LDA #$00
  STA $2006

  LDX #$00
.Loop:
  LDA capturedTextScreen, x
  STA $2007

  INX
  CPX #$52
  BNE .Loop
  RTS

BackgroundSwap:
  LDA backgroundScrollCount
  BEQ .End

  LDA scroll
  BNE .End

  DEC backgroundScrollCount

  LDA backgroundScrollCount
  CMP #$01
  BEQ .DrawOffScreenBackground

  LDA backgroundScrollCount
  BNE .End

.Swap:
  JSR SwapBackgrounds
  JMP .End

.DrawOffScreenBackground:
  JSR DisableGraphics

  LDA #LOW(levelSecondBackground)
  STA pointerBackgroundLowByte
  LDA #HIGH(levelSecondBackground)
  STA pointerBackgroundHighByte
  JSR LoadBackground2

  JSR LoadForgeExteriorPalette
  JSR LoadAttribute2
  JSR LoadSpritePalettes

  JSR EnableGraphicsPattern2

.End:
  RTS

SwapBackgrounds:
  JSR DisableGraphics

  LDA #LOW(levelSecondBackground)
  STA pointerBackgroundLowByte
  LDA #HIGH(levelSecondBackground)
  STA pointerBackgroundHighByte
  JSR LoadBackground

  LDA #LOW(teslaLandingBackground)
  STA pointerBackgroundLowByte
  LDA #HIGH(teslaLandingBackground)
  STA pointerBackgroundHighByte
  JSR LoadBackgroundExtra2

  JSR LoadForgeExteriorPalette

  JSR LoadAttribute2
  JSR LoadAttributeExtra2
  JSR LoadSpritePalettes

  JSR EnableGraphicsPattern2

  LDA #$01
  STA scrollCheck

  RTS

DrawTheEnd:
  LDA #LOW(backgroundTheEnd)
  STA pointerBackgroundLowByte
  LDA #HIGH(backgroundTheEnd)
  STA pointerBackgroundHighByte

  LDA $2002
  LDA #$21
  STA $2006
  LDA #$AC
  STA $2006

  LDY #$00
.Loop:
  LDA [pointerBackgroundLowByte], y
  STA $2007

  INY
  CPY #$08
  BNE .Loop
  RTS
