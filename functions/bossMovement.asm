ExecuteBossMovement:

  LDA bossMovementWaitTimer
  BEQ .BeginMovement

  DEC bossMovementWaitTimer
  JMP EndExecuteBossMovement

.BeginMovement:
  LDA bossDirection
  BEQ .BeginLeftMovement

.BeginRightMovement:
  LDA travelerSprite1X
  CMP #$B0
  BCC .MoveBossRight

  JSR TurnBossLeft
  JMP EndExecuteBossMovement

.MoveBossRight:
  JSR MoveBossRight
  JSR MoveBossRight
  JMP EndExecuteBossMovement

.BeginLeftMovement:
  LDA travelerSprite1X
  CMP #$18
  BCS .MoveBossLeft

  JSR TurnBossRight
  JMP EndExecuteBossMovement

.MoveBossLeft:
  JSR MoveBossLeft
  JSR MoveBossLeft
  JMP EndExecuteBossMovement

EndExecuteBossMovement:
  RTS




MoveBossLeft:
  DEC travelerSprite1X
  DEC travelerSprite2X
  DEC travelerSprite3X
  DEC travelerSprite4X
  DEC travelerSprite5X
  DEC travelerSprite6X
  DEC travelerSprite7X
  DEC travelerSprite8X
  DEC travelerSprite9X
  DEC travelerSprite10X
  DEC travelerSprite11X
  DEC travelerSprite12X
  RTS

MoveBossRight:
  INC travelerSprite1X
  INC travelerSprite2X
  INC travelerSprite3X
  INC travelerSprite4X
  INC travelerSprite5X
  INC travelerSprite6X
  INC travelerSprite7X
  INC travelerSprite8X
  INC travelerSprite9X
  INC travelerSprite10X
  INC travelerSprite11X
  INC travelerSprite12X
  RTS

TurnBossRight:
  LDA bossDirection
  BNE .End

  LDA #%01000001
  JSR StoreBossAttributeData

  LDA #$01
  JSR FlipBossSprite

  JSR ResetBossMovementTimer

.End:
  RTS

TurnBossLeft:
  LDA #%00000001
  JSR StoreBossAttributeData

  LDA #$00
  JSR FlipBossSprite

  JSR ResetBossMovementTimer

.End:
  RTS

StoreBossAttributeData:
  STA travelerSprite1Attr
  STA travelerSprite2Attr
  STA travelerSprite3Attr
  STA travelerSprite4Attr
  STA travelerSprite5Attr
  STA travelerSprite6Attr
  STA travelerSprite7Attr
  STA travelerSprite8Attr
  STA travelerSprite9Attr
  STA travelerSprite10Attr
  STA travelerSprite11Attr
  STA travelerSprite12Attr
  RTS

FlipBossSprite:
  STA bossDirection

  LDX travelerSprite1Tile
  LDA travelerSprite3Tile
  STA travelerSprite1Tile
  STX travelerSprite3Tile

  LDX travelerSprite4Tile
  LDA travelerSprite6Tile
  STA travelerSprite4Tile
  STX travelerSprite6Tile

  LDX travelerSprite7Tile
  LDA travelerSprite9Tile
  STA travelerSprite7Tile
  STX travelerSprite9Tile

  LDX travelerSprite10Tile
  LDA travelerSprite12Tile
  STA travelerSprite10Tile
  STX travelerSprite12Tile
  RTS

ResetBossMovementTimer:
  LDA #$30
  STA bossMovementWaitTimer
  RTS
