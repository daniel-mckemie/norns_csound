engine.name = "Csound"

local CONNECT_SCRIPT = "/home/we/csound/connect-csound.sh" -- park this somewhere, stays the same
local CSD_PATH = "/home/we/dust/code/csd_engine_test/csd_engine_test.csd"

local freq = 440
local amp  = 0.5

local function kill_csound()
  norns.system_cmd("pkill -f '/usr/bin/csound " .. CSD_PATH .. "'")  -- SIGTERM, lets JACK client deregister
  norns.system_cmd("pkill -f '" .. CONNECT_SCRIPT .. "'")
end

function init()
  kill_csound()

  clock.run(function()
    clock.sleep(2) -- let JACK release csound6 before relaunch
    norns.system_cmd("/usr/bin/csound " .. CSD_PATH .. " > /tmp/norns_engine.log 2>&1 &")
    print("csound launched")

    clock.sleep(1.5) -- let csound register its JACK ports before connecting
    norns.system_cmd(CONNECT_SCRIPT .. " > /tmp/csound_connect.log 2>&1 &")
    print("connect script launched")

    clock.sleep(2) -- let ports actually patch before sending OSC
    engine.freq(freq)
    engine.amp(amp)
  end)
end

local function clamp(x, min, max)
  return math.max(min, math.min(max, x))
end

function enc(n,d)
  if n == 2 then
    freq = clamp(freq + d, 20, 20000)
    engine.freq(freq)
  end
  if n == 3 then
    amp = clamp(amp + d/100, 0.0, 1.0)
    engine.amp(amp)
  end
end

function cleanup()
  kill_csound()
end
