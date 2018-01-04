  .inesprg 2
  .ineschr 3
  .inesmap 3
  .inesmir 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  .rsset $0000
music  .rs 16
pointerBackgroundLowByte  .rs 1
pointerBackgroundHighByte  .rs 1
jumping  .rs 1
falling  .rs 1
jumpingVelocity  .rs 1
movementSpeed  .rs 1
projectileSpeed  .rs 1
playerHealth  .rs 1
enemyHealth  .rs 1
iFrames  .rs 1
enemyIFrames  .rs 1
deathSpeed  .rs 1
deathTimer  .rs 1
enemyDeathTimer  .rs 1
movementEnabled  .rs 1
firingProjectile  .rs 1
firingProjectile2  .rs 1
firingProjectile3  .rs 1
projectile1Direction  .rs 1
projectile2Direction  .rs 1
projectile3Direction  .rs 1
gameOver  .rs 1
gameOverLoaded  .rs 1
gameWin  .rs 1
; gameWinLoaded  .rs 1
titleScreen  .rs 1
creditsScreen  .rs 1
creditsScreenLoaded  .rs 1
gameInProgress  .rs 1
introScene  .rs 1
introSceneLoaded  .rs 1
introScene2  .rs 1
introSceneLoaded2  .rs 1
introDialog  .rs 1
introDialogLoaded  .rs 1
forgeScene  .rs 1
forgeSceneLoaded  .rs 1
advanceDialog  .rs 1
currentDialogScreen  .rs 1
endOfDialog  .rs 1
creditsOptionSelected  .rs 1
selectButtonHeldDown  .rs 1
enemyFireTimer  .rs 1
enemyDirection  .rs 1
playerVisibility  .rs 1
buttonPressedA  .rs 1
buttonHeldA  .rs 1
previousButtonStateA  .rs 1
buttonPressedB  .rs 1
buttonBReleased  .rs 1
runAnimationTimer  .rs 1
buttonLeftPressed  .rs 1
buttonRightPressed  .rs 1
facingRight  .rs 1
enemyAnimationTimer  .rs 1
teslaScene  .rs 1
teslaSceneLoaded  .rs 1
teslaLandingScene  .rs 1
teslaLandingSceneLoaded  .rs 1
approachingTheForge  .rs 1
approachingTheForgeLoaded  .rs 1
moodyAppearsScene  .rs 1
moodyAppearsSceneLoaded  .rs 1
moodyDialog  .rs 1
moodyDialogLoaded  .rs 1
moodyBattleSequence  .rs 1
moodyBattleSequenceLoaded  .rs 1
lincRescueScene  .rs 1
lincRescueSceneLoaded  .rs 1
lincDialogSequence  .rs 1
lincDialogSequenceLoaded  .rs 1

  .include "reference/spriteMemoryLocations.asm"

musicLoad = $A050
musicInit = $A999
musicPlay = $A99C

  .bank 0
  .org $8000

RESET:
  SEI
  CLD
  LDX #$40
  STX $4017    ; Disable APU frame IRQ
  LDX #$FF
  TXS
  JSR DisableGraphics

  JSR VBlank

ClearMemory:
  LDA #$00
  STA $0000, x
  STA $0100, x
  STA $0300, x
  STA $0400, x
  STA $0500, x
  STA $0600, x
  STA $0700, x
  LDA #$FE
  STA $0200, x
  INX
  BNE ClearMemory

  JSR VBlank

  LDA #$00
  LDX #$00
ClearAudio:
  STA $4000, x
  INX
  CPX #$0F
  BNE ClearAudio
  LDA #$10
  STA $4010
  LDA #$00
  STA $4011
  STA $4012
  STA $4013
  LDA #%00001111
  STA $4015
  LDA #$00
  LDX #$00
  JSR musicInit

  LDA #$01
  STA titleScreen
  STA jumpingVelocity
  STA movementSpeed
  STA deathSpeed

  LDA #$03
  STA playerHealth
  STA projectileSpeed

  LDA #$06
  STA enemyHealth

  LDA #$3C
  STA deathTimer
  STA enemyDeathTimer

  JSR LoadTitlePalettes

  LDA #LOW(backgroundTitle)
  STA pointerBackgroundLowByte
  LDA #HIGH(backgroundTitle)
  STA pointerBackgroundHighByte
  JSR LoadBackground

  JSR LoadAttributeTitle

  JSR EnableGraphics

InfiniteLoop:
  JMP InfiniteLoop

; Can put 8 full backgrounds here
teslaBackground:
  .incbin "graphics/tesla/nametable.dat"

teslaAttribute:
  .incbin "graphics/tesla/attribute.dat"

teslaPalette:
  .incbin "graphics/tesla/palette.dat"

teslaLandingBackground:
  .include "graphics/teslaLandingBackground.asm"

insideTheForgeBackground:
  .include "graphics/insideTheForgeBackground.asm"

lincRescueSceneBackground:
  .include "graphics/lincRescueSceneBackground.asm"

bossBattleDialog1:
  .include "graphics/dialog/bossBattle01.asm"

bossBattleDialog2:
  .include "graphics/dialog/bossBattle02.asm"

bossBattleDialog3:
  .include "graphics/dialog/bossBattle03.asm"

bossBattleDialog4:
  .include "graphics/dialog/bossBattle04.asm"

bossBattleDialog5:
  .include "graphics/dialog/bossBattle05.asm"

bossBattleDialog6:
  .include "graphics/dialog/bossBattle06.asm"

bossBattleDialog7:
  .include "graphics/dialog/bossBattle07.asm"

bossBattleDialog8:
  .include "graphics/dialog/bossBattle08.asm"

