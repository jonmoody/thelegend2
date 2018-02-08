LoadAttributeDialog:
  JSR PrimeAttribute1
.Loop:
  LDA attributeDialog, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS
