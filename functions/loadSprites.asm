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
.Loop:
  LDA spritePlayer, x
  STA $0324, x
  INX
  CPX #$24
  BNE .Loop
  RTS

LoadEnemySprite:
  LDX #$00
.Loop:
  LDA spriteEnemy, x
  STA $0348, x
  INX
  CPX #$24
  BNE .Loop
  RTS

LoadTravelerSprite:
  LDX #$00
.Loop:
  LDA spriteTraveler, x
  STA $036C, x
  INX
  CPX #$30
  BNE .Loop
  RTS

LoadLincSprite:
  LDX #$00
.Loop:
  LDA spriteLinc, x
  STA $039C, x
  INX
  CPX #$20
  BNE .Loop
  RTS

LoadMattSprite:
  LDX #$00
.Loop:
  LDA spriteMatt, x
  STA $03BC, x
  INX
  CPX #$20
  BNE .Loop
  RTS

LoadMoonSprite:
  LDX #$00
.Loop:
  LDA spriteMoon, x
  STA $03BC, x
  INX
  CPX #$20
  BNE .Loop
  RTS

HidePlayerSprite:
  LDX #$00
.Loop:
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

  LDA #$78
  STA playerSprite1X
  STA playerSprite4X
  STA playerSprite7X
  LDA #$80
  STA playerSprite2X
  STA playerSprite5X
  STA playerSprite8X
  LDA #$88
  STA playerSprite3X
  STA playerSprite6X
  STA playerSprite9X

  RTS

HideTravelerSprite:
  LDX #$00
.Loop:
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
  LDA #$A0
  STA travelerSprite1Y
  STA travelerSprite2Y
  STA travelerSprite3Y
  LDA #$A8
  STA travelerSprite4Y
  STA travelerSprite5Y
  STA travelerSprite6Y
  LDA #$B0
  STA travelerSprite7Y
  STA travelerSprite8Y
  STA travelerSprite9Y
  LDA #$B8
  STA travelerSprite10Y
  STA travelerSprite11Y
  STA travelerSprite12Y
  RTS

ShowTravelerCombatSprite:
  JSR ShowTravelerSprite
  LDA #$A7
  STA travelerSprite7Tile
  LDA #$A8
  STA travelerSprite8Tile
  LDA #$A6
  STA travelerSprite10Tile
  RTS

TravelerStandingLeftTiles:
  LDA #$A9
  STA travelerSprite1Tile
  LDA #$AA
  STA travelerSprite2Tile
  LDA #$AB
  STA travelerSprite3Tile
  LDA #$AC
  STA travelerSprite4Tile
  LDA #$AD
  STA travelerSprite5Tile
  LDA #$AE
  STA travelerSprite6Tile
  LDA #$A7
  STA travelerSprite7Tile
  LDA #$A8
  STA travelerSprite8Tile
  LDA #$B1
  STA travelerSprite9Tile
  LDA #$A6
  STA travelerSprite10Tile
  LDA #$B3
  STA travelerSprite11Tile
  LDA #$B4
  STA travelerSprite12Tile
  RTS

TravelerStandingRightTiles:
  LDA #$AB
  STA travelerSprite1Tile
  LDA #$AA
  STA travelerSprite2Tile
  LDA #$A9
  STA travelerSprite3Tile
  LDA #$AE
  STA travelerSprite4Tile
  LDA #$AD
  STA travelerSprite5Tile
  LDA #$AC
  STA travelerSprite6Tile
  LDA #$B1
  STA travelerSprite7Tile
  LDA #$A8
  STA travelerSprite8Tile
  LDA #$A7
  STA travelerSprite9Tile
  LDA #$B4
  STA travelerSprite10Tile
  LDA #$B3
  STA travelerSprite11Tile
  LDA #$A6
  STA travelerSprite12Tile
  RTS

TravelerDashLeftTiles:
  LDA #$9A
  STA travelerSprite1Tile
  LDA #$9B
  STA travelerSprite2Tile
  LDA #$9C
  STA travelerSprite3Tile
  LDA #$9D
  STA travelerSprite4Tile
  LDA #$9E
  STA travelerSprite5Tile
  LDA #$9F
  STA travelerSprite6Tile
  LDA #$A0
  STA travelerSprite7Tile
  LDA #$A1
  STA travelerSprite8Tile
  LDA #$A2
  STA travelerSprite9Tile
  LDA #$A3
  STA travelerSprite10Tile
  LDA #$A4
  STA travelerSprite11Tile
  LDA #$A5
  STA travelerSprite12Tile
  RTS

