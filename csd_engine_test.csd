<CsoundSynthesizer>
<CsOptions>
-+rtaudio=jack -odac -iadc
</CsOptions>
; ==============================================
<CsInstruments>

sr	=	48000
ksmps	=	32
nchnls	=	2
0dbfs	=	1

giOSC OSCinit 9000

instr 1	
  krawfreq init 440 ; for smoothing and not clashing with OSC
  kfreq init 440
  krawamp init 0.5
  kamp init 0.5

  ktrig OSClisten giOSC, "/freq", "f", krawfreq
  ktrig OSClisten giOSC, "/amp", "f", krawamp
  kfreq portk krawfreq, 0.05
  kamp portk krawamp, 0.05
  aout oscili kamp, kfreq
  outs aout, aout
  

endin

</CsInstruments>
; ==============================================
<CsScore>
i 1 0 3600


</CsScore>
</CsoundSynthesizer>

