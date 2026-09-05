#!/bin/bash

# wait for csound's ports to appear
while ! jack_lsp | grep -q "csound"; do
  sleep 0.2
done

jack_connect csound6:output1 system:playback_1 2>/dev/null
jack_connect csound6:output2 system:playback_2 2>/dev/null
jack_connect system:capture_1 csound6:input1 2>/dev/null
jack_connect system:capture_2 csound6:input2 2>/dev/null

# stay alive so pkill -f can still find/kill this script on cleanup
while true; do
  sleep 3600
done