bossBattleDialog9:
  .include "graphics/dialog/bossBattle09.asm"

bossBattleDialog10:
  .include "graphics/dialog/bossBattle10.asm"

awakeningDialog1:
  .include "graphics/dialog/awakening01.asm"

awakeningDialog2:
  .include "graphics/dialog/awakening02.asm"

awakeningDialog3:
  .include "graphics/dialog/awakening03.asm"

awakeningDialog4:
  .include "graphics/dialog/awakening04.asm"

awakeningDialog5:
  .include "graphics/dialog/awakening05.asm"

awakeningDialog6:
  .include "graphics/dialog/awakening06.asm"

awakeningDialog7:
  .include "graphics/dialog/awakening07.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  .bank 1
  .org musicLoad
  .incbin "music.bin"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  .bank 2
  .org $C000

NMI:
  LDA #$00
  STA $2003
  LDA #$03
  STA $4014

  .include "graphics/gameStatusLoader.asm"

ReadController:
  LDA titleScreen
  BNE ReadTitleScreenControls

  JMP ReadGameplayControls

ReadTitleScreenControls:
  .include "controls/titleScreenControls.asm"

ReadGameplayControls:
  .include "controls/gameplayControls.asm"
EndReadController:

; GameVictory:
;   LDA gameWin
;   BEQ EndGameVictory
;
;   JMP EndCurrentFrame
; EndGameVictory:

GameOver:
  LDA gameOver
  BEQ EndGameOver

  LDA gameOverLoaded
  BNE EndGameOver

  JSR HideSprites

  JSR DisableGraphics
  JSR ClearBackground

  LDA #LOW(backgroundGameOver)
  STA pointerBackgroundLowByte
  LDA #HIGH(backgroundGameOver)
  STA pointerBackgroundHighByte
  JSR LoadBackground

  JSR LoadAttributeTitle
  JSR LoadTitlePalettes

  JSR EnableGraphics

  LDA #$01
  STA gameOverLoaded

  JMP EndCurrentFrame
EndGameOver:

; Credits:
;   LDA creditsScreen
;   BEQ EndCredits
;
;   JMP EndCurrentFrame
; EndCredits:

  LDA playerHealth
  BNE MoveProjectile

  JMP Die

MoveProjectile:
  LDA projectileX
  CMP #$F8
  BCS HideProjectile
  CMP #$04
  BCC HideProjectile
  LDA projectile1Direction
  BEQ .MoveProjectileLeft
  LDA projectileX
  CLC
  ADC projectileSpeed
  STA projectileX
  JMP HideProjectileEnd
.MoveProjectileLeft:
  LDA projectileX
  SEC
  SBC projectileSpeed
  STA projectileX
  JMP HideProjectileEnd

HideProjectile:
  LDA #$FF
  STA projectileY
HideProjectileEnd:

MoveProjectile2:
  LDA projectile2X
  CMP #$F8
  BCS HideProjectile2
  CMP #$04
  BCC HideProjectile2
  LDA projectile2Direction
  BEQ .MoveProjectileLeft
  LDA projectile2X
  CLC
  ADC projectileSpeed
  STA projectile2X
  JMP HideProjectile2End
.MoveProjectileLeft:
  LDA projectile2X
  SEC
  SBC projectileSpeed
  STA projectile2X
  JMP HideProjectile2End

HideProjectile2:
  LDA #$FF
  STA projectile2Y
HideProjectile2End:

MoveProjectile3:
  LDA projectile3X
  CMP #$F8
  BCS HideProjectile3
  CMP #$04
  BCC HideProjectile3
  LDA projectile3Direction
  BEQ .MoveProjectileLeft
  LDA projectile3X
  CLC
  ADC projectileSpeed
  STA projectile3X
  JMP HideProjectile3End
.MoveProjectileLeft:
  LDA projectile3X
  SEC
  SBC projectileSpeed
  STA projectile3X
  JMP HideProjectile3End

HideProjectile3:
  LDA #$FF
  STA projectile3Y
HideProjectile3End:

CheckFiringStatus:
  LDX #$00
  LDA projectileY
  CMP #$FF
  BNE .CheckProjectile2

  STX firingProjectile

.CheckProjectile2:
  LDA projectile2Y
  CMP #$FF
  BNE .CheckProjectile3

  STX firingProjectile2

.CheckProjectile3:
  LDA projectile3Y
  CMP #$FF
  BNE EndCheckFiringStatus

  STX firingProjectile3

EndCheckFiringStatus:

SetJumpingVelocity:
  LDA playerSprite1Y
  CMP #$88
  BCS .MidVelocity

  LDA #$01
  STA jumpingVelocity
  JMP EndSetJumpingVelocity

.MidVelocity:
  LDA playerSprite1Y
  CMP #$92
  BCS .FastVelocity

  LDA #$02
  STA jumpingVelocity
  JMP EndSetJumpingVelocity

.FastVelocity:
  LDA #$03
  STA jumpingVelocity
EndSetJumpingVelocity:

Jump:
  LDA jumping
  BNE StartJump

  JMP EndJump

StartJump:
  LDA playerSprite1Attr
  AND #%01000000
  BEQ .FacingRight

  LDA #$C0
  STA playerSprite1Tile
  LDA #$BF
  STA playerSprite2Tile
  LDA #$BE
  STA playerSprite3Tile
  LDA #$C3
  STA playerSprite4Tile
  LDA #$C2
  STA playerSprite5Tile
  LDA #$C1
  STA playerSprite6Tile
  LDA #$C6
  STA playerSprite7Tile
  LDA #$C5
  STA playerSprite8Tile
  LDA #$C4
  STA playerSprite9Tile
  JMP .EndJumpSprite

