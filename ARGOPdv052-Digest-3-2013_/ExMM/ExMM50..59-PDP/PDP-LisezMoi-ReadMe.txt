PDP-LisezMoi-ReadMe.txt

Citation -----------------------------------------------------------

"PDP - Pure Data Packet a packet processing library for pure data"
"This external pd library is a framework for image/video processing (and other raw data packets) that is fast, simple and flexible and as much as possible compatible with the pd messaging system."


LisezMoi -----------------------------------------------------------

- Les ExMM-PDP et les MM-PDP utilisent la "library" PDP.

- La "library" PDP, les ExMM-PDP et les MM-PDP ne fonctionnent pas sous Windows.

- Pour utiliser PDP sous Mac OS X 10.4/Tiger ou 10.3/Panther, il faut installer X11 (X11 est installé avec 10.5/Leopard or 10.6/SnowLeopard). X11 est sur le CD/DVD d'installation livré avec votre Macintosh.

- Sous MacOSX: l'application X11, une fenêtre xterm et une fenêtre "pdp" s'ouvrent au clic sur le bouton "PDPWindow" d'un MM "PDP-Out" qui recoit des images.

- Attention: la fenetre pdp peut etre cachée derriere la fenetre xterm.

- N'ouvre pas un fichier sans chemin d'acces dans le meme dossier que lui.
(contrairement aux modules Audio, GEM, etc...)
Un dossier "File" contenant des fichiers "movie" .mp4 ou image .png permet de tester les ExMM contenant un MM PDP-Film ou PDP-Image.

- Conseils - Limitations
  - Préférer les images et films au format YUV (= YCrCb) 
  - La taille des images des films doit etre multiple de 8 x 8
  - En cas de probleme Audio (son haché):
    Preferences -> Audio Settings... -> delay (msec) -> Augmenter (50...100...)

ReadMe -----------------------------------------------------------

- The PDP ExMM (et MM) do not work under Windows.

- If you want to use PDP on Mac OS X 10.4/Tiger or 10.3/Panther, you will need to install X11 (X11 comes installed with 10.5/Leopard or 10.6/SnowLeopard). It comes on the install CD/DVD that your computer came with.
http://www.simplehelp.net/2006/10/22/how-to-install-x11-in-os-x/

- Under MacOSX: the X11 application, an xterm window and a pdp window open on a click on the "PDPWindow" button of a MM "PDP-Out" who is receiving images.


