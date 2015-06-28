Miniwoog 1.0 
requires pd-extended 

== Miniwoog controls == 

Works more or less like a Minimoog, controls are explained better than I would in the original manual : archive.org/details/synthmanual-moog-minimoog-owners-manual 

== Keyboard control == 

- "kbd_mode" switches note priority : 

0 = low note priority 
1 = high note priority 
2 = last note priority 

- "kbd-split" splits a midi keyboard : 

0 = use left zone 
1 = disable keyboard splitting 
2 = use right zone zone 

limit can be changed in the [pd midiin] subpatch (default = 60) 

- "afttouch" sets the settings affected by the keyboard aftertouch (0 = disabled) 

- "legato" : 

0 = trigger envelopes for each note played 
1 = only trigger envelopes when the first note is played, until all notes are released 

- "panic" : in case something goes wrong ! 

== Presets == 

- presets are saved in the /preset dir in the txt format 
- when using "save_new" to save a new preset, remember to add the .txt extension to the file name, the patch won't find it otherwise 
- "save" overwrites the current preset 

== Multi-instantiation ==

All settings are local, it is hence possible to open as many "miniwoog" your cpu can handle
Use keyboard splitting to play 2 moogs at once or play to 2 different presets at the same time for some interesting results

== Effects ==

Set the last settings of each effect to 0 to bypass them 

== Thanks == 

- bandlimited oscillators from Maelstorm and piano GUI from katz in the puredata.hurleur.com forum 
- effects from the rjdj library, slightly modified 

== Contact, questions, feedback, bug report and booze == 

jnoe@hotmail.fr