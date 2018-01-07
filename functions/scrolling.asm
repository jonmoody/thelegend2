ScrollBackgroundLeft:
  LDA approachingTheForge
  BEQ .End

  LDA gameOver
  BNE .End

  LDA #$00
  STA $2006        ; clean up PPU address registers
  STA $2006

  DEC scroll       ; add one to our scroll variable each frame
  LDA scroll
  STA $2005        ; write the horizontal scroll count register

  LDA #$00         ; no vertical scrolling
  STA $2005

.End:
  RTS

ScrollBackgroundRight:
  LDA approachingTheForge
  BEQ .End

  LDA gameOver
  BNE .End

  LDA #$00
  STA $2006        ; clean up PPU address registers
  STA $2006

  INC scroll       ; add one to our scroll variable each frame
  LDA scroll
  STA $2005        ; write the horizontal scroll count register

  LDA #$00         ; no vertical scrolling
  STA $2005

.End:
  RTS

ScrollBackgroundUp:
  LDA moveCreditsUp
  BEQ .End

  LDA #$00
  STA $2006        ; clean up PPU address registers
  STA $2006

  LDA #$00
  STA $2005        ; write the horizontal scroll count register

  INC scroll       ; add one to our scroll variable each frame
  LDA scroll
  STA $2005

.End:
  LDA moveCreditsUp
  EOR #$01
  STA moveCreditsUp
  RTS