.FacingRight:
  LDA #$BE
  STA playerSprite1Tile
  LDA #$BF
  STA playerSprite2Tile
  LDA #$C0
  STA playerSprite3Tile
  LDA #$C1
  STA playerSprite4Tile
  LDA #$C2
  STA playerSprite5Tile
  LDA #$C3
  STA playerSprite6Tile
  LDA #$C4
  STA playerSprite7Tile
  LDA #$C5
  STA playerSprite8Tile
  LDA #$C6
  STA playerSprite9Tile

.EndJumpSprite:

  LDA playerSprite1Y
  CMP #$80
  BEQ Fall

  LDA falling
  BNE Fall

  SEC
  LDA playerSprite1Y
  SBC jumpingVelocity
  STA playerSprite1Y
  LDA playerSprite2Y
  SBC jumpingVelocity
  STA playerSprite2Y
  LDA playerSprite3Y
  SBC jumpingVelocity
  STA playerSprite3Y
  LDA playerSprite4Y
  SBC jumpingVelocity
  STA playerSprite4Y
  LDA playerSprite5Y
  SBC jumpingVelocity
  STA playerSprite5Y
  LDA playerSprite6Y
  SBC jumpingVelocity
  STA playerSprite6Y
  LDA playerSprite7Y
  SBC jumpingVelocity
  STA playerSprite7Y
  LDA playerSprite8Y
  SBC jumpingVelocity
  STA playerSprite8Y
  LDA playerSprite9Y
  SBC jumpingVelocity
  STA playerSprite9Y

  JMP EndJump

Fall:
  LDA #$01
  STA falling

LandOnFloor:
  LDA playerSprite1Y
  CMP #$A8
  BCS CompleteJump

  CLC
  LDA playerSprite1Y
  ADC jumpingVelocity
  STA playerSprite1Y
  LDA playerSprite2Y
  ADC jumpingVelocity
  STA playerSprite2Y
  LDA playerSprite3Y
  ADC jumpingVelocity
  STA playerSprite3Y
  LDA playerSprite4Y
  ADC jumpingVelocity
  STA playerSprite4Y
  LDA playerSprite5Y
  ADC jumpingVelocity
  STA playerSprite5Y
  LDA playerSprite6Y
  ADC jumpingVelocity
  STA playerSprite6Y
  LDA playerSprite7Y
  ADC jumpingVelocity
  STA playerSprite7Y
  LDA playerSprite8Y
  ADC jumpingVelocity
  STA playerSprite8Y
  LDA playerSprite9Y
  ADC jumpingVelocity
  STA playerSprite9Y

  JMP EndJump

CompleteJump:
  LDA playerSprite1Attr
  AND #%01000000
  BEQ .FacingRight

  LDA #$7F
  STA playerSprite1Tile
  LDA #$7E
  STA playerSprite2Tile
  LDA #$7D
  STA playerSprite3Tile
  LDA #$82
  STA playerSprite4Tile
  LDA #$81
  STA playerSprite5Tile
  LDA #$80
  STA playerSprite6Tile
  LDA #$85
  STA playerSprite7Tile
  LDA #$84
  STA playerSprite8Tile
  LDA #$83
  STA playerSprite9Tile
  JMP .EndJumpSprite

.FacingRight:
  LDA #$7D
  STA playerSprite1Tile
  LDA #$7E
  STA playerSprite2Tile
  LDA #$7F
  STA playerSprite3Tile
  LDA #$80
  STA playerSprite4Tile
  LDA #$81
  STA playerSprite5Tile
  LDA #$82
  STA playerSprite6Tile
  LDA #$83
  STA playerSprite7Tile
  LDA #$84
  STA playerSprite8Tile
  LDA #$85
  STA playerSprite9Tile

.EndJumpSprite:

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

  LDA #$00
  STA jumping
  LDA #$00
  STA falling
EndJump:

IdlePose:
  LDA jumping
  BEQ .CheckMovement

  JMP EndIdlePose

.CheckMovement:
  LDA buttonLeftPressed
  ORA buttonRightPressed
  BEQ .StartIdlePose

  JMP EndIdlePose

.StartIdlePose:
  LDA playerSprite1Attr
  CMP #%00000011
  BEQ .FaceRight

  LDA #$7F
  STA playerSprite1Tile
  LDA #$7E
  STA playerSprite2Tile
  LDA #$7D
  STA playerSprite3Tile
  LDA #$81
  STA playerSprite5Tile
  LDA #$80
  STA playerSprite6Tile
  LDA #$84
  STA playerSprite8Tile
  LDA #$83
  STA playerSprite9Tile

  LDA buttonPressedB
  BNE .IdlePose

  LDA #$82
  STA playerSprite4Tile
  LDA #$85
  STA playerSprite7Tile
  JMP EndIdlePose

.IdlePose:
  LDA #$86
  STA playerSprite4Tile
  LDA #$87
  STA playerSprite7Tile

  JMP EndIdlePose

.FaceRight:
  LDA #$7D
  STA playerSprite1Tile
  LDA #$7E
  STA playerSprite2Tile
  LDA #$7F
  STA playerSprite3Tile
  LDA #$80
  STA playerSprite4Tile
  LDA #$81
  STA playerSprite5Tile
  LDA #$83
  STA playerSprite7Tile
  LDA #$84
  STA playerSprite8Tile

  LDA buttonPressedB
  BNE .IdlePoseRight

  LDA #$82
  STA playerSprite6Tile
  LDA #$85
  STA playerSprite9Tile
  JMP EndIdlePose

.IdlePoseRight:
  LDA #$86
  STA playerSprite6Tile
  LDA #$87
  STA playerSprite9Tile

