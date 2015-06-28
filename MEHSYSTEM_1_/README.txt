After using the MEH-SYSTEM several times, on stage... I upload the 1.0 "DJ-MEH" version, with GPL license! This is the exact version that I use in my show "Mario Mey & Pinokio 3D-Circus". It has some personal commands... but they don't affect the correct function of MEH-SYSTEM (personal commands at bottom of specifications).

You can watch the entire acting here using MEH-SYSTEM. Sorry, I speak argentine spanish, but you will understand the point.

https://www.youtube.com/watch?v=ckKg_rS5ezQ

About MEH-SYSTEM... it's a bit complex to explain all the functions and specs, but I will try...

8 stereo record banks, 32 seconds max each.
4 recording modes: SAMPLE, RESAMPLE, "LOOPING" and OVERDUB.
2 FX CONSOLES controlled by XYpads, HOLD button, DEPTH fader, etc.
100 (and more) effects for each FX console (almost the same KP3 effects).

Controlled by TouchOSC interface, on Android (interface included in ZIP) (sorry Hexler, I didn't paid for it)

Mic in: has EQ3 (for using different types of mics) and LIMITER.

Recording modes:
SAMPLE: it uses predefined BPM to record in 1, 2, 4, 8 and 16 beats, using Mic as input.
RESAMPLE: same as SAMPLE, but it uses everything (FX, Mic and Banks) as input.
"LOOPING": uses the Boss LooperStation recording Style. To use this mode, no bank must be playing. Clicking (or tapping) the button, it starts recording. Clicking again, it stops recording and starts playing. Taking the amount of beats, MEH-SYSTEM defines the new BPM.
OVERDUB: while, at least, one bank is playing, it start recording in the same bank "overdubbing". Also, it can be activated as Stop button using "LOOPING" mode. (it uses ipoke2~, compiled for Linux64).

FX Consoles modes: 
1. Mic & Banks -> FX1 -> FX2 -> Output
2. Mic -> FX1 -> Output, Banks -> FX2 -> Output
3. Banks -> FX1 -> Output, Mic -> FX2 -> Output
4. Mic -> Output, Banks -> FX1 -> FX2 -> Output
5. Banks -> Output, Mic -> FX1 -> FX2 -> Output

First 2 Banks: have LIMITER (every bank can has it, it's like this for optimization, I only need those)

Output: has LIMITER and EQ7 (actually, I don't use the EQ).

MEH-SYSTEM uses original or modified patchs from: DIY2 FXs (by Matt Davey, I love him), eq7.mmb~ (by Maelstorm), CMETRONOME (I think by Chris Edward, posted by screwtop), RJDJ-vocoder, VLFO (by don't know who), and don't remember other...

I use MEH-SYSTEM on Ubuntu 12.04, using Jack with 128 frames of buffer, with 10ms of latency. For me, it's enought. I think it can be used in any system or plataform... but I didn't try it in other than mine.

A lot of people helped me to develop MEH-SYSTEM, by this forum, by list, by IRC... so I don't remember all their names. To all of them: THANKS.
