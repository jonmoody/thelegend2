LoadAttribute:
  JSR PrimeAttribute1
.Loop:
  LDA attribute, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS

LoadTeslaAttribute:
  JSR PrimeAttribute1
.Loop:
  LDA teslaAttribute, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS

LoadTeslaLandingAttribute:
  JSR PrimeAttribute1
.Loop:
  LDA teslaLandingAttribute, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS

LoadLincRescuedAttribute:
  JSR PrimeAttribute1
.Loop:
  LDA lincRescueSceneAttribute, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS

LoadAttribute2:
  JSR PrimeAttribute2
.Loop:
  LDA levelSecondAttribute, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS

LoadAttributeExtra2:
  JSR PrimeAttribute2
.Loop:
  LDA teslaLandingAttribute, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS

LoadZeroAttribute:
  JSR PrimeAttribute1
.Loop:
  LDA $00
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS

PrimeAttribute1:
  LDA $2002
  LDA #$23
  STA $2006
  LDA #$C0
  STA $2006
  LDX #$00
  RTS

PrimeAttribute2:
  LDA $2002
  LDA #$27
  STA $2006
  LDA #$C0
  STA $2006
  LDX #$00
  RTS