EndIdlePose:


CheckIfTheLevelIsComplete:
  LDA gameWin
  BEQ ChangeEnemyDirection

  JMP LoadIntroScene1


ChangeEnemyDirection:
  LDA enemySprite1X
  CMP #$01
  BEQ .TurnRight

  LDA enemySprite3X
  CMP #$F0
  BEQ .TurnLeft

  JMP EndChangeEnemyDirection

.TurnLeft:
  LDA #$00
  STA enemyDirection
  JSR FlipEnemySprite
  JMP EndChangeEnemyDirection

.TurnRight:
  LDA #$01
  STA enemyDirection
  JSR FlipEnemySprite
EndChangeEnemyDirection:

MoveEnemy:
  LDA gameInProgress
  BEQ EndMoveEnemy

  LDA enemyHealth
  BEQ EndMoveEnemy

  LDA enemyDirection
  BNE .MoveRight

  JSR MoveEnemyLeft
  JMP EndMoveEnemy

.MoveRight:
  JSR MoveEnemyRight
EndMoveEnemy:



AnimateEnemyLeft:
  LDA enemyDirection
  BEQ .Animate

  JMP EndAnimateEnemyLeft

.Animate:
  INC enemyAnimationTimer

  LDA enemyAnimationTimer
  CMP #$30
  BNE .RunTimer

  LDA #$00
  STA enemyAnimationTimer

.RunTimer:
  LDA enemyAnimationTimer
  CMP #$24
  BCS .RunFrame2

  CMP #$18
  BCS .RunFrame3

  CMP #$0C
  BCS .RunFrame2

  CMP #$00
  BCS .RunFrame1

.RunFrame1:
  LDA #$8C
  STA enemySprite4Tile
  LDA #$8D
  STA enemySprite5Tile
  LDA #$8E
  STA enemySprite6Tile
  LDA #$8F
  STA enemySprite7Tile
  LDA #$90
  STA enemySprite8Tile
  LDA #$91
  STA enemySprite9Tile
  JMP EndAnimateEnemyLeft

.RunFrame2:
  LDA #$D9
  STA enemySprite4Tile
  LDA #$DA
  STA enemySprite5Tile
  LDA #$DB
  STA enemySprite6Tile
  LDA #$DC
  STA enemySprite7Tile
  LDA #$DD
  STA enemySprite8Tile
  LDA #$DE
  STA enemySprite9Tile
  JMP EndAnimateEnemyLeft

.RunFrame3:
  LDA #$8C
  STA enemySprite4Tile
  LDA #$8D
  STA enemySprite5Tile
  LDA #$8E
  STA enemySprite6Tile
  LDA #$DF
  STA enemySprite7Tile
  LDA #$E0
  STA enemySprite8Tile
  LDA #$E1
  STA enemySprite9Tile
  JMP EndAnimateEnemyLeft

EndAnimateEnemyLeft:

AnimateEnemyRight:
  LDA enemyDirection
  BNE .Animate

  JMP EndAnimateEnemyRight

.Animate:
  INC enemyAnimationTimer

  LDA enemyAnimationTimer
  CMP #$30
  BNE .RunTimer

  LDA #$00
  STA enemyAnimationTimer

.RunTimer:
  LDA enemyAnimationTimer
  CMP #$24
  BCS .RunFrame2

  CMP #$18
  BCS .RunFrame3

  CMP #$0C
  BCS .RunFrame2

  CMP #$00
  BCS .RunFrame1

.RunFrame1:
  LDA #$8E
  STA enemySprite4Tile
  LDA #$8D
  STA enemySprite5Tile
  LDA #$8C
  STA enemySprite6Tile
  LDA #$91
  STA enemySprite7Tile
  LDA #$90
  STA enemySprite8Tile
  LDA #$8F
  STA enemySprite9Tile
  JMP EndAnimateEnemyRight

.RunFrame2:
  LDA #$DB
  STA enemySprite4Tile
  LDA #$DA
  STA enemySprite5Tile
  LDA #$D9
  STA enemySprite6Tile
  LDA #$DE
  STA enemySprite7Tile
  LDA #$DD
  STA enemySprite8Tile
  LDA #$DC
  STA enemySprite9Tile
  JMP EndAnimateEnemyRight

.RunFrame3:
  LDA #$8E
  STA enemySprite4Tile
  LDA #$8D
  STA enemySprite5Tile
  LDA #$8C
  STA enemySprite6Tile
  LDA #$E1
  STA enemySprite7Tile
  LDA #$E0
  STA enemySprite8Tile
  LDA #$DF
  STA enemySprite9Tile
  JMP EndAnimateEnemyRight

EndAnimateEnemyRight:




CheckProjectileCollision:
  LDA enemyDeathTimer
  CMP #$3C
  BEQ .CheckCollision1

  JMP EnemyDie

.CheckCollision1:
  LDA projectileX
  CLC
  ADC #$08
  CMP enemySprite1X
  BCS .CheckCollision2

  JMP CheckProjectile2Collision

.CheckCollision2:
  LDA projectileX
  SEC
  SBC #$08
  CMP enemySprite3X
  BCC .CheckCollision3

  JMP CheckProjectile2Collision

.CheckCollision3:
  LDA projectileY
  CMP enemySprite1Y
  BCS .CheckCollision4

  JMP CheckProjectile2Collision

.CheckCollision4:
  LDA projectileY
  CMP enemySprite8Y
  BCS CheckProjectile2Collision

  LDA #$FF
  STA projectileY
  JMP EnemyLoseHealth

