  LDA #$01
  STA $4016
  LDA #$00
  STA $4016

  LDA $4016       ; Player 1 - A
  LDA $4016       ; Player 1 - B
  LDA $4016       ; Player 1 - Select

ReadStart:
  LDA $4016       ; Player 1 - Start
  AND #%00000001
  BEQ EndReadStart

  LDA titleScreen
  BEQ EndReadStart

  LDA creditsOptionSelected
  STA creditsScreen
  BNE LeaveTitleScreen

  LDA #$01
  STA introScene

LeaveTitleScreen:
  LDA #$00
  STA titleScreen

EndReadStart:

  LDA $4016       ; Player 1 - Up
  LDA $4016       ; Player 1 - Down
  LDA $4016       ; Player 1 - Left
  LDA $4016       ; Player 1 - Right
