ScrollBackgroundLeft:
  LDA #$00
  STA $2006        ; clean up PPU address registers
  STA $2006

  DEC scroll       ; add one to our scroll variable each frame
  LDA scroll
  STA $2005        ; write the horizontal scroll count register

  LDA #$00         ; no vertical scrolling
  STA $2005
  RTS

ScrollBackgroundRight:
  LDA #$00
  STA $2006        ; clean up PPU address registers
  STA $2006

  INC scroll       ; add one to our scroll variable each frame
  LDA scroll
  STA $2005        ; write the horizontal scroll count register

  LDA #$00         ; no vertical scrolling
  STA $2005
  RTS
