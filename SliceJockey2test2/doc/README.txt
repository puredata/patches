

Slice//Jockey version 2 package for Pd extended 0.42 and 0.43


- Pure Data patches
- binary executables of:
  [bitflip~] [krunch~]
  [complexify~] [duck~] [instantamp~] [qompand~]
  [slicerec~] [sliceplay~]
  [combsL~] [combsR~] [damp~] [dcombsL~] [dcombsR~] [diffusorL~] [diffusorR~]	
- source code of these classes
- help patches for these classes (in folder 'doc')


////////////////////////////////////////////////////////////////////////////////


INSTALL

In order to use Slice//Jockey2, you must have Pd-extended installed on your computer (http://puredata.info). Or else, when using vanilla Pd, some classes from Pd-extended must be added (see further down).

The SliceJockey2 zipped package contains directory SliceJockey2 (possibly extended with test version number). Copy or move directory SliceJockey2 with all it's contents to any location on your computer which suits you. Do not reorganize the content within directory SliceJockey2 and do not change directory names.


////////////////////////////////////////////////////////////////////////////////


RUN

Start Pd extended. Select file >> open and load the patch SliceJockey2.pd from directory SliceJockey2. For help, click the question mark in the SliceJockey2 window. For settings, click the exclamation mark. Pay special attention to audio settings. To start slice-recording, activate one of the [>] buttons and feed sounds into your computer. 


////////////////////////////////////////////////////////////////////////////////


DIRECTORY CONTENTS

The directory 'SJsessions' is for session recordings which are automatically stored there. You can safely rename recorded .wav files, play them with any soundfile player, or copy them to another location.

The directory 'bin' contain binary class files for [slicerec~], [sliceplay~] and additional classes. Directory 'abstractions' contains abstractions used in [SliceJockey2]. Directory 'doc' contains LICENSE.txt, README.txt, and help files for classes [slicerec~], [sliceplay~] and other supplied binaries. Binary executable files have extensions according to platform:

.l_i386 for Linux 32 bit on Intel
.l_ia64 for Linux 64 bit on Intel
.pd_darwin for MacOSX on PPC and Intel
.dll for Windows 32 bit

If you want to use [slicerec~] and [sliceplay~] in your own patches, move the class binaries into a path known by Pd. In that case, be sure to delete any older versions of the binaries from your computer, to avoid conflicts. See http://puredata.info/docs/faq/how-do-i-install-externals-and-help-files for information about setting paths for Pd. 

Directory 'src' has source code for the binaries that come with this distribution.


////////////////////////////////////////////////////////////////////////////////


BUILD

If you want to build the provided classes on your own machine, cd to the 'src' directory in the package and type 'make'. This should work for Linux 32 / 64 bit, Linux on armv6l (Raspberry Pi) or armv7 (BeagleBoard, PengPod), Windows using MinGW, and OSX (creating a fat binary for ppc and Intel 32 / 64 bit).

Binaries are copied to directory 'bin' within the package. For Pd externals under Linux, the generic extension is .pd_linux. At the moment, separate extensions are available for Linux on Intel 32 and 64 bit (as used in this package). Do not copy .pd_linux executables in a Pd searchpath on a machine of the wrong architecture.


////////////////////////////////////////////////////////////////////////////////


EXTERNALS

List of Pd-extended classes used in [sliceockey2]:

cyclone/atan~
cyclone/delay~
cyclone/svf~
cyclone/MouseState
cyclone/Scope~

hcs/split_path
hcs/window_name
hcs/sys_gui
hcs/canvas_name

zexy/limiter~
zexy/z~


////////////////////////////////////////////////////////////////////////////////


SUPPORT

Slice//Jockey is documented with included help files, and a webpage at: 

http://www.katjaas.nl/slicejockey/slicejockey.html 

Individual support is not offered. For questions concerning installation and configuration of Pure Data, consult:
 
http://puredata.info/docs

Also consider searching the forum and the Pd mailing list archives: 

http://puredata.hurleur.com 
http://lists.puredata.info/pipermail/pd-list 

If you find a bug in patch [SliceJockey2] or any of the included abstractions and classes, please send an email to katjavetter@gmail.com.


////////////////////////////////////////////////////////////////////////////////


Slice//Jockey version history

SliceJockey2.pd
- made compatible across Pd-extended 0.42 and 0.43 
- introduction of playback tonalities (harmonic, minor, major, 12-tone, hijaz,     slendro)
- feedback loop around effects (resonant filter, krunch)
- presets for slicycle settings
- manual record start
- midi-controlled record start / stop
- improved built-in help 
- dropped: xy-object 'active time'
- dropped: gamepad support

SliceJockey.pd
- initial version


////////////////////////////////////////////////////////////////////////////////


sliceplay~ version history

version 1.0:
- cubic interpolation
- improved indexing

version 0.9.12:
- addition of 'interrupt' method and fade-out of interrupted slice
- addition of method and message selector 'minspeed' for minimum playback speed
- addition of play status message outlet
- negative cuepoints are now ignored, not interpreted modulo-loopsize


version 0.9.11: 
- used garray_getfloatwords() instead of garray_getfloatarray(), for 64 bit compatibility


version 0.91:
- fixed bug with playback speed
- amplitude compensation is now variable user parameter


version 0.9: first version


////////////////////////////////////////////////////////////////////////////////


slicerec~ version history

version 1.0:
- fade-out bug fixed
- support for cubic interpolated slice playback

version 0.9.11: 
- function slicerec_fadeout() renewed and called from slicerec_analysis()
- message selector 'start' added, for manual slice-recording start 


version 0.9.1: 
- used garray_getfloatwords() instead of garray_getfloatarray(), for 64 bit compatibility


version 0.9: first version

