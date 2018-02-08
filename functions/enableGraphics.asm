EnableGraphics:
  LDA #%10001000   ; Enable NMI, sprites and background on table 0
  ORA nametable
  STA $2000
  LDA #%00011110   ; Enable sprites, enable backgrounds
  STA $2001
  LDA #$00         ; No background scrolling
  STA $2006
  STA $2006
  STA $2005
  STA $2005
  RTS

EnableGraphicsPattern2:
  LDA #%10001000   ; Enable NMI, sprites and background on second table
  STA $2000
  LDA #%00011110   ; Enable sprites, enable backgrounds
  STA $2001
  LDA #$00         ; No background scrolling
  STA $2006
  STA $2006
  STA $2005
  STA $2005
  RTS
