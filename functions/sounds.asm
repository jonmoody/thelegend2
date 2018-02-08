AudioBankSwitch:
  LDX #%00000111
  STX $8000
  STA $8001
  JSR RestartAudio
  RTS

RestartAudio:
  STA $4000, x
  INX
  CPX #$0F
  BNE RestartAudio
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
  JSR musicPlay
  RTS
