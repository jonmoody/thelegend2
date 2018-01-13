ExecuteBossMovement:
  JSR MoveBossLeft

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
EndMoveBossLeft:
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

EndMoveBossRight:
  RTS