CheckProjectile2Collision:
  LDA enemyDeathTimer
  CMP #$3C
  BEQ .CheckCollision1

  JMP EnemyDie

.CheckCollision1:
  LDA projectile2X
  CLC
  ADC #$08
  CMP enemySprite1X
  BCS .CheckCollision2

  JMP CheckProjectile3Collision

.CheckCollision2:
  LDA projectile2X
  SEC
  SBC #$08
  CMP enemySprite3X
  BCC .CheckCollision3

  JMP CheckProjectile3Collision

.CheckCollision3:
  LDA projectile2Y
  CMP enemySprite1Y
  BCS .CheckCollision4

  JMP CheckProjectile3Collision

.CheckCollision4:
  LDA projectile2Y
  CMP enemySprite8Y
  BCS CheckProjectile3Collision

  LDA #$FF
  STA projectile2Y
  JMP EnemyLoseHealth

CheckProjectile3Collision:
  LDA enemyDeathTimer
  CMP #$3C
  BEQ .CheckCollision1

  JMP EnemyDie

.CheckCollision1:
  LDA projectile3X
  CLC
  ADC #$08
  CMP enemySprite1X
  BCS .CheckCollision2

  JMP EndCheckProjectileCollision

.CheckCollision2:
  LDA projectile3X
  SEC
  SBC #$08
  CMP enemySprite3X
  BCC .CheckCollision3

  JMP EndCheckProjectileCollision

.CheckCollision3:
  LDA projectile3Y
  CMP enemySprite1Y
  BCS .CheckCollision4

  JMP EndCheckProjectileCollision

.CheckCollision4:
  LDA projectile3Y
  CMP enemySprite8Y
  BCC EnemyLoseHealth

  JMP EndCheckProjectileCollision

  LDA #$FF
  STA projectile3Y

EnemyLoseHealth:
  LDA enemyIFrames
  BNE EndEnemyLoseHealth

  DEC enemyHealth


  ; This is causing the background to jump around wildly
  ; LDA #$20
  ; STA $2006
  ; LDA #$39
  ; CLC
  ; ADC enemyHealth
  ; STA $2006
  ; LDA #$01
  ; STA $2007

  LDA #$3C
  STA enemyIFrames
EndEnemyLoseHealth:

  LDA enemyHealth
  BEQ EnemyDie

  JMP EndCheckProjectileCollision

EnemyDie:
  LDA enemyDeathTimer
  BNE MoveEnemyParts

  LDA #$FF
  STA enemySprite1Y
  STA enemySprite2Y
  STA enemySprite3Y
  STA enemySprite4Y
  STA enemySprite5Y
  STA enemySprite6Y
  STA enemySprite7Y
  STA enemySprite8Y
  STA enemySprite9Y

  LDA #$01
  STA gameWin

  JMP CheckGameVictory

MoveEnemyParts:
  DEC enemySprite1Y
  DEC enemySprite1X

  DEC enemySprite2Y

  DEC enemySprite3Y
  INC enemySprite3X

  DEC enemySprite4X

  INC enemySprite6X

  INC enemySprite7Y
  DEC enemySprite7X

  INC enemySprite8Y

  INC enemySprite9Y
  INC enemySprite9X

  DEC enemyDeathTimer
EndCheckProjectileCollision:

CheckEnemyBulletCollision:
  LDA enemyProjectileX
  CLC
  ADC #$08
  CMP playerSprite1X
  BCC EndCheckEnemyBulletCollision

  LDA enemyProjectileX
  SEC
  SBC #$08
  CMP playerSprite3X
  BCS EndCheckEnemyBulletCollision

  LDA enemyProjectileY
  CMP playerSprite1Y
  BCC EndCheckEnemyBulletCollision

  LDA enemyProjectileY
  CMP playerSprite8Y
  BCS EndCheckEnemyBulletCollision

  LDA iFrames
  BNE EndCheckEnemyBulletCollision

  LDA #$FF
  STA enemyProjectileY

  JSR LoseHealth
EndCheckEnemyBulletCollision:

CheckPlayerCollision:
  LDA enemyDeathTimer
  CMP #$3C
  BNE EndCheckPlayerCollision

  LDA playerSprite9X
  CMP enemySprite1X
  BCC EndCheckPlayerCollision

  LDA playerSprite9X
  SEC
  SBC #$20
  CMP enemySprite1X
  BCS EndCheckPlayerCollision

  LDA playerSprite9Y
  CMP enemySprite1Y
  BCC EndCheckPlayerCollision

  LDA iFrames
  BNE EndCheckPlayerCollision

  JSR LoseHealth
EndCheckPlayerCollision:

EnemyFireProjectile:
  LDA enemyHealth
  BEQ EndEnemyFireProjectile

  LDA enemyFireTimer
  BNE EndEnemyFireProjectile

  LDA #$40
  STA enemyFireTimer

  LDA enemySprite1Y
  TAX
  LDA enemyProjectileY
  TXA
  CLC
  ADC #$0A
  STA enemyProjectileY

  LDA enemySprite1X
  TAX
  LDA enemyProjectileX
  TXA
  CLC

  LDY enemyDirection
  CPY #$00
  BEQ .FacingLeft

  ADC #$10
  STA enemyProjectileX
  JMP EndEnemyFireProjectile

.FacingLeft:
  ADC #$00
  STA enemyProjectileX
EndEnemyFireProjectile:

  DEC enemyFireTimer

MoveEnemyProjectile:
  LDA enemyHealth
  BEQ HideEnemyProjectile

  LDA enemyProjectileX
  CMP #$F8
  BCS HideEnemyProjectile
  CMP #$04
  BCC HideEnemyProjectile

  LDA enemyDirection
  BNE .MoveEnemyProjectileRight

  LDA enemyProjectileX
  SEC
  SBC projectileSpeed
  STA enemyProjectileX
  JMP HideEnemyProjectileEnd

