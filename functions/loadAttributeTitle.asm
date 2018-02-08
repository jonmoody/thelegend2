LoadAttributeTitle:
  JSR PrimeAttribute1
.Loop:
  LDA attributeTitle, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS
