DrawNextDialogScreen:
  INC currentDialogScreen

  LDA #$00
  STA movementEnabled

  JSR DisableGraphics

  JSR DrawTopSprite
  JSR LoadMattSprite

LoadIntro1:
  LDA currentDialogScreen
  CMP #$01
  BNE LoadIntro2

  ; LDA #$01
  ; JSR Bankswitch

  LDA #%00000000
  STA $8000
  LDA #13
  STA $8001

  JSR DrawDialogBackground

  LDA #LOW(backgroundDialogIntro1)
  STA pointerBackgroundLowByte
  LDA #HIGH(backgroundDialogIntro1)
  STA pointerBackgroundHighByte
  JSR LoadTopDialog

  JMP EndLoadingDialogBackground

LoadIntro2:
  LDA currentDialogScreen
  CMP #$02
  BNE LoadIntro3

  JSR WipeTopDialog

  LDA #LOW(backgroundDialogIntro2)
  STA pointerBackgroundLowByte
  LDA #HIGH(backgroundDialogIntro2)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  JMP EndLoadingDialogBackground

LoadIntro3:
  LDA currentDialogScreen
  CMP #$03
  BNE LoadIntro4

  JSR WipeBottomDialog

  LDA #LOW(backgroundDialogIntro3)
  STA pointerBackgroundLowByte
  LDA #HIGH(backgroundDialogIntro3)
  STA pointerBackgroundHighByte
  JSR LoadTopDialog
  JMP EndLoadingDialogBackground

LoadIntro4:
  LDA currentDialogScreen
  CMP #$04
  BNE LoadIntro5

  JSR WipeTopDialog

  LDA #LOW(backgroundDialogIntro4)
  STA pointerBackgroundLowByte
  LDA #HIGH(backgroundDialogIntro4)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog
  JMP EndLoadingDialogBackground

LoadIntro5:
  LDA currentDialogScreen
  CMP #$05
  BNE LeaveIntroDialog

  JSR WipeBottomDialog

  LDA #LOW(backgroundDialogIntro5)
  STA pointerBackgroundLowByte
  LDA #HIGH(backgroundDialogIntro5)
  STA pointerBackgroundHighByte
  JSR LoadTopDialog
  JMP EndLoadingDialogBackground

LeaveIntroDialog:
  LDA currentDialogScreen
  CMP #$06
  BNE EndLoadingDialogBackground

  LDA #$00
  STA introDialog
  STA forgeScene
  STA currentDialogScreen
  LDA #$01
  STA teslaScene
  LDA #$02
  JSR Bankswitch
  JSR HideMattSprite

  LDA #$01
  STA movementEnabled

EndLoadingDialogBackground:
  JSR EnableGraphics
  RTS



DrawNextMoodyDialogScreen:
  INC currentDialogScreen

  LDA #$00
  STA movementEnabled

  JSR DisableGraphics

  JSR DrawTopSprite
  JSR DrawBottomSprite

LoadMoodyDialog1:
  LDA currentDialogScreen
  CMP #$01
  BNE LoadMoodyDialog2

  LDA #$01
  JSR Bankswitch

  JSR DrawDialogBackground

  LDA #LOW(bossBattleDialog1)
  STA pointerBackgroundLowByte
  LDA #HIGH(bossBattleDialog1)
  STA pointerBackgroundHighByte
  JSR LoadTopDialog

  JMP EndDrawNextMoodyDialogScreen

LoadMoodyDialog2:
  LDA currentDialogScreen
  CMP #$02
  BNE LoadMoodyDialog3

  JSR WipeTopDialog

  LDA #LOW(bossBattleDialog2)
  STA pointerBackgroundLowByte
  LDA #HIGH(bossBattleDialog2)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  JMP EndDrawNextMoodyDialogScreen

LoadMoodyDialog3:
  LDA currentDialogScreen
  CMP #$03
  BNE LoadMoodyDialog4

  JSR WipeBottomDialog

  LDA #LOW(bossBattleDialog3)
  STA pointerBackgroundLowByte
  LDA #HIGH(bossBattleDialog3)
  STA pointerBackgroundHighByte
  JSR LoadTopDialog

  JMP EndDrawNextMoodyDialogScreen

LoadMoodyDialog4:
  LDA currentDialogScreen
  CMP #$04
  BNE LoadMoodyDialog5

  JSR WipeTopDialog

  LDA #LOW(bossBattleDialog4)
  STA pointerBackgroundLowByte
  LDA #HIGH(bossBattleDialog4)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  JMP EndDrawNextMoodyDialogScreen

LoadMoodyDialog5:
  LDA currentDialogScreen
  CMP #$05
  BNE LoadMoodyDialog6

  LDA #LOW(bossBattleDialog5)
  STA pointerBackgroundLowByte
  LDA #HIGH(bossBattleDialog5)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  JMP EndDrawNextMoodyDialogScreen

LoadMoodyDialog6:
  LDA currentDialogScreen
  CMP #$06
  BNE LoadMoodyDialog7

  LDA #LOW(bossBattleDialog6)
  STA pointerBackgroundLowByte
  LDA #HIGH(bossBattleDialog6)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  JMP EndDrawNextMoodyDialogScreen

LoadMoodyDialog7:
  LDA currentDialogScreen
  CMP #$07
  BNE LoadMoodyDialog8

  LDA #LOW(bossBattleDialog7)
  STA pointerBackgroundLowByte
  LDA #HIGH(bossBattleDialog7)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  JMP EndDrawNextMoodyDialogScreen

LoadMoodyDialog8:
  LDA currentDialogScreen
  CMP #$08
  BNE LoadMoodyDialog9

  LDA #LOW(bossBattleDialog8)
  STA pointerBackgroundLowByte
  LDA #HIGH(bossBattleDialog8)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  JMP EndDrawNextMoodyDialogScreen

