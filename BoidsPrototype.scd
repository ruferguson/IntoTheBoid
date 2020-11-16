(
SynthDef("bass",
	{
		arg freq = 440, decay = 0.1, amp = 1, len = 1.075, width = 0.5, lpf = 1000, hpf = 10, pan = 0;
		var sig, env;
		env = EnvGen.kr(
			Env.new(
				[0.001,1,decay,0.001],
				[0.025, len - 0.025, 0.02] * (1/5),
				\exponential
			),
			doneAction: 2
		);

		sig = LFSaw.ar(freq, [0,0], (1 - width) * amp, SinOsc.ar(freq, [0,0], amp * width));
		sig = HPF.ar(sig, hpf);
		sig = LPF.ar(sig, lpf);
		sig = sig * env;
		Out.ar(0, Pan2.ar(sig, pan));
	}
).add;

SynthDef("chirp", { |out, freq, amp, dur, pan|
    Out.ar(out,
		Line.ar(0.1, 0, dur, SinOsc.ar(freq, mul: 0.4, add: 0.6), 0, 2) * Pulse.ar(freq,mul: [1,0.8])
    )
}).add;
)

var bass = 10;
bass.postln;

(f = {
	arg bass = 36;
})

f.value(\bass, 36);

Synth("bass",[\freq, 80, \lpf, 200, \width, 0.75, \pan, 1]);
Synth("chirp", [\freq, 440, \amp, 1, \dur, 0.1]);


OSCdef(\listener,
	{
		|msg|
		var bass, type, degree, volume, orientation, note;

		msg[1] = type;     //See key below
		msg[2] = degree;
		msg[3] = volume;
		msg[4] = orientation;

		/* Types:
		 *   0: Bass note
		 *   1: Chirp note
		 *
		 * Degree:
		 *   For Bass notes: Midi note (~30-40)
		 *   For Other notes: Scale degree (5 degrees per oct.)
		 *
		 * Volume:
		 *   Amplitude between 0-1
		 *
		 * Orientation:
		 *   I'm not sure yet lol. maybe -1 to 1
		 *
		*/

		if (type == 0) {

			bass = degree;
			Synth("bass",[\freq, degree.midicps, \amp, volume, \lpf, 200, \width, 0.75]);

		}{



			Synth("chirp", [\freq, 440, \amp, volume, \dur, 0.1, \pan, 1]);

		}

	},
	'/bass'
);