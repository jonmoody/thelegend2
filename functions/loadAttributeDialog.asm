LoadAttributeDialog:
  LDA $2002
  LDA #$23
  STA $2006
  LDA #$C0
  STA $2006
  LDX #$00
.Loop:
  LDA attributeDialog, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS
