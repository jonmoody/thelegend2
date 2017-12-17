DrawNextDialogScreen:
  INC currentDialogScreen

  JSR DisableGraphics

  JSR DrawTopSprite
  JSR DrawBottomSprite

LoadIntro1:
  LDA currentDialogScreen
  CMP #$01
  BNE LoadIntro2

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

  JSR DrawDialogBackground

  LDA #LOW(backgroundDialogIntro2)
  STA pointerBackgroundLowByte
  LDA #HIGH(backgroundDialogIntro2)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  JMP EndLoadingDialogBackground

LoadIntro3: ; Actually put in real text here and beyond - transitions seem to be ok now
  LDA currentDialogScreen
  CMP #$03
  BNE LoadIntro4

  JSR DrawDialogBackground

  LDA #LOW(backgroundDialogIntro3)
  STA pointerBackgroundLowByte
  LDA #HIGH(backgroundDialogIntro3)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog
  JMP EndLoadingDialogBackground

LoadIntro4:
  LDA currentDialogScreen
  CMP #$04
  BNE LoadIntro5

  JSR DrawDialogBackground

  LDA #LOW(backgroundDialogIntro2)
  STA pointerBackgroundLowByte
  LDA #HIGH(backgroundDialogIntro2)
  STA pointerBackgroundHighByte
  JSR LoadTopDialog
  JMP EndLoadingDialogBackground

LoadIntro5:
  LDA currentDialogScreen
  CMP #$05
  BNE EndLoadingDialogBackground

  JSR DrawDialogBackground

  LDA #LOW(backgroundDialogIntro1)
  STA pointerBackgroundLowByte
  LDA #HIGH(backgroundDialogIntro1)
  STA pointerBackgroundHighByte
  JSR LoadBottomDialog

  LDA #$01
  STA endOfDialog
  LDA #$00
  STA forgeScene


  

EndLoadingDialogBackground:
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
