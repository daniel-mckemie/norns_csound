# csound engine wrapper for norns

If you install csound on norns and place the csound-connect.sh into the ~/csound folder, the rest should function the same as having a custom SC engine. You can write your csound file and communicate via OSC params. I don't know howstreamlined this could be over maiden, but I placed these files manually over SSH.

- Place the wrapper with your params in lib/
- Set your ports (different port numbers for each csound project?)
- Set your csound-connect.sh path in .lua (.sh never needs to move)
- Set your path to your .csd file.
- Write lua script as any other with an audo engine in csound...

TO-DO:
- More integrated into SC. This goes direct I/O bypassing onboard reverb, levels, compressor, etc.
- Grid and arc tests
- CPU stress tests!
- Replacement of all SC parts? Likely not possible or a tremendously difficult task. And wildly unnecessary!

Asking:
- How efficient is this???