LoadMoodyDialog9:
  LDA currentDialogScreen
  CMP #$09
  BNE LoadMoodyDialog10

  LDA #LOW(bossBattleDialog9)
  STA pointerBackgroundLowByte
  LDA #HIGH(bossBattleDialog9)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  JMP EndDrawNextMoodyDialogScreen

LoadMoodyDialog10:
  LDA currentDialogScreen
  CMP #$0A
  BNE LeaveMoodyDialog

  JSR WipeBottomDialog

  LDA #LOW(bossBattleDialog10)
  STA pointerBackgroundLowByte
  LDA #HIGH(bossBattleDialog10)
  STA pointerBackgroundHighByte
  JSR LoadTopDialog

  JMP EndDrawNextMoodyDialogScreen

LeaveMoodyDialog:
  LDA currentDialogScreen
  CMP #$0B
  BNE EndDrawNextMoodyDialogScreen

  LDA #$00
  STA moodyDialog
  STA currentDialogScreen
  LDA #$01
  STA moodyBattleSequence
  LDA #$04
  JSR Bankswitch

  LDA #$01
  STA movementEnabled

EndDrawNextMoodyDialogScreen:
  JSR EnableGraphics
  RTS


DrawNextLincDialogScreen:
  INC currentDialogScreen

  LDA #$00
  STA movementEnabled

  JSR DisableGraphics

  JSR DrawTopSprite
  JSR DrawLincSprite

LoadLincDialog1:
  LDA currentDialogScreen
  CMP #$01
  BNE LoadLincDialog2

  LDA #$01
  JSR Bankswitch

  JSR DrawDialogBackground

  LDA #LOW(awakeningDialog1)
  STA pointerBackgroundLowByte
  LDA #HIGH(awakeningDialog1)
  STA pointerBackgroundHighByte
  JSR LoadTopDialog

  JMP EndDrawNextLincDialogScreen

LoadLincDialog2:
  LDA currentDialogScreen
  CMP #$02
  BNE LoadLincDialog3

  JSR WipeTopDialog

  LDA #LOW(awakeningDialog2)
  STA pointerBackgroundLowByte
  LDA #HIGH(awakeningDialog2)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  JMP EndDrawNextLincDialogScreen

LoadLincDialog3:
  LDA currentDialogScreen
  CMP #$03
  BNE LoadLincDialog4

  JSR WipeBottomDialog

  LDA #LOW(awakeningDialog3)
  STA pointerBackgroundLowByte
  LDA #HIGH(awakeningDialog3)
  STA pointerBackgroundHighByte
  JSR LoadTopDialog

  JMP EndDrawNextLincDialogScreen

LoadLincDialog4:
  LDA currentDialogScreen
  CMP #$04
  BNE LoadLincDialog5

  JSR WipeTopDialog

  LDA #LOW(awakeningDialog4)
  STA pointerBackgroundLowByte
  LDA #HIGH(awakeningDialog4)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  JMP EndDrawNextLincDialogScreen

LoadLincDialog5:
  LDA currentDialogScreen
  CMP #$05
  BNE LoadLincDialog6

  LDA #LOW(awakeningDialog5)
  STA pointerBackgroundLowByte
  LDA #HIGH(awakeningDialog5)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  JMP EndDrawNextLincDialogScreen

LoadLincDialog6:
  LDA currentDialogScreen
  CMP #$06
  BNE LoadLincDialog7

  LDA #LOW(awakeningDialog6)
  STA pointerBackgroundLowByte
  LDA #HIGH(awakeningDialog6)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  JMP EndDrawNextLincDialogScreen

LoadLincDialog7:
  LDA currentDialogScreen
  CMP #$07
  BNE LeaveLincDialog

  LDA #LOW(awakeningDialog7)
  STA pointerBackgroundLowByte
  LDA #HIGH(awakeningDialog7)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  JMP EndDrawNextLincDialogScreen

LeaveLincDialog:
  LDA currentDialogScreen
  CMP #$08
  BNE EndDrawNextLincDialogScreen

  LDA #$00
  STA lincDialogSequence
  STA currentDialogScreen
  LDA #$01
  STA creditsScreen

EndDrawNextLincDialogScreen:
  JSR EnableGraphics
  RTS

DrawTopSprite:
  JSR LoadPlayerSprite

  LDA #$2F
  STA playerSprite1Y
  STA playerSprite2Y
  STA playerSprite3Y
  LDA #$37
  STA playerSprite4Y
  STA playerSprite5Y
  STA playerSprite6Y
  LDA #$3F
  STA playerSprite7Y
  STA playerSprite8Y
  STA playerSprite9Y

EndDrawTopSprite:
  RTS

DrawLincSprite:
  JSR LoadLincSprite

EndDrawLincSprite:
  RTS

DrawBottomSprite:
  JSR LoadTravelerSprite

  LDA #$30
  STA travelerSprite1X
  STA travelerSprite4X
  STA travelerSprite7X
  STA travelerSprite10X
  LDA #$38
  STA travelerSprite2X
  STA travelerSprite5X
  STA travelerSprite8X
  STA travelerSprite11X
  LDA #$40
  STA travelerSprite3X
  STA travelerSprite6X
  STA travelerSprite9X
  STA travelerSprite12X

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

EndDrawBottomSprite:
  RTS

DrawDialogBackground:
  LDA #LOW(backgroundDialogTemplate)
  STA pointerBackgroundLowByte
  LDA #HIGH(backgroundDialogTemplate)
  STA pointerBackgroundHighByte
  JSR LoadBackground
  JSR LoadAttributeDialog
  JSR LoadDialogPalettes
  RTS
