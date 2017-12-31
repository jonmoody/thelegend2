LoseHealth:
  LDA #$3C
  STA iFrames

  LDA playerHealth
  CMP #$00
  BEQ EndLoseHealth

  ; This is causing the background to jump around wildly
  ; JSR DrawHearts
  DEC playerHealth
EndLoseHealth:
  RTS