.MoveEnemyProjectileRight:
  LDA enemyProjectileX
  CLC
  ADC projectileSpeed
  STA enemyProjectileX
  JMP HideEnemyProjectileEnd

HideEnemyProjectile:
  LDA #$FF
  STA enemyProjectileY
HideEnemyProjectileEnd:

EnemyIFramesCheck:
  LDA enemyIFrames
  BEQ EndEnemyIFramesCheck

  DEC enemyIFrames
EndEnemyIFramesCheck:

IFramesCheck:
  LDA iFrames
  BEQ EndIFramesCheck
  DEC iFrames

  CMP #$24
  BCC EnableMovement

  LDA #$00
  STA movementEnabled

  LDA playerSprite1Attr
  AND #%01000000
  BNE .KnockBackRight

.KnockBackLeft:
  LDA playerSprite1X
  CMP #$01
  BEQ .SkipKnockBackLeft

  DEC playerSprite1X
  DEC playerSprite2X
  DEC playerSprite3X
  DEC playerSprite4X
  DEC playerSprite5X
  DEC playerSprite6X
  DEC playerSprite7X
  DEC playerSprite8X
  DEC playerSprite9X

.SkipKnockBackLeft:
  JMP EndIFramesCheck

.KnockBackRight:
  LDA playerSprite3X
  CMP #$F0
  BEQ .SkipKnockBackRight

  INC playerSprite1X
  INC playerSprite2X
  INC playerSprite3X
  INC playerSprite4X
  INC playerSprite5X
  INC playerSprite6X
  INC playerSprite7X
  INC playerSprite8X
  INC playerSprite9X

.SkipKnockBackRight:
  JMP EndIFramesCheck

EnableMovement:
  LDA #$01
  STA movementEnabled

EndIFramesCheck:

CheckPlayerDeath:
  LDA playerHealth
  BEQ Die

  JMP EndCheckPlayerDeath

Die:
  LDA deathTimer
  BNE MoveParts

  LDA #$FF
  STA playerSprite1Y
  STA playerSprite2Y
  STA playerSprite3Y
  STA playerSprite4Y
  STA playerSprite5Y
  STA playerSprite6Y
  STA playerSprite7Y
  STA playerSprite8Y
  STA playerSprite9Y

  LDA #$01
  STA gameOver

  JMP EndCheckPlayerDeath

MoveParts:
  DEC playerSprite1Y
  DEC playerSprite1X

  DEC playerSprite2Y

  DEC playerSprite3Y
  INC playerSprite3X

  DEC playerSprite4X

  INC playerSprite6X

  INC playerSprite7Y
  DEC playerSprite7X

  INC playerSprite8Y

  INC playerSprite9Y
  INC playerSprite9X

  DEC deathTimer
EndCheckPlayerDeath:

CheckTitleScreen:
  LDA titleScreen
  BEQ EndCheckTitleScreen

  JSR HidePlayerSprite

EndCheckTitleScreen:

; CheckGameInProgress:
;   LDA titleScreen
;   BNE EndCheckGameInProgress
;
;   LDA introDialog
;   BNE EndCheckGameInProgress
;
;   LDA gameInProgress
;   BNE EndCheckGameInProgress
;
;   LDA introScene
;   BNE EndCheckGameInProgress
;
;   LDA introScene2
;   BNE EndCheckGameInProgress
;
;   LDA travelTransition
;   BNE EndCheckGameInProgress
;
;   JSR DisableGraphics
;
;   JSR LoadSprites
;
;   LDA #LOW(background)
;   STA pointerBackgroundLowByte
;   LDA #HIGH(background)
;   STA pointerBackgroundHighByte
;   JSR LoadBackground
;
;   JSR LoadAttribute
;   JSR LoadFuturePalettes
;
;   LDA #$01
;   STA gameInProgress
;   STA movementEnabled
; EndCheckGameInProgress:

LoadIntroScene1:
  LDA introScene
  BEQ EndLoadIntroScene1

  LDA buttonPressedA
  BEQ .LoadScene

  LDA #$00
  STA introScene

  LDA #$01
  STA introScene2
  JMP LoadIntroScene2

.LoadScene:

  LDA introSceneLoaded
  BNE EndLoadIntroScene1

  LDA #$01
  JSR Bankswitch

  JSR DisableGraphics
  JSR ClearBackground

  LDA #LOW(introSequence)
  STA pointerBackgroundLowByte
  LDA #HIGH(introSequence)
  STA pointerBackgroundHighByte
  JSR LoadBackground

  JSR LoadAttributeTitle
  JSR LoadTitlePalettes

  JSR EnableGraphics

  LDA #$01
  STA introSceneLoaded
EndLoadIntroScene1:

LoadIntroScene2:
  LDA introScene2
  BEQ EndLoadIntroScene2

  LDA buttonPressedB ; fix this
  BEQ .LoadScene

  LDA #$00
  STA introScene2

  LDA #$01
  STA forgeScene
  JMP LoadForgeDialogSequence

.LoadScene:
  LDA introSceneLoaded2
  BNE EndLoadIntroScene2

  JSR DisableGraphics
  JSR ClearBackground

  JSR LoadCapturedTextScreen

  JSR EnableGraphics

  LDA #$01
  STA introSceneLoaded2
EndLoadIntroScene2:

LoadForgeDialogSequence:
  LDA forgeScene
  BEQ EndLoadForgeDialogSequence

  LDA advanceDialog
  BNE .DrawDialog

  LDA forgeSceneLoaded
  BNE EndLoadForgeDialogSequence