TravelerDashRightTiles:
  LDA #$9C
  STA travelerSprite1Tile
  LDA #$9B
  STA travelerSprite2Tile
  LDA #$9A
  STA travelerSprite3Tile
  LDA #$9F
  STA travelerSprite4Tile
  LDA #$9E
  STA travelerSprite5Tile
  LDA #$9D
  STA travelerSprite6Tile
  LDA #$A2
  STA travelerSprite7Tile
  LDA #$A1
  STA travelerSprite8Tile
  LDA #$A0
  STA travelerSprite9Tile
  LDA #$A5
  STA travelerSprite10Tile
  LDA #$A4
  STA travelerSprite11Tile
  LDA #$A3
  STA travelerSprite12Tile
  RTS

TravelerDeath:
  LDA #$70
  STA travelerSprite1Tile
  LDA #$71
  STA travelerSprite2Tile
  LDA #$72
  STA travelerSprite3Tile
  LDA #$73
  STA travelerSprite4Tile
  LDA #$76
  STA travelerSprite5Tile
  LDA #$77
  STA travelerSprite6Tile
  LDA #$78
  STA travelerSprite7Tile
  LDA #$79
  STA travelerSprite8Tile

  LDA #$B0
  STA travelerSprite1Y
  STA travelerSprite2Y
  STA travelerSprite3Y
  STA travelerSprite4Y
  LDA #$B8
  STA travelerSprite5Y
  STA travelerSprite6Y
  STA travelerSprite7Y
  STA travelerSprite8Y

  LDA travelerSprite1X
  STA travelerSprite5X
  LDA travelerSprite2X
  STA travelerSprite6X
  LDA travelerSprite3X
  STA travelerSprite7X

  LDA travelerSprite3X
  CLC
  ADC #$08
  STA travelerSprite4X
  STA travelerSprite8X

  LDA #$FF
  STA travelerSprite9Y
  STA travelerSprite10Y
  STA travelerSprite11Y
  STA travelerSprite12Y

  JSR HideBossProjectile

  LDA bossDirection
  BNE .FacingRight
  JMP .End

.FacingRight:

  LDA travelerSprite1X
  LDX travelerSprite4X
  STA travelerSprite4X
  STX travelerSprite1X

  LDA travelerSprite2X
  LDX travelerSprite3X
  STA travelerSprite3X
  STX travelerSprite2X

  LDA travelerSprite5X
  LDX travelerSprite8X
  STA travelerSprite8X
  STX travelerSprite5X

  LDA travelerSprite6X
  LDX travelerSprite7X
  STA travelerSprite7X
  STX travelerSprite6X

.End:
  RTS

DisplayLincInChamber:
  LDX #$00
.Loop:
  LDA spriteLincChamber, x
  STA $039C, x
  INX
  CPX #$20
  BNE .Loop
  RTS

HideLincSprite:
  LDX #$00
.Loop:
  LDA #$FF
  STA $039C, x
  INX
  INX
  INX
  INX
  CPX #$24
  BNE .Loop
  RTS

MoveLincToFrontOfChamber:
  LDA #$A8
  STA lincSprite1Y
  STA lincSprite2Y
  LDA #$B0
  STA lincSprite3Y
  STA lincSprite4Y
  STA lincSprite5Y
  LDA #$B8
  STA lincSprite6Y
  STA lincSprite7Y
  STA lincSprite8Y

  LDA #$B8
  STA lincSprite2X
  STA lincSprite5X
  STA lincSprite8X
  LDA #$B0
  STA lincSprite1X
  STA lincSprite4X
  STA lincSprite7X
  LDA #$A8
  STA lincSprite3X
  STA lincSprite6X
  RTS

SetProjectileTiles:
  LDA #$74
  STA enemyProjectileTile
  STA projectileTile
  STA projectile2Tile
  STA projectile3Tile

  LDA #$03
  STA projectileAttr
  STA projectile2Attr
  STA projectile3Attr
  LDA #$02
  STA enemyProjectileAttr

  RTS

HideMattSprite:
  LDX #$00
.Loop:
  LDA #$FF
  STA $03BC, x
  INX
  INX
  INX
  INX
  CPX #$20
  BNE .Loop
  RTS

HideSprites:
  LDX #$00
.Loop:
  LDA #$FF
  STA $0300, x
  INX
  CPX #$FF
  BNE .Loop
  RTS

LoadStars:
  LDX #$00
.Loop:
  LDA star, x
  STA $03A0, x
  INX
  CPX #$30
  BNE .Loop
  RTS

MoveStars:
  LDX #$00
.Loop:
  LDA starX, x
  SEC
  SBC #$08
  STA starX, x
  INX
  INX
  INX
  INX
  CPX #$30
  BNE .Loop
  RTS
