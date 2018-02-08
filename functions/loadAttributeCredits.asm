LoadAttributeCredits:
  JSR PrimeAttribute1
.Loop:
  LDA attributeCredits, x
  STA $2007
  INX
  CPX #$40
  BNE .Loop
  RTS