.DrawDialog:
  LDA #$01
  STA introDialog

  JSR DrawNextDialogScreen

  LDA #$00
  STA advanceDialog

  LDA #$01
  STA forgeSceneLoaded
EndLoadForgeDialogSequence:

LoadTeslaScene:
  LDA teslaScene
  BEQ EndLoadTeslaScene

  LDA buttonPressedB ; fix this
  BEQ .LoadScene

  LDA #$00
  STA teslaScene
  LDA #$01
  STA teslaLandingScene
  JMP EndLoadTeslaScene

.LoadScene:
  LDA teslaSceneLoaded
  BNE EndLoadTeslaScene

  LDA #$02
  JSR Bankswitch

  JSR HideSprites
  JSR HidePlayerSprite
  JSR HideTravelerSprite

  JSR DisableGraphics
  JSR ClearBackground

  LDA #LOW(teslaBackground)
  STA pointerBackgroundLowByte
  LDA #HIGH(teslaBackground)
  STA pointerBackgroundHighByte
  JSR LoadBackground

  JSR LoadTeslaAttribute
  JSR LoadTeslaPalette

  JSR EnableGraphics

  LDA #$01
  STA teslaSceneLoaded
EndLoadTeslaScene:

LoadTeslaLandingScene:
  LDA teslaLandingScene
  BEQ EndLoadTeslaLandingScene

  LDA buttonPressedA ; fix this
  BEQ .LoadScene

  LDA #$00
  STA teslaLandingScene
  LDA #$01
  STA approachingTheForge
  JMP EndLoadTeslaLandingScene

.LoadScene:
  LDA teslaLandingSceneLoaded
  BNE EndLoadTeslaLandingScene

  LDA #$01
  JSR Bankswitch

  JSR HideSprites
  JSR HidePlayerSprite
  JSR HideTravelerSprite
  JSR DisableGraphics
  JSR ClearBackground

  LDA #LOW(teslaLandingBackground)
  STA pointerBackgroundLowByte
  LDA #HIGH(teslaLandingBackground)
  STA pointerBackgroundHighByte
  JSR LoadBackground

  JSR LoadAttributeTitle
  JSR LoadTitlePalettes

  JSR EnableGraphics

  LDA #$01
  STA teslaLandingSceneLoaded
EndLoadTeslaLandingScene:

ApproachingTheForge:
  LDA approachingTheForge
  BEQ EndApproachingTheForge

  LDA gameWin
  BEQ .LoadScene

  LDA #$00
  STA approachingTheForge
  LDA #$01
  STA moodyAppearsScene

.LoadScene:
  LDA approachingTheForgeLoaded
  BNE EndApproachingTheForge

  JSR LoadSprites
  JSR ShowPlayerSprite
  JSR DisableGraphics
  JSR ClearBackground

  LDA #LOW(background)
  STA pointerBackgroundLowByte
  LDA #HIGH(background)
  STA pointerBackgroundHighByte
  JSR LoadBackground

  JSR LoadAttribute
  JSR LoadFuturePalettes

  JSR EnableGraphics

  LDA #$01
  STA gameInProgress
  STA movementEnabled
  STA approachingTheForgeLoaded
EndApproachingTheForge:

MoodyAppearsScene:
  LDA moodyAppearsScene
  BEQ EndMoodyAppearsScene

  LDA buttonPressedA ; fix this
  BEQ .LoadScene

  LDA #$00
  STA moodyAppearsScene
  STA endOfDialog
  STA gameInProgress
  LDA #$01
  STA moodyDialog

  JMP EndMoodyAppearsScene

.LoadScene:
  LDA moodyAppearsSceneLoaded
  BNE EndMoodyAppearsScene

  JSR HideSprites
  JSR HidePlayerSprite
  JSR HideTravelerSprite
  JSR DisableGraphics
  JSR ClearBackground

  LDA #LOW(insideTheForgeBackground)
  STA pointerBackgroundLowByte
  LDA #HIGH(insideTheForgeBackground)
  STA pointerBackgroundHighByte
  JSR LoadBackground

  JSR LoadAttributeTitle
  JSR LoadTitlePalettes

  JSR EnableGraphics

  LDA #$01
  STA moodyAppearsSceneLoaded
EndMoodyAppearsScene:

LoadMoodyDialogSequence:
  LDA moodyDialog
  BEQ EndLoadMoodyDialogSequence

  LDA advanceDialog
  BNE .DrawDialog

  LDA moodyDialogLoaded
  BNE EndLoadMoodyDialogSequence

.DrawDialog:
  JSR DrawNextMoodyDialogScreen

  LDA #$00
  STA advanceDialog

  LDA #$01
  STA moodyDialogLoaded
EndLoadMoodyDialogSequence:

MoodyBattleSequence:
  LDA moodyBattleSequence
  BEQ EndMoodyBattleSequence

  LDA #$00
  STA endOfDialog

  LDA moodyBattleSequenceLoaded
  BEQ .LoadScene

  LDA playerSprite1X
  CMP #$B0
  BCC .LoadScene

  ; LDA gameInProgress ; fix this
  ; BNE .LoadScene

  LDA #$00
  STA moodyBattleSequence
  LDA #$01
  STA lincRescueScene
  JMP EndMoodyBattleSequence

