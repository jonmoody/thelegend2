WipeTopDialog:
  LDA $2002
  LDA #$20
  STA $2006
  LDA #$8C
  STA $2006

  LDY #$00
.Loop:
  LDA #$00
  STA $2007

  INY
  JSR NextLineTop
  CPY #$70
  BNE .Loop
  RTS

WipeBottomDialog:
  LDA $2002
  LDA #$22
  STA $2006
  LDA #$6C
  STA $2006

  LDY #$00
.Loop:
  LDA #$00
  STA $2007

  INY
  JSR NextLineBottom
  CPY #$70
  BNE .Loop
  RTS
