ExecuteBossMovement:

  LDA bossHealth
  BNE .Move

  JMP EndExecuteBossMovement

.Move:
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
  LDA bossHealth
  BEQ EndExecuteBossMovement

  JSR TravelerDashRightTiles
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
  LDA bossHealth
  BEQ EndExecuteBossMovement

  JSR TravelerDashLeftTiles
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

  JSR TravelerStandingRightTiles

  JSR ResetBossMovementTimer

.End:
  RTS

TurnBossLeft:
  LDA #%00000001
  JSR StoreBossAttributeData

  LDA #$00
  JSR FlipBossSprite

  JSR TravelerStandingLeftTiles

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
  LDA #$01
  STA bossProjectileDirection

  JMP EndBossFireProjectile

.FacingLeft:
  ADC #$00
  STA enemyProjectileX
  LDA #$00
  STA bossProjectileDirection
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

  LDA bossProjectileDirection
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

  LDA bossHealth
  BNE .End

  JSR TravelerDeath

.End:
  RTS


CheckChamberCollision:

  LDA bossHealth
  BEQ .CheckCollision1

  JMP EndChamberCollisionCheck

.CheckCollision1:
  LDA projectileX
  CLC
  ADC #$08
  CMP lincSprite1X
  BCS .CheckCollision2

  JMP CheckChamber2Collision

.CheckCollision2:
  LDA projectileX
  SEC
  SBC #$08
  CMP lincSprite2X
  BCC .CheckCollision3

  JMP CheckChamber2Collision

.CheckCollision3:
  LDA projectileY
  CMP lincSprite1Y
  BCS .CheckCollision4

  JMP CheckChamber2Collision

.CheckCollision4:
  LDA projectileY
  CMP lincSprite6Y
  BCS CheckChamber2Collision

  LDA #$FF
  STA projectileY
  JMP DamageStasisChamber

CheckChamber2Collision:

.CheckCollision1:
  LDA projectile2X
  CLC
  ADC #$08
  CMP lincSprite1X
  BCS .CheckCollision2

  JMP CheckChamber3Collision

.CheckCollision2:
  LDA projectile2X
  SEC
  SBC #$08
  CMP lincSprite2X
  BCC .CheckCollision3

  JMP CheckChamber3Collision

.CheckCollision3:
  LDA projectile2Y
  CMP lincSprite1Y
  BCS .CheckCollision4

  JMP CheckChamber3Collision

.CheckCollision4:
  LDA projectile2Y
  CMP lincSprite6Y
  BCS CheckChamber3Collision

  LDA #$FF
  STA projectile2Y
  JMP DamageStasisChamber

CheckChamber3Collision:

.CheckCollision1:
  LDA projectile3X
  CLC
  ADC #$08
  CMP lincSprite1X
  BCS .CheckCollision2

  JMP EndChamberCollisionCheck

.CheckCollision2:
  LDA projectile3X
  SEC
  SBC #$08
  CMP lincSprite2X
  BCC .CheckCollision3

  JMP EndChamberCollisionCheck

.CheckCollision3:
  LDA projectile3Y
  CMP lincSprite1Y
  BCS .CheckCollision4

  JMP EndChamberCollisionCheck

.CheckCollision4:
  LDA projectile3Y
  CMP lincSprite6Y
  BCS EndChamberCollisionCheck

  LDA #$FF
  STA projectile3Y
  JMP DamageStasisChamber

EndChamberCollisionCheck:
  RTS


DamageStasisChamber:
  LDA stasisChamberHealth
  BEQ .End

  DEC stasisChamberHealth

  LDA stasisChamberHealth
  BNE .End

  LDA #$C0
  STA timer

  LDA #%00000000
  STA $8000
  LDA #48
  STA $8001

  JSR DisableGraphics
  JSR ClearBackground

  LDA #LOW(lincRescueSceneBackground)
  STA pointerBackgroundLowByte
  LDA #HIGH(lincRescueSceneBackground)
  STA pointerBackgroundHighByte
  JSR LoadBackground

  JSR LoadLincRescuedAttribute
  JSR LoadFuturePalettes
  JSR LoadSpritePalettes

  JSR DisplayLincInChamber

  JSR EnableGraphics

.End:
  RTS
