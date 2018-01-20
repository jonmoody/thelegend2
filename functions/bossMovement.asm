ExecuteBossMovement:

  JSR CheckProjectileBossCollision
  JSR CheckBossBulletCollision
  JSR BossFireProjectile

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


CheckProjectileBossCollision:

.CheckCollision1:
  LDA projectileX
  CLC
  ADC #$08
  CMP travelerSprite1X
  BCS .CheckCollision2

  JMP CheckProjectile2BossCollision

.CheckCollision2:
  LDA projectileX
  SEC
  SBC #$08
  CMP travelerSprite3X
  BCC .CheckCollision3

  JMP CheckProjectile2BossCollision

.CheckCollision3:
  LDA projectileY
  CMP travelerSprite1Y
  BCS .CheckCollision4

  JMP CheckProjectile2BossCollision

.CheckCollision4:
  LDA projectileY
  CMP travelerSprite11Y
  BCS CheckProjectile2BossCollision

  LDA #$FF
  STA projectileY
  JMP BossLoseHealth

CheckProjectile2BossCollision:

.CheckCollision1:
  LDA projectile2X
  CLC
  ADC #$08
  CMP travelerSprite1X
  BCS .CheckCollision2

  JMP CheckProjectile3BossCollision

.CheckCollision2:
  LDA projectile2X
  SEC
  SBC #$08
  CMP travelerSprite3X
  BCC .CheckCollision3

  JMP CheckProjectile3BossCollision

.CheckCollision3:
  LDA projectile2Y
  CMP travelerSprite1Y
  BCS .CheckCollision4

  JMP CheckProjectile3BossCollision

.CheckCollision4:
  LDA projectile2Y
  CMP travelerSprite11Y
  BCS CheckProjectile3BossCollision

  LDA #$FF
  STA projectile2Y
  JMP BossLoseHealth

CheckProjectile3BossCollision:

.CheckCollision1:
  LDA projectile3X
  CLC
  ADC #$08
  CMP travelerSprite1X
  BCS .CheckCollision2

  JMP EndBossCollisionCheck

.CheckCollision2:
  LDA projectile3X
  SEC
  SBC #$08
  CMP travelerSprite3X
  BCC .CheckCollision3

  JMP EndBossCollisionCheck

.CheckCollision3:
  LDA projectile3Y
  CMP travelerSprite1Y
  BCS .CheckCollision4

  JMP EndBossCollisionCheck

.CheckCollision4:
  LDA projectile3Y
  CMP travelerSprite11Y
  BCS EndBossCollisionCheck

  LDA #$FF
  STA projectile3Y
  JMP BossLoseHealth

EndBossCollisionCheck:
  RTS


CheckBossBulletCollision:
  LDA enemyProjectileX
  CLC
  ADC #$08
  CMP playerSprite1X
  BCC EndCheckBossBulletCollision

  LDA enemyProjectileX
  SEC
  SBC #$08
  CMP playerSprite3X
  BCS EndCheckBossBulletCollision

  LDA enemyProjectileY
  CMP playerSprite1Y
  BCC EndCheckBossBulletCollision

  LDA enemyProjectileY
  CMP playerSprite8Y
  BCS EndCheckBossBulletCollision

  ; The iFrames for some reason aren't getting reset and knockback isn't working
  ; LDA iFrames
  ; BNE EndCheckBossBulletCollision

  LDA #$FF
  STA enemyProjectileY

  JSR LoseHealth
EndCheckBossBulletCollision:
  RTS

BossFireProjectile:
  LDA bossHealth
  BEQ EndBossFireProjectile

  LDA enemyFireTimer
  BNE EndBossFireProjectile

  LDA #$40
  STA enemyFireTimer

  LDA travelerSprite4Y
  TAX
  LDA enemyProjectileY
  TXA
  CLC
  ADC #$0A
  STA enemyProjectileY

  LDA travelerSprite1X
  TAX
  LDA enemyProjectileX
  TXA
  CLC

  LDY bossDirection
  BEQ .FacingLeft

  ADC #$10
  STA enemyProjectileX
  JMP EndBossFireProjectile

.FacingLeft:
  ADC #$00
  STA enemyProjectileX
EndBossFireProjectile:

  DEC enemyFireTimer

MoveBossProjectile:
  LDA enemyHealth
  BEQ HideBossProjectile

  LDA enemyProjectileX
  CMP #$F8
  BCS HideBossProjectile
  CMP #$04
  BCC HideBossProjectile

  LDA bossDirection
  BNE .MoveBossProjectileRight

  LDA enemyProjectileX
  SEC
  SBC projectileSpeed
  STA enemyProjectileX
  JMP HideBossProjectileEnd

.MoveBossProjectileRight:
  LDA enemyProjectileX
  CLC
  ADC projectileSpeed
  STA enemyProjectileX
  JMP HideBossProjectileEnd

HideBossProjectile:
  LDA #$FF
  STA enemyProjectileY
HideBossProjectileEnd:
  RTS


BossLoseHealth:
  DEC bossHealth
  RTS
