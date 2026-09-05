Engine_Csound : CroneEngine {

  var osc;

  *new { arg context, doneCallback;
    ^super.new(context, doneCallback);
  }

  alloc {
    // OSC connection to Csound
    osc = NetAddr("127.0.0.1", 9000);

    // Norns engine command
    this.addCommand(\freq, "f", {arg msg;
      // ("Csound freq: " ++ msg[1]).postln;

      osc.sendMsg(
        "/freq",
        msg[1].asFloat
      );
    });

    this.addCommand(\amp, "f", {arg msg;
    
      // ("Csound amp: " ++ msg[1]).postln;

      osc.sendMsg(
        "/amp",
        msg[1].asFloat
      );
    });

    /* EVERYTHING IS FLOAT
    this.addCommand(\gate, "f", {arg msg;
      ("Csound gate: " ++ msg[1]).postln;

      NetAddr("127.0.0.1", 9000).sendMsg(
        "/gate",
        msg[1].asFloat
      );
    });
    */

    postln("Csound: Csound engine loaded");

  }

  free {
    osc = nil;
  }
}
