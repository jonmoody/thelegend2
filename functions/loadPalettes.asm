LoadPalettes:
  JSR PrimePalette1
.Loop:
  LDA palette, x
  STA $2007
  INX
  CPX #$20
  BNE .Loop
  RTS

LoadFuturePalettes:
  JSR PrimePalette1
.Loop:
  LDA futurePalette, x
  STA $2007
  INX
  CPX #$20
  BNE .Loop
  RTS

LoadSpritePalettes:
  LDA $2002
  LDA #$3F
  STA $2006
  LDA #$10
  STA $2006

  LDX #$00
.Loop:
  LDA spritePalette, x
  STA $2007
  INX
  CPX #$10
  BNE .Loop
  RTS

LoadTeslaSpritePalettes:
  LDA $2002
  LDA #$3F
  STA $2006
  LDA #$10
  STA $2006

  LDX #$00
.Loop:
  LDA teslaSpritePalette, x
  STA $2007
  INX
  CPX #$10
  BNE .Loop
  RTS

LoadTitlePalettes:
  JSR PrimePalette1
.Loop:
  LDA titlePalette, x
  STA $2007
  INX
  CPX #$20
  BNE .Loop
  RTS

LoadTeslaPalette:
  JSR PrimePalette1
.Loop:
  LDA teslaPalette, x
  STA $2007
  INX
  CPX #$20
  BNE .Loop
  RTS

LoadTeslaLandingPalette:
  JSR PrimePalette1
.Loop:
  LDA teslaLandingPalette, x
  STA $2007
  INX
  CPX #$20
  BNE .Loop
  RTS

LoadForgeExteriorPalette:
  JSR PrimePalette1
.Loop:
  LDA levelSecondPalette, x
  STA $2007
  INX
  CPX #$20
  BNE .Loop
  RTS

LoadLincRescuedPalette:
  JSR PrimePalette1
.Loop:
  LDA lincRescueScenePalette, x
  STA $2007
  INX
  CPX #$20
  BNE .Loop
  RTS

PrimePalette1:
  LDA $2002
  LDA #$3F
  STA $2006
  LDA #$00
  STA $2006

  LDX #$00
  RTS
