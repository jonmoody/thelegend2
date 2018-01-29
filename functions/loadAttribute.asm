LoadAttribute:
  LDA $2002
  LDA #$23
  STA $2006
  LDA #$C0
  STA $2006
  LDX #$00
.Loop:
  LDA attribute, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS

LoadTeslaAttribute:
  LDA $2002
  LDA #$23
  STA $2006
  LDA #$C0
  STA $2006
  LDX #$00
.Loop:
  LDA teslaAttribute, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS

LoadTeslaLandingAttribute:
  LDA $2002
  LDA #$23
  STA $2006
  LDA #$C0
  STA $2006
  LDX #$00
.Loop:
  LDA teslaLandingAttribute, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS

LoadLincRescuedAttribute:
  LDA $2002
  LDA #$23
  STA $2006
  LDA #$C0
  STA $2006
  LDX #$00
.Loop:
  LDA lincRescueSceneAttribute, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS

LoadAttribute2:
  LDA $2002
  LDA #$27
  STA $2006
  LDA #$C0
  STA $2006
  LDX #$00
.Loop:
  LDA levelSecondAttribute, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS

LoadAttributeExtra2:
  LDA $2002
  LDA #$27
  STA $2006
  LDA #$C0
  STA $2006
  LDX #$00
.Loop:
  LDA teslaLandingAttribute, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS

LoadZeroAttribute:
  LDA $2002
  LDA #$23
  STA $2006
  LDA #$C0
  STA $2006
  LDX #$00
.Loop:
  LDA $00
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS
