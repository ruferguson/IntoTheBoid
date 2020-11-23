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

SynthDef("hihat", {arg out = 0, amp = 0.5, att = 0.01, rel = 0.2, ffreq = 6000, pan = 0;
	var env, snd;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	snd = WhiteNoise.ar;
	snd = HPF.ar(in: snd, freq: ffreq, mul: env);
	Out.ar(out, Pan2.ar(snd, pan));
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
Synth("hihat", [\rel, 0.075]);

NetAddr.localAddr;



(
b = 36;
OSCdef('imageListener',
	{
		|msg|
		var bass, note, octave;
		//var bass, type, degree, volume, orientation, note;
		// I commented the above out and changed how the variables were declared.
		// Matched how it was done for temp sonification.

		var type = msg[1];     //See key below
		var degree = msg[2];
		var volume = msg[3];
		var orientation = msg[4];

		octave = (degree / 5).floor;
		//([octave, degree]).postln;


		//msg.postln;

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

		if (type == 0, {

			bass = 36;
			b = degree;
			bass.postln;

			Synth("bass",[\freq, degree.midicps, \amp, volume * 0.8, \lpf, 200, \width, 0.75, \pan, orientation]);

		}, {
			if (type == 1, {
				note = 60;
				degree = (degree % 5);

				if (b == 31,{ //G1
					note = [50,53,55,56,59].at(degree);
					"G1".postln;
				},{});

				if (b == 34,{ //Bb1
					note = [49,50,53,56,58].at(degree);
					"Bb1".postln;
				},{});

				if (b == 36,{ //C2
					note = [48,51,53,55,58].at(degree);
					"C2".postln;
				},{});

				if (b == 39,{ //Eb2
					note = [50,51,55,56,58].at(degree);
					"Eb2".postln;
				},{});

				note = note + (octave * 12);
				//note.postln;
				Synth("chirp", [\freq, note.midicps, \amp, volume, \dur, 0.1, \pan, orientation]);
				//note.midicps.postln;
			},{
				Synth("hihat", [\rel, 0.075, \amp, 0.5 * volume]);
			})

		}
		)

	},
	"/listener"
);)