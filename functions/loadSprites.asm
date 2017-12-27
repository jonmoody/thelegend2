LoadSprites:
  LDX #$00
.Loop:
  LDA sprites, x
  STA $0300, x
  INX
  CPX #$6C
  BNE .Loop
  RTS

LoadPlayerSprite:
  LDX #$00
.Loop
  LDA spritePlayer, x
  STA $0324, x
  INX
  CPX #$24
  BNE .Loop
  RTS

LoadEnemySprite:
  LDX #$00
.Loop
  LDA spriteEnemy, x
  STA $0348, x
  INX
  CPX #$24
  BNE .Loop
  RTS

LoadTravelerSprite:
  LDX #$00
.Loop
  LDA spriteTraveler, x
  STA $036C, x
  INX
  CPX #$30
  BNE .Loop
  RTS

HidePlayerSprite:
  LDX #$00
.Loop
  LDA #$FF
  STA $0324, x
  INX
  INX
  INX
  INX
  CPX #$24
  BNE .Loop
  RTS

ShowPlayerSprite:
  LDA #$A8
  STA playerSprite1Y
  STA playerSprite2Y
  STA playerSprite3Y
  LDA #$B0
  STA playerSprite4Y
  STA playerSprite5Y
  STA playerSprite6Y
  LDA #$B8
  STA playerSprite7Y
  STA playerSprite8Y
  STA playerSprite9Y
  RTS

HideTravelerSprite:
  LDX #$00
.Loop
  LDA #$FF
  STA $036C, x
  INX
  INX
  INX
  INX
  CPX #$30
  BNE .Loop
  RTS

ShowTravelerSprite:
  LDA #$40
  STA travelerSprite1Y
  STA travelerSprite2Y
  STA travelerSprite3Y
  LDA #$48
  STA travelerSprite4Y
  STA travelerSprite5Y
  STA travelerSprite6Y
  LDA #$50
  STA travelerSprite7Y
  STA travelerSprite8Y
  STA travelerSprite9Y
  LDA #$58
  STA travelerSprite10Y
  STA travelerSprite11Y
  STA travelerSprite12Y
  RTS

HideSprites:
  LDX #$00
.Loop
  LDA #$00
  STA $0300, x
  INX
  CPX #$FF
  BNE .Loop
  RTS