.LoadScene:
  LDA moodyBattleSequenceLoaded
  BNE EndMoodyBattleSequence

  JSR LoadPlayerSprite
  JSR LoadTravelerSprite
  LDA #$03
  STA enemyHealth
  LDA #$01
  STA gameInProgress

  JSR DisableGraphics
  JSR ClearBackground

  LDA #LOW(background)
  STA pointerBackgroundLowByte
  LDA #HIGH(background)
  STA pointerBackgroundHighByte
  JSR LoadBackground

  JSR LoadAttribute
  JSR LoadFuturePalettes

  JSR EnableGraphics

  LDA #$01
  STA moodyBattleSequenceLoaded

EndMoodyBattleSequence:

LoadLincRescueScene:
  LDA lincRescueScene
  BEQ EndLoadLincRescueScene

  LDA buttonPressedA ; fix this
  BEQ .LoadScene

  LDA #$00
  STA lincRescueScene
  LDA #$01
  STA lincDialogSequence
  JMP EndLoadLincRescueScene

.LoadScene:
  LDA lincRescueSceneLoaded
  BNE EndLoadLincRescueScene

  JSR HideSprites
  JSR HidePlayerSprite
  JSR HideTravelerSprite

  JSR DisableGraphics
  JSR ClearBackground

  LDA #LOW(lincRescueSceneBackground)
  STA pointerBackgroundLowByte
  LDA #HIGH(lincRescueSceneBackground)
  STA pointerBackgroundHighByte
  JSR LoadBackground

  JSR LoadAttributeTitle
  JSR LoadTitlePalettes

  JSR EnableGraphics

  LDA #$01
  STA lincRescueSceneLoaded
EndLoadLincRescueScene:

LincDialogSequence:
  LDA lincDialogSequence
  BEQ EndLincDialogSequence

  LDA advanceDialog
  BNE .DrawDialog

  LDA lincDialogSequenceLoaded
  BNE EndLincDialogSequence

.DrawDialog:
  JSR DrawNextLincDialogScreen

  LDA #$00
  STA advanceDialog

  LDA #$01
  STA lincDialogSequenceLoaded
EndLincDialogSequence:


RollCredits:
  LDA creditsScreen
  BEQ EndRollCredits

.LoadScene:
  LDA creditsScreenLoaded
  BNE EndRollCredits

  JSR HideSprites
  JSR HidePlayerSprite
  JSR HideTravelerSprite

  JSR DisableGraphics
  JSR ClearBackground

  LDA #LOW(backgroundCredits)
  STA pointerBackgroundLowByte
  LDA #HIGH(backgroundCredits)
  STA pointerBackgroundHighByte
  JSR LoadBackground

  JSR LoadAttributeTitle
  JSR LoadTitlePalettes

  JSR EnableGraphics

  LDA #$01
  STA creditsScreenLoaded
EndRollCredits:


EndCurrentFrame:
  ; Figure out why the music makes the game crash
  ; JSR musicPlay
  RTI


Bankswitch:
  TAX
  STA Bankvalues, X
  RTS

Bankvalues:
  .db $00, $01, $02, $03

  .include "functions/enableGraphics.asm"
  .include "functions/disableGraphics.asm"
  .include "functions/vBlank.asm"
  .include "functions/loadSprites.asm"
  .include "functions/loadPalettes.asm"
  .include "functions/loadDialogPalettes.asm"
  .include "functions/loadAttribute.asm"
  .include "functions/loadAttributeTitle.asm"
  .include "functions/loadAttributeCredits.asm"
  .include "functions/loadAttributeDialog.asm"
  .include "functions/loadBackground.asm"
  .include "functions/nextLineTop.asm"
  .include "functions/nextLineBottom.asm"
  .include "functions/loadTopDialog.asm"
  .include "functions/loadBottomDialog.asm"
  .include "functions/drawHearts.asm"
  .include "functions/loseHealth.asm"
  .include "functions/drawNextDialogScreen.asm"
  .include "functions/wipeDialog.asm"
  .include "functions/sounds.asm"
  .include "functions/enemyMovement.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  .bank 3
  .org $E000

palette:
  .include "graphics/palette.asm"

futurePalette:
  .include "graphics/futurePalette.asm"

titlePalette:
  .incbin "graphics/title/palette.dat"

paletteDialog:
  .include "graphics/dialog/paletteIntro.asm"

sprites:
  .include "graphics/sprites.asm"

background:
  .include "graphics/background.asm"

backgroundGameOver:
  .include "graphics/backgroundGameOver.asm"

backgroundGameWin:
  .include "graphics/backgroundGameWin.asm"

backgroundTitle:
  .incbin "graphics/title/nametable.dat"

backgroundCredits:
  .include "graphics/backgroundCredits.asm"

backgroundDialogTemplate:
  .include "graphics/dialog/dialogTemplate.asm"

backgroundDialogIntro1:
  .include "graphics/dialog/intro01.asm"

backgroundDialogIntro2:
  .include "graphics/dialog/intro02.asm"

backgroundDialogIntro3:
  .include "graphics/dialog/intro03.asm"

backgroundDialogIntro4:
  .include "graphics/dialog/intro04.asm"

backgroundDialogIntro5:
  .include "graphics/dialog/intro05.asm"

capturedTextScreen:
  .include "graphics/capturedTextScreen.asm"

introSequence:
  .include "graphics/introSequence.asm"

attribute:
  .include "graphics/attributes.asm"

attributeTitle:
  .incbin "graphics/title/attribute.dat"

attributeCredits:
  .include "graphics/attributesCredits.asm"

attributeDialog:
  .include "graphics/dialog/attributesIntro.asm"

  .org $FFFA
  .dw NMI
  .dw RESET
  .dw 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  .bank 4
  .org $0000
  .incbin "graphics/title/chr.dat"

  .bank 5
  .org $0000
  .incbin "sprites.chr"

  .bank 6
  .org $0000
  .incbin "graphics/tesla/chr.dat"
